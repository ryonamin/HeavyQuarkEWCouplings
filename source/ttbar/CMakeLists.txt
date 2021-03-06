########################################################
# cmake file for building Marlin example Package
# @author Jan Engels, Desy IT
CMAKE_MINIMUM_REQUIRED(VERSION 2.6 FATAL_ERROR)
########################################################


# project name
PROJECT( ttbar )


# project version
SET( ${PROJECT_NAME}_VERSION_MAJOR 0 )
SET( ${PROJECT_NAME}_VERSION_MINOR 1 )
SET( ${PROJECT_NAME}_VERSION_PATCH 0 )



### DEPENDENCIES ############################################################

# additionally search for cmake macros/moules defined by this project
LIST( APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake )

# ------- required packages -------------------
SET( required_packages LCIO GEAR Marlin ROOT MarlinUtil)

# ------- optional packages -------------------
#SET( optional_packages AIDA )


# ------- do the search -----------------------

# fix for backwards compatibility
FOREACH( pkg ${required_packages} ${optional_packages} )
    IF( NOT ${pkg}_DIR AND DEFINED ${pkg}_HOME )
        SET( ${pkg}_DIR ${${pkg}_HOME} )
    ENDIF()
ENDFOREACH()

FOREACH( pkg ${required_packages} )
    FIND_PACKAGE( ${pkg} REQUIRED )
ENDFOREACH()

FOREACH( pkg ${optional_packages} )
    FIND_PACKAGE( ${pkg} QUIET )
ENDFOREACH()

FOREACH( pkg ${required_packages} ${optional_packages} )
    IF( ${pkg}_FOUND )
        INCLUDE_DIRECTORIES( ${${pkg}_INCLUDE_DIRS} )
        LINK_LIBRARIES( ${${pkg}_LIBRARIES} )
        ADD_DEFINITIONS ( ${${pkg}_DEFINITIONS} )
    ELSE()
        MESSAGE( STATUS "${pkg} not found" )
    ENDIF()
ENDFOREACH()



### SETTINGS ################################################################

FIND_PACKAGE( ILCUTIL COMPONENTS ILCSOFT_CMAKE_MODULES REQUIRED )
# ilcsoft cmake macros / default settings
INCLUDE( ilcsoft_default_settings )
INCLUDE( MacroAddSharedLibrary )



### DOCUMENTATION ###########################################################

OPTION( INSTALL_DOC "Set to OFF to skip build/install Documentation" ON )

IF( INSTALL_DOC AND EXISTS "${PROJECT_SOURCE_DIR}/doc/CMakeLists.txt" )
    ADD_SUBDIRECTORY( doc )
ELSE()
    MESSAGE( STATUS "Documentation not found. INSTALL_DOC set to OFF" )
    SET( INSTALL_DOC OFF )
ENDIF()



### LIBRARY #################################################################

# library name
SET( libname ${PROJECT_NAME} )

# include directories
INCLUDE_DIRECTORIES( "include" )
INSTALL( DIRECTORY include DESTINATION . FILES_MATCHING PATTERN "*.h" )

# definitions to pass to the compiler
ADD_DEFINITIONS( "-Wall -ansi -pedantic" )
ADD_DEFINITIONS( "-Wno-long-long" )
ADD_DEFINITIONS( "-std=c++11" )

# add library
AUX_SOURCE_DIRECTORY( src library_sources )
ADD_SHARED_LIBRARY( ${libname} ${library_sources} )


# display some variables and write them to cache
DISPLAY_STD_VARIABLES()

