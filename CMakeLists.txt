cmake_minimum_required( VERSION 3.4.1 )

# Project.
project( ProjectEmptyReplaceMe_AndroidProject VERSION 0.1 LANGUAGES CXX )

add_subdirectory( GameEmptyReplaceMe )
add_subdirectory( Engine )
add_subdirectory( Framework )

#target_link_libraries( GameEmptyReplaceMe MyEngine MyFramework )
target_link_libraries( GameEmptyReplaceMe )
