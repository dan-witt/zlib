# zlibConfig.cmake
# Configuration file for the zlib library, providing paths for includes and pre-built binaries.

cmake_minimum_required(VERSION 3.22)

# Determine the architecture, especially for Android builds.
if(DEFINED ANDROID_ABI)
  if(ANDROID_ABI STREQUAL "x86")
	  set(ZLIB_ARCH "android-x86")
  elseif(ANDROID_ABI STREQUAL "x86_64")
	  set(ZLIB_ARCH "android-x86_64")
  else()
	  set(ZLIB_ARCH ${ANDROID_ABI})
  endif()
else()
    execute_process(
      COMMAND ${CMAKE_C_COMPILER} -dumpmachine
      OUTPUT_VARIABLE ZLIB_ARCH
      OUTPUT_STRIP_TRAILING_WHITESPACE
      RESULT_VARIABLE RESULT
    )
    if(RESULT)
      message(FATAL_ERROR "Failed to determine the target triplet using -dumpmachine!")
    endif()    	
endif()

# Set the include and library paths.
set(ZLIB_INCLUDE_DIRS "${CMAKE_CURRENT_LIST_DIR}/include")
set(ZLIB_LIBRARIES "${CMAKE_CURRENT_LIST_DIR}/lib/${ZLIB_ARCH}/libz.a")

# Define an IMPORTED library target.
add_library(ZLIB::ZLIB STATIC IMPORTED)
set_target_properties(ZLIB::ZLIB PROPERTIES IMPORTED_LOCATION "${ZLIB_LIBRARIES}")
target_include_directories(ZLIB::ZLIB INTERFACE ${ZLIB_INCLUDE_DIRS})

