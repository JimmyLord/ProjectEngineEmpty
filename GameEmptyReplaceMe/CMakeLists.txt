cmake_minimum_required( VERSION 3.4.1 )

###############################################################################
# Source code file list.
###############################################################################

# Game source files.
file( GLOB_RECURSE sourceFiles "Game/SourceCommon/*.cpp" )

# Android specific source files.
if( CMAKE_SYSTEM_NAME MATCHES Android )
    file( GLOB_RECURSE platformFiles "Game/SourceAndroid/*.cpp" )
    set( sourceFiles ${sourceFiles} ${platformFiles} )
endif()

# Linux specific source files.
if( CMAKE_SYSTEM_NAME MATCHES Linux )
    file( GLOB_RECURSE platformFiles "Game/SourceLinux/*.cpp" )
    set( sourceFiles ${sourceFiles} ${platformFiles} )
    list( REMOVE_ITEM sourceFiles "${CMAKE_CURRENT_SOURCE_DIR}/Game/SourceLinux/LinuxMainWx.cpp" )
endif()

# Windows/VisualStudio specific source files.
if( CMAKE_SYSTEM_NAME MATCHES Windows )
    file( GLOB_RECURSE platformFiles "Game/SourceWindows/*.cpp" )
    set( sourceFiles ${sourceFiles} ${platformFiles} )
    list( REMOVE_ITEM sourceFiles "${CMAKE_CURRENT_SOURCE_DIR}/Game/SourceWindows/WinMainWx.cpp" )
endif()

###############################################################################
# Library setup.
###############################################################################

# Create a shared library on Android or an executable on other platforms.
if( CMAKE_SYSTEM_NAME MATCHES Android )
    add_library( GameEmptyReplaceMe SHARED ${sourceFiles} )
elseif( CMAKE_SYSTEM_NAME MATCHES Windows )
    add_executable( GameEmptyReplaceMe WIN32 ${sourceFiles} )
else()
    add_executable( GameEmptyReplaceMe ${sourceFiles} )
endif()

target_link_libraries( GameEmptyReplaceMe MyEngine MyFramework )

# Game include directories.
target_include_directories( GameEmptyReplaceMe PRIVATE "Game/SourceCommon" )

###############################################################################
# Platform specific settings.
###############################################################################

# Android settings.
if( CMAKE_SYSTEM_NAME MATCHES Android )
    target_compile_definitions( GameEmptyReplaceMe PRIVATE MYFW_ANDROID=1 )
    target_include_directories( GameEmptyReplaceMe PRIVATE "Game/SourceAndroid" )
    target_link_libraries( GameEmptyReplaceMe android log GLESv2 OpenSLES EGL ) #c m gcc )
endif()

# Linux settings.
if( CMAKE_SYSTEM_NAME MATCHES Linux )
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

# Windows/VisualStudio settings.
if( CMAKE_SYSTEM_NAME MATCHES Windows )
    target_compile_definitions( GameEmptyReplaceMe PRIVATE MYFW_WINDOWS=1 )
    target_include_directories( GameEmptyReplaceMe PRIVATE "Game/SourceWindows" )
	add_definitions( -DUNICODE -D_UNICODE )
    target_link_libraries( GameEmptyReplaceMe Ws2_32.lib opengl32.lib glu32.lib xinput.lib
	                                          $(SolutionDir)Framework/Libraries/pthreads-w32/lib/x86/pthreadVC2.lib )
    set_target_properties( GameEmptyReplaceMe PROPERTIES LINK_FLAGS "/DELAYLOAD:pthreadVC2.dll" )
endif()

# Editor settings.
if( CMAKE_BUILD_TYPE MATCHES EditorDebug OR CMAKE_BUILD_TYPE MATCHES EditorRelease )
    target_compile_definitions( GameEmptyReplaceMe PRIVATE MYFW_USING_IMGUI=1 MYFW_EDITOR=1 )

    # Set base CMake build type to debug or release.
    if( CMAKE_BUILD_TYPE MATCHES EditorDebug )
        set( CMAKE_BUILD_TYPE Debug )
    elseif( CMAKE_BUILD_TYPE MATCHES EditorRelease )
        set( CMAKE_BUILD_TYPE Release )
    endif()
endif()

# Debug settings.
if( CMAKE_BUILD_TYPE MATCHES Debug )
    target_compile_definitions( GameEmptyReplaceMe PRIVATE _DEBUG=1 )
endif()

# cotire (Compile time reducer)
include( ../Framework/Libraries/Cotire/CMake/cotire.cmake )
set_target_properties( GameEmptyReplaceMe PROPERTIES COTIRE_CXX_PREFIX_HEADER_INIT "Game/SourceCommon/GameCommonHeader.h" )
cotire( GameEmptyReplaceMe )
