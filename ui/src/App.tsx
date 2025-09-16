import { useEffect, useMemo, useRef, useState, useLayoutEffect } from "react";
import {
  Card,
  Stack,
  Group,
  Text,
  TextInput,
  Switch,
  Button,
  ActionIcon,
  Tooltip,
  Divider,
  ScrollArea,
  Badge,
  Box,
  SegmentedControl,
} from "@mantine/core";
import {
  IconDoorExit,
  IconFocus,
  IconSearch,
  IconPlayerPlay,
  IconX,
  IconChevronDown,
  IconDeviceGamepad2,
} from "@tabler/icons-react";
import { handleNuiCallback } from "./handleNuiCallback";
import { useNuiEvent } from "./useNuiEvent";
import { DEV_SNAPSHOT } from "./dev-snapshot";

/* ------------------------- DESIGN TOKENS ------------------------- */
const UI = {
  radiusLg: 16,
  radiusMd: 12,
  panel: "rgba(18, 20, 24, 0.82)",
  panelElevated: "rgba(24, 26, 30, 0.85)",
  glass: "rgba(255, 255, 255, 0.04)",
  stroke: "rgba(255,255,255,0.08)",
  hover: "rgba(255,255,255,0.05)",
  keyFocus: "rgba(255,255,255,0.07)",
  active: "rgba(56, 149, 255, 0.12)",
  blue: "var(--mantine-color-blue-6)",
  textDim: "rgba(255,255,255,0.65)",
  aurora:
    "radial-gradient(1200px 500px at 80% -10%, rgba(64,171,255,.20), transparent 60%), radial-gradient(800px 400px at -20% 0%, rgba(125,90,255,.18), transparent 60%), radial-gradient(600px 300px at 50% 100%, rgba(0,255,170,.12), transparent 60%)",
  glow: "0 0 0 1px rgba(255,255,255,0.045), 0 10px 28px rgba(0,0,0,.40), 0 2px 8px rgba(0,0,0,.35)",
  glowActive:
    "0 0 0 1px rgba(80,140,255,0.35), 0 0 0 8px rgba(80,140,255,.06), 0 14px 36px rgba(10,35,80,.55)",
  ringBlue: "0 0 0 1px rgba(80,140,255,0.55)",
};

/* --------------------------- TYPES --------------------------- */
type Vec3 = { x: number; y: number; z: number };
type EntitySet = { set: string; label: string; hidden?: boolean };
type Ipl = { name: string; label: string; hidden?: boolean };
type Preset = { label: string; sets?: string[]; ipls?: string[] };
type Interior = {
  id: string;
  name: string;
  coords: Vec3;
  adminOnly?: boolean;
  entitySets: EntitySet[];
  ipls?: Ipl[];
  presets?: Preset[];
  state: Record<string, boolean>;
};
type Folder = { name: string; interiors: Interior[] };
type Snapshot = {
  title: string;
  allowed: boolean;
  interiors: Interior[];
  folders: Folder[];
};
type WithFolder = Interior & { __folder?: string };

