// dev-snapshot.ts
import type { Snapshot } from "./Types"; // or wherever your Snapshot type lives

export const DEV_SNAPSHOT: Snapshot = {
  title: "Interior Manager",
  allowed: true,
  interiors: [
    {
      id: "int_ltd_davis",
      name: "Davis LTD Gas",
      coords: { x: -47.52, y: -1758.52, z: 29.42 },
      adminOnly: false,
      entitySets: [
        { label: "Bathroom Light", set: "bathroomlight" },
        { label: "Hall Light", set: "halllight" },
        { label: "Bedroom Light", set: "bedroomlight" },
        { label: "Master Bedroom Light", set: "masterbedroomlight" },
        { label: "Bathroom 1", set: "bathroom1" },
        { label: "Bathroom 2", set: "bathroom2" },
        { label: "Master Bathroom 1", set: "masterbathroom1" },
        { label: "Master Bathroom 2", set: "masterbathroom2" },
        { label: "Bedroom 1", set: "bedroom1" },
        { label: "Bedroom 2", set: "bedroom2" },
        { label: "Bedroom 3", set: "bedroom3" },
        { label: "Master Bedroom 1", set: "masterbedroom1" },
        { label: "Master Bedroom 2", set: "masterbedroom2" },
        { label: "Master Bedroom 3", set: "masterbedroom3" },
        { label: "Bath 1", set: "bath1" },
        { label: "Bath 2", set: "bath2" },
        { label: "Master Bath 1", set: "masterbath1" },
        { label: "Master Bath 2", set: "masterbath2" },
        { label: "Bedroom Dirt", set: "bedroomdirt" },
        { label: "Hall Dirt", set: "halldirt" },
        { label: "Master Bedroom Dirt", set: "masterbedroomdirt" },
        { label: "Door Frame 1", set: "doorframe1" },
        { label: "Door Frame 2", set: "doorframe2" },
        { label: "Window Frame 1", set: "windowframe1" },
        { label: "Window Frame 2", set: "windowframe2" },
        { label: "Wall Frame 1", set: "wallframe1" },
        { label: "Wall Frame 2", set: "wallframe2" },
        { label: "Upper Frame", set: "upframe" },
        { label: "Radiator Place", set: "radiatorplace" },
        { label: "Fireplace", set: "fireplace" },
      ],
      ipls: [
        { name: "hei_dt1_03_gr_apt1", label: "Apartment Props A" },
        { name: "v_ret_ml_win2", label: "Store Windows" },
      ],
      presets: [
        {
          label: "Store Clean",
          sets: ["cash_register", "back_office"],
          ipls: ["v_ret_ml_win2"],
        },
        {
          label: "Robbery Ready",
          sets: ["cash_register", "stockroom_crates"],
          ipls: ["hei_dt1_03_gr_apt1"],
        },
        {
          label: "Store Clean2",
          sets: ["cash_register", "back_office"],
          ipls: ["v_ret_ml_win2"],
        },
        {
          label: "Robbery Ready2",
          sets: ["cash_register", "stockroom_crates"],
          ipls: ["hei_dt1_03_gr_apt1"],
        },
        {
          label: "Store Clean3",
          sets: ["cash_register", "back_office"],
          ipls: ["v_ret_ml_win2"],
        },
        {
          label: "Robbery Ready3",
          sets: ["cash_register", "stockroom_crates"],
          ipls: ["hei_dt1_03_gr_apt1"],
        },
      ],
      state: {
        cash_register: true,
        back_office: false,
        stockroom_crates: true,
        hei_dt1_03_gr_apt1: false,
        v_ret_ml_win2: true,
      },
    },
    {
      id: "int_sandy_bank",
      name: "Sandy Shores Bank",
      coords: { x: 1175.01, y: 2708.37, z: 38.09 },
      adminOnly: true,
      entitySets: [
        { set: "vault_door_open", label: "Vault Door Open" },
        { set: "vault_lights", label: "Vault Lights" },
        { set: "lobby_debris", label: "Lobby Debris" },
      ],
      ipls: [{ name: "v_bank_sandy_milo", label: "Bank Shell" }],
      presets: [
        {
          label: "Closed",
          sets: ["vault_lights"],
          ipls: ["v_bank_sandy_milo"],
        },
        {
          label: "Heist Aftermath",
          sets: ["vault_door_open", "lobby_debris", "vault_lights"],
          ipls: ["v_bank_sandy_milo"],
        },
      ],
      state: {
        vault_door_open: false,
        vault_lights: true,
        lobby_debris: false,
        v_bank_sandy_milo: true,
      },
    },
  ],
  folders: [
    {
      name: "Penthouses",
      interiors: [
        {
          id: "int_eclipse_ph1",
          name: "Eclipse PH 1",
          coords: { x: -786.8663, y: 315.7642, z: 217.6385 },
          adminOnly: false,
          entitySets: [
            { set: "set_clean", label: "Clean Theme" },
            { set: "set_party", label: "Party Theme" },
          ],
          ipls: [{ name: "apa_v_mp_h_01_a", label: "Shell A" }],
          presets: [
            {
              label: "Party Mode",
              sets: ["set_party"],
              ipls: ["apa_v_mp_h_01_a"],
            },
          ],
          state: { set_clean: true, set_party: false, apa_v_mp_h_01_a: true },
        },
        {
          id: "int_eclipse_ph2",
          name: "Eclipse PH 2",
          coords: { x: -774.6987, y: 331.7133, z: 207.6218 },
          adminOnly: false,
          entitySets: [
            { set: "set_minimal", label: "Minimal Theme" },
            { set: "set_modern", label: "Modern Theme" },
          ],
          ipls: [{ name: "apa_v_mp_h_02_a", label: "Shell B" }],
          presets: [
            {
              label: "Modern Living",
              sets: ["set_modern"],
              ipls: ["apa_v_mp_h_02_a"],
            },
          ],
          state: {
            set_minimal: true,
            set_modern: false,
            apa_v_mp_h_02_a: true,
          },
        },
      ],
    },
    {
      name: "Arcades",
      interiors: [
        {
          id: "int_mirror_park_arcade",
          name: "Mirror Park Arcade",
          coords: { x: -561.24, y: 281.18, z: 85.68 },
          adminOnly: false,
          entitySets: [
            { set: "machines_on", label: "Machines Powered" },
            { set: "neon_signs", label: "Neon Signs" },
            { set: "backroom_tools", label: "Backroom Tools" },
          ],
          ipls: [{ name: "vw_dlc_casino_apart", label: "Arcade Shell" }],
          presets: [
            {
              label: "Open For Business",
              sets: ["machines_on", "neon_signs"],
              ipls: ["vw_dlc_casino_apart"],
            },
            {
              label: "Closed",
              sets: ["backroom_tools"],
              ipls: ["vw_dlc_casino_apart"],
            },
          ],
          state: {
            machines_on: true,
            neon_signs: true,
            backroom_tools: false,
            vw_dlc_casino_apart: true,
          },
        },
      ],
    },
  ],
};
