Config = {}

Config.menuCommand = 'interiormanager'

Config.Interiors = {
    {
        id = "prompts_sandy_church",
        name = "Sandy Church Interior",
        coords = vec3(1790.5172, 3902.3560, 34.6489),
        adminOnly = true,
        entitySets = {
            { label = "Funeral", set = "church_funeral" },
            { label = "Wedding", set = "church_married" },
            { label = "Service", set = "church_service" }
        },
    },
    {
        id = "prompts_sandy_cityhall",
        name = "Sandy Cityhall Interior",
        coords = vec3(1753.6223, 3804.6450, 35.4474),
        adminOnly = true,
        entitySets = {
            { label = "Static Elevator",   set = "static_elevator" },
            { label = "Conference Chairs", set = "conference_chairs" },
            { label = "Meeting Table",     set = "conference_meeting_table" },
            { label = "Voting Room",       set = "eventroom_voting" }
        },
        ipls = {
            { label = "Back Fences (Open)",   name = "p_prompt_sandy_cityhall_fences_backopened" },
            { label = "Back Fences (Closed)", name = "p_prompt_sandy_cityhall_fences_backclosed" },
            { label = "Back Tables",          name = "p_prompt_sandy_cityhall_backtables" },
            { label = "Tables",               name = "p_prompt_sandy_cityhall_tables" },
            { label = "Coffin (Closed)",      name = "p_prompt_sandy_cityhall_coffin_closed" },
            { label = "Coffin (Open)",        name = "p_prompt_sandy_cityhall_coffin_opened" },
            { label = "Funeral Chairs",       name = "p_prompt_sandy_cityhall_funeral_chairs" },
            { label = "Funeral Picture",      name = "p_prompt_sandy_cityhall_funeral_picture" },
            { label = "Leaves",               name = "p_prompt_sandy_cityhall_leaves" },
            { label = "Wedding Chairs",       name = "p_prompt_sandy_cityhall_wedding_chairs" },
            { label = "Wedding Spotlight",    name = "p_prompt_sandy_cityhall_wedding_spotlight" },
            { label = "Wedding Venue",        name = "p_prompt_sandy_cityhall_wedding_venue" }
        },
        presets = {
            {
                label = "Dinner (Opened Back)",
                sets = {},
                ipls = {
                    "p_prompt_sandy_cityhall_backtables",
                    "p_prompt_sandy_cityhall_tables",
                    "p_prompt_sandy_cityhall_fences_backopened"
                }
            },
            {
                label = "Dinner (Closed Back)",
                sets = {},
                ipls = {
                    "p_prompt_sandy_cityhall_tables",
                    "p_prompt_sandy_cityhall_fences_backclosed"
                }
            },
            {
                label = "Wedding Ceremony",
                sets = {},
                ipls = {
                    "p_prompt_sandy_cityhall_fences_backclosed",
                    "p_prompt_sandy_cityhall_wedding_chairs",
                    "p_prompt_sandy_cityhall_wedding_spotlight",
                    "p_prompt_sandy_cityhall_wedding_venue",
                    "p_prompt_sandy_cityhall_leaves"
                }
            },
            {
                label = "Funeral",
                sets = {},
                ipls = {
                    "p_prompt_sandy_cityhall_fences_backclosed",
                    "p_prompt_sandy_cityhall_funeral_chairs",
                    "p_prompt_sandy_cityhall_funeral_picture",
                    "p_prompt_sandy_cityhall_leaves",
                    "p_prompt_sandy_cityhall_coffin_closed"
                }
            }
        }
    },
    {
        id = "gcom_logistics",
        name = "Logistics Interior",
        coords = vec3(1885.3466, 3147.4792, 44.6878),
        adminOnly = true,
        entitySets = {
            { label = "Default Garage",      set = "gcom_lc_garage_1" },
            { label = "Garage with Storage", set = "gcom_lc_garage_2" }
        }
    }
}
