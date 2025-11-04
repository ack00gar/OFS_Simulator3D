#!/bin/bash
# OFS_Simulator3D - macOS Setup Script
# Automates Godot Mono installation and project setup for Apple Silicon & Intel Macs

set -e

echo "=========================================="
echo "OFS_Simulator3D - macOS Setup"
echo "=========================================="
echo ""

# Detect architecture
ARCH=$(uname -m)
echo "Detected system architecture: $ARCH"
echo ""

# Check if Godot Mono is already installed
GODOT_APP="/Applications/Godot_mono.app"
GODOT_BIN="$GODOT_APP/Contents/MacOS/Godot"

if [ -f "$GODOT_BIN" ]; then
    GODOT_VERSION=$("$GODOT_BIN" --version 2>&1 | head -n1 | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' | head -n1)
    echo "✓ Godot Mono found: Version $GODOT_VERSION"
    echo "  Location: $GODOT_APP"
else
    echo "✗ Godot Mono 3.5.3 not found"
    echo ""
    echo "To install Godot Mono 3.5.3:"
    echo "1. Visit: https://godotengine.org/download/3.x/macos/"
    echo "2. Download: 'Godot Engine - .NET 3.5.3' (Mono version)"
    if [ "$ARCH" = "arm64" ]; then
        echo "3. Choose the ARM64 or Universal version for Apple Silicon"
    else
        echo "3. Choose the x86_64 or Universal version for Intel"
    fi
    echo "4. Extract and move to /Applications/Godot_mono.app"
    echo ""

    read -p "Would you like to open the download page now? (y/n) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        open "https://godotengine.org/download/3.x/macos/"
    fi

    echo ""
    echo "Please install Godot Mono and run this script again."
    exit 1
fi

echo ""

# Check for .NET SDK or Mono
DOTNET_FOUND=false
MONO_FOUND=false

if command -v dotnet &> /dev/null; then
    DOTNET_VERSION=$(dotnet --version 2>&1)
    echo "✓ .NET SDK found: Version $DOTNET_VERSION"
    DOTNET_FOUND=true
fi

if command -v mono &> /dev/null; then
    MONO_VERSION=$(mono --version 2>&1 | head -n1 | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' | head -n1)
    echo "✓ Mono found: Version $MONO_VERSION"
    MONO_FOUND=true
fi

if [ "$DOTNET_FOUND" = false ] && [ "$MONO_FOUND" = false ]; then
    echo "✗ Neither .NET SDK nor Mono found"
    echo ""
    echo "Godot Mono requires either .NET SDK or Mono for C# compilation."
    echo ""
    echo "Install options:"
    echo "  Option 1 (Recommended): Install .NET SDK"
    echo "    brew install --cask dotnet-sdk"
    echo ""
    echo "  Option 2: Install Mono"
    echo "    brew install mono"
    echo ""

    read -p "Install .NET SDK via Homebrew now? (y/n) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if command -v brew &> /dev/null; then
            echo "Installing .NET SDK..."
            brew install --cask dotnet-sdk
            echo "✓ .NET SDK installed"
        else
            echo "✗ Homebrew not found. Please install Homebrew first:"
            echo "  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
            exit 1
        fi
    else
        echo ""
        echo "Please install .NET SDK or Mono and run this script again."
        exit 1
    fi
fi

echo ""

# Check if we're in the project directory
if [ ! -f "project.godot" ]; then
    echo "✗ Not in OFS_Simulator3D project directory"
    echo "Please run this script from the project root."
    exit 1
fi

echo "✓ Found project.godot"
echo ""

# Create command-line alias if not exists
if ! grep -q "alias godot=" ~/.zshrc 2>/dev/null; then
    echo "Adding godot command alias to ~/.zshrc..."
    echo "" >> ~/.zshrc
    echo "# Godot Mono alias" >> ~/.zshrc
    echo "alias godot=\"$GODOT_BIN\"" >> ~/.zshrc
    echo "✓ Added 'godot' command alias"
    echo "  Run 'source ~/.zshrc' to activate in current terminal"
else
    echo "✓ Godot command alias already exists"
fi

echo ""
echo "=========================================="
echo "Setup Complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo ""
echo "1. Build the C# project:"
echo "   $GODOT_BIN --path . --editor --quit"
echo ""
echo "2. Export for macOS (Option A - GUI):"
echo "   open -a Godot_mono.app project.godot"
echo "   Then: Project → Export → Select 'macOS' → Export Project"
echo ""
echo "   (Option B - Command line):"
echo "   $GODOT_BIN --path . --export 'macOS' ../Export/OFS3D/macos/FunscriptSimulator3D.app"
echo ""
echo "3. Run the exported app:"
echo "   open ../Export/OFS3D/macos/FunscriptSimulator3D.app"
echo ""
echo "For detailed instructions, see BUILD_MACOS.md"
echo ""
