export type Vec3 = { x: number; y: number; z: number };

export type EntitySet = {
  set: string;
  label: string;
  hidden?: boolean;
};

export type Ipl = {
  name: string;
  label: string;
  hidden?: boolean;
};

export type Preset = {
  label: string;
  sets?: string[];
  ipls?: string[];
};

export type Interior = {
  id: string;
  name: string;
  coords: Vec3;
  adminOnly?: boolean;
  entitySets: EntitySet[];
  ipls?: Ipl[];
  presets?: Preset[];
  state: Record<string, boolean>;
};

export type Folder = {
  name: string;
  interiors: Interior[];
};

export type Snapshot = {
  title: string;
  allowed: boolean;
  interiors: Interior[];
  folders: Folder[];
};
