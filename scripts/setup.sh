# scripts/setup.sh
#!/bin/bash

set -e  # Exit on error

echo "Setting up velov-tracker..."
echo ""

# Check prerequisites
echo "Checking prerequisites..."

if ! command -v pyenv &> /dev/null; then
    echo "Error: pyenv not found"
    echo ""
    echo "Install it with:"
    echo "  curl https://pyenv.run | bash"
    exit 1
fi

if ! command -v poetry &> /dev/null; then
    echo "Error: Poetry not found"
    echo ""
    echo "Install it with:"
    echo "  curl -sSL https://install.python-poetry.org | python3 -"
    exit 1
fi

echo "Prerequisites found: pyenv and Poetry"
echo ""

# Install Python version
PYTHON_VERSION=$(cat .python-version)
echo "Installing Python $PYTHON_VERSION..."

if pyenv versions --bare | grep -q "^${PYTHON_VERSION}$"; then
    echo "Python $PYTHON_VERSION already installed"
else
    pyenv install "$PYTHON_VERSION"
    echo "Python $PYTHON_VERSION installed"
fi

pyenv local "$PYTHON_VERSION"

CURRENT_VERSION=$(python --version | cut -d' ' -f2)
echo "Active Python version: $CURRENT_VERSION"
echo ""

# Configure Poetry
echo "Configuring Poetry..."
poetry config virtualenvs.in-project true
echo "Poetry configured (virtualenv will be created in .venv/)"
echo ""

# Install dependencies
echo "Installing dependencies..."
poetry install

if [ $? -eq 0 ]; then
    echo "Dependencies installed successfully"
else
    echo "Error: Failed to install dependencies"
    exit 1
fi
echo ""

# Create data subdirectories (main structure already exists via .gitkeep)
echo "Creating data subdirectories..."
mkdir -p data/bronze/velov_raw  # Subdirectory not tracked
echo "Data subdirectories created"
echo ""

# Optional: Just installation reminder
if ! command -v just &> /dev/null; then
    echo "Optional: Install Just for task running"
    echo "  curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to ~/.local/bin"
    echo ""
fi

# Summary
echo "Setup complete"
echo ""
echo "Next steps:"
echo ""
echo "  1. Enter the virtual environment:"
echo "     poetry shell"
echo ""
echo "  2. Verify installation:"
echo "     python --version"
echo "     poetry show"
echo ""
if [ -f "justfile" ]; then
    echo "  3. See available commands:"
    echo "     just"
    echo ""
fi