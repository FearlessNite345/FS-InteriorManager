local activeInteriors = {}
local waitTime = 250

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
    local thisInterior = interior
    CreateThread(function()
        local interiorHandle = GetInteriorAtCoords(thisInterior.coords.x, thisInterior.coords.y, thisInterior.coords.z)
        print("Interior handle for", thisInterior.id, "is", interiorHandle)
        while not IsInteriorReady(interiorHandle) do Wait(100) end

        activeInteriors[thisInterior.id] = interiorHandle
        local currentSet = GlobalState["interior:" .. thisInterior.id] or ""
        if type(currentSet) ~= "table" or next(currentSet) == nil then
            currentSet = {}
            if thisInterior.defaults then
                for _, setName in ipairs(thisInterior.defaults.sets or {}) do
                    currentSet[setName] = true
                end
                for _, iplName in ipairs(thisInterior.defaults.ipls or {}) do
                    currentSet[iplName] = true
                end
            end
        end
        ApplyInteriorConfig(interiorHandle, currentSet, thisInterior.entitySets, thisInterior.ipls)
    end)

    AddStateBagChangeHandler("interior:" .. thisInterior.id, "", function(_, _, value)
        local interiorHandle = activeInteriors[thisInterior.id]
        if interiorHandle then
            ApplyInteriorConfig(interiorHandle, value, thisInterior.entitySets, thisInterior.ipls)
        end
    end)
end

for _, folder in pairs(Config.InteriorFolders) do
    for _, interior in pairs(folder.interiors) do
        local thisInterior = interior
        CreateThread(function()
            local interiorHandle = GetInteriorAtCoords(thisInterior.coords.x, thisInterior.coords.y, thisInterior.coords.z)
            print("Interior handle for", thisInterior.id, "is", interiorHandle)
            while not IsInteriorReady(interiorHandle) do Wait(100) end

            activeInteriors[thisInterior.id] = interiorHandle
            local currentSet = GlobalState["interior:" .. thisInterior.id] or ""
            if type(currentSet) ~= "table" or next(currentSet) == nil then
                currentSet = {}
                if thisInterior.defaults then
                    for _, setName in ipairs(thisInterior.defaults.sets or {}) do
                        currentSet[setName] = true
                    end
                    for _, iplName in ipairs(thisInterior.defaults.ipls or {}) do
                        currentSet[iplName] = true
                    end
                end
            end
            ApplyInteriorConfig(interiorHandle, currentSet, thisInterior.entitySets, thisInterior.ipls)
        end)

        AddStateBagChangeHandler("interior:" .. thisInterior.id, "", function(_, _, value)
            local interiorHandle = activeInteriors[thisInterior.id]
            if interiorHandle then
                ApplyInteriorConfig(interiorHandle, value, thisInterior.entitySets, thisInterior.ipls)
            end
        end)
    end
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

    table.insert(submenuOptions, {
        title = "[Teleport to " .. interior.name .. "]",
        description = "Will teleport you to the interior",
        onSelect = function()
            local playerPed = PlayerPedId()
            local coords = interior.coords
            SetEntityCoords(playerPed, coords.x, coords.y, coords.z, false, false, false, true)
            ShowEntitySetMenu(interior)
        end
    })

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

    if interior.folder then
        lib.registerContext({
            id = 'sub_' .. interior.id,
            title = interior.name,
            menu = 'folder_' .. interior.folder,
            options = submenuOptions
        })
    else
        lib.registerContext({
            id = 'sub_' .. interior.id,
            title = interior.name,
            menu = 'entitysetloader_menu',
            options = submenuOptions
        })
    end


    lib.showContext('sub_' .. interior.id)
end

function ShowPresetMenu(interior)
    local presetOptions = {}

    for _, preset in ipairs(interior.presets or {}) do
        table.insert(presetOptions, {
            title = preset.label,
            description = "Activate: " .. table.concat(preset.sets or {}, ", "),
            onSelect = function()
                TriggerServerEvent("entityset:toggle", interior.id, {
                    sets = preset.sets or {},
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

TriggerEvent("chat:addSuggestion", "/" .. Config.menuCommand, "Will open the Interior Manager menu")

RegisterCommand(Config.menuCommand, function()
    lib.callback('interiors:checkPerms', false, function(allowed)
        local menuOptions = {}

        -- Add interior folders first
        if Config.InteriorFolders and #Config.InteriorFolders > 0 then
            for _, folder in ipairs(Config.InteriorFolders) do
                local folderOptions = {}
                for _, interior in ipairs(folder.interiors or {}) do
                    interior.folder = folder.folder
                    if not interior.adminOnly or allowed then
                        table.insert(folderOptions, {
                            title = interior.name,
                            description = "Change entity sets for this interior",
                            onSelect = function()
                                ShowEntitySetMenu(interior)
                            end
                        })
                    else
                        table.insert(folderOptions, {
                            title = interior.name,
                            description = "Only admins can use this",
                            disabled = true
                        })
                    end
                end
                table.insert(menuOptions, {
                    title = "[" .. folder.folder .. "]",
                    description = "Interiors under " .. folder.folder,
                    onSelect = function()
                        lib.registerContext({
                            id = "folder_" .. folder.folder,
                            title = "[" .. folder.folder .. "]",
                            menu = 'entitysetloader_menu',
                            options = folderOptions
                        })
                        lib.showContext("folder_" .. folder.folder)
                    end
                })
            end
        end

        -- Add individual interiors defined in Config.Interiors
        if Config.Interiors and #Config.Interiors > 0 then
            for _, interior in ipairs(Config.Interiors) do
                if not interior.adminOnly or allowed then
                    table.insert(menuOptions, {
                        title = interior.name,
                        description = "Change entity sets for this interior",
                        onSelect = function()
                            ShowEntitySetMenu(interior)
                        end
                    })
                else
                    table.insert(menuOptions, {
                        title = interior.name,
                        description = "Only admins can use this",
                        disabled = true
                    })
                end
            end
        end

        if #menuOptions == 0 then
            menuOptions = { { title = "No interiors available", disabled = true } }
        end

        lib.registerContext({
            id = "entitysetloader_menu",
            title = "Interior Manager",
            options = menuOptions
        })
        lib.showContext("entitysetloader_menu")
    end)
end, false)
