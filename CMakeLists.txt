cmake_minimum_required(VERSION 3.15)
project(redformatter VERSION 1.0)

# Conan 설정
#include(${CMAKE_BINARY_DIR}/conan_toolchain.cmake)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Debug/Release 확인
message(STATUS "CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}")
include(FetchContent)
FetchContent_Declare(
    Slint
    GIT_REPOSITORY https://github.com/slint-ui/slint.git
    # `release/1` will auto-upgrade to the latest Slint >= 1.0.0 and < 2.0.0
    # `release/1.0` will auto-upgrade to the latest Slint >= 1.0.0 and < 1.1.0
    GIT_TAG release/1
    SOURCE_SUBDIR api/cpp
)
FetchContent_MakeAvailable(Slint)
# 소스 및 헤더 경로
file(GLOB_RECURSE SOURCES "src/*.cpp")
file(GLOB_RECURSE UI_SLINT "src/*.slint")
file(GLOB_RECURSE HEADERS "src/*.h")

# 실행 파일 생성
add_executable(redformatter ${SOURCES})

slint_target_sources(redformatter src/main_ui.slint)
target_link_libraries(redformatter PRIVATE Slint::Slint)

find_package(cpprestsdk REQUIRED)
find_package(Boost REQUIRED COMPONENTS system filesystem thread regex)
find_package(OpenSSL REQUIRED)

target_link_libraries(redformatter PRIVATE
    cpprestsdk::cpprest
    Boost::system
    Boost::filesystem
    Boost::thread
    Boost::regex
    OpenSSL::SSL
    OpenSSL::Crypto
)

# 설치 경로 설정
install(TARGETS redformatter
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
)
