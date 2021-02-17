function(check_target target)
  if(NOT TARGET ${target})
    message(FATAL_ERROR "This project requires a ${target} CMake target")
  endif()
endfunction()

# Use static libraries
set(_hello_saved_CMAKE_FIND_LIBRARY_SUFFIXES ${CMAKE_FIND_LIBRARY_SUFFIXES})
set(CMAKE_FIND_LIBRARY_SUFFIXES ${CMAKE_STATIC_LIBRARY_SUFFIX})

if(HELLO_ENABLE_TESTS)
  if(HELLO_DOWNLOAD_GOOGLETEST)
    include(cmake/googletest/Download.cmake)
  endif()
  check_target(gtest)
  check_target(gtest_main)
  check_target(gmock)

  if(HELLO_DOWNLOAD_BENCHMARK)
    include(cmake/benchmark/Download.cmake)
  endif()
  check_target(benchmark)
endif()

if(HELLO_DOWNLOAD_ABSL)
  include(cmake/abseil/Download.cmake)
endif()
check_target(absl::core_headers)

if(HELLO_DOWNLOAD_PROTOBUF)
  include(cmake/protobuf/Download.cmake)
  check_target(protobuf::libprotobuf)
  check_target(protobuf::protoc)
else()
  find_package(Protobuf REQUIRED)
endif()

# Undo global change
set(CMAKE_FIND_LIBRARY_SUFFIXES ${_hello_saved_CMAKE_FIND_LIBRARY_SUFFIXES})
