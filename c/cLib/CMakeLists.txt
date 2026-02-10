# Set minimum version of CMake required to cnfigure the project
cmake_minimum_required(VERSION 3.15)

# Project name, version and languages used
project(cLib
    VERSION 0.1.0
    LANGUAGES C
)

# Include GNUInstallDirs to use standard directory variables
include(GNUInstallDirs)

# Provide additional CMAKE_INSTALL_CMAKEDIR path
if(NOT CMAKE_INSTALL_CMAKEDIR)
    set(CMAKE_INSTALL_CMAKEDIR ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})
endif()

# Include CMakePackageConfigHelpers to use config files generator 
include(CMakePackageConfigHelpers)
# Enable testing with CTest
include(CTest)

#---------------------------------- Options -----------------------------------
# Shared/Static liibrary switch
option(BUILD_SHARED_LIBS "Build shared libraries" OFF)
# Build tests
option(BUILD_TESTING "Build tests" ON)
# Build examples
option(BUILD_EXAMPLES "Build examples" ON)


#------------------------------- Subdirectories -------------------------------
add_subdirectory(src)

if(BUILD_TESTING AND EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/tests/CMakeLists.txt")
    add_subdirectory(tests)
endif()

if(BUILD_EXAMPLES AND EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/examples/CMakeLists.txt")
    add_subdirectory(examples)
endif()
