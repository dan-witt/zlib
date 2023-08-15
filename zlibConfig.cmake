cmake_minimum_required(VERSION 3.22)

if(ARM_ABI STREQUAL "x86")
    set(ZLIB_ARCH "android-x86")
elseif(ARM_ABI STREQUAL "x86_64")
    set(ZLIB_ARCH "android-x86_64")
elseif(ARM_ABI STREQUAL "")
    set(ZLIB_ARCH "linux")    
else()
    set(ZLIB_ARCH ${ARM_ABI})
endif()

set(ZLIB_INCLUDE_DIRS "${CMAKE_CURRENT_LIST_DIR}/include")
set(ZLIB_LIBRARIES "${CMAKE_CURRENT_LIST_DIR}/lib/${ZLIB_ARCH}/libz.a")

add_library(ZLIB::ZLIB STATIC IMPORTED)
set_target_properties(ZLIB::ZLIB PROPERTIES IMPORTED_LOCATION "${ZLIB_LIBRARIES}")
target_include_directories(ZLIB::ZLIB INTERFACE ${ZLIB_INCLUDE_DIRS})
