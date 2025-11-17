#!/bin/bash
# Universal Clinic Visit Tracker Launcher
# Works on Linux, macOS, and Windows (Git Bash/WSL)

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Color output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  Clinic Visit Tracker${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Check if virtual environment exists, create if it doesn't
if [ ! -d "venv" ]; then
    echo -e "${YELLOW}Setting up virtual environment...${NC}"
    python3 -m venv venv
    if [ $? -ne 0 ]; then
        echo "Failed to create virtual environment. Trying with 'python' instead..."
        python -m venv venv
    fi
fi

# Activate virtual environment
echo -e "${BLUE}Activating virtual environment...${NC}"
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    # Windows Git Bash
    source venv/Scripts/activate
else
    # Linux/macOS
    source venv/bin/activate
fi

# Install/update requirements
if [ ! -f ".requirements_installed" ] || [ "requirements.txt" -nt ".requirements_installed" ]; then
    echo -e "${YELLOW}Installing dependencies...${NC}"
    pip install -r requirements.txt
    if [ $? -eq 0 ]; then
        touch .requirements_installed
    fi
fi

# Start Flask server in background
echo -e "${GREEN}Starting Clinic Visit Tracker...${NC}"
python app.py &
FLASK_PID=$!

# Wait for server to start
sleep 3

# Detect OS and open browser accordingly
echo -e "${BLUE}Opening browser...${NC}"
URL="http://127.0.0.1:5000"

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    xdg-open "$URL" 2>/dev/null || sensible-browser "$URL" 2>/dev/null
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    open "$URL"
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    # Windows
    start "$URL"
else
    echo -e "${YELLOW}Could not detect OS. Please open: $URL${NC}"
fi

# Display status
echo ""
echo -e "${GREEN}✅ Clinic Visit Tracker is running!${NC}"
echo -e "${BLUE}🌐 Access it at: $URL${NC}"
echo ""
echo -e "${YELLOW}Press Ctrl+C to stop the server${NC}"
echo ""

# Trap Ctrl+C to cleanup
trap "echo ''; echo 'Stopping server...'; kill $FLASK_PID 2>/dev/null; exit 0" INT

# Wait for Flask process
wait $FLASK_PID
