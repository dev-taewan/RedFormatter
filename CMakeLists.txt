cmake_minimum_required(VERSION 3.15)
project(redfomatter CXX)

find_package(cpprestsdk REQUIRED)
find_package(OpenSSL REQUIRED)
find_package(Boost REQUIRED)

add_executable(redfomatter src/redfomatter.cpp src/main.cpp)



install(TARGETS redfomatter DESTINATION "."
        RUNTIME DESTINATION bin
        ARCHIVE DESTINATION lib
        LIBRARY DESTINATION lib
        )


target_link_libraries(redfomatter PRIVATE
    cpprestsdk::cpprest
    OpenSSL::SSL
    Boost::boost
)
