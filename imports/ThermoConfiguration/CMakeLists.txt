# Copyright (C) 2023 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

set_source_files_properties(Configuration.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE true
)
qt_add_library(ThermoConfiguration STATIC)
qt_add_qml_module(ThermoConfiguration
    URI "ThermoConfiguration"
    VERSION 1.0
    QML_FILES
        Configuration.qml
    OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/imports/ThermoConfiguration
)
