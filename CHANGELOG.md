# Changelog v1.4.4
- Fixed an issue where interiors marked as `adminOnly` were incorrectly hidden from all players, including admins. These interiors now appear properly in the picker and HUD for admins, while still remaining hidden from non-admins.

# Changelog v1.4.3
- Fixed version checker incorrectly telling you to download from the portal instead of GitHub  
- Fixed fxmanifest.lua having the wrong version which caused it to always say an update was needed  
- Added a new feature where the interiors picker automatically collapses when one is selected, giving much more space for the interior details

# Changelog v1.4.2
- FS-Lib is no longer required for this script to function and it now runs completely standalone

# Changelog v1.4.1
- Renamed all Prompts Sandy Shores houses to match the numbers displayed on each property.
- Fixed an issue where two different houses were teleporting to the same location (House 1018). The duplicate now correctly points to House 1017.

# Changelog v1.4.0
- Added full support for the *Prompts: Sandy Shores Houses – Part 1* update.
- Fixed an issue where transparency effects weren’t displaying correctly.
- Introduced a new **Shortcuts** section in the UI, displaying all available hotkeys for quick navigation.

# Changelog v1.3.0
- Added a brand-new standalone UI.
- Removed **ox_lib** dependency (script no longer requires ox_lib).
- Added Prompt's new SAHP stations.
- Added Prompt's Motel Room Entity Set.

# Changelog v1.2.0
- Fixed various issues with the UI
- Added a new config option for entity sets where you can do `hidden = true` to hide that entity set from the menu but it will still be managed by this script
