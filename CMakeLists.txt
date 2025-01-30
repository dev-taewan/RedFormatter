cmake_minimum_required(VERSION 3.16)

project(RedmineTest VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)
set(MODULE_QML_FILES
    imports/Thermo/ColorStyle.qml
    imports/Thermo/Rooms.qml
    imports/Thermo/Room.qml)

qt_standard_project_setup(REQUIRES 6.5)
qt_policy(SET QTP0004 NEW)

qt_add_executable(appRedmineTest
    main.cpp
)
qt_add_resources(appRedmineTest "assets"
    PREFIX "/"
    FILES
                assets/qt-logo.png
                assets/JAPAN.png
                assets/temp-down-pressed.png
                assets/switch-handle.png
                assets/popup-bg.png
                assets/scrollbar-temperature-track.png
                assets/radiobutton-checked-pressed.png
                assets/digitMaskBottom.png
                assets/switch-i.png
                assets/btn-bg-big-on.png
                assets/radiobutton-pressed.png
                assets/pressed-bg-up.png
                assets/selected.png
                assets/eco-on.png
                assets/streamer-on-small.png
                assets/page-indicator.png
                assets/jog-off.png
                assets/status-small.png
                assets/dryer-on-small.png
                assets/dryer-on.png
                assets/close.png
                assets/auto-card.png
                assets/toggle-year.png
                assets/eco-on-small.png
                assets/separator-line.png
                assets/radiobutton-checked.png
                assets/streamer-on.png
                assets/btn-bg-down.png
                assets/slider-handle.png
                assets/thermo-handle.png
                assets/switch-bg.png
                assets/pressed-bg-down.png
                assets/auto-on.png
                assets/place-back.png
                assets/UK.png
                assets/radiobutton.png
                assets/baseline-arrow-back.png
                assets/digitMaskTop.png
                assets/switch-o.png
                assets/power-on.png
                assets/temp-up-pressed.png
                assets/btn-bg-big-off.png
                assets/toggle-month.png
                assets/jog.png
                assets/GERMANY.png
                assets/change-language.png
                assets/scrollbar-off-track.png
                assets/weather/w_06.png
                assets/weather/w_01.png
                assets/weather/w_02.png
                assets/weather/w_07.png
                assets/weather/w_05.png
                assets/weather/w_04.png
                assets/weather/w_03.png
                assets/stats-month.png
                assets/stats-year.png
                assets/main-bg.png
                assets/fan-off.png
                assets/fan-off-small.png
                assets/fan-1-on.png
                assets/fan-1-on-small.png
                assets/fan-2-on.png
                assets/fan-2-on-small.png
                assets/fan-3-on.png
                assets/fan-3-on-small.png
                assets/fan-4-on.png
                assets/fan-4-on-small.png
)
qt_add_resources(appRedmineTest "images"
    PREFIX "/"
    FILES
               images/inner-circle.png
               images/card-back-topleft.png
               images/card-back-bottomleft.png
               images/card-back-topright.png
               images/card-back-bottomright.png
)
qt_add_resources(appRedmineTest "fonts"
    PREFIX "/"
    FILES
                fonts/NotoSansArabic-Regular.ttf
                fonts/NotoSansJP-Regular.otf
                fonts/NotoSansThai-Regular.ttf
                fonts/Roboto-Regular.ttf
)
qt_add_qml_module(appRedmineTest
    URI RedmineTest
    VERSION 1.0
    QML_FILES
        Main.qml
        QML_FILES contents/MainView.ui.qml
        QML_FILES contents/BottomBar.qml
        QML_FILES contents/BottomBarButton.ui.qml
        RESOURCES resource.qrc
        QML_FILES contents/BackgroundImage.ui.qml
)
qt_add_qml_module(Thermo_module
    URI Thermo
    VERSION 1.0
    QML_FILES
        imports/Thermo/Theme.qml
        ${MODULE_QML_FILES}
    OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/imports/Thermo
)
qt_add_qml_module(ThermoConfiguration_module
    URI ThermoConfiguration
    VERSION 1.0
    QML_FILES
        imports/ThermoConfiguration/Configuration.qml
    OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/imports/ThermoConfiguration
)
# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appRedmineTest PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appRedmineTest
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appRedmineTest
    PRIVATE Qt6::Quick
    PRIVATE Thermo_module
    ThermoConfiguration_module
)

include(GNUInstallDirs)
#add_subdirectory(imports)
install(TARGETS appRedmineTest
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
