"""Configuration management."""

import logging
from pathlib import Path

# Project paths
PROJECT_ROOT = Path(__file__).parent.parent
DATA_DIR = PROJECT_ROOT / "data"
BRONZE_DIR = DATA_DIR / "bronze" / "velov_raw"

# Ensure directories exist
BRONZE_DIR.mkdir(parents=True, exist_ok=True)

# API Configuration (Open Data Lyon - no authentication needed)
# Source: https://transport.data.gouv.fr/datasets/stations-velov-de-la-metropole-de-lyon-disponibilites-temps-reel
VELOV_STATIONS_STATUS_URL = (
    "https://transport.data.gouv.fr/gbfs/lyon/station_status.json"
)
VELOV_STATIONS_INFORMATION_URL = "https://download.data.grandlyon.com/files/rdata/jcd_jcdecaux.jcdvelov/station_information.json"

# Application settings
LOG_LEVEL = logging.INFO
COLLECTION_INTERVAL = 5  # minutes
CONTRACT_NAME = "lyon"
