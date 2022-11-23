cmake_minimum_required(VERSION 3.0.0)
project(lua VERSION 5.4.4)

include(GNUInstallDirs)

add_library(lua544 SHARED onelua.c)
target_compile_definitions(lua544 PRIVATE MAKE_LIB)
if(MSVC OR MINGW)
    if(MINGW)
        target_link_options(lua544 PRIVATE "-static" "-lstdc++")
    endif()
    target_compile_definitions(lua544 PUBLIC LUA_BUILD_AS_DLL)
endif()
set_target_properties(lua544 PROPERTIES DEBUG_POSTFIX "d")
install(TARGETS lua544 EXPORT lua544-config)
file(GLOB_RECURSE LUA_HEADERS "*.h")
set_property(TARGET lua544 PROPERTY PUBLIC_HEADER ${LUA_HEADERS})
install(TARGETS lua544
    EXPORT lua544-config
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

add_executable(lua lua.c)
add_dependencies(lua lua544)
target_link_libraries(lua lua544)
target_compile_definitions(lua PRIVATE MAKE_LIB)
set_target_properties(lua PROPERTIES DEBUG_POSTFIX "d")
install(TARGETS lua EXPORT lua-config)
install(TARGETS lua
    EXPORT lua-config
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)
