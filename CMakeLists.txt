cmake_minimum_required(VERSION 3.14)

project(zsign)
set(CMAKE_CXX_STANDARD 11)

# Dependencies
# On macOS, search Homebrew for keg-only versions of OpenSSL because system provided /usr/lib/libssl.dylib cannot be linked
if (CMAKE_HOST_SYSTEM_NAME MATCHES "Darwin")
    execute_process(
        COMMAND brew --prefix OpenSSL 
        RESULT_VARIABLE BREW_OPENSSL
        OUTPUT_VARIABLE BREW_OPENSSL_PREFIX
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    if (BREW_OPENSSL EQUAL 0 AND EXISTS "${BREW_OPENSSL_PREFIX}")
        message(STATUS "Found OpenSSL keg installed by Homebrew at ${BREW_OPENSSL_PREFIX}")
        set(OPENSSL_ROOT_DIR "${BREW_OPENSSL_PREFIX}/")
        set(OPENSSL_INCLUDE_DIR "${BREW_OPENSSL_PREFIX}/include")
        set(OPENSSL_LIBRARIES "${BREW_OPENSSL_PREFIX}/lib/libssl.dylib;${BREW_OPENSSL_PREFIX}/lib/libcrypto.dylib")
    endif()

    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
    set(CMAKE_INSTALL_LIBDIR ${CMAKE_BINARY_DIR}/lib)

    file(MAKE_DIRECTORY ${CMAKE_INSTALL_LIBDIR})

else()
    find_package(OpenSSL REQUIRED)
endif()

message("OpenSSL include dir: ${OPENSSL_INCLUDE_DIR}")
message("OpenSSL libraries: ${OPENSSL_LIBRARIES}")
include_directories(${OPENSSL_INCLUDE_DIR})
list(APPEND LIB_LIST ${OPENSSL_LIBRARIES})

find_package(ZLIB REQUIRED)
message("zlib include dir: ${ZLIB_INCLUDE_DIR}")
message("zlib libraries: ${ZLIB_LIBRARIES}")
include_directories(${ZLIB_INCLUDE_DIR})
list(APPEND LIB_LIST ${ZLIB_LIBRARIES})

# Main sources

file(GLOB SRC common/*.cpp ./**.cpp)

add_executable(zsign ${SRC})
target_link_libraries(zsign ${LIB_LIST})

if (CMAKE_HOST_SYSTEM_NAME MATCHES "Darwin")
    SET(PROJ_LIB_DIR ${CMAKE_CURRENT_LIST_DIR}/lib)
    SET(CMAKE_SKIP_BUILD_RPATH  FALSE)
    SET(CMAKE_BUILD_WITH_INSTALL_RPATH TRUE) 
    SET(CMAKE_INSTALL_RPATH "${PROJ_LIB_DIR}")
    SET(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
endif()