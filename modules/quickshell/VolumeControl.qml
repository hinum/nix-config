import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import Quickshell.Hyprland
import QtQuick
import QtQuick.Shapes

PanelWindow {
  id: root
  screen: Quickshell.screens.find(s => s.name == Hyprland.focusedMonitor.name)

  anchors {
    bottom: true
    left: true
  }
  implicitWidth: 480
  implicitHeight: 480
  color: "transparent"

  Shape {
    id: bg
    anchors.fill: parent

    ShapePath {
      strokeWidth: 0
      fillGradient: RadialGradient {
        centerX: 0
        centerY: bg.height
        focalX: centerX
        focalY: centerY
        centerRadius: bg.height

        GradientStop {
          position: 0
          color: Color.crust
        }
        GradientStop {
          position: 1
          color: "transparent"
        }
      }
      PathRectangle {
        x: 0
        y: 0
        width: bg.width
        height: bg.width
      }
    }

    PieCircle {
      size: 200
      strokesize: 20
      percent: Pipewire.defaultAudioSink.audio.volume
      anchors {
        bottom: bg.bottom
        left: bg.left
        bottomMargin: 40
        leftMargin: 40
      }
    }

    Timer {
      id: timer
      interval: 500
      running: false
      onTriggered: root.visible = false
    }

    IpcHandler {
      function increaseVolume() {
        root.visible = true
        timer.restart()
        Pipewire.defaultAudioSink.audio.volume += 0.05
      }
      function decreaseVolume() {
        root.visible = true
        timer.restart()
        Pipewire.defaultAudioSink.audio.volume -= 0.05
      }
    }
  }
}
