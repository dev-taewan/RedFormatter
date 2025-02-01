import QtQuick 2.15
import QtQml 2.15

Item {
    id: root

    // 외부에서 쓸 수 있는 속성
    property alias source: imageSource.source
    property color color: "white"

    // 크기 설정: 이미지 크기를 따라감
    implicitWidth: imageSource.implicitWidth
    implicitHeight: imageSource.implicitHeight

    // 실제 이미지 로딩
    Image {
        id: imageSource
        anchors.fill: parent
        // source: "assets/page-indicator.png"  // 필요하면 기본값 지정
        visible: false // ShaderEffect가 그리는 대상이라 직접 표시 X
    }

    // ShaderEffect로 색상화
    ShaderEffect {
        anchors.fill: parent

        // 이 쉐이더가 사용할 텍스처 프로퍼티
        property var sourceTexture: imageSource

        // 외부에서 지정한 color를 쉐이더 유니폼으로 넘김
        property alias color: root.color

        // Qt 6에서 ShaderEffect는 기본적으로 glsl 3.0 ES를 사용하기도 함
        vertexShader: "
            #ifdef GL_ES
            precision highp float;
            #endif

            in vec4 qt_Vertex;
            in vec2 qt_MultiTexCoord0;
            out vec2 vTexCoord;

            void main() {
                gl_Position = qt_Vertex;
                vTexCoord = qt_MultiTexCoord0;
            }
        "

        fragmentShader: "
            #ifdef GL_ES
            precision mediump float;
            #endif

            in vec2 vTexCoord;
            out vec4 fragColor;

            // 샘플러(원본 이미지)
            uniform sampler2D sourceTexture;
            // 지정된 color
            uniform vec4 color;

            void main() {
                vec4 src = texture(sourceTexture, vTexCoord);
                // 단순 Multiply 방식으로 색상화
                // (원본 알파 고려하여 src.a 유지)
                fragColor = vec4(src.rgb * color.rgb, src.a * color.a);
            }
        "
    }
}
