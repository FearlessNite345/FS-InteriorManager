// dev-snapshot.ts
import type { Snapshot, Interior, EntitySet, Ipl, Preset } from "./Types";

const rand = (min: number, max: number) => Math.random() * (max - min) + min;

const baseSets: EntitySet[] = [
  { set: "lights_main", label: "Main Lights" },
  { set: "lights_aux", label: "Aux Lights" },
  { set: "decor_plants", label: "Plants" },
  { set: "decor_posters", label: "Posters" },
  { set: "props_boxes", label: "Storage Boxes" },
];

const baseIpls: Ipl[] = [
  { name: "shell_a", label: "Shell A" },
  { name: "shell_b", label: "Shell B" },
  { name: "shell_c", label: "Shell C" },
];

function makeState(sets: EntitySet[], ipls: Ipl[]): Record<string, boolean> {
  const s: Record<string, boolean> = {};
  sets.forEach((e) => (s[e.set] = Math.random() < 0.5));
  ipls.forEach((i) => (s[i.name] = Math.random() < 0.7));
  return s;
}

function makePresets(): Preset[] {
  return [
    { label: "Clean", sets: ["lights_main", "decor_plants"], ipls: ["shell_a"] },
    { label: "Showroom", sets: ["lights_aux", "decor_posters"], ipls: ["shell_b"] },
    { label: "Storage", sets: ["props_boxes"], ipls: ["shell_c"] },
  ];
}

function makeInterior(id: string, name: string): Interior {
  // vary sets a bit to avoid everything identical
  const sets = baseSets
    .map((x) => ({ ...x }))
    .slice(0, 3 + Math.floor(Math.random() * (baseSets.length - 2)));
  const ipls = baseIpls
    .map((x) => ({ ...x }))
    .slice(0, 1 + Math.floor(Math.random() * baseIpls.length));
  return {
    id,
    name,
    coords: { x: rand(-2000, 2000), y: rand(-2000, 2000), z: rand(10, 120) },
    adminOnly: Math.random() < 0.15,
    entitySets: sets,
    ipls,
    presets: makePresets(),
    state: makeState(sets, ipls),
  };
}

function makeMany(prefix: string, count: number): Interior[] {
  const arr: Interior[] = [];
  for (let i = 1; i <= count; i++) {
    arr.push(makeInterior(`${prefix}_${i}`, `${prefix.replace(/_/g, " ")} ${i}`));
  }
  return arr;
}

const folderNames = [
  "Penthouses",
  "Arcades",
  "Ammu-Nation",
  "Banks",
  "Nightclubs",
  "Warehouses",
  "Apartments",
  "Stores",
  "Police Stations",
  "Medical",
  "Customs Garages",
  "Offices",
];

const folders = folderNames.map((name, idx) => ({
  name,
  interiors: makeMany(name.toLowerCase().replace(/\s+/g, "_"), 25 + (idx % 10)),
}));

const topLevel = [
  ...makeMany("Downtown_Apt", 30),
  ...makeMany("Industrial_Lot", 20),
];

export const DEV_SNAPSHOT: Snapshot = {
  title: "Interior Manager",
  allowed: true,
  interiors: topLevel,
  folders,
};
