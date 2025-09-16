local activeInteriors = {}

-- ==========
-- Utilities
-- ==========
local function pushStateUpdate(interiorId, newState)
    SendNUIMessage({
        action = "stateUpdate",
        data   = {
            id    = interiorId,
            state = (type(newState) == "table") and newState or {}
        }
    })
end

local function ApplyInteriorConfig(interiorId, selected, allSets, allIpls)
    if not interiorId then return end

    local selectedSets = {}
    if type(selected) == "string" and selected ~= "" then
        selectedSets[selected] = true
    elseif type(selected) == "table" then
        for k, v in pairs(selected) do
            if type(k) == "string" and v == true then
                selectedSets[k] = true
            elseif type(v) == "string" then
                selectedSets[v] = true
            end
        end
    end

    -- entity sets
    for _, set in pairs(allSets or {}) do
        if selectedSets[set.set] then
            ActivateInteriorEntitySet(interiorId, set.set)
        else
            DeactivateInteriorEntitySet(interiorId, set.set)
        end
    end

    RefreshInterior(interiorId)
    Wait(100)

    -- IPLs
    for _, ipl in ipairs(allIpls or {}) do
        if selectedSets[ipl.name] then
            RequestIpl(ipl.name)
        else
            RemoveIpl(ipl.name)
        end
    end
end

