import QtQuick
import QtQuick.Controls

Item {
    property int rangeValue: 40
    property int nowRange: 10

    property int mW: 130
    property int mH: 130
    property int lineWidth: 2

    property double r: mH / 2
    property double cR: r - 16 * lineWidth

    // Sin 파도 관련 속성
    property int sX: 0
    property int sY: mH / 2
    property int axisLength: mW
    property double waveWidth: 0.015
    property double waveHeight: 6
    property double speed: 0.09
    property double xOffset: 0

    Canvas {
        id: canvas
        width: mW
        height: mH
        anchors.centerIn: parent

        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, mW, mH);

            // 바깥 원 (굵은 선)
            ctx.beginPath();
            ctx.strokeStyle = '#148014';
            ctx.arc(r, r, cR + 5, 0, 2 * Math.PI);
            ctx.stroke();

            // 안쪽 원 클리핑
            ctx.beginPath();
            ctx.arc(r, r, cR, 0, 2 * Math.PI);
            ctx.clip();

            // 파도 채우기
            ctx.save();
            var points = [];
            ctx.beginPath();
            for (var x = sX; x < sX + axisLength; x += 20 / axisLength) {
                var y = -Math.sin((sX + x) * waveWidth + xOffset);
                // 퍼센트만큼 수면 높이 조절
                var dY = mH * (1 - nowRange / 100 );
                points.push([x, dY + y * waveHeight]);
                ctx.lineTo(x, dY + y * waveHeight);
            }
            ctx.lineTo(axisLength, mH);
            ctx.lineTo(sX, mH);
            ctx.lineTo(points[0][0], points[0][1]);
            ctx.fillStyle = '#1c86d1';
            ctx.fill();
            ctx.restore();

            // 중앙 퍼센트 텍스트
            ctx.save();
            var size = 0.5 * cR;
            ctx.font = size + 'px Arial';
            ctx.textAlign = 'center';
            ctx.fillStyle = "#3acf93"; //"rgba(14, 80, 14, 0.8)";
            ctx.fillText(~~nowRange + '%', r, r + size / 2);
            ctx.restore();

            // nowRange가 목표 rangeValue에 수렴
            if (nowRange < rangeValue) {
                nowRange += 1;
            } else if (nowRange > rangeValue) {
                nowRange -= 1;
            }

            // 파도 움직임
            xOffset += speed;
        }

        // 주기적으로 그려주기 위한 타이머
        Timer {
            id: timer
            interval: 16   // 60fps 정도
            running: true
            repeat: true
            onTriggered: {
                canvas.requestPaint()
            }
        }
    }
}
