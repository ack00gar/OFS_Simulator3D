# Building OFS_Simulator3D for macOS (Apple Silicon & Intel)

This guide shows how to build and export OFS_Simulator3D for macOS on Apple Silicon (M1/M2/M3) and Intel Macs.

## Prerequisites

### 1. Install Godot 3.5.3 Mono (ARM64)

**Download the correct version:**
- Go to: https://godotengine.org/download/3.x/macos/
- Download: **Godot Engine - .NET 3.5.3** (Mono version with C# support)
- Choose the **ARM64** version for Apple Silicon or **x86_64** for Intel

**Installation:**
```bash
# Extract the downloaded .zip file
unzip Godot_v3.5.3-stable_mono_osx.universal.zip

# Move to Applications
mv Godot_mono.app /Applications/

# Create command-line alias (optional but recommended)
echo 'alias godot="/Applications/Godot_mono.app/Contents/MacOS/Godot"' >> ~/.zshrc
source ~/.zshrc
```

### 2. Install .NET/Mono (Required for C# support)

Godot Mono requires either .NET SDK or Mono runtime for C# compilation.

**Option 1: Install .NET SDK (Recommended)**
```bash
# Download from Microsoft
# https://dotnet.microsoft.com/download

# Or install via Homebrew
brew install --cask dotnet-sdk
```

**Option 2: Install Mono**
```bash
brew install mono
```

Verify installation:
```bash
dotnet --version
# or
mono --version
```

## Building the Project

### Option 1: Using Godot Editor (Recommended)

1. **Open the project:**
   ```bash
   cd /path/to/OFS_Simulator3D
   open -a Godot_mono.app project.godot
   ```

2. **Wait for C# solution to build:**
   - Godot will automatically detect the C# project
   - Wait for the initial build to complete (bottom panel)
   - You'll see "Build succeeded" when ready

3. **Add macOS Export Preset:**
   - Go to **Project → Export**
   - Click **Add...** → **macOS**
   - Configure the preset:
     - **Name**: macOS (ARM64) or macOS (Universal)
     - **Runnable**: ✓ Enabled
     - **Export Path**: Choose destination (e.g., `../Export/OFS3D/macos/FunscriptSimulator3D.app`)
     - **Architectures**: Select ARM64 for Apple Silicon, or Universal for both

4. **Export the project:**
   - Click **Export Project**
   - Choose your export path
   - Click **Save**

5. **Run the app:**
   ```bash
   open ../Export/OFS3D/macos/FunscriptSimulator3D.app
   ```

### Option 2: Command-Line Export

1. **Build the C# project first:**
   ```bash
   cd /path/to/OFS_Simulator3D

   # Open project to trigger C# build, then close
   godot --path . --editor --quit
   ```

2. **Add macOS export template** (see `export_presets.cfg` section below)

3. **Export via command line:**
   ```bash
   # Export for macOS
   godot --path . --export "macOS" ../Export/OFS3D/macos/FunscriptSimulator3D.app
   ```

## Export Preset Configuration

Add this to your `export_presets.cfg` file:

```ini
[preset.2]

name="macOS"
platform="macOS"
runnable=true
custom_features=""
export_filter="all_resources"
include_filter=""
exclude_filter=""
export_path="../Export/OFS3D/macos/FunscriptSimulator3D.app"
script_export_mode=1
script_encryption_key=""

[preset.2.options]

custom_template/debug=""
custom_template/release=""
application/icon="res://favicon.png"
application/identifier="com.zestyraraferu.funscriptsimulator3d"
application/signature=""
application/app_category="Games"
application/short_version="1.6"
application/version="1.6"
application/copyright=""
display/high_res=true
privacy/camera_usage_description=""
privacy/microphone_usage_description=""
codesign/enable=false
codesign/identity=""
codesign/timestamp=true
codesign/hardened_runtime=true
codesign/replace_existing_signature=true
codesign/entitlements/custom_file=""
codesign/entitlements/allow_jit_code_execution=false
codesign/entitlements/allow_unsigned_executable_memory=false
codesign/entitlements/allow_dyld_environment_variables=false
codesign/entitlements/disable_library_validation=false
codesign/entitlements/audio_input=false
codesign/entitlements/camera=false
codesign/entitlements/location=false
codesign/entitlements/address_book=false
codesign/entitlements/calendars=false
codesign/entitlements/photos_library=false
codesign/entitlements/apple_events=false
codesign/entitlements/debugging=false
codesign/entitlements/app_sandbox/enabled=false
codesign/entitlements/app_sandbox/network_server=false
codesign/entitlements/app_sandbox/network_client=false
codesign/entitlements/app_sandbox/device_usb=false
codesign/entitlements/app_sandbox/device_bluetooth=false
codesign/entitlements/app_sandbox/files_downloads=0
codesign/entitlements/app_sandbox/files_pictures=0
codesign/entitlements/app_sandbox/files_music=0
codesign/entitlements/app_sandbox/files_movies=0
codesign/custom_options=PoolStringArray(  )
notarization/enable=false
notarization/apple_id_name=""
notarization/apple_id_password=""
notarization/apple_team_id=""
texture_format/s3tc=true
texture_format/etc=false
texture_format/etc2=false
```

## Architecture Support

### Apple Silicon (M1/M2/M3)
Godot 3.5.3 Mono has **native ARM64 support** and runs without Rosetta 2. Export as:
- **ARM64 only** - Smallest size, best performance on Apple Silicon
- **Universal Binary** - Works on both ARM64 and Intel (larger file size)

### Intel Macs
Use the x86_64 version of Godot 3.5.3 Mono, or use Universal Binary exports.

## Troubleshooting

### "Cannot open because the developer cannot be verified"

macOS Gatekeeper will block unsigned apps. To run:

**Method 1: Right-Click Open**
1. Right-click the app → **Open**
2. Click **Open** in the dialog

**Method 2: Remove Quarantine**
```bash
xattr -cr /path/to/FunscriptSimulator3D.app
```

### C# Build Errors

If you see C# compilation errors:

1. **Check .NET/Mono installation:**
   ```bash
   dotnet --version
   mono --version
   ```

2. **Regenerate C# solution:**
   - In Godot Editor: **Build → Clean Solution**
   - Then: **Build → Build Solution**

3. **Check Godot's Mono installation:**
   - **Editor → Editor Settings → Mono → Builds**
   - Verify the Build Tool is set correctly

### Missing Export Templates

If export fails with "Missing export templates":

1. **Download templates:**
   - In Godot Editor: **Editor → Manage Export Templates**
   - Click **Download and Install**

2. **Or download manually:**
   - Go to: https://godotengine.org/download/3.x/
   - Download "Export templates" for 3.5.3
   - Install via Godot Editor

## Project Structure

```
OFS_Simulator3D/
├── Main.tscn                   # Main scene
├── Simulator3D.cs              # Core simulator logic
├── Funscript.cs                # Funscript file handling
├── BorderlessWindow.cs         # Window management
├── ResizeHandle.cs             # Window resizing
├── InputListener.gd            # Input handling (GDScript)
├── LineDrawer.gd               # Line rendering (GDScript)
├── project.godot               # Godot project config
├── export_presets.cfg          # Export configurations
└── FunscriptSimulator3D.csproj # C# project file
```

## Performance Notes

- **Apple Silicon**: Native ARM64 export provides best performance
- **Universal Binary**: Works on all Macs but ~2x file size
- **Intel**: Use x86_64 export or Universal Binary

## Integration with OFS

This simulator is designed to work with OpenFunscripter (OFS):

1. Build/export the simulator
2. In OFS, configure the simulator path to point to the exported `.app`
3. OFS will launch the simulator and communicate via WebSocket

## Additional Resources

- **Godot Documentation**: https://docs.godotengine.org/en/3.5/
- **Godot C# Guide**: https://docs.godotengine.org/en/3.5/tutorials/scripting/c_sharp/
- **OFS Documentation**: Check the main OpenFunscripter repository
