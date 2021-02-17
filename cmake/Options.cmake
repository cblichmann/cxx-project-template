# These options determine whether CMake should download ibraries at configure
# time.
# The CMake script Deps.cmake checks for the presence of certain build
# targets to determine whether a library can be used. Disabling the options
# below enables embedding projects to selectively override/replace these
# dependencies. This is useful for cases where embedding projects already
# depend on some of these libraries (e.g. Abseil).
option(HELLO_DOWNLOAD_ABSL "Download Abseil at config time" ON)
option(HELLO_DOWNLOAD_GOOGLETEST "Download googletest at config time" ON)
option(HELLO_DOWNLOAD_BENCHMARK "Download benchmark at config time" ON)
#option(HELLO_DOWNLOAD_GFLAGS "Download gflags at config time" ON)
#option(HELLO_DOWNLOAD_GLOG "Download glog at config time" ON)
option(HELLO_DOWNLOAD_PROTOBUF "Download protobuf at config time" ON)

option(HELLO_ENABLE_TESTS "Build unit tests" ON)
