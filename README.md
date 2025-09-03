# Sunscreen

This repo contains a Windows batchfile (`main.bat`) and UNIX shell script (`main.sh`) that can be used to quickly and automatically install temporary environments in which to run your Python script.

You can share your Python scripts with others with confidence that everything will run correctly, even if they don't have Python installed.

# Quickstart

1. Add a dependencies section to the top of your Python script (see `main.py` for an example of the metadata format).
2. Copy `main.bat` (Windows) or `main.sh` (UNIX) to the same folder as your Python file.
3. Rename the batchfile/shell script so it matches your Python file (e.g. `main.bat` -> `myscript.bat` if you have `myscript.py`).
4. Double-click the batchfile/shell script to run.

## Background

Sharing a simple Python script is not always as simple as it should be.

Often the following steps are involved:

1. ⌚ install anaconda/miniconda/mamba
2. 🥹 set up path
3. 😢 create environment
4. 😿 solve dependencies
5. 🚀 run script


## Inline script metadata

With the advent of [PEP 723](https://peps.python.org/pep-0723) it is possible to embed the script dependencies in the header block of the code like so:


```python
# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "numpy",
#     "pandas",
#     "matplotlib",
# ]
# ///

import numpy as np

print("Hello, world!")
```

## Package management with `uv`

[`uv`](https://docs.astral.sh/uv/) is a fast Python package manager written in Rust.

Is has been variously described as:

- lightning fast
- extremely fast
- blazingly fast
- confusingly fast

It can be installed with just one shell command:

```sh
# Mac/Linux
curl -LsSf https://astral.sh/uv/install.sh | sh

# Windows
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

## Magic batchfiles and shell scripts

There are two scripts in this repo:

`main.bat` (Windows)  
`main.sh` (Mac/Linux)  

When run, they will do the following:

1. Install `uv` on your system
2. Add `uv` to the system `PATH`
3. Run a Python script with matching name (in this case, `main.py`)

`uv` will then install all of the dependencies in a temporary environment.

## Reproducibility

There are different strategies to achieve an environment that behaves the way you expect.

1. **Flexible**

    The quickest way to set your dependencies is just with package names:

    ```python
    # /// script
    # dependencies = [
    #     "numpy",
    # ]
    # ///
    ```

    This approach will install the latest versions, but your code may produce warnings or errors.

2. **Time-based**

    You can also specify a date with the 'exclude-newer' option:

    ```python
    # /// script
    # dependencies = [
    #     "numpy",
    # ]
    # [tool.uv]
    # exclude-newer = "2020-01-01T00:00:00Z"
    # ///
    ```

    This approach will install the latest package versions that were published before the specified date.

3. **Strict**  
    For maximum control and reproducibilty you can lock your script to specific versions.

    ```python
    # /// script
    # requires-python = "==3.12.9"
    # dependencies = [
    #     "numpy==2.3.2",
    # ]
    # ///
    ```

## FAQ
**My environment cannot be solved. How do I fix it?**  
You can make you dependencies less strict, or just delete the temporary environment and start again.

**Where are the `uv` environments saved?**  
`uv` creates temporary environments in the user's cache folder, located in `%LOCALAPPDATA%/uv/cache` for Windows and `$HOME/.cache/uv` on Mac/Linux. You can get the location of the cache folder by running `uv` in verbose mode, i.e. `uv run -v ...`.

**How big are the virtual environments?**  
The disk space required for an environment varies depending on the number of dependencies. Here is a rough guide:

- No dependencies (standard Python library only): <100 Mb  
- Typical data science dependencies (`numpy`, `pandas`, `matplotlib`): ~150 Mb
- More complex dependencies: > 200 Mb

**Can I use script metadata in all of my 1000s of scripts?**  
If you have a large number of scripts with similar dependencies, it's better to use a [project structure](https://docs.astral.sh/uv/concepts/projects/).

**Why 'sunscreen'?**  
Like UV radiation, `uv` is powerful and can be intimidating for new users. Sunscreen means you don't have to think about `uv`, and can just continue having fun in the sun.
