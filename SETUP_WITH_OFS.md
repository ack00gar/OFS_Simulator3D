# Setting Up OFS_Simulator3D with OpenFunscripter

This guide shows how to connect the 3D Simulator to your OpenFunscripter installation.

## How It Works

The 3D Simulator connects to OpenFunscripter via **WebSocket API**:

- **OFS** runs a WebSocket server at `ws://127.0.0.1:8080/ofs`
- **Simulator3D** connects as a client to receive real-time script data
- They communicate using the `ofs-api.json` protocol

The simulator receives:
- Current playback position
- Playing/paused state
- Funscript data for all axes (stroke, roll, pitch, twist, sway, surge)
- Real-time updates synchronized with video playback

## Prerequisites

1. **OpenFunscripter** installed and running
2. **OFS_Simulator3D** built for macOS (see [BUILD_MACOS.md](BUILD_MACOS.md))

## Setup Steps

### 1. Enable WebSocket API in OFS

1. Launch **OpenFunscripter**
2. Go to **Options** or **Preferences** menu
3. Look for **WebSocket API** or **Network** settings
4. Enable the WebSocket server
5. Verify the port is set to **8080** (default)

> **Note:** The WebSocket server should start automatically when OFS launches. You can verify it's running by checking if OFS is listening on port 8080.

### 2. Build the Simulator (if not done)

```bash
cd /path/to/OFS_Simulator3D

# Run setup script
./setup-macos.sh

# Open in Godot and export for macOS
open -a Godot_mono.app project.godot
# Then: Project → Export → macOS → Export Project
```

### 3. Launch the Simulator

**Option 1: Default Connection (Automatic)**
```bash
# The simulator will automatically connect to ws://127.0.0.1:8080/ofs
open FunscriptSimulator3D.app
```

**Option 2: Custom WebSocket URL**

If your OFS is running on a different port or machine:

```bash
# From terminal with custom WebSocket URL
open FunscriptSimulator3D.app --args "ws://localhost:9090/ofs"

# Or for remote OFS instance
open FunscriptSimulator3D.app --args "ws://192.168.1.100:8080/ofs"
```

### 4. Verify Connection

When the simulator launches, you should see:

**In the Simulator window:**
- Top-left status: "Connected to ws://127.0.0.1:8080/ofs" ✓
- If connection fails: "Trying to connect to ws://127.0.0.1:8080/ofs"

**In OFS:**
- Check the OFS log/console for "WebSocket client connected"
- The simulator should respond to script playback in real-time

### 5. Test the Connection

1. In **OFS**, load a funscript and video
2. Press **Play**
3. The **3D Simulator** should:
   - Show the stroker moving in sync with the script
   - Follow all axis movements (stroke, twist, roll, pitch, etc.)
   - Update in real-time as you scrub through the video

## Troubleshooting

### Simulator Shows "Trying to connect..."

**Problem:** Simulator can't connect to OFS WebSocket server

**Solutions:**

1. **Check OFS WebSocket is enabled:**
   - Open OFS preferences
   - Verify WebSocket API is enabled
   - Check the port is 8080

2. **Check OFS is running:**
   - OFS must be launched **before** the simulator
   - The WebSocket server starts with OFS

3. **Check port availability:**
   ```bash
   # Check if port 8080 is in use
   lsof -i :8080

   # Should show OFS process listening on port 8080
   ```

4. **Firewall blocking connection:**
   - Go to **System Settings → Network → Firewall**
   - Allow OpenFunscripter to accept incoming connections

### Simulator Connects but Doesn't Move

**Problem:** Connection established but simulator doesn't respond to playback

**Solutions:**

1. **Load a funscript in OFS:**
   - The simulator needs an active script to visualize
   - Load a .funscript file or create actions

2. **Check script is playing:**
   - Press Play in OFS
   - Verify video playback is active

3. **Check script axes:**
   - The simulator supports: stroke (L0), twist (R0), roll (R1), pitch (R2), surge (L1), sway (L2)
   - Make sure your script has data for these axes

### Connection Drops Randomly

**Problem:** Simulator disconnects during use

**Solutions:**

1. **Check network stability:**
   - Even localhost connections can have issues
   - Restart both OFS and the simulator

2. **Check OFS logs:**
   - Look for WebSocket errors or timeout messages
   - May indicate OFS is overloaded or crashing

3. **Reduce WebSocket buffer size:**
   - In the simulator's `project.godot`:
   - `network/limits/websocket_client/max_in_buffer_kb=1048576`
   - Try reducing if memory issues occur

### Multiple Scripts/Simulators

You can run **multiple simulators** connected to one OFS instance:

```bash
# Launch first simulator
open FunscriptSimulator3D.app

# Launch second simulator (they'll both connect to the same OFS)
open -n FunscriptSimulator3D.app
```

All connected simulators will receive the same script data simultaneously.

## Advanced Configuration

### Custom WebSocket Port

If you need to change the WebSocket port:

**In OFS:**
1. Edit OFS preferences/config file
2. Change WebSocket port from 8080 to your desired port

**In Simulator:**
```bash
# Launch with custom port
open FunscriptSimulator3D.app --args "ws://127.0.0.1:YOUR_PORT/ofs"
```

### Remote Connection (OFS on Different Machine)

You can connect the simulator to OFS running on another computer:

1. **On the OFS machine:**
   - Enable WebSocket API
   - Note the local IP address (e.g., 192.168.1.100)
   - Ensure firewall allows incoming connections on port 8080

2. **On the Simulator machine:**
   ```bash
   open FunscriptSimulator3D.app --args "ws://192.168.1.100:8080/ofs"
   ```

### Editing WebSocket URL in Godot

If you want to change the default WebSocket URL permanently:

1. Open the project in Godot
2. Select the `Simulator3D` node in the scene tree
3. In the **Inspector** panel, find:
   - **Script Variables → WsSocketUrl**
4. Change to your desired URL
5. Re-export the project

## Integration with OFS FunGen Edition

If you're using the **OFS FunGen Edition** (macOS ARM64 optimized):

1. Both OFS and the simulator support **native ARM64**
2. Build both for ARM64 for best performance:
   - OFS: Use `build-macos.sh` with default settings
   - Simulator: Export as ARM64 from Godot

3. They will communicate via WebSocket just like the standard version

## WebSocket API Protocol

The simulator uses the OFS WebSocket API to receive:

- **Playback events:** Play, pause, seek
- **Script changes:** Add, remove, update funscripts
- **Current time:** Synchronized playback position
- **Script data:** Action points for all axes

For developers wanting to extend the simulator or create custom integrations, refer to the OFS WebSocket API documentation.

## Summary

1. **Launch OFS** with WebSocket API enabled (port 8080)
2. **Launch Simulator** - it auto-connects to `ws://127.0.0.1:8080/ofs`
3. **Load and play** a funscript in OFS
4. **Watch the 3D simulator** respond in real-time

The setup is automatic - just ensure both applications are running!
