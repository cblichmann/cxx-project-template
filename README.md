# Modern CMake template for C/C++ projects

Features:

- Superbuild for dependencies, using `ExternalProject_add`
- Base target that sets build properties
- Example dependencies: Abseil, Google Test

## Configure/Build

### Linux

Default "Makefile" generator does not have the concept of build configurations
that can be selected at build invocation time.

Instead one needs to specify the build type explicitly ("Release", "Debug",
etc.).

```bash
mkdir -p build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_RULE_MESSAGES=OFF
cmake --build . -- -j$(nproc)
```

Note: Everything after the `--` in the build command above gets passed to Make
and runs a parallel build on all available (logical) CPUs.

### macOS

On macOS, the XCode generator can be used that allows to select the build
configuration as build invocation time. Builds are always run in parallel.

```bash
mkdir -p build && cd build
cmake .. -G "XCode"
cmake --build . --config Release
```

### Windows

The Visual Studio generator uses MSBuild by default and allows to select the
build configuration at build invocation time.

```dos
if not exist build mkdir build
cd build
cmake .. -G "Visual Studio 15 2017 Win64"
cmake --build . --config Release -- /m /clp:NoSummary;ForceNoAlign /v:minimal
```

Everything after the `--` in the build command above gets passed to MSBuild and
ensures proper multi-core builds and sensible build output.
