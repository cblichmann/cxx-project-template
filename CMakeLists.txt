cmake_minimum_required(VERSION 3.12)

project(hello_project C CXX ASM)

# Hello-wide setting for the language level
set(HELLO_CXX_STANDARD 17)

set(HELLO_BINARY_DIR "${PROJECT_BINARY_DIR}" CACHE INTERNAL "" FORCE)
set(HELLO_SOURCE_DIR "${PROJECT_SOURCE_DIR}" CACHE INTERNAL "" FORCE)

include(CheckCXXCompilerFlag)

# CMake modules, order matters
list(APPEND CMAKE_MODULE_PATH "${HELLO_SOURCE_DIR}/cmake")
include(Options)
include(Deps)

# Library with basic project settings. The empty file is there to be able to
# define header-only libraries without cumbersome target_sources() hacks.
file(WRITE ${HELLO_BINARY_DIR}/hello_base_force_cxx_linkage.cc "")
add_library(hello_base STATIC
  "${HELLO_BINARY_DIR}/hello_base_force_cxx_linkage.cc"
)
add_library(hello::base ALIAS hello_base)
set_target_properties(hello_base PROPERTIES
  CXX_STANDARD              ${HELLO_CXX_STANDARD}
  CXX_STANDARD_REQUIRED     TRUE
  CXX_EXTENSIONS            FALSE
  SKIP_BUILD_RPATH          TRUE
  POSITION_INDEPENDENT_CODE TRUE
)
target_compile_features(hello_base INTERFACE cxx_std_17)
target_include_directories(hello_base INTERFACE
  "${HELLO_BINARY_DIR}"
  "${HELLO_SOURCE_DIR}"
  # To reach into Abseil internal headers. Discouraged.
  #"${CMAKE_BINARY_DIR}/absl-src"
)

add_library(hello_test_main INTERFACE)
add_library(hello::test_main ALIAS hello_test_main)
target_link_libraries(hello_test_main INTERFACE
  gtest_main
  gmock
  hello::base
)

if(HELLO_ENABLE_TESTS)
  include(GoogleTest)
  enable_testing()
endif()

##### Hello project targets start here

# Simple library
add_library(hello_library STATIC
  hello_library.cc
  hello_library.h
)
add_library(hello::hello_library ALIAS hello_library)
target_link_libraries(hello_library PUBLIC
  hello::base  # Should come first
  absl::strings
)

if(HELLO_ENABLE_TESTS)
  add_executable(hello_library_test
    hello_library_test.cc
  )
  target_link_libraries(hello_library_test PRIVATE
    hello::test_main  # Provides GoogleTest main
    hello::hello_library
  )
  gtest_discover_tests(hello_library_test)
endif()

# An executable depending on the simple library above
add_executable(hello
  hello.cc
)
target_link_libraries(hello PRIVATE
  hello::base
  hello::hello_library
)
