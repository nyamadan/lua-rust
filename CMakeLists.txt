cmake_minimum_required(VERSION 3.0.0)
project(lua VERSION 5.4.4)

include(GNUInstallDirs)
include(ExternalProject)

if(NOT DEFINED CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Debug")
endif()

ExternalProject_Add(lua
    PREFIX ${PROJECT_BINARY_DIR}
    URL https://github.com/lua/lua/archive/refs/tags/v5.4.4.tar.gz
    URL_HASH SHA256=2ff89bbea22a7c8b910d6b006f5ba4559edcf468a25537cedf9988ed90f6b450
    CMAKE_ARGS
    -DCMAKE_BUILD_TYPE:PATH=${CMAKE_BUILD_TYPE}
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    -DCMAKE_TOOLCHAIN_FILE:PATH=${CMAKE_TOOLCHAIN_FILE}
    PATCH_COMMAND
    ${CMAKE_COMMAND} -E copy_if_different "${CMAKE_CURRENT_SOURCE_DIR}/externals/Lua.cmake" <SOURCE_DIR>/CMakeLists.txt
)