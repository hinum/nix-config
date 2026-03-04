import Quickshell
import Quickshell.Wayland
import QtQuick
import "bar"
import "quicksettings"

ShellRoot {
  Bar {
    onClicked: settings.display()
  }
  QuickSettings {
    id: settings
  }
}
