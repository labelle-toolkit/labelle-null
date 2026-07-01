/// Null audio backend — satisfies the engine AudioInterface(Impl) contract
/// with no-op implementations. Sound and music handles are issued from a
/// monotonic counter so unique-id semantics still hold; no PCM data is
/// loaded or played.
// Contract-version tag (labelle-assembler#453 item 1). The assembler emits a
// directional `@compileError` version assert in the generated game's main.zig
// comparing this against labelle-core's `AUDIO_PLAYBACK_CONTRACT_VERSION`. null
// implements the audio **playback** surface (`playSound`/`stopSound` required,
// the rest capability-gated — all present as no-ops here), so it declares that.
//
// It does NOT declare `targets_audio_loader_contract`: the loader surface is the
// decode path (`decodeAudio`/`uploadSound`/`DecodedAudio`/`Sound`), which null
// does not implement — `loadSound` just issues a counter id and ignores the
// path. Claiming the loader contract would over-state what the headless backend
// provides. The assembler's version assert is `@hasDecl`-guarded, so omitting
// the tag simply skips the audio-loader check for null (no flag day).
pub const targets_audio_playback_contract: u32 = 1;

const std = @import("std");

var next_sound_id: u32 = 1;
var next_music_id: u32 = 1;

// ── Sound effects ──────────────────────────────────────────

pub fn loadSound(path: [:0]const u8) u32 {
    _ = path;
    const id = next_sound_id;
    next_sound_id += 1;
    return id;
}

pub fn unloadSound(id: u32) void {
    _ = id;
}

pub fn playSound(id: u32) void {
    _ = id;
}

pub fn stopSound(id: u32) void {
    _ = id;
}

pub fn isSoundPlaying(id: u32) bool {
    _ = id;
    return false;
}

pub fn setSoundVolume(id: u32, volume: f32) void {
    _ = .{ id, volume };
}

// ── Music (streaming) ──────────────────────────────────────

pub fn loadMusic(path: [:0]const u8) u32 {
    _ = path;
    const id = next_music_id;
    next_music_id += 1;
    return id;
}

pub fn unloadMusic(id: u32) void {
    _ = id;
}

pub fn playMusic(id: u32) void {
    _ = id;
}

pub fn stopMusic(id: u32) void {
    _ = id;
}

pub fn pauseMusic(id: u32) void {
    _ = id;
}

pub fn resumeMusic(id: u32) void {
    _ = id;
}

pub fn isMusicPlaying(id: u32) bool {
    _ = id;
    return false;
}

pub fn setMusicVolume(id: u32, volume: f32) void {
    _ = .{ id, volume };
}

pub fn updateMusic(id: u32) void {
    _ = id;
}

// ── Global ────────────────────────────────────────────────

pub fn setVolume(volume: f32) void {
    _ = volume;
}

test "null audio: load issues unique ids" {
    const a = loadSound("a.wav");
    const b = loadSound("b.wav");
    try std.testing.expect(a != b);
    try std.testing.expect(!isSoundPlaying(a));
}
