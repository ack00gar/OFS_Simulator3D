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
