<img src="https://github.com/ZestyRaraferu/OFS_Simulator3D/blob/1.2.1/favicon.png" width="128">

# OFS_Simulator3D - macOS Edition

A 3D simulator for OpenFunscripter (OFS) made in Godot.

**This fork adds full macOS support** with native Apple Silicon (ARM64) compatibility to the original [OFS_Simulator3D](https://github.com/ZestyRaraferu/OFS_Simulator3D).

## What's New in This Fork

✨ **macOS Support Added!**
- ✅ Native ARM64 support for Apple Silicon (M1, M2, M3, M4, M5)
- ✅ Universal Binary support for both Apple Silicon and Intel Macs
- ✅ Automated setup script for easy installation
- ✅ Comprehensive build and integration documentation
- ✅ WebSocket connection guide for OFS integration

## Platform Support

- ✅ **macOS (Apple Silicon & Intel)** - **NEW!** Native ARM64 support
- ✅ **Windows** - Fully supported (original)
- ✅ **Linux** - Fully supported (original)

## About

This project uses Godot 3.5.3 with C# Mono support. It connects to OpenFunscripter via WebSocket API to display real-time 3D visualization of funscript playback with support for all axes (stroke, twist, roll, pitch, sway, surge).

## Building for macOS

**Quick Start:**
```bash
# Run the automated setup script
chmod +x setup-macos.sh
./setup-macos.sh
```

The setup script will:
- Check for Godot Mono 3.5.3 installation
- Verify .NET SDK or Mono runtime
- Configure the project for macOS export

**For detailed instructions**, see [BUILD_MACOS.md](BUILD_MACOS.md)

### Requirements
- **Godot 3.5.3 Mono** (with C# support) - [Download](https://godotengine.org/download/3.x/macos/)
- **.NET SDK** or **Mono** runtime for C# compilation
- **macOS 11.0+** (Big Sur or later)

### Export Options
- **ARM64** - Native Apple Silicon (M1, M2, M3, M4, M5) - Best performance
- **Universal Binary** - Works on both Apple Silicon and Intel Macs

### Step-by-Step Build Process

1. **Install Prerequisites:**
   ```bash
   # Download Godot 3.5.3 Mono from https://godotengine.org/download/3.x/macos/
   # Install .NET SDK or Mono runtime
   ```

2. **Run Setup Script:**
   ```bash
   chmod +x setup-macos.sh
   ./setup-macos.sh
   ```
   The script will check for all dependencies and guide you through installation.

3. **Build with Godot:**
   ```bash
   # Option A: Using Godot GUI (Recommended)
   open -a Godot_mono.app project.godot
   # Then: Project → Export → macOS → Export Project

   # Option B: Command line
   /Applications/Godot_mono.app/Contents/MacOS/Godot --path . --export "macOS" ../Export/OFS3D/macos/FunscriptSimulator3D.app
   ```

4. **Run the Simulator:**
   ```bash
   open ../Export/OFS3D/macos/FunscriptSimulator3D.app
   ```

## Using with OpenFunscripter

Once built, you need to connect the simulator to your OFS installation:

**Quick Setup:**
1. Launch **OpenFunscripter** (WebSocket API enabled on port 8080)
2. Launch **FunscriptSimulator3D.app**
3. The simulator auto-connects to OFS
4. Load and play a funscript in OFS - the 3D simulator will respond in real-time

**For detailed setup instructions**, see [SETUP_WITH_OFS.md](SETUP_WITH_OFS.md)

### How It Works

The simulator connects to OFS via WebSocket (`ws://127.0.0.1:8080/ofs`) and receives:
- Real-time playback position
- Funscript data for all axes (stroke, twist, roll, pitch, sway, surge)
- Synchronized updates as you play/pause/seek in OFS
