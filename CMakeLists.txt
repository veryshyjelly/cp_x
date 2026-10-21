cmake_minimum_required(VERSION 3.20)
project(Competitive_Programming)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 1. MAP THE 'lib' FOLDER FOR AUTOCOMPLETE
# This ensures anything inside lib/ can be included as #include "file.h"
include_directories(src/lib)

# 2. STRICT COMPILER FLAGS
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O2 -Wall -Wextra -Wshadow -D_GLIBCXX_DEBUG")

# 3. FLAT GLOBBING IN src/bin/
# CONFIGURE_DEPENDS tells CLion to update whenever your tool creates a new file
file(GLOB CPP_FILES CONFIGURE_DEPENDS "src/bin/*.cpp")

foreach(CPP_FILE ${CPP_FILES})
    # Get the flat file name without the .cpp extension (e.g., "1553-a-digits-sum")
    get_filename_component(TARGET_NAME ${CPP_FILE} NAME_WE)

    # Create the executable mapped to that specific problem
    add_executable(${TARGET_NAME} ${CPP_FILE}
#            src/main.cpp
    )
endforeach()