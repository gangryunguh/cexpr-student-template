cmake_minimum_required(VERSION 3.15)
project(cexpr C)

set(CMAKE_C_STANDARD 99)
set(CMAKE_BUILD_TYPE Debug)

if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    set(BISON_EXCUTABLE /usr/local/opt/flex/bin/flex)
    set(BISON_INCLUDE_DIRS /usr/local/opt/flex/include)
endif()

find_package(BISON REQUIRED)
BISON_TARGET(Expr cexpr.y ${CMAKE_BINARY_DIR}/cexpr.tab.c
        DEFINES_FILE ${CMAKE_BINARY_DIR}/cexpr.tab.h)

if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    set(FLEX_EXCUTABLE /usr/local/opt/flex/bin/flex)
    set(FLEX_INCLUDE_DIRS /usr/local/opt/flex/include)
endif()

find_package(FLEX REQUIRED)
FLEX_TARGET(Scan scan.l ${CMAKE_BINARY_DIR}/scan.yy.c
        DEFINES_FILE ${CMAKE_BINARY_DIR}/scan.yy.h)

if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
set(FLEX_LIBRARIES /usr/local/opt/flex/lib/libfl.dylib /usr/local/opt/flex/lib/libfl.a
        /usr/local/opt/flex/lib/libfl.2.dylib)
endif()

add_executable(cexpr ${BISON_Expr_OUTPUTS} ${FLEX_Scan_OUTPUTS})
target_link_libraries(cexpr ${FLEX_LIBRARIES} ${BISON_LIBRARIES})
