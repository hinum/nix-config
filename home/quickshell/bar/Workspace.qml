import QtQuick
import Quickshell.Hyprland

Rectangle {
  id: root
  property int itemsize
  property int strokesize

  property int length: Hyprland.workspaces.values.length
  property int active: Math.min(Hyprland.focusedWorkspace.id || 1, length)

  width: itemsize
  height: itemsize
  color: Color.surface0
  radius: 9999

  PieCircle {
    id: pie
    color: Color.blue
    anchors.centerIn: parent
    size: root.itemsize - strokesize
    strokesize: root.strokesize

    percent: 1 / root.length
    startPercent: (root.active - 1)/root.length + 0.25
  }

  Text {
    text: Hyprland.focusedWorkspace.name
    anchors.centerIn: parent
    color: Color.blue
  }
}
