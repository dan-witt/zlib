# Findzlib.cmake

find_path(ZLIB_INCLUDE_DIR
         NAMES zlib.h
         PATHS "${CMAKE_CURRENT_LIST_DIR}/include"
         NO_DEFAULT_PATH)

if(ARM_ABI STREQUAL "x86")
    set(ZLIB_ARCH "android-x86")
elseif(ARM_ABI STREQUAL "x86_64")
    set(ZLIB_ARCH "android-x86_64")
elseif(ARM_ABI STREQUAL "")
    set(ZLIB_ARCH "linux")    
else()
    set(ZLIB_ARCH ${ARM_ABI})
endif()

find_library(ZLIB_LIBRARY
             NAMES z libz
             PATHS "${CMAKE_CURRENT_LIST_DIR}/lib/${ZLIB_ARCH}"
             NO_DEFAULT_PATH)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(ZLIB REQUIRED_VARS ZLIB_LIBRARY ZLIB_INCLUDE_DIR)

if(ZLIB_FOUND AND NOT TARGET ZLIB::ZLIB)
    add_library(ZLIB::ZLIB UNKNOWN IMPORTED)
    set_target_properties(ZLIB::ZLIB PROPERTIES
                          IMPORTED_LOCATION "${ZLIB_LIBRARY}"
                          INTERFACE_INCLUDE_DIRECTORIES "${ZLIB_INCLUDE_DIR}")
endif()

