cmake_minimum_required(VERSION 3.16)

project(RedFormatter VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(cpprestsdk REQUIRED)
find_package(Boost REQUIRED)
find_package(OpenSSL REQUIRED)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appRedFormatter
    main.cpp
)

qt_add_qml_module(appRedFormatter
    URI RedFormatter
    VERSION 1.0
    QML_FILES
        Main.qml
        SOURCES IssueList.h IssueList.cpp
        QML_FILES IssueList.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appRedFormatter PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appRedFormatter
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appRedFormatter
    PRIVATE Qt6::Quick
    cpprestsdk::cpprest
    Boost::system
    Boost::filesystem
    Boost::thread
    Boost::regex
    OpenSSL::SSL
    OpenSSL::Crypto
)

include(GNUInstallDirs)
install(TARGETS appRedFormatter
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
