import QtQuick 
import QtQuick.Shapes

Shape {

  property real percent: 0.8 // out of 1
  property real startPercent: 0.25 // also out of 1
  property int strokesize: 6
  property int size
  property color color: "white"

  property real startTheta: startPercent * 2 * Math.PI
  property real theta: (startPercent + percent) * 2 * Math.PI

  id: root
  width: size
  height: size

  ShapePath {
    id: path
    strokeWidth: root.strokesize
    strokeColor: root.color
    fillColor: "transparent"

    startX: (1 - Math.cos(root.startTheta)) * (root.size / 2)
    startY: (1 - Math.sin(root.startTheta)) * (root.size / 2)
    capStyle: ShapePath.RoundCap


    PathArc {
      x: (1 - Math.cos(Math.min(root.theta, Math.PI + root.startTheta))) * (root.size / 2)
      y: (1 - Math.sin(Math.min(root.theta, Math.PI + root.startTheta))) * (root.size / 2)
      radiusX: root.size / 2
      radiusY: root.size / 2
      useLargeArc: false
      direction: PathArc.Clockwise
    }

    PathArc {
      x: (1 - Math.cos(root.theta)) * (root.size / 2)
      y: (1 - Math.sin(root.theta)) * (root.size / 2)
      radiusX: root.size / 2
      radiusY: root.size / 2
      useLargeArc: false
      direction: PathArc.Clockwise
    }
  }

  Behavior on theta {
    NumberAnimation {
      duration: 250
      easing.type: Easing.InOutSine
    }
  }
}
