# Downloads and unpacks Abseil at configure time

set(workdir "${CMAKE_BINARY_DIR}/absl-download")

configure_file("${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt.in"
               "${workdir}/CMakeLists.txt")
execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
                RESULT_VARIABLE error
                WORKING_DIRECTORY "${workdir}")
if(error)
  message(FATAL_ERROR "CMake step for ${PROJECT_NAME} failed: ${error}")
endif()

execute_process(COMMAND ${CMAKE_COMMAND} --build .
                RESULT_VARIABLE error
                WORKING_DIRECTORY "${workdir}")
if(error)
  message(FATAL_ERROR "Build step for ${PROJECT_NAME} failed: ${error}")
endif()

set(_absl_saved_CMAKE_CXX_STANDARD ${CMAKE_CXX_STANDARD})
set(CMAKE_CXX_STANDARD ${HELLO_CXX_STANDARD})
set(ABSL_USE_GOOGLETEST_HEAD OFF CACHE BOOL "" FORCE)
set(ABSL_CXX_STANDARD ${HELLO_CXX_STANDARD} CACHE STRING "" FORCE)

add_subdirectory("${CMAKE_BINARY_DIR}/absl-src"
                 "${CMAKE_BINARY_DIR}/absl-build" EXCLUDE_FROM_ALL)

if(_absl_saved_CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD "${_absl_saved_CMAKE_CXX_STANDARD}")
endif()
