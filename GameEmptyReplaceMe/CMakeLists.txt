cmake_minimum_required( VERSION 3.7 )

# Project.
project( ProjectEmptyReplaceMe_Project VERSION 0.1 LANGUAGES CXX )

# Game source files.
file( GLOB_RECURSE sourcefiles "Game/SourceCommon/*.cpp" "Game/SourceLinux/*.cpp" )

if( CMAKE_BUILD_TYPE MATCHES wxDebug OR CMAKE_BUILD_TYPE MATCHES wxRelease )
    list( REMOVE_ITEM sourcefiles "${CMAKE_SOURCE_DIR}/Game/SourceLinux/LinuxMain.cpp" )
else()
    list( REMOVE_ITEM sourcefiles "${CMAKE_SOURCE_DIR}/Game/SourceLinux/LinuxMainWx.cpp" )
endif()

# Executable
add_executable( ProjectEmptyReplaceMe ${sourcefiles} )

#set_property( GLOBAL PROPERTY RULE_LAUNCH_COMPILE "${CMAKE_COMMAND} -E time" )

# Game include directories.
target_include_directories( ProjectEmptyReplaceMe PRIVATE "Game/SourceCommon" "Game/SourceLinux" )

# Base Preprocessor defines.
target_compile_definitions( ProjectEmptyReplaceMe PRIVATE MYFW_LINUX=1 )

if( CMAKE_BUILD_TYPE MATCHES Debug OR CMAKE_BUILD_TYPE MATCHES wxDebug )
    target_compile_definitions( ProjectEmptyReplaceMe PRIVATE _DEBUG=1 )
endif()

# MyFramework include directories.
target_include_directories( ProjectEmptyReplaceMe PUBLIC
    "../Framework/MyFramework/SourceCommon"
    "../Framework/MyFramework/SourceLinux"
    "../Framework/MyFramework/SourceWidgets"
    "../Framework/Libraries/Box2D"
    "../Framework/Libraries/cJSON"
    "../Framework/Libraries/LodePNG"
    "../Framework/Libraries/wxWidgets/include"
)

# MyEngine include directories.
target_include_directories( ProjectEmptyReplaceMe PUBLIC
    "../Engine/MyEngine/SourceCommon"
    "../Engine/Libraries/imgui"
    "../Engine/Libraries/Lua/src"
    "../Engine/Libraries/LuaBridge"
    "../Engine/Libraries/bullet3/src/"
    "../Engine/Libraries/SharedGameCode"
    "../SharedGameCode/Core"
    "../SharedGameCode/Menus"
)

# Common libraries for all configurations.
target_link_libraries( ProjectEmptyReplaceMe
    ${CMAKE_CURRENT_BINARY_DIR}/../../../Engine/build/${CMAKE_BUILD_TYPE}/libMyEngine.a
    ${CMAKE_CURRENT_BINARY_DIR}/../../../Framework/build/${CMAKE_BUILD_TYPE}/libMyFramework.a
    ${CMAKE_CURRENT_BINARY_DIR}/../../../Engine/Libraries/bullet3/bin/libBulletDynamics_gmake_x64_release.a
    ${CMAKE_CURRENT_BINARY_DIR}/../../../Engine/Libraries/bullet3/bin/libBulletCollision_gmake_x64_release.a
    ${CMAKE_CURRENT_BINARY_DIR}/../../../Engine/Libraries/bullet3/bin/libLinearMath_gmake_x64_release.a
    GL pthread openal X11
)

# WxWidgets specific preprocessor defines, libs, includes, etc.
if( CMAKE_BUILD_TYPE MATCHES wxDebug OR CMAKE_BUILD_TYPE MATCHES wxRelease )

    if( CMAKE_BUILD_TYPE MATCHES wxDebug )
        set( WXWIDGETS_FOLDER_NAME ../Framework/Libraries/wxWidgets/gtk-build-debug )
    elseif( CMAKE_BUILD_TYPE MATCHES wxRelease )
        set( WXWIDGETS_FOLDER_NAME ../Framework/Libraries/wxWidgets/gtk-build-release )
    endif()

    # Preprocessor defines.
    target_compile_definitions( ProjectEmptyReplaceMe PRIVATE MYFW_USING_WX=1 _FILE_OFFSET_BITS=64 __WXGTK__ )

    # Include directory for wxconfig.h.
    target_include_directories( ProjectEmptyReplaceMe PUBLIC "${WXWIDGETS_FOLDER_NAME}/lib/wx/include/gtk3-unicode-static-3.1" )

    # Libraries.
    target_link_libraries( ProjectEmptyReplaceMe
        ${CMAKE_CURRENT_BINARY_DIR}/../../${WXWIDGETS_FOLDER_NAME}/lib/libwx_baseu-3.1.a
        ${CMAKE_CURRENT_BINARY_DIR}/../../${WXWIDGETS_FOLDER_NAME}/lib/libwx_gtk3u_core-3.1.a
        ${CMAKE_CURRENT_BINARY_DIR}/../../${WXWIDGETS_FOLDER_NAME}/lib/libwx_gtk3u_aui-3.1.a
        ${CMAKE_CURRENT_BINARY_DIR}/../../${WXWIDGETS_FOLDER_NAME}/lib/libwx_gtk3u_gl-3.1.a
        X11 Xxf86vm SM gtk-3 gdk-3 pangocairo-1.0 pango-1.0 cairo
        gdk_pixbuf-2.0 gio-2.0 gobject-2.0 glib-2.0 png dl

        # Recommended by "wx-config --libs", but not needed for now.
        #${CMAKE_CURRENT_BINARY_DIR}/../../${WXWIDGETS_FOLDER_NAME}/lib/libwx_gtk3u_xrc-3.1.a
        #${CMAKE_CURRENT_BINARY_DIR}/../../${WXWIDGETS_FOLDER_NAME}/lib/libwx_gtk3u_qa-3.1.a
        #${CMAKE_CURRENT_BINARY_DIR}/../../${WXWIDGETS_FOLDER_NAME}/lib/libwx_baseu_net-3.1.a
        #${CMAKE_CURRENT_BINARY_DIR}/../../${WXWIDGETS_FOLDER_NAME}/lib/libwx_gtk3u_html-3.1.a
        #${CMAKE_CURRENT_BINARY_DIR}/../../${WXWIDGETS_FOLDER_NAME}/lib/libwx_gtk3u_adv-3.1.a
        #${CMAKE_CURRENT_BINARY_DIR}/../../${WXWIDGETS_FOLDER_NAME}/lib/libwx_baseu_xml-3.1.a
        #gthread-2.0 atk-1.0 cairo-gobject Xtst expat wxregexu-3.1 wxtiff-3.1 wxjpeg-3.1 z m
    )
    
    # Set base CMake build type to debug or release. not sure if works.
    if( CMAKE_BUILD_TYPE MATCHES wxDebug )
        set( CMAKE_BUILD_TYPE Debug )
    elseif( CMAKE_BUILD_TYPE MATCHES wxRelease )
        set( CMAKE_BUILD_TYPE Release )
    endif()

endif()

# cotire (Compile time reducer)
include( ../Framework/Libraries/Cotire/CMake/cotire.cmake )
set_target_properties( ProjectEmptyReplaceMe PROPERTIES COTIRE_CXX_PREFIX_HEADER_INIT "Game/SourceCommon/GameCommonHeader.h" )
cotire( ProjectEmptyReplaceMe )
