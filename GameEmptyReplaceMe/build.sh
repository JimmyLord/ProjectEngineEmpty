
# Parse command line arguments.
CleanBuild=dontclean
BuildConfiguration=none

for var in "$@"
do
    if [[ $var =~ ^(Debug|Release|wxDebug|wxRelease)$ ]]; then
        BuildConfiguration=$var;
    fi
    if [[ $var = clean ]]; then
        CleanBuild=clean;
    fi
done

# Exit if a valid build config wasn't specified.
if [[ ! $BuildConfiguration =~ ^(Debug|Release|wxDebug|wxRelease)$ ]]; then
    echo "Specify a build configuration: Debug, Release, wxDebug, wxRelease"
    echo "add 'clean' to clean that configuration"
    exit 2
fi

# Output a title for the build.
echo "$(tput setaf 3)==> Configuration: $BuildConfiguration$(tput sgr0)"

# Build Dependents.
pushd ../Framework > /dev/null
    ./build.sh $BuildConfiguration $CleanBuild
popd > /dev/null

pushd ../Engine > /dev/null
    ./build.sh $BuildConfiguration $CleanBuild
popd > /dev/null

# Clean and exit.
if [[ $CleanBuild == clean ]]; then
    echo "$(tput setaf 5)==> Cleaning ProjectEmptyReplaceMe$(tput sgr0)"
    rm -r build/$BuildConfiguration
    exit 2
fi

# Link the engine data folder to data folder
if [ ! -d "Game/Data/DataEngine" ]; then
    pushd Game/Data > /dev/null
        ln -s ../../../Engine/DataEngine/ DataEngine
    popd > /dev/null
fi

# Build ProjectEmptyReplaceMe.
let NumJobs=$(nproc)*2
echo "$(tput setaf 2)==> Building ProjectEmptyReplaceMe$ (make -j$NumJobs)$(tput sgr0)"

if [ ! -d "build" ]; then
    mkdir build
fi

if [ ! -d build/$BuildConfiguration ]; then
    mkdir build/$BuildConfiguration
    pushd build/$BuildConfiguration > /dev/null
        cmake -DCMAKE_BUILD_TYPE=$BuildConfiguration ../..
    popd > /dev/null
fi

pushd build/$BuildConfiguration > /dev/null
    make -j$NumJobs
popd > /dev/null
