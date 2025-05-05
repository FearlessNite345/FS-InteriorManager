RegisterNetEvent("entityset:toggle", function(interiorId, data)
    if type(interiorId) ~= "string" then return end

    local stateValue = {}

    if type(data) == "string" and data ~= "" then
        stateValue[data] = true
    elseif type(data) == "table" then
        if data.sets then
            for _, set in ipairs(data.sets) do
                stateValue[set] = true
            end
        end
        if data.ipls then
            for _, ipl in ipairs(data.ipls) do
                stateValue[ipl] = true
            end
        end
    end

    GlobalState:set("interior:" .. interiorId, stateValue, true)
end)

RegisterNetEvent("entityset:toggle_individual", function(interiorId, key, value)
    if type(interiorId) ~= "string" or type(key) ~= "string" or type(value) ~= "boolean" then return end

    local current = GlobalState["interior:" .. interiorId] or {}

    -- Safety check
    if type(current) ~= "table" then current = {} end

    -- Modify the key
    current[key] = value and true or nil

    -- Clean up any false/nil keys
    for k, v in pairs(current) do
        if not v then
            current[k] = nil
        end
    end

    GlobalState:set("interior:" .. interiorId, current, true)
end)

lib.callback.register('interiors:checkPerms', function(source)
    return IsPlayerAceAllowed(source, Config.acePermissionForAdmin)
end)

exports['FS-Lib']:VersionCheck('FS-InteriorManager', 'fearlessnite345/FS-InteriorManager')
