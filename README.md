# labelle-null

The **headless `null` backend** for the [labelle](https://github.com/labelle-toolkit) 2D engine, as an **out-of-tree pluggable backend** (labelle-assembler#386).

Pure Zig, **zero dependencies, no native artifact** — every backend module (gfx/window/input/audio) is a no-op stub, and the generated `main()` drives a fixed-frame tick loop that exits cleanly. It's the backend the assembler's `zig build test` target uses so tests run on any host with no system libs or cross-compile toolchain.

## Use it

```zig
.backend = .null,
.backend_package = .{ .name = "null", .repo = "github.com/labelle-toolkit/labelle-null", .version = "0.1.0" },
```

(With the default-flip, `.backend = .null` resolves here automatically; the `.backend_package` line is optional.)

## Layout

- `src/` — the four no-op backend modules: `gfx`, `window`, `input`, `audio`
- `backend.manifest.zon` + `build_fragments/` — drive the assembler's manifest-splice codegen (the `link` fragment is empty — nothing to link)
- `templates/headless.txt` — the generated fixed-frame `main()`

## Build

```sh
zig build test   # pure-Zig unit tests, no system deps
```
