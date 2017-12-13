if [ "$1" != "" ]; then

    # call CleanupTempFiles.sh $1

    # Update all existing files with matching files from the Game folder. (Data, DataSource and Tools)
    echo "$(tput setaf 5)==> Updating data files$(tput sgr0)"
    rsync -avL --update --existing ../GameEmptyReplaceMe/Game $1/
    source OSXCopyReleasePackages.sh

else

    echo "$(tput setaf 5)Must supply a folder name$(tput sgr0)"

fi
