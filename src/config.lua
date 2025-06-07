Config = {}

-- Command to open the interior manager
Config.menuCommand = 'interiormanager'

-- ACE permission required for admin-level interior modifications
Config.acePermissionForAdmin = 'entitysetloader.access'

-- The interiors below are provided as preconfigured samples. Remove them if you already have your own interior configurations.

Config.InteriorFolders = {
    {
        folder = "Sandy Houses",
        interiors = {
            {
                id = "prompts_sandy_house1",
                name = "House 1",
                coords = vec3(1812.367, 3762.021, 34.21988),
                adminOnly = false,
                defaults = {
                    sets = {
                        "wallframe2",
                        "windowframe1",
                        "doorframe2",
                        "bathroomlight",
                        "halllight",
                        "bedroomlight",
                        "masterbedroomlight",
                        "masterbathroomlight",
                        "masterbathroom2",
                        "bedroom3",
                        "masterbedroom1",
                        "bathroom2",
                    }
                },
                entitySets = {
                    { label = "Bathroom Light",       set = "bathroomlight" },
                    { label = "Hall Light",           set = "halllight" },
                    { label = "Bedroom Light",        set = "bedroomlight" },
                    { label = "Master Bedroom Light", set = "masterbedroomlight" },
                    { label = "Bathroom 1",           set = "bathroom1" },
                    { label = "Bathroom 2",           set = "bathroom2" },
                    { label = "Master Bathroom 1",    set = "masterbathroom1" },
                    { label = "Master Bathroom 2",    set = "masterbathroom2" },
                    { label = "Bedroom 1",            set = "bedroom1" },
                    { label = "Bedroom 2",            set = "bedroom2" },
                    { label = "Bedroom 3",            set = "bedroom3" },
                    { label = "Master Bedroom 1",     set = "masterbedroom1" },
                    { label = "Master Bedroom 2",     set = "masterbedroom2" },
                    { label = "Master Bedroom 3",     set = "masterbedroom3" },
                    { label = "Bath 1",               set = "bath1" },
                    { label = "Bath 2",               set = "bath2" },
                    { label = "Master Bath 1",        set = "masterbath1" },
                    { label = "Master Bath 2",        set = "masterbath2" },
                    { label = "Bedroom Dirt",         set = "bedroomdirt" },
                    { label = "Hall Dirt",            set = "halldirt" },
                    { label = "Master Bedroom Dirt",  set = "masterbedroomdirt" },
                    { label = "Door Frame 1",         set = "doorframe1" },
                    { label = "Door Frame 2",         set = "doorframe2" },
                    { label = "Window Frame 1",       set = "windowframe1" },
                    { label = "Window Frame 2",       set = "windowframe2" },
                    { label = "Wall Frame 1",         set = "wallframe1" },
                    { label = "Wall Frame 2",         set = "wallframe2" },
                    { label = "Upper Frame",          set = "upframe" },
                    { label = "Radiator Place",       set = "radiatorplace" },
                    { label = "Fireplace",            set = "fireplace" },
                },
                presets = {
                    {
                        label = "Clean",
                        sets = {
                            "wallframe2",
                            "windowframe1",
                            "doorframe2",
                            "bathroomlight",
                            "halllight",
                            "bedroomlight",
                            "masterbedroomlight",
                            "masterbathroomlight",
                            "masterbathroom2",
                            "bedroom3",
                            "masterbedroom1",
                            "bathroom2",
                        },
                        ipls = {}
                    },
                    {
                        label = "Dirty",
                        sets = {
                            "wallframe2",
                            "windowframe1",
                            "doorframe2",
                            "bathroomlight",
                            "halllight",
                            "bedroomlight",
                            "masterbedroomlight",
                            "masterbathroomlight",
                            "masterbathroom2",
                            "bedroom3",
                            "masterbedroom1",
                            "bathroom2",
                            "bedroomdirt",
                            "halldirt",
                            "masterbedroomdirt",
                        },
                        ipls = {}
                    },
                    {
                        label = "Lights Off",
                        sets = {
                            "wallframe2",
                            "windowframe1",
                            "doorframe2",
                            "masterbathroom2",
                            "bedroom3",
                            "masterbedroom1",
                            "bathroom2",
                            "bedroomdirt",
                            "halldirt",
                            "masterbedroomdirt",
                        },
                        ipls = {}
                    }
                }
            },
            {
                id = "prompts_sandy_house2",
                name = "House 2",
                coords = vec3(1775.337, 3746.64, 34.72295),
                adminOnly = false,
                defaults = {
                    sets = {
                        "wallframe1",
                        "windowframe2",
                        "doorframe2",
                        "bathroomlight",
                        "livingroomlight",
                        "kitchenlight",
                        "bedroomlight",
                        "bedroom2",
                        "bathroom2",
                    }
                },
                entitySets = {
                    { label = "Bathroom Light",    set = "bathroomlight" },
                    { label = "Living Room Light", set = "livingroomlight" },
                    { label = "Kitchen Light",     set = "kitchenlight" },
                    { label = "Bedroom Light",     set = "bedroomlight" },
                    { label = "Bathroom 1",        set = "bathroom1" },
                    { label = "Bathroom 2",        set = "bathroom2" },
                    { label = "Bathroom 3",        set = "bathroom3" },
                    { label = "Bedroom 1",         set = "bedroom1" },
                    { label = "Bedroom 2",         set = "bedroom2" },
                    { label = "Bedroom 3",         set = "bedroom3" },
                    { label = "Bedroom 4",         set = "bedroom4" },
                    { label = "Bathroom Set 1",    set = "bath1" },
                    { label = "Bathroom Set 2",    set = "bath2" },
                    { label = "Bedroom Dirt",      set = "bedroomdirt" },
                    { label = "Living Room Dirt",  set = "livingroomdirt" },
                    { label = "Kitchen Dirt",      set = "kitchendirt" },
                    { label = "Door Frame 1",      set = "doorframe1" },
                    { label = "Door Frame 2",      set = "doorframe2" },
                    { label = "Window Frame 1",    set = "windowframe1" },
                    { label = "Window Frame 2",    set = "windowframe2" },
                    { label = "Wall Frame 1",      set = "wallframe1" },
                    { label = "Wall Frame 2",      set = "wallframe2" },
                    { label = "Upper Frame",       set = "upframe" },
                },
                presets = {
                    {
                        label = "Clean",
                        sets = {
                            "wallframe1",
                            "windowframe2",
                            "doorframe2",
                            "bathroomlight",
                            "livingroomlight",
                            "kitchenlight",
                            "bedroomlight",
                            "bedroom2",
                            "bathroom2",
                        },
                        ipls = {}
                    },
                    {
                        label = "Dirty",
                        sets = {
                            "wallframe1",
                            "windowframe2",
                            "doorframe2",
                            "bathroomlight",
                            "livingroomlight",
                            "kitchenlight",
                            "bedroomlight",
                            "bedroom2",
                            "bathroom2",
                            "bedroomdirt",
                            "livingroomdirt",
                            "kitchendirt",
                        },
                        ipls = {}
                    },
                    {
                        label = "Lights Off",
                        sets = {
                            "wallframe1",
                            "windowframe2",
                            "doorframe2",
                            "bathroom2",
                            "bedroom2",
                            "bedroomdirt",
                            "livingroomdirt",
                            "kitchendirt",
                        },
                        ipls = {}
                    }
                }
            },
            {
                id = "prompts_sandy_house3",
                name = "House 3",
                coords = vec3(1353.875, 3598.896, 35.84079),
                adminOnly = false,
                defaults = {
                    sets = {
                        "wallframe1",
                        "windowframe1",
                        "doorframe2",
                        "bathroomlight",
                        "livingroomlight",
                        "kitchenlight",
                        "bedroomlight",
                        "bathroom2",
                        "bedroom2",
                        "bath1",
                    }
                },
                entitySets = {
                    { label = "Bathroom Light",    set = "bathroomlight" },
                    { label = "Living Room Light", set = "livingroomlight" },
                    { label = "Kitchen Light",     set = "kitchenlight" },
                    { label = "Bedroom Light",     set = "bedroomlight" },
                    { label = "Bathroom 1",        set = "bathroom1" },
                    { label = "Bathroom 2",        set = "bathroom2" },
                    { label = "Bathroom 3",        set = "bathroom3" },
                    { label = "Bedroom 1",         set = "bedroom1" },
                    { label = "Bedroom 2",         set = "bedroom2" },
                    { label = "Bedroom 3",         set = "bedroom3" },
                    { label = "Bedroom 4",         set = "bedroom4" },
                    { label = "Bathroom Set 1",    set = "bath1" },
                    { label = "Bathroom Set 2",    set = "bath2" },
                    { label = "Bedroom Dirt",      set = "bedroomdirt" },
                    { label = "Living Room Dirt",  set = "livingroomdirt" },
                    { label = "Kitchen Dirt",      set = "kitchendirt" },
                    { label = "Door Frame 1",      set = "doorframe1" },
                    { label = "Door Frame 2",      set = "doorframe2" },
                    { label = "Window Frame 1",    set = "windowframe1" },
                    { label = "Window Frame 2",    set = "windowframe2" },
                    { label = "Wall Frame 1",      set = "wallframe1" },
                    { label = "Wall Frame 2",      set = "wallframe2" },
                    { label = "Upper Frame",       set = "upframe" },
                },
                presets = {
                    {
                        label = "Clean",
                        sets = {
                            "wallframe1",
                            "windowframe1",
                            "doorframe2",
                            "bathroomlight",
                            "livingroomlight",
                            "kitchenlight",
                            "bedroomlight",
                            "bathroom2",
                            "bedroom2",
                            "bath1",
                        },
                        ipls = {}
                    },
                    {
                        label = "Dirty",
                        sets = {
                            "wallframe1",
                            "windowframe1",
                            "doorframe2",
                            "bathroomlight",
                            "livingroomlight",
                            "kitchenlight",
                            "bedroomlight",
                            "bathroom2",
                            "bedroom2",
                            "bath1",
                            "bedroomdirt",
                            "livingroomdirt",
                            "kitchendirt",
                        },
                        ipls = {}
                    },
                    {
                        label = "Lights Off",
                        sets = {
                            "wallframe1",
                            "windowframe1",
                            "doorframe2",
                            "bathroom2",
                            "bedroom2",
                            "bath1",
                            "bedroomdirt",
                            "livingroomdirt",
                            "kitchendirt",
                        },
                        ipls = {}
                    }
                }
            },
            {
                id = "prompts_sandy_house4",
                name = "House 4",
                coords = vec3(1650.912, 3626.822, 36.44559),
                adminOnly = false,
                defaults = {
                    sets = {
                        "wallframe1",
                        "windowframe2",
                        "doorframe2",
                        "bathroomlight",
                        "livingroomlight",
                        "kitchenlight",
                        "bedroomlight",
                        "walllight2",
                        "bedroom2",
                        "bathroom2",
                    }
                },
                entitySets = {
                    { label = "Bathroom Light",    set = "bathroomlight" },
                    { label = "Living Room Light", set = "livingroomlight" },
                    { label = "Kitchen Light",     set = "kitchenlight" },
                    { label = "Bedroom Light",     set = "bedroomlight" },
                    { label = "Bathroom 1",        set = "bathroom1" },
                    { label = "Bathroom 2",        set = "bathroom2" },
                    { label = "Bathroom 3",        set = "bathroom3" },
                    { label = "Bedroom 1",         set = "bedroom1" },
                    { label = "Bedroom 2",         set = "bedroom2" },
                    { label = "Bedroom 3",         set = "bedroom3" },
                    { label = "Bathroom Set 1",    set = "bath1" },
                    { label = "Bathroom Set 2",    set = "bath2" },
                    { label = "Bedroom Dirt",      set = "bedroomdirt" },
                    { label = "Living Room Dirt",  set = "livingroomdirt" },
                    { label = "Kitchen Dirt",      set = "kitchendirt" },
                    { label = "Door Frame 1",      set = "doorframe1" },
                    { label = "Door Frame 2",      set = "doorframe2" },
                    { label = "Window Frame 1",    set = "windowframe1" },
                    { label = "Window Frame 2",    set = "windowframe2" },
                    { label = "Wall Frame 1",      set = "wallframe1" },
                    { label = "Wall Frame 2",      set = "wallframe2" },
                    { label = "Upper Frame",       set = "upframe" },
                    { label = "Wall Light 1",      set = "walllight1" },
                    { label = "Wall Light 2",      set = "walllight2" },
                },
                presets = {
                    {
                        label = "Clean",
                        sets = {
                            "wallframe1",
                            "windowframe2",
                            "doorframe2",
                            "bathroomlight",
                            "livingroomlight",
                            "kitchenlight",
                            "bedroomlight",
                            "walllight2",
                            "bedroom2",
                            "bathroom2",
                        },
                        ipls = {}
                    },
                    {
                        label = "Dirty",
                        sets = {
                            "wallframe1",
                            "windowframe2",
                            "doorframe2",
                            "walllight1",
                            "bathroomlight",
                            "livingroomlight",
                            "kitchenlight",
                            "bedroomlight",
                            "bedroom2",
                            "bathroom2",
                            "bedroomdirt",
                            "livingroomdirt",
                            "kitchendirt",
                        },
                        ipls = {}
                    },
                    {
                        label = "Lights Off",
                        sets = {
                            "wallframe1",
                            "windowframe2",
                            "doorframe2",
                            "bedroom2",
                            "bathroom2",
                            "bedroomdirt",
                            "livingroomdirt",
                            "kitchendirt",
                        },
                        ipls = {}
                    }
                }
            },
            {
                id = "prompts_sandy_house5",
                name = "House 5",
                coords = vec3(1425.434, 3669.213, 35.62526),
                adminOnly = false,
                defaults = {
                    sets = {
                        "wallframe1",
                        "windowframe2",
                        "doorframe2",
                        "livingroomlight",
                        "kitchenlight",
                        "halllight",
                        "bathroomlight",
                        "masterbathroomlight",
                        "masterbedroomlight",
                        "bedroomlight",
                        "bathroom2",
                        "bedroom2",
                        "masterbathroom1",
                        "bath1",
                    }
                },
                entitySets = {
                    { label = "Living Room Light",     set = "livingroomlight" },
                    { label = "Kitchen Light",         set = "kitchenlight" },
                    { label = "Hall Light",            set = "halllight" },
                    { label = "Bathroom Light",        set = "bathroomlight" },
                    { label = "Master Bathroom Light", set = "masterbathroomlight" },
                    { label = "Master Bedroom Light",  set = "masterbedroomlight" },
                    { label = "Bedroom Light",         set = "bedroomlight" },
                    { label = "Master Bathroom 1",     set = "masterbathroom1" },
                    { label = "Master Bathroom 2",     set = "masterbathroom2" },
                    { label = "Bathroom 1",            set = "bathroom1" },
                    { label = "Bathroom 2",            set = "bathroom2" },
                    { label = "Master Bedroom 1",      set = "masterbedroom1" },
                    { label = "Master Bedroom 2",      set = "masterbedroom2" },
                    { label = "Master Bedroom 3",      set = "masterbedroom3" },
                    { label = "Bedroom 1",             set = "bedroom1" },
                    { label = "Bedroom 2",             set = "bedroom2" },
                    { label = "Bedroom 3",             set = "bedroom3" },
                    { label = "Bathroom Set 1",        set = "bath1" },
                    { label = "Bathroom Set 2",        set = "bath2" },
                    { label = "Master Bathroom Set 1", set = "masterbath1" },
                    { label = "Master Bathroom Set 2", set = "masterbath2" },
                    { label = "Living Room Dirt",      set = "livingroomdirt" },
                    { label = "Kitchen Dirt",          set = "kitchendirt" },
                    { label = "Hall Dirt",             set = "halldirt" },
                    { label = "Bedroom Dirt",          set = "bedroomdirt" },
                    { label = "Master Bedroom Dirt",   set = "masterbedroomdirt" },
                    { label = "Door Frame 1",          set = "doorframe1" },
                    { label = "Door Frame 2",          set = "doorframe2" },
                    { label = "Wall Frame 1",          set = "wallframe1" },
                    { label = "Wall Frame 2",          set = "wallframe2" },
                    { label = "Window Frame 1",        set = "windowframe1" },
                    { label = "Window Frame 2",        set = "windowframe2" },
                    { label = "Upper Frame",           set = "upframe" },
                },
                presets = {
                    {
                        label = "Clean",
                        sets = {
                            "wallframe1",
                            "windowframe2",
                            "doorframe2",
                            "livingroomlight",
                            "kitchenlight",
                            "halllight",
                            "bathroomlight",
                            "masterbathroomlight",
                            "masterbedroomlight",
                            "bedroomlight",
                            "bathroom2",
                            "bedroom2",
                            "masterbathroom1",
                            "bath1",
                        },
                        ipls = {}
                    },
                    {
                        label = "Dirty",
                        sets = {
                            "wallframe1",
                            "windowframe2",
                            "doorframe2",
                            "livingroomlight",
                            "kitchenlight",
                            "halllight",
                            "bathroomlight",
                            "masterbathroomlight",
                            "masterbedroomlight",
                            "bedroomlight",
                            "bathroom2",
                            "bedroom2",
                            "masterbedroomdirt",
                            "masterbathroom1",
                            "bath1",
                            "livingroomdirt",
                            "kitchendirt",
                            "halldirt",
                            "bedroomdirt",
                        },
                        ipls = {}
                    },
                    {
                        label = "Lights Off",
                        sets = {
                            "wallframe1",
                            "windowframe2",
                            "doorframe2",
                            "bathroom2",
                            "bedroom2",
                            "masterbedroomdirt",
                            "masterbathroom1",
                            "bath1",
                            "livingroomdirt",
                            "kitchendirt",
                            "halldirt",
                            "bedroomdirt",
                        },
                        ipls = {}
                    }
                }
            },
            {
                id = "prompts_sandy_house6",
                name = "House 6",
                coords = vec3(1794.129, 3717.376, 35.1188),
                adminOnly = false,
                defaults = {
                    sets = {
                        "wallframe1",
                        "windowframe2",
                        "doorframe2",
                        "bathroomlight",
                        "livingroomlight",
                        "kitchenlight",
                        "bedroomlight",
                        "halllight",
                        "bathroom1",
                        "bedroom2",
                    }
                },
                entitySets = {
                    { label = "Bathroom Light",    set = "bathroomlight" },
                    { label = "Living Room Light", set = "livingroomlight" },
                    { label = "Kitchen Light",     set = "kitchenlight" },
                    { label = "Bedroom Light",     set = "bedroomlight" },
                    { label = "Hall Light",        set = "halllight" },
                    { label = "Bathroom 1",        set = "bathroom1" },
                    { label = "Bathroom 2",        set = "bathroom2" },
                    { label = "Bathroom 3",        set = "bathroom3" },
                    { label = "Bedroom 1",         set = "bedroom1" },
                    { label = "Bedroom 2",         set = "bedroom2" },
                    { label = "Bedroom 3",         set = "bedroom3" },
                    { label = "Bathroom Set 1",    set = "bath1" },
                    { label = "Bathroom Set 2",    set = "bath2" },
                    { label = "Bedroom Dirt",      set = "bedroomdirt" },
                    { label = "Living Room Dirt",  set = "livingroomdirt" },
                    { label = "Kitchen Dirt",      set = "kitchendirt" },
                    { label = "Hall Dirt",         set = "halldirt" },
                    { label = "Door Frame 1",      set = "doorframe1" },
                    { label = "Door Frame 2",      set = "doorframe2" },
                    { label = "Window Frame 1",    set = "windowframe1" },
                    { label = "Window Frame 2",    set = "windowframe2" },
                    { label = "Wall Frame 1",      set = "wallframe1" },
                    { label = "Wall Frame 2",      set = "wallframe2" },
                    { label = "Upper Frame",       set = "upframe" },
                },
                presets = {
                    {
                        label = "Clean",
                        sets = {
                            "wallframe1",
                            "windowframe2",
                            "doorframe2",
                            "bathroomlight",
                            "livingroomlight",
                            "kitchenlight",
                            "bedroomlight",
                            "halllight",
                            "bathroom1",
                            "bedroom2",
                        },
                        ipls = {}
                    },
                    {
                        label = "Dirty",
                        sets = {
                            "wallframe1",
                            "windowframe2",
                            "doorframe2",
                            "bathroomlight",
                            "livingroomlight",
                            "kitchenlight",
                            "bedroomlight",
                            "halllight",
                            "bathroom1",
                            "bedroom2",
                            "bedroomdirt",
                            "livingroomdirt",
                            "kitchendirt",
                            "halldirt",
                        },
                        ipls = {}
                    },
                    {
                        label = "Lights Off",
                        sets = {
                            "wallframe1",
                            "windowframe2",
                            "doorframe2",
                            "bathroom3",
                            "bedroom2",
                            "bedroomdirt",
                            "livingroomdirt",
                            "kitchendirt",
                            "halldirt",
                        },
                        ipls = {}
                    }
                }
            },
            {
                id = "prompts_sandy_house7",
                name = "House 7",
                coords = vec3(1644.035, 3660.563, 35.57352),
                adminOnly = false,
                defaults = {
                    sets = {
                        "wallframe1",
                        "windowframe2",
                        "doorframe1",
                        "masterbedroomlight",
                        "bathroomlight",
                        "livingroomlight",
                        "kitchenlight",
                        "bedroomlight",
                        "halllight",
                        "masterbathroomlight",
                        "bathroomblinds",
                        "masterbedroom1",
                        "masterbathroom1",
                        "bathroom1",
                        "bedroom3",
                        "bath2",
                        "masterbath1",
                    }
                },
                entitySets = {
                    { label = "Master Bedroom Light",  set = "masterbedroomlight" },
                    { label = "Bathroom Light",        set = "bathroomlight" },
                    { label = "Living Room Light",     set = "livingroomlight" },
                    { label = "Kitchen Light",         set = "kitchenlight" },
                    { label = "Bedroom Light",         set = "bedroomlight" },
                    { label = "Hall Light",            set = "halllight" },
                    { label = "Master Bathroom Light", set = "masterbathroomlight" },
                    { label = "Bathroom 1",            set = "bathroom1" },
                    { label = "Bathroom 2",            set = "bathroom2" },
                    { label = "Bedroom 1",             set = "bedroom1" },
                    { label = "Bedroom 2",             set = "bedroom2" },
                    { label = "Bedroom 3",             set = "bedroom3" },
                    { label = "Master Bedroom 1",      set = "masterbedroom1" },
                    { label = "Master Bedroom 2",      set = "masterbedroom2" },
                    { label = "Master Bedroom 3",      set = "masterbedroom3" },
                    { label = "Master Bedroom 4",      set = "masterbedroom4" },
                    { label = "Master Bathroom 1",     set = "masterbathroom1" },
                    { label = "Master Bathroom 2",     set = "masterbathroom2" },
                    { label = "Master Bathroom 3",     set = "masterbathroom3" },
                    { label = "Bathroom Set 1",        set = "bath1" },
                    { label = "Bathroom Set 2",        set = "bath2" },
                    { label = "Master Bathroom Set 1", set = "masterbath1" },
                    { label = "Master Bathroom Set 2", set = "masterbath2" },
                    { label = "Bedroom Dirt",          set = "bedroomdirt" },
                    { label = "Living Room Dirt",      set = "livingroomdirt" },
                    { label = "Kitchen Dirt",          set = "kitchendirt" },
                    { label = "Hall Dirt",             set = "halldirt" },
                    { label = "Master Bedroom Dirt",   set = "masterbedroomdirt" },
                    { label = "Door Frame 1",          set = "doorframe1" },
                    { label = "Door Frame 2",          set = "doorframe2" },
                    { label = "Window Frame 1",        set = "windowframe1" },
                    { label = "Window Frame 2",        set = "windowframe2" },
                    { label = "Wall Frame 1",          set = "wallframe1" },
                    { label = "Wall Frame 2",          set = "wallframe2" },
                    { label = "Curtains",              set = "curtains" },
                    { label = "Upper Frame",           set = "upframe" },
                    { label = "Bathroom Blinds",       set = "bathroomblinds" },
                    { label = "Curtains 2",            set = "curtains2" },
                },
                presets = {
                    {
                        label = "Clean",
                        sets = {
                            "wallframe1",
                            "windowframe2",
                            "doorframe1",
                            "masterbedroomlight",
                            "bathroomlight",
                            "livingroomlight",
                            "kitchenlight",
                            "bedroomlight",
                            "halllight",
                            "masterbathroomlight",
                            "bathroomblinds",
                            "masterbedroom1",
                            "masterbathroom1",
                            "bathroom1",
                            "bedroom3",
                            "bath2",
                            "masterbath1",
                        },
                        ipls = {}
                    },
                    {
                        label = "Dirty",
                        sets = {
                            "wallframe1",
                            "windowframe2",
                            "doorframe1",
                            "masterbedroomlight",
                            "bathroomlight",
                            "livingroomlight",
                            "kitchenlight",
                            "bedroomlight",
                            "halllight",
                            "masterbathroomlight",
                            "bathroomblinds",
                            "masterbedroom3",
                            "masterbathroom1",
                            "bathroom1",
                            "bedroomdirt",
                            "livingroomdirt",
                            "kitchendirt",
                            "halldirt",
                            "masterbedroomdirt",
                            "bedroom3",
                            "bath2",
                            "masterbath1",
                        },
                        ipls = {}
                    },
                    {
                        label = "Lights Off",
                        sets = {
                            "wallframe1",
                            "windowframe2",
                            "doorframe1",
                            "bathroomblinds",
                            "masterbedroom2",
                            "masterbathroom1",
                            "bathroom1",
                            "bedroomdirt",
                            "livingroomdirt",
                            "kitchendirt",
                            "halldirt",
                            "masterbedroomdirt",
                            "bedroom3",
                            "bath2",
                            "masterbath1",
                        },
                        ipls = {}
                    }
                }
            },
            {
                id = "prompts_sandy_house8",
                name = "House 8",
                coords = vec3(1384.889, 3610.139, 35.468),
                adminOnly = false,
                defaults = {
                    sets = {
                        "wallframe1",
                        "windowframe1",
                        "doorframe2",
                        "masterbedroomlight",
                        "bathroomlight",
                        "livingroomlight",
                        "kitchenlight",
                        "bedroomlight",
                        "halllight",
                        "bedroom1",
                        "masterbedroom3",
                        "masterbathroom1",
                        "masterbath1",
                    }
                },
                entitySets = {
                    { label = "Master Bedroom Light",  set = "masterbedroomlight" },
                    { label = "Bathroom Light",        set = "bathroomlight" },
                    { label = "Living Room Light",     set = "livingroomlight" },
                    { label = "Kitchen Light",         set = "kitchenlight" },
                    { label = "Bedroom Light",         set = "bedroomlight" },
                    { label = "Hall Light",            set = "halllight" },
                    { label = "Bathroom 1",            set = "bathroom1" },
                    { label = "Bathroom 2",            set = "bathroom2" },
                    { label = "Bedroom 1",             set = "bedroom1" },
                    { label = "Bedroom 2",             set = "bedroom2" },
                    { label = "Bedroom 3",             set = "bedroom3" },
                    { label = "Master Bedroom 1",      set = "masterbedroom1" },
                    { label = "Master Bedroom 2",      set = "masterbedroom2" },
                    { label = "Master Bedroom 3",      set = "masterbedroom3" },
                    { label = "Master Bathroom 1",     set = "masterbathroom1" },
                    { label = "Master Bathroom 2",     set = "masterbathroom2" },
                    { label = "Bathroom Set 1",        set = "bath1" },
                    { label = "Bathroom Set 2",        set = "bath2" },
                    { label = "Master Bathroom Set 1", set = "masterbath1" },
                    { label = "Master Bathroom Set 2", set = "masterbath2" },
                    { label = "Bedroom Dirt",          set = "bedroomdirt" },
                    { label = "Living Room Dirt",      set = "livingroomdirt" },
                    { label = "Kitchen Dirt",          set = "kitchendirt" },
                    { label = "Hall Dirt",             set = "halldirt" },
                    { label = "Master Bedroom Dirt",   set = "masterbedroomdirt" },
                    { label = "Door Frame 1",          set = "doorframe1" },
                    { label = "Door Frame 2",          set = "doorframe2" },
                    { label = "Window Frame 1",        set = "windowframe1" },
                    { label = "Window Frame 2",        set = "windowframe2" },
                    { label = "Wall Frame 1",          set = "wallframe1" },
                    { label = "Wall Frame 2",          set = "wallframe2" },
                    { label = "Curtains",              set = "curtains" },
                },
                presets = {
                    {
                        label = "Clean",
                        sets = {
                            "wallframe1",
                            "windowframe1",
                            "doorframe2",
                            "masterbedroomlight",
                            "bathroomlight",
                            "livingroomlight",
                            "kitchenlight",
                            "bedroomlight",
                            "halllight",
                            "bedroom1",
                            "masterbedroom3",
                            "masterbathroom1",
                            "masterbath1",
                        },
                        ipls = {}
                    },
                    {
                        label = "Dirty",
                        sets = {
                            "wallframe1",
                            "windowframe1",
                            "doorframe2",
                            "masterbedroomlight",
                            "bathroomlight",
                            "livingroomlight",
                            "kitchenlight",
                            "bedroomlight",
                            "halllight",
                            "masterbathroom2",
                            "bedroom1",
                            "masterbedroom3",
                            "masterbath1",
                            "bedroomdirt",
                            "livingroomdirt",
                            "kitchendirt",
                            "halldirt",
                            "masterbedroomdirt",
                        },
                        ipls = {}
                    },
                    {
                        label = "Lights Off",
                        sets = {
                            "wallframe1",
                            "windowframe1",
                            "doorframe2",
                            "masterbathroom2",
                            "bedroom1",
                            "masterbedroom3",
                            "masterbathroom1",
                            "masterbath1",
                            "bedroomdirt",
                            "livingroomdirt",
                            "kitchendirt",
                            "halldirt",
                            "masterbedroomdirt",
                        },
                        ipls = {}
                    }
                }
            },
            {
                id = "prompts_sandy_house9",
                name = "House 9",
                coords = vec3(1827.661, 3738.009, 32.46845),
                adminOnly = false,
                defaults = {
                    sets = {
                        "wallframe2",
                        "windowframe2",
                        "doorframe1",
                        "bathroomlight",
                        "livingroomlight",
                        "kitchenlight",
                        "bedroomlight",
                        "halllight",
                        "bathroom2",
                        "bedroom3",
                        "bath1",
                    }
                },
                entitySets = {
                    { label = "Bathroom Light",    set = "bathroomlight" },
                    { label = "Living Room Light", set = "livingroomlight" },
                    { label = "Kitchen Light",     set = "kitchenlight" },
                    { label = "Bedroom Light",     set = "bedroomlight" },
                    { label = "Hall Light",        set = "halllight" },
                    { label = "Bathroom 1",        set = "bathroom1" },
                    { label = "Bathroom 2",        set = "bathroom2" },
                    { label = "Bedroom 1",         set = "bedroom1" },
                    { label = "Bedroom 2",         set = "bedroom2" },
                    { label = "Bedroom 3",         set = "bedroom3" },
                    { label = "Bathroom Set 1",    set = "bath1" },
                    { label = "Bathroom Set 2",    set = "bath2" },
                    { label = "Bedroom Dirt",      set = "bedroomdirt" },
                    { label = "Living Room Dirt",  set = "livingroomdirt" },
                    { label = "Kitchen Dirt",      set = "kitchendirt" },
                    { label = "Hall Dirt",         set = "halldirt" },
                    { label = "Door Frame 1",      set = "doorframe1" },
                    { label = "Door Frame 2",      set = "doorframe2" },
                    { label = "Window Frame 1",    set = "windowframe1" },
                    { label = "Window Frame 2",    set = "windowframe2" },
                    { label = "Wall Frame 1",      set = "wallframe1" },
                    { label = "Wall Frame 2",      set = "wallframe2" },
                },
                presets = {
                    {
                        label = "Clean",
                        sets = {
                            "wallframe2",
                            "windowframe2",
                            "doorframe1",
                            "bathroomlight",
                            "livingroomlight",
                            "kitchenlight",
                            "bedroomlight",
                            "halllight",
                            "bathroom2",
                            "bedroom3",
                            "bath1",
                        },
                        ipls = {}
                    },
                    {
                        label = "Dirty",
                        sets = {
                            "wallframe2",
                            "windowframe2",
                            "doorframe1",
                            "bathroomlight",
                            "livingroomlight",
                            "kitchenlight",
                            "bedroomlight",
                            "halllight",
                            "bathroom2",
                            "bedroom3",
                            "bath1",
                            "bedroomdirt",
                            "livingroomdirt",
                            "kitchendirt",
                            "halldirt",
                        },
                        ipls = {}
                    },
                    {
                        label = "Lights Off",
                        sets = {
                            "wallframe2",
                            "windowframe2",
                            "doorframe1",
                            "bathroom2",
                            "bedroom3",
                            "bath1",
                            "bedroomdirt",
                            "livingroomdirt",
                            "kitchendirt",
                            "halldirt",
                        },
                        ipls = {}
                    }
                }
            },
            {
                id = "prompts_sandy_house10",
                name = "House 10",
                coords = vec3(1677.48, 3653.435, 37.39836),
                adminOnly = false,
                defaults = {
                    sets = {
                        "wallframe1",
                        "windowframe1",
                        "doorframe2",
                        "bathroomlight",
                        "livingroomlight",
                        "kitchenlight",
                        "bedroomlight",
                        "halllight",
                        "bathroom1",
                        "bath2",
                    }
                },
                entitySets = {
                    { label = "Bathroom Light",    set = "bathroomlight" },
                    { label = "Living Room Light", set = "livingroomlight" },
                    { label = "Kitchen Light",     set = "kitchenlight" },
                    { label = "Bedroom Light",     set = "bedroomlight" },
                    { label = "Hall Light",        set = "halllight" },
                    { label = "Bathroom 1",        set = "bathroom1" },
                    { label = "Bathroom 2",        set = "bathroom2" },
                    { label = "Bedroom 1",         set = "bedroom1" },
                    { label = "Bedroom 2",         set = "bedroom2" },
                    { label = "Bedroom 3",         set = "bedroom3" },
                    { label = "Bathroom Set 1",    set = "bath1" },
                    { label = "Bathroom Set 2",    set = "bath2" },
                    { label = "Bedroom Dirt",      set = "bedroomdirt" },
                    { label = "Living Room Dirt",  set = "livingroomdirt" },
                    { label = "Kitchen Dirt",      set = "kitchendirt" },
                    { label = "Hall Dirt",         set = "halldirt" },
                    { label = "Door Frame 1",      set = "doorframe1" },
                    { label = "Door Frame 2",      set = "doorframe2" },
                    { label = "Window Frame 1",    set = "windowframe1" },
                    { label = "Window Frame 2",    set = "windowframe2" },
                    { label = "Wall Frame 1",      set = "wallframe1" },
                    { label = "Wall Frame 2",      set = "wallframe2" },
                },
                presets = {
                    {
                        label = "Clean",
                        sets = {
                            "wallframe1",
                            "windowframe1",
                            "doorframe2",
                            "bathroomlight",
                            "livingroomlight",
                            "kitchenlight",
                            "bedroomlight",
                            "halllight",
                            "bathroom1",
                            "bath2",
                        },
                        ipls = {}
                    },
                    {
                        label = "Dirty",
                        sets = {
                            "wallframe1",
                            "windowframe1",
                            "doorframe2",
                            "bathroomlight",
                            "livingroomlight",
                            "kitchenlight",
                            "bedroomlight",
                            "halllight",
                            "bathroom1",
                            "bedroomdirt",
                            "bath2",
                            "livingroomdirt",
                            "kitchendirt",
                            "halldirt",
                        },
                        ipls = {}
                    },
                    {
                        label = "Lights Off",
                        sets = {
                            "wallframe1",
                            "windowframe1",
                            "doorframe2",
                            "bathroom1",
                            "bedroomdirt",
                            "bath2",
                            "livingroomdirt",
                            "kitchendirt",
                            "halldirt",
                        },
                        ipls = {}
                    }
                }
            }
        }
    },
    {
        folder = "Repair Garages",
        interiors = {
            {
                id = "prompts_repair_garage1",
                name = "Paleto Repair Garage",
                coords = vec3(-292.54, 6042.77, 32.21),
                adminOnly = false,
                defaults = {
                    sets = {
                        "1",
                    }
                },
                entitySets = {
                    { label = "Dirty", set = "1" },
                    { label = "Clean", set = "2" }
                }
            },
            {
                id = "prompts_repair_garage2",
                name = "City Repair Garage",
                coords = vec3(990.01, -1393.61, 32.43),
                adminOnly = false,
                defaults = {
                    sets = {
                        "1",
                    }
                },
                entitySets = {
                    { label = "Dirty", set = "1" },
                    { label = "Clean", set = "2" }
                }
            },
            {
                id = "prompts_repair_garage3",
                name = "Chumash Repair Garage",
                coords = vec3(-2969.34, 438.79, 17.16),
                adminOnly = false,
                defaults = {
                    sets = {
                        "1",
                    }
                },
                entitySets = {
                    { label = "Dirty", set = "1" },
                    { label = "Clean", set = "2" }
                }
            },
            {
                id = "prompts_repair_garage4",
                name = "Highway Repair Garage",
                coords = vec3(2573.65, 481.06, 109.83),
                adminOnly = false,
                defaults = {
                    sets = {
                        "1",
                    }
                },
                entitySets = {
                    { label = "Dirty", set = "1" },
                    { label = "Clean", set = "2" }
                }
            },
            {
                id = "prompts_repair_garage5",
                name = "Beach Repair Garage",
                coords = vec3(-1645.78, -794.85, 11.17),
                adminOnly = false,
                defaults = {
                    sets = {
                        "1",
                    }
                },
                entitySets = {
                    { label = "Dirty", set = "1" },
                    { label = "Clean", set = "2" }
                }
            }
        }
    }
}

-- List of interiors available in the system.
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
        entitySets = {
            { label = "Static Elevator",   set = "static_elevator" },
            { label = "Conference Chairs", set = "conference_chairs" },
            { label = "Meeting Table",     set = "conference_meeting_table" },
            { label = "Voting Room",       set = "eventroom_voting" }
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
