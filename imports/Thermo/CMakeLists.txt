# Copyright (C) 2023 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

set_source_files_properties(Rooms.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE true
)

set_source_files_properties(Theme.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE true
)
set_source_files_properties(ColorStyle.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE true
)


qt_add_qml_module(Theme
    URI "Theme"
    VERSION 1.0
    QML_FILES
        Theme.qml
        Rooms.qml
	Room.qml
        ColorStyle.qml
    OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/imports/Theme
)
