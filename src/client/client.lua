local activeInteriors = {}
local waitTime = 150

function ApplyInteriorConfig(interiorId, selected, allSets, allIpls)
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

    -- Apply entity sets
    for _, set in pairs(allSets or {}) do
        if selectedSets[set.set] then
            ActivateInteriorEntitySet(interiorId, set.set)
        else
            DeactivateInteriorEntitySet(interiorId, set.set)
        end
    end

    RefreshInterior(interiorId)
    Wait(100)

    -- Apply IPLs
    for _, ipl in ipairs(allIpls or {}) do
        if selectedSets[ipl.name] then
            RequestIpl(ipl.name)
        else
            RemoveIpl(ipl.name)
        end
    end
end

for _, interior in pairs(Config.Interiors) do
    CreateThread(function()
        local interiorHandle = GetInteriorAtCoords(interior.coords.x, interior.coords.y, interior.coords.z)
        print("Interior handle for", interior.id, "is", interiorHandle)
        while not IsInteriorReady(interiorHandle) do Wait(100) end

        activeInteriors[interior.id] = interiorHandle
        local currentSet = GlobalState["interior:" .. interior.id] or ""
        ApplyInteriorConfig(interiorHandle, currentSet, interior.entitySets, interior.ipls)
    end)

    AddStateBagChangeHandler("interior:" .. interior.id, "", function(_, _, value)
        local interiorHandle = activeInteriors[interior.id]
        if interiorHandle then
            ApplyInteriorConfig(interiorHandle, value, interior.entitySets, interior.ipls)
        end
    end)
end


function ShowIplMenu(interior)
    local iplOptions = {}
    local currentSet = GlobalState["interior:" .. interior.id]
    if type(currentSet) ~= "table" then currentSet = {} end

    for _, ipl in ipairs(interior.ipls or {}) do
        table.insert(iplOptions, {
            title = ipl.label,
            icon = currentSet[ipl.name] and 'fas fa-check' or 'fas fa-times',
            description = "Toggle " .. ipl.name,
            onSelect = function()
                local isActive = currentSet[ipl.name] == true
                TriggerServerEvent("entityset:toggle_individual", interior.id, ipl.name, not isActive)
                Wait(waitTime)
                ShowEntitySetMenu(interior)
                ShowIplMenu(interior)
            end
        })
    end

    lib.registerContext({
        id = 'sub_ipls_' .. interior.id,
        title = interior.name .. " - IPLs",
        menu = 'sub_' .. interior.id,
        options = iplOptions
    })

    lib.showContext('sub_ipls_' .. interior.id)
end

function ShowEntitySetMenu(interior)
    local submenuOptions = {}
    local currentSet = GlobalState["interior:" .. interior.id]
    if type(currentSet) ~= "table" then currentSet = {} end -- normalize for consistency

    if interior.presets then
        table.insert(submenuOptions, {
            title = "[Presets]",
            description = "Apply multiple sets at once",
            onSelect = function()
                ShowPresetMenu(interior)
            end
        })
    end

    if interior.ipls then
        table.insert(submenuOptions, {
            title = "[IPLs]",
            description = "Toggle IPLs (map parts)",
            onSelect = function()
                ShowEntitySetMenu(interior) -- re-register parent
                ShowIplMenu(interior)
            end
        })
    end

    for _, set in ipairs(interior.entitySets) do
        table.insert(submenuOptions, {
            title = set.label,
            icon = (type(currentSet) == "table" and currentSet[set.set]) and 'fas fa-check' or 'fas fa-times',
            description = "Toggle " .. set.set,
            onSelect = function()
                local isActive = currentSet[set.set] == true
                TriggerServerEvent("entityset:toggle_individual", interior.id, set.set, not isActive)
                Wait(waitTime)
                ShowEntitySetMenu(interior)
            end
        })
    end

    table.insert(submenuOptions, {
        title = "Disable All",
        icon = (not currentSet or next(currentSet) == nil) and 'fas fa-check' or 'fas fa-times',
        description = "Turn off all entity sets & ipls",
        onSelect = function()
            TriggerServerEvent("entityset:toggle", interior.id, "")
            Wait(waitTime)
            ShowEntitySetMenu(interior)
        end
    })

    lib.registerContext({
        id = 'sub_' .. interior.id,
        title = interior.name,
        menu = 'entitysetloader_menu',
        options = submenuOptions
    })

    lib.showContext('sub_' .. interior.id)
end

function ShowPresetMenu(interior)
    local presetOptions = {}

    for _, preset in ipairs(interior.presets or {}) do
        table.insert(presetOptions, {
            title = preset.label,
            description = "Activate: " .. table.concat(preset.sets, ", "),
            onSelect = function()
                TriggerServerEvent("entityset:toggle", interior.id, {
                    sets = preset.sets,
                    ipls = preset.ipls
                })

                Wait(waitTime)
                ShowEntitySetMenu(interior)
                ShowPresetMenu(interior)
            end
        })
    end

    lib.registerContext({
        id = 'sub_presets_' .. interior.id,
        title = interior.name .. " - Presets",
        menu = 'sub_' .. interior.id,
        options = presetOptions
    })

    lib.showContext('sub_presets_' .. interior.id)
end

RegisterCommand("interiormanager", function()
    lib.callback('interiors:checkPerms', false, function(allowed)
        local submenus = {}

        for _, interior in pairs(Config.Interiors) do
            local interiorCopy = interior

            if not interior.adminOnly or allowed then
                table.insert(submenus, {
                    title = interior.name,
                    description = 'Change entity sets for this interior',
                    onSelect = function()
                        ShowEntitySetMenu(interiorCopy)
                    end
                })
            elseif not allowed then
                table.insert(submenus, {
                    title = interior.name,
                    description = 'Only admins can use this',
                    disabled = true
                })
            end
        end

        lib.registerContext({
            id = 'entitysetloader_menu',
            title = 'Interior Entity Sets',
            options = submenus
        })

        lib.showContext('entitysetloader_menu')
    end)
end, false)
