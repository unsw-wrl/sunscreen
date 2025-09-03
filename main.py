# /// script
# requires-python = "==3.12"
# dependencies = [
#     "netCDF4",
#     "pandas",
#     "xarray",
# ]
# ///

from pathlib import Path
import pandas as pd
import matplotlib.pyplot as plt
import xarray as xr

# Get path to WRL1
WRL1 = Path(__file__).parent.parent

# Define path to netCDF data
m2_path = (
    WRL1
    / "Project/wrl2024039 DEECA Pilot Coastal Hazard Early Warning System/04_Data/01_Water level data/Astronomical tide/tide_models/tide_models_clipped/fes2022b/ocean_tide_20241025/m2_fes2022.nc"
)

# Plot M2 tide constituent
ds = xr.load_dataset(m2_path)
ds.sel["amplitude"].plot()

plt.show()
