A Fork of OpenFunScripter's OFS_Simulator3D that fixes some issues.

<img src="https://github.com/ZestyRaraferu/OFS_Simulator3D/blob/1.2.1/favicon.png" width="128">

# OFS_Simulator3D
A 3D simulator for OFS made in godot.

This project uses godot 3.5.3 with C# mono support.

## Platform Support

- ✅ **Windows** - Fully supported
- ✅ **Linux** - Fully supported
- ✅ **macOS (Apple Silicon & Intel)** - Fully supported with native ARM64

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
- **ARM64** - Native Apple Silicon (M1/M2/M3) - Best performance
- **Universal Binary** - Works on both Apple Silicon and Intel Macs

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