-- ==========================================
-- Build a UI snapshot from current config
-- ==========================================
local function buildUiSnapshot(allowed)
    local function currentState(id)
        local st = GlobalState["interior:" .. id]
        if type(st) ~= "table" then st = {} end
        return st
    end

    local interiors = {}
    for _, it in ipairs(Config.Interiors or {}) do
        interiors[#interiors + 1] = {
            id         = it.id,
            name       = it.name,
            coords     = it.coords,
            adminOnly  = it.adminOnly or false,
            entitySets = it.entitySets or {},
            ipls       = it.ipls or {},
            presets    = it.presets or {},
            state      = currentState(it.id)
        }
    end

    local folders = {}
    for _, folder in ipairs(Config.InteriorFolders or {}) do
        local list = {}
        for _, it in ipairs(folder.interiors or {}) do
            list[#list + 1] = {
                id         = it.id,
                name       = it.name,
                coords     = it.coords,
                adminOnly  = it.adminOnly or false,
                entitySets = it.entitySets or {},
                ipls       = it.ipls or {},
                presets    = it.presets or {},
                state      = currentState(it.id)
            }
        end
        folders[#folders + 1] = { name = folder.folder, interiors = list }
    end

    return { title = "Interior Manager", allowed = allowed == true, interiors = interiors, folders = folders }
end

-- ================================================
-- Init / hydrate interiors + react to state changes
-- ================================================
local function ensureDefaultState(thisInterior, interiorHandle)
    local currentSet = GlobalState["interior:" .. thisInterior.id]
    if type(currentSet) ~= "table" or next(currentSet) == nil then
        currentSet = {}
        if thisInterior.defaults then
            for _, setName in ipairs(thisInterior.defaults.sets or {}) do currentSet[setName] = true end
            for _, iplName in ipairs(thisInterior.defaults.ipls or {}) do currentSet[iplName] = true end
        end
        TriggerServerEvent("entityset:toggle", thisInterior.id, {
            sets = thisInterior.defaults and thisInterior.defaults.sets or {},
            ipls = thisInterior.defaults and thisInterior.defaults.ipls or {}
        })
    end
    ApplyInteriorConfig(interiorHandle, currentSet, thisInterior.entitySets, thisInterior.ipls)
end

-- Top-level interiors
for _, interior in pairs(Config.Interiors or {}) do
    local thisInterior = interior
    CreateThread(function()
        local h = GetInteriorAtCoords(thisInterior.coords.x, thisInterior.coords.y, thisInterior.coords.z)
        if Config.debug then print("Interior handle for", thisInterior.id, "is", h) end
        while not IsInteriorReady(h) do Wait(100) end

        activeInteriors[thisInterior.id] = h
        ensureDefaultState(thisInterior, h)
    end)

    AddStateBagChangeHandler("interior:" .. thisInterior.id, "", function(_, _, value)
        local h = activeInteriors[thisInterior.id]
        if h then
            ApplyInteriorConfig(h, value, thisInterior.entitySets, thisInterior.ipls)
            pushStateUpdate(thisInterior.id, value)
        end
    end)
end

-- Foldered interiors
for _, folder in pairs(Config.InteriorFolders or {}) do
    for _, interior in pairs(folder.interiors or {}) do
        local thisInterior = interior
        CreateThread(function()
            local h = GetInteriorAtCoords(thisInterior.coords.x, thisInterior.coords.y, thisInterior.coords.z)
            if Config.debug then print("Interior handle for", thisInterior.id, "is", h) end
            while not IsInteriorReady(h) do Wait(100) end

            activeInteriors[thisInterior.id] = h
            ensureDefaultState(thisInterior, h)
        end)

        AddStateBagChangeHandler("interior:" .. thisInterior.id, "", function(_, _, value)
            local h = activeInteriors[thisInterior.id]
            if h then
                ApplyInteriorConfig(h, value, thisInterior.entitySets, thisInterior.ipls)
                pushStateUpdate(thisInterior.id, value)
            end
        end)
    end
end

-- ==========================
-- NUI + Focus (Left Alt)
-- ==========================
local UI_OPEN = false
local FOCUS_GAME = true    -- false = UI has focus
local KEY_TOGGLE_FOCUS = 19 -- INPUT_CHARACTER_WHEEL (Left Alt)

local function setUiFocus(hasUi)
    FOCUS_GAME = not hasUi
    SetNuiFocus(hasUi, hasUi)
    SetNuiFocusKeepInput(false)
    SendNUIMessage({ action = "focus", data = { uiHasFocus = hasUi } })
end

local function openUi(allowed)
    if UI_OPEN then return end
    UI_OPEN = true
    setUiFocus(true)
    SendNUIMessage({
        action = "open",
        data = {
            payload = buildUiSnapshot(allowed)
        }
    })

    -- While UI is open and game has focus, let Left Alt bring focus back to UI
    CreateThread(function()
        while UI_OPEN do
            if FOCUS_GAME then
                DisableControlAction(0, 200, true) -- block pause key a bit while we watch for Alt
                if IsControlJustPressed(0, KEY_TOGGLE_FOCUS) then
                    setUiFocus(true)
                end
            end
            Wait(0)
        end
    end)
end

local function closeUi()
    if not UI_OPEN then return end
    UI_OPEN = false
    setUiFocus(false)
    SendNUIMessage({ action = "close" })
end

-- NUI callbacks
RegisterNUICallback("toggleSet", function(data, cb)
    -- data = { id, set, enabled }
    TriggerServerEvent("entityset:toggle_individual", data.id, data.set, data.enabled)
    cb({ ok = true })
end)

RegisterNUICallback("toggleIpl", function(data, cb)
    -- data = { id, name, enabled }
    TriggerServerEvent("entityset:toggle_individual", data.id, data.name, data.enabled)
    cb({ ok = true })
end)

RegisterNUICallback("applyPreset", function(data, cb)
    -- data = { id, sets, ipls }
    TriggerServerEvent("entityset:toggle", data.id, { sets = data.sets or {}, ipls = data.ipls })
    cb({ ok = true })
end)

RegisterNUICallback("disableAll", function(data, cb)
    -- data = { id }
    TriggerServerEvent("entityset:toggle", data.id, "")
    cb({ ok = true })
end)

RegisterNUICallback("teleportTo", function(data, cb)
    -- data = { coords = {x,y,z} }
    local ped = PlayerPedId()
    SetEntityCoords(ped, data.coords.x + 0.0, data.coords.y + 0.0, data.coords.z + 0.0, false, false, false, true)
    cb({ ok = true })
end)

RegisterNUICallback("toggleFocus", function(_, cb)
    setUiFocus(FOCUS_GAME) -- invert
    cb({ ok = true })
end)

RegisterNUICallback("close", function(_, cb)
    closeUi()
    cb({ ok = true })
end)

-- ==========================
-- Open command + perms
-- ==========================
TriggerEvent("chat:addSuggestion", "/" .. Config.menuCommand, "Open the Interior Manager")

RegisterCommand(Config.menuCommand, function()
    TriggerServerEvent("interiors:checkPerms:request")
end, false)

RegisterNetEvent("interiors:checkPerms:response", function(allowed)
    openUi(allowed)
end)