/* ------------------------- COMPONENT ------------------------- */
export default function App() {
  const [open, setOpen] = useState(process.env.NODE_ENV === "development");
  const [uiHasFocus, setUiHasFocus] = useState(
    process.env.NODE_ENV === "development"
  );
  const [snap, setSnap] = useState<Snapshot | null>(
    process.env.NODE_ENV === "development" ? DEV_SNAPSHOT : null
  );
  const [query, setQuery] = useState("");
  const [activeId, setActiveId] = useState<string | null>(null);

  const [cursor, setCursor] = useState(0);
  const [hoverIdx, setHoverIdx] = useState<number | null>(null);
  const [usingKeys, setUsingKeys] = useState(false);

  const itemRefs = useRef<(HTMLDivElement | null)[]>([]);
  const searchRef = useRef<HTMLInputElement>(null);
  const [openedFolders, setOpenedFolders] = useState<string[]>([]);
  const [presetHoverIdx, setPresetHoverIdx] = useState<number | null>(null);

  // Measure "chrome" (everything above the details scroller)
  const chromeRef = useRef<HTMLDivElement>(null);
  const [chromeH, setChromeH] = useState(0);
  useLayoutEffect(() => {
    const update = () => setChromeH(chromeRef.current?.offsetHeight ?? 0);
    update();
    const ro =
      typeof ResizeObserver !== "undefined" ? new ResizeObserver(update) : null;
    if (chromeRef.current) ro?.observe(chromeRef.current);
    window.addEventListener("resize", update);
    return () => {
      ro?.disconnect();
      window.removeEventListener("resize", update);
    };
  }, []);

  const applyPresetAndRemember = (i: Interior, label: string) => {
    const p = i.presets?.find((x) => x.label === label);
    if (!p) return;
    handleNuiCallback("applyPreset", { id: i.id, sets: p.sets, ipls: p.ipls });
  };

  /* --------------------------- NUI events --------------------------- */
  useNuiEvent<{ payload: Snapshot }>("open", (data) => {
    setSnap(data.payload);
    setOpen(true);
    setActiveId(null);
    setCursor(0);
    setHoverIdx(null);
    setOpenedFolders([]);
    setUiHasFocus(true);
    setTimeout(() => searchRef.current?.focus(), 30);
  });
  useNuiEvent<undefined>("close", () => {
    setOpen(false);
    setSnap(null);
    setActiveId(null);
    setCursor(0);
    setHoverIdx(null);
    setOpenedFolders([]);
  });
  useNuiEvent<{ id: string; state: Record<string, boolean> }>(
    "stateUpdate",
    (data) => {
      setSnap((prev) => {
        if (!prev) return prev;
        const upd = structuredClone(prev);
        const apply = (arr: Interior[]) =>
          arr.forEach((it) => {
            if (it.id === data.id) it.state = data.state;
          });
        apply(upd.interiors);
        upd.folders.forEach((f) => apply(f.interiors));
        return upd;
      });
    }
  );
  useNuiEvent<{ uiHasFocus: boolean }>("focus", (data) =>
    setUiHasFocus(!!data.uiHasFocus)
  );

  /* ------------------------- Keyboard nav ------------------------- */
  useEffect(() => {
    const onKey = (e: KeyboardEvent) => {
      if (!open) return;
      if (e.key === "Escape") {
        e.preventDefault();
        handleNuiCallback("close");
        return;
      }
      if (e.code === "AltLeft") {
        e.preventDefault();
        handleNuiCallback("toggleFocus");
        return;
      }
      if (!visibleInteriors.length) return;

      if (e.key === "ArrowDown") {
        e.preventDefault();
        setUsingKeys(true);
        setCursor((c) => {
          const n = Math.min(c + 1, visibleInteriors.length - 1);
          setActiveId(visibleInteriors[n]?.id ?? null);
          return n;
        });
      } else if (e.key === "ArrowUp") {
        e.preventDefault();
        setUsingKeys(true);
        setCursor((c) => {
          const n = Math.max(c - 1, 0);
          setActiveId(visibleInteriors[n]?.id ?? null);
          return n;
        });
      } else if (e.key === "Enter") {
        e.preventDefault();
        setUsingKeys(true);
        const pick = visibleInteriors[cursor];
        if (pick) setActiveId(pick.id);
      }
    };
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
  }, [open, cursor]); // eslint-disable-line

  /* ---------------------------- Data shaping ---------------------------- */
  const topLevel = useMemo<Interior[]>(() => snap?.interiors ?? [], [snap]);
  const folders = useMemo<Folder[]>(() => snap?.folders ?? [], [snap]);

  const flattenedAll: WithFolder[] = useMemo(() => {
    if (!snap) return [];
    const a: WithFolder[] = [...topLevel.map((i) => ({ ...i }))];
    for (const f of folders)
      for (const i of f.interiors) a.push({ ...i, __folder: f.name });
    return a;
  }, [topLevel, folders, snap]);

  const searching = query.trim().length > 0;

  type Row =
    | { type: "folder"; name: string; count: number; opened: boolean }
    | { type: "interior"; item: WithFolder; indent: number };

  const rows: Row[] = useMemo(() => {
    const r: Row[] = [];
    if (searching) {
      const q = query.trim().toLowerCase();
      flattenedAll
        .filter(
          (i) =>
            i.name.toLowerCase().includes(q) ||
            (i.__folder?.toLowerCase().includes(q) ?? false)
        )
        .forEach((i) => r.push({ type: "interior", item: i, indent: 0 }));
      return r;
    }
    topLevel.forEach((i) => r.push({ type: "interior", item: i, indent: 0 }));
    for (const f of folders) {
      const opened = openedFolders.includes(f.name);
      r.push({
        type: "folder",
        name: f.name,
        count: f.interiors.length,
        opened,
      });
      if (opened)
        for (const it of f.interiors)
          r.push({
            type: "interior",
            item: { ...it, __folder: f.name },
            indent: 12,
          });
    }
    return r;
  }, [flattenedAll, topLevel, folders, openedFolders, searching, query]);

  const visibleInteriors: WithFolder[] = useMemo(
    () =>
      rows
        .filter((r) => r.type === "interior")
        .map((r) => (r as any).item as WithFolder),
    [rows]
  );

  const indexById = useMemo(() => {
    const map = new Map<string, number>();
    visibleInteriors.forEach((i, idx) => map.set(i.id, idx));
    return map;
  }, [visibleInteriors]);

  useEffect(() => {
    if (!visibleInteriors.length) {
      setCursor(0);
      setActiveId(null);
      return;
    }
    setCursor((c) => Math.min(c, visibleInteriors.length - 1));
  }, [visibleInteriors.length]);

  /* Manual collapse override for auto-open-by-selection */
  const manualCollapsed = useRef<Set<string>>(new Set());

  useEffect(() => {
    if (!searching && activeId) {
      manualCollapsed.current.clear();
      const item = flattenedAll.find((x) => x.id === activeId);
      const folder = item?.__folder;
      if (
        folder &&
        !manualCollapsed.current.has(folder) &&
        !openedFolders.includes(folder)
      ) {
        setOpenedFolders((p) => (p.includes(folder) ? p : [...p, folder]));
      }
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [activeId, searching, flattenedAll]);

  useEffect(() => {
    itemRefs.current[cursor]?.scrollIntoView({ block: "nearest" });
  }, [cursor]);

  /* Active always from full set (not only visible) */
  const active: WithFolder | null = useMemo(
    () =>
      activeId ? flattenedAll.find((i) => i.id === activeId) ?? null : null,
    [flattenedAll, activeId]
  );

  const canUse = (i?: Interior | null) =>
    !!i && (snap?.allowed || !i?.adminOnly);
  if (!open) return null;

  /* ----------------------------- Actions ----------------------------- */
  const toggleSet = (i: Interior, setName: string, next: boolean) =>
    handleNuiCallback("toggleSet", { id: i.id, set: setName, enabled: next });
  const toggleIpl = (i: Interior, name: string, next: boolean) =>
    handleNuiCallback("toggleIpl", { id: i.id, name, enabled: next });
  const disableAll = (i: Interior) =>
    handleNuiCallback("disableAll", { id: i.id });
  const teleportTo = (i: Interior) =>
    handleNuiCallback("teleportTo", { coords: i.coords });

  /* ----------------------------- Helpers ----------------------------- */
  const clearHover = () => setHoverIdx(null);
  const markMouseUse = () => setUsingKeys(false);
  const folderHasSelected = (name: string) =>
    flattenedAll.some((x) => x.__folder === name && x.id === activeId);

  /* -------------------------- Row renderers -------------------------- */
  const FolderRow = (name: string, count: number, opened: boolean) => {
    const hasSel = folderHasSelected(name);
    const bg = opened ? UI.glass : "transparent";
    const shadow = hasSel
      ? "inset 0 0 0 1px rgba(80,140,255,.65)"
      : "inset 0 0 0 1px rgba(255,255,255,.06)";
    return (
      <Box
        key={`folder-${name}`}
        onMouseEnter={markMouseUse}
        onClick={() => {
          const willCollapse = opened;
          setOpenedFolders((p) =>
            p.includes(name) ? p.filter((x) => x !== name) : [...p, name]
          );
          if (willCollapse && folderHasSelected(name)) {
            manualCollapsed.current.add(name);
          } else if (!willCollapse) {
            manualCollapsed.current.delete(name);
          }
        }}
        style={{
          display: "flex",
          alignItems: "center",
          gap: 8,
          padding: "6px 10px",
          height: 30,
          borderRadius: UI.radiusMd,
          cursor: "pointer",
          userSelect: "none",
          background: bg,
          border: `1px solid ${UI.stroke}`,
          boxShadow: shadow,
          transition: "box-shadow 140ms, background 140ms, transform 140ms",
        }}
      >
        <IconChevronDown
          size={14}
          style={{
            transform: `rotate(${opened ? 180 : 0}deg)`,
            transition: "transform 140ms",
            opacity: 0.9,
          }}
        />
        <Text size="sm" fw={700} style={{ letterSpacing: 0.2 }}>
          {name}
        </Text>
        <div style={{ flex: 1 }} />
        <Badge
          size="xs"
          variant={hasSel ? "filled" : "light"}
          color={hasSel ? "blue" : "gray"}
        >
          {count}
        </Badge>
      </Box>
    );
  };

  const InteriorRow = (i: WithFolder, indent: number) => {
    const navIdx = indexById.get(i.id)!;
    const isActive = i.id === activeId;
    const isKeyFocus = usingKeys && navIdx === cursor && !isActive;
    const isHover = hoverIdx === navIdx;
    const bg = isActive
      ? UI.active
      : isKeyFocus
      ? UI.keyFocus
      : isHover
      ? UI.hover
      : "transparent";
    const shadow = isActive
      ? "inset 0 0 0 1px rgba(80,140,255,.65)"
      : isHover
      ? "inset 0 0 0 1px rgba(255,255,255,.06)"
      : "inset 0 0 0 1px rgba(255,255,255,.06)";

    return (
      <div
        key={i.id}
        ref={(el) => {
          itemRefs.current[navIdx] = el;
        }}
        onMouseEnter={() => {
          markMouseUse();
          setHoverIdx(navIdx);
        }}
        onMouseLeave={clearHover}
        onClick={() => {
          setActiveId(i.id === activeId ? null : i.id);
          setCursor(navIdx);
        }}
        style={{
          display: "flex",
          alignItems: "center",
          gap: 8,
          padding: "6px 10px",
          height: 30,
          borderRadius: UI.radiusMd,
          marginLeft: indent,
          cursor: "pointer",
          background: bg,
          border: `1px solid ${UI.stroke}`,
          boxShadow: shadow,
          transition: "box-shadow 140ms, background 140ms, transform 140ms",
        }}
      >
        <Text
          size="sm"
          fw={isActive ? 700 : 500}
          style={{
            whiteSpace: "nowrap",
            overflow: "hidden",
            textOverflow: "ellipsis",
            color: isActive ? undefined : UI.textDim,
          }}
        >
          {i.name}
        </Text>
        <div style={{ flex: 1 }} />
        {i.__folder && query && (
          <Badge size="xs" variant="light">
            {i.__folder}
          </Badge>
        )}
        {i.adminOnly && (
          <Badge size="xs" variant="outline">
            ADMIN
          </Badge>
        )}
      </div>
    );
  };

  const PresetRow = (p: Preset, idx: number) => {
    const isHover = presetHoverIdx === idx;
    const bg = isHover ? UI.hover : "transparent";
    const shadow = "inset 0 0 0 1px rgba(255,255,255,.06)";
    const count = (p.sets?.length ?? 0) + (p.ipls?.length ?? 0);

    return (
      <div
        key={p.label}
        onMouseEnter={() => setPresetHoverIdx(idx)}
        onMouseLeave={() => setPresetHoverIdx(null)}
        onClick={() => applyPresetAndRemember(active!, p.label)}
        style={{
          display: "flex",
          alignItems: "center",
          gap: 8,
          padding: "6px 10px",
          height: 30,
          borderRadius: UI.radiusMd,
          cursor: "pointer",
          background: bg,
          border: `1px solid ${UI.stroke}`,
          boxShadow: shadow,
          transition: "box-shadow 140ms, background 140ms, transform 140ms",
        }}
      >
        <Text
          size="sm"
          fw={700}
          style={{
            whiteSpace: "nowrap",
            overflow: "hidden",
            textOverflow: "ellipsis",
          }}
        >
          {p.label}
        </Text>
        <div style={{ flex: 1 }} />
        <Badge size="xs" variant="light">
          {count}
        </Badge>
      </div>
    );
  };

  /* ------------------------------- UI ------------------------------- */
  return (
    <div
      style={{
        position: "fixed",
        top: 24,
        right: 24,
        width: 380,
        maxHeight: "calc(100vh - 48px)", // cap, but allow shrink
        zIndex: 9999,
        pointerEvents: "auto",
      }}
    >
      <Card
        shadow="sm"
        radius={UI.radiusLg}
        withBorder
        style={{
          // no fixed height; shrink-wrap until capped
          maxHeight: "inherit",
          display: "flex",
          flexDirection: "column",
          overflow: "hidden",
          background: `${UI.panel}, ${UI.aurora}`,
          backgroundImage: UI.aurora,
          border: `1px solid ${UI.stroke}`,
          boxShadow: UI.glow,
        }}
      >
        {/* Measured chrome (header/search/picker/summary/divider) */}
        <div ref={chromeRef}>
          <Stack gap="xs" style={{ padding: 10 }}>
            {/* Header */}
            <Group justify="space-between" align="center">
              <Text fw={800} size="sm" style={{ letterSpacing: 0.3 }}>
                {snap?.title ?? "Interior Manager"}
              </Text>
              <Group gap="xs">
                <Tooltip label="Toggle focus (Left Alt)" zIndex={15000}>
                  <SegmentedControl
                    size="xs"
                    radius="xl"
                    color="blue"
                    value={uiHasFocus ? "ui" : "game"}
                    onChange={(v) => {
                      if (
                        (uiHasFocus && v === "game") ||
                        (!uiHasFocus && v === "ui")
                      ) {
                        handleNuiCallback("toggleFocus");
                      }
                    }}
                    transitionDuration={120}
                    data={[
                      {
                        value: "game",
                        label: (
                          <Group gap={4} wrap="nowrap">
                            <IconDeviceGamepad2 size={12} />
                            <Text size="xs">Game</Text>
                          </Group>
                        ),
                      },
                      {
                        value: "ui",
                        label: (
                          <Group gap={4} wrap="nowrap">
                            <IconFocus size={12} />
                            <Text size="xs">UI</Text>
                          </Group>
                        ),
                      },
                    ]}
                  />
                </Tooltip>
                <Tooltip label="Close (Esc)" zIndex={15000}>
                  <ActionIcon
                    color="red"
                    variant="filled"
                    radius="xl"
                    onClick={() => handleNuiCallback("close")}
                    style={{ boxShadow: UI.glow }}
                  >
                    <IconDoorExit size={16} />
                  </ActionIcon>
                </Tooltip>
              </Group>
            </Group>

            {/* Search */}
            <TextInput
              ref={searchRef}
              leftSection={<IconSearch size={14} />}
              placeholder="Search interiors…"
              value={query}
              radius="xl"
              variant="filled"
              onChange={(e) => {
                setQuery(e.currentTarget.value);
                setCursor(0);
                setUsingKeys(false);
              }}
              styles={{
                input: {
                  background: UI.panelElevated,
                  borderColor: UI.stroke,
                  color: "white",
                },
              }}
            />

            {/* Picker */}
            <Card
              withBorder
              radius="lg"
              p={8}
              style={{
                flex: "0 0 auto",
                background: UI.panelElevated,
                border: `1px solid ${UI.stroke}`,
                boxShadow: UI.glow,
                overflow: "hidden",
              }}
            >
              <ScrollArea.Autosize
                mah="clamp(148px, 28vh, 260px)"
                offsetScrollbars
                onMouseLeave={() => setHoverIdx(null)}
                onMouseMove={() => setUsingKeys(false)}
                style={{ padding: 2 }}
                scrollbarSize={8}
                type="auto"
              >
                <Stack gap={6}>
                  {rows.map((r) =>
                    r.type === "folder"
                      ? FolderRow(r.name, r.count, r.opened)
                      : InteriorRow(
                          (r as any).item as WithFolder,
                          (r as any).indent as number
                        )
                  )}
                  {rows.length === 0 && (
                    <Text c="dimmed" size="sm" px="xs" py={4}>
                      No matches
                    </Text>
                  )}
                </Stack>
              </ScrollArea.Autosize>
            </Card>

            {/* Active summary */}
            {active && (
              <Card
                withBorder
                radius="lg"
                p="xs"
                mt="xs"
                mb="xs"
                style={{
                  border: `1px solid ${UI.stroke}`,
                  background: UI.panelElevated,
                  boxShadow: "inset 0 0 0 1px rgba(80,140,255,.65)",
                  flex: "0 0 auto",
                }}
              >
                <Group justify="space-between" align="center">
                  <Text
                    size="sm"
                    fw={800}
                    style={{
                      whiteSpace: "nowrap",
                      overflow: "hidden",
                      textOverflow: "ellipsis",
                    }}
                  >
                    {active.name}
                  </Text>
                  <Group gap={6}>
                    {active.adminOnly && (
                      <Badge size="xs" variant="outline">
                        ADMIN
                      </Badge>
                    )}
                    {active.__folder && (
                      <Badge size="xs" variant="light">
                        {active.__folder}
                      </Badge>
                    )}
                  </Group>
                </Group>
              </Card>
            )}

            <Divider
              label="Interior Details"
              labelPosition="center"
              styles={{
                label: {
                  background:
                    "linear-gradient(90deg, #8FD3FF, #C59CFF 40%, #71FFC4)",
                  WebkitBackgroundClip: "text",
                  color: "transparent",
                  fontWeight: 700,
                  letterSpacing: 0.4,
                },
              }}
            />
          </Stack>
        </div>

        {/* Details scroller — gets a definite max height = cap - chrome */}
        <ScrollArea.Autosize
          mah={`calc(100vh - 48px - ${chromeH}px)`}
          type="auto"
          offsetScrollbars
        >
          <div style={{ padding: 10 }}>
            {!active ? (
              <Text c="dimmed" size="sm">
                Pick an interior to manage.
              </Text>
            ) : (
              <Stack gap="xs">
                <Group justify="space-between">
                  <Button
                    size="xs"
                    radius="xl"
                    variant="gradient"
                    gradient={{ from: "blue.6", to: "cyan.5", deg: 135 }}
                    leftSection={<IconPlayerPlay size={14} />}
                    onClick={() => teleportTo(active)}
                    disabled={!canUse(active)}
                    styles={{
                      root: {
                        boxShadow: "inset 0 0 0 1px rgba(255,255,255,.06)",
                      },
                    }}
                  >
                    Teleport
                  </Button>
                  <Button
                    size="xs"
                    radius="xl"
                    color="red"
                    variant="light"
                    leftSection={<IconX size={14} />}
                    onClick={() => disableAll(active)}
                    disabled={!canUse(active)}
                    styles={{
                      root: {
                        boxShadow: "inset 0 0 0 1px rgba(255,255,255,.06)",
                      },
                    }}
                  >
                    Disable all
                  </Button>
                </Group>

                <Card
                  withBorder
                  radius="lg"
                  p="sm"
                  style={{
                    background: UI.panelElevated,
                    border: `1px solid ${UI.stroke}`,
                    boxShadow: "inset 0 0 0 1px rgba(255,255,255,.06)",
                  }}
                >
                  <Text fw={700} size="sm" mb={6}>
                    Entity Sets
                  </Text>
                  <Stack gap={8}>
                    {active.entitySets
                      ?.filter((s) => !s.hidden)
                      ?.map((s) => {
                        const on = !!active.state?.[s.set];
                        return (
                          <Group key={s.set} justify="space-between" gap={8}>
                            <Text size="sm" c={UI.textDim}>
                              {s.label}
                            </Text>
                            <Switch
                              size="xs"
                              checked={on}
                              onChange={(e) =>
                                toggleSet(
                                  active,
                                  s.set,
                                  e.currentTarget.checked
                                )
                              }
                            />
                          </Group>
                        );
                      })}
                    {(!active.entitySets ||
                      active.entitySets.filter((s) => !s.hidden).length ===
                        0) && (
                      <Text c="dimmed" size="xs">
                        No entity sets
                      </Text>
                    )}
                  </Stack>
                </Card>

                <Card
                  withBorder
                  radius="lg"
                  p="sm"
                  style={{
                    background: UI.panelElevated,
                    border: `1px solid ${UI.stroke}`,
                    boxShadow: "inset 0 0 0 1px rgba(255,255,255,.06)",
                  }}
                >
                  <Text fw={700} size="sm" mb={6}>
                    IPLs
                  </Text>
                  <Stack gap={8}>
                    {active.ipls
                      ?.filter((i) => !i.hidden)
                      ?.map((i) => {
                        const on = !!active.state?.[i.name];
                        return (
                          <Group key={i.name} justify="space-between" gap={8}>
                            <Text size="sm" c={UI.textDim}>
                              {i.label}
                            </Text>
                            <Switch
                              size="xs"
                              checked={on}
                              onChange={(e) =>
                                toggleIpl(
                                  active,
                                  i.name,
                                  e.currentTarget.checked
                                )
                              }
                            />
                          </Group>
                        );
                      })}
                    {(!active.ipls ||
                      active.ipls.filter((i) => !i.hidden).length === 0) && (
                      <Text c="dimmed" size="xs">
                        No IPLs
                      </Text>
                    )}
                  </Stack>
                </Card>

                {/* Presets */}
                {active.presets && active.presets.length > 0 && (
                  <>
                    <Divider
                      label="Presets"
                      styles={{
                        label: {
                          background:
                            "linear-gradient(90deg, #8FD3FF, #C59CFF 40%, #71FFC4)",
                          WebkitBackgroundClip: "text",
                          color: "transparent",
                          fontWeight: 700,
                          letterSpacing: 0.3,
                        },
                      }}
                    />
                    <Card
                      withBorder
                      radius="lg"
                      p="sm"
                      style={{
                        background: UI.panelElevated,
                        border: `1px solid ${UI.stroke}`,
                        boxShadow: "inset 0 0 0 1px rgba(255,255,255,.06)",
                      }}
                    >
                      <Stack gap="xs">
                        <ScrollArea.Autosize mah={220} scrollbarSize={6}>
                          <Stack gap={6} style={{ paddingRight: 2 }}>
                            {(active.presets ?? []).map((p, idx) =>
                              PresetRow(p, idx)
                            )}
                            {(!active.presets ||
                              active.presets.length === 0) && (
                              <Text c="dimmed" size="xs">
                                No presets
                              </Text>
                            )}
                          </Stack>
                        </ScrollArea.Autosize>
                      </Stack>
                    </Card>
                  </>
                )}
              </Stack>
            )}
          </div>
        </ScrollArea.Autosize>
      </Card>
    </div>
  );
}
