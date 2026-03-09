#!/bin/bash
# OpenClaw Easy Install Script
# Usage: curl -fsSL https://raw.githubusercontent.com/ailemotree/openclaw-install-guide/main/install.sh | bash

echo "🚀 OpenClaw Easy Installer"
echo "=========================="
echo ""

# Check system
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    PLATFORM="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    PLATFORM="mac"
else
    echo "❌ Unsupported platform: $OSTYPE"
    echo "Please use manual installation: https://github.com/ailemotree/openclaw-install-guide"
    exit 1
fi

echo "📋 Platform detected: $PLATFORM"
echo ""

# Check Node.js
if ! command -v node &> /dev/null; then
    echo "📦 Installing Node.js..."
    if [[ "$PLATFORM" == "mac" ]]; then
        if ! command -v brew &> /dev/null; then
            echo "Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        brew install node
    else
        curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
        sudo apt-get install -y nodejs
    fi
fi

NODE_VERSION=$(node --version | cut -dv -f2 | cut -d. -f1)
if [[ $NODE_VERSION -lt 18 ]]; then
    echo "❌ Node.js 18+ required. Current: $(node --version)"
    echo "Please upgrade Node.js first"
    exit 1
fi

echo "✅ Node.js version: $(node --version)"
echo ""

# Install OpenClaw
echo "📥 Installing OpenClaw..."
npm install -g @openclaw/cli

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ OpenClaw installed successfully!"
    echo ""
    echo "📝 Next steps:"
    echo "1. Get API key from https://openrouter.ai"
    echo "2. Configure: openclaw config set apiKey YOUR_KEY"
    echo "3. Start: openclaw"
    echo ""
    echo "📚 Full guide: https://github.com/ailemotree/openclaw-install-guide"
    echo "🛒 Easy install package: https://openclaw-sales.vercel.app"
else
    echo "❌ Installation failed"
    echo "Please try manual installation or get the easy install package"
    exit 1
fi
