cmake_minimum_required( VERSION 3.4.1 )

# Project.
#project( ProjectEmptyReplaceMe_Project VERSION 0.1 LANGUAGES CXX )

# Game source files.
file( GLOB_RECURSE sourceFiles "Game/SourceCommon/*.cpp" )

# Extra files specific to Android builds.
if( NOT ${ANDROID_ABI} STREQUAL "" )
    file( GLOB_RECURSE platformFiles "Game/SourceAndroid/*.cpp" )
    set( sourceFiles ${sourceFiles} ${platformFiles} )
endif()

# Extra files specific to Linux builds.
if( CMAKE_BUILD_TYPE MATCHES Linux )
    file( GLOB_RECURSE platformFiles "Game/SourceLinux/*.cpp" )
    set( sourceFiles ${sourceFiles} ${platformFiles} )
endif()

# Extra files specific to WxWidgets builds.
if( CMAKE_BUILD_TYPE MATCHES wxDebug OR CMAKE_BUILD_TYPE MATCHES wxRelease )
    list( REMOVE_ITEM sourceFiles "${CMAKE_CURRENT_SOURCE_DIR}/Game/SourceLinux/LinuxMain.cpp" )
else()
    list( REMOVE_ITEM sourceFiles "${CMAKE_CURRENT_SOURCE_DIR}/Game/SourceLinux/LinuxMainWx.cpp" )
endif()

# Create a shared library on Android or an executable on other platforms.
if( NOT ${ANDROID_ABI} STREQUAL "" )
    add_library( GameEmptyReplaceMe SHARED ${sourceFiles} )
else()
    add_executable( GameEmptyReplaceMe ${sourceFiles} )
endif()

#target_link_libraries( GameEmptyReplaceMe MyFramework LinearMath BulletCollision BulletDynamics MyEngine )
target_link_libraries( GameEmptyReplaceMe MyEngine MyFramework )

#set_property( GLOBAL PROPERTY RULE_LAUNCH_COMPILE "${CMAKE_COMMAND} -E time" )

# Game include directories.
target_include_directories( GameEmptyReplaceMe PRIVATE "Game/SourceCommon" )

#############
# Preprocessor defines, platform include dirs and link libraries.
#############

# Android defines.
if( NOT ${ANDROID_ABI} STREQUAL "" )
    target_compile_definitions( GameEmptyReplaceMe PRIVATE MYFW_ANDROID=1 )
    target_include_directories( GameEmptyReplaceMe PRIVATE "Game/SourceAndroid" )
    target_link_libraries( GameEmptyReplaceMe android log GLESv2 OpenSLES EGL ) #c m gcc )
endif()

# Linux defines.
if( CMAKE_BUILD_TYPE MATCHES Linux )
    target_compile_definitions( GameEmptyReplaceMe PRIVATE MYFW_LINUX=1 )
    target_include_directories( GameEmptyReplaceMe PRIVATE "Game/SourceLinux" )
    target_link_libraries( GameEmptyReplaceMe
        #${CMAKE_CURRENT_BINARY_DIR}/../../../Engine/build/${CMAKE_BUILD_TYPE}/libMyEngine.a
        #${CMAKE_CURRENT_BINARY_DIR}/../../../Framework/build/${CMAKE_BUILD_TYPE}/libMyFramework.a
        #${CMAKE_CURRENT_BINARY_DIR}/../../../Engine/Libraries/bullet3/bin/libBulletDynamics_gmake_x64_release.a
        #${CMAKE_CURRENT_BINARY_DIR}/../../../Engine/Libraries/bullet3/bin/libBulletCollision_gmake_x64_release.a
        #${CMAKE_CURRENT_BINARY_DIR}/../../../Engine/Libraries/bullet3/bin/libLinearMath_gmake_x64_release.a
        GL pthread openal X11
    )
endif()

# Set debug preprocessor define.
if( CMAKE_BUILD_TYPE MATCHES Debug OR CMAKE_BUILD_TYPE MATCHES wxDebug )
    target_compile_definitions( GameEmptyReplaceMe PRIVATE _DEBUG=1 )
endif()

# WxWidgets specific preprocessor defines, libs, includes, etc.
if( CMAKE_BUILD_TYPE MATCHES wxDebug OR CMAKE_BUILD_TYPE MATCHES wxRelease )

    if( CMAKE_BUILD_TYPE MATCHES wxDebug )
        set( WXWIDGETS_FOLDER_NAME ../Framework/Libraries/wxWidgets/gtk-build-debug )
    elseif( CMAKE_BUILD_TYPE MATCHES wxRelease )
        set( WXWIDGETS_FOLDER_NAME ../Framework/Libraries/wxWidgets/gtk-build-release )
    endif()

    # Preprocessor defines.
    target_compile_definitions( GameEmptyReplaceMe PRIVATE MYFW_USING_WX=1 _FILE_OFFSET_BITS=64 __WXGTK__ )

    # Include directory for wxconfig.h.
    target_include_directories( GameEmptyReplaceMe PUBLIC "${WXWIDGETS_FOLDER_NAME}/lib/wx/include/gtk3-unicode-static-3.1" )

    # Libraries.
    target_link_libraries( GameEmptyReplaceMe
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
#include( ../Framework/Libraries/Cotire/CMake/cotire.cmake )
#set_target_properties( GameEmptyReplaceMe PROPERTIES COTIRE_CXX_PREFIX_HEADER_INIT "Game/SourceCommon/GameCommonHeader.h" )
#cotire( GameEmptyReplaceMe )
