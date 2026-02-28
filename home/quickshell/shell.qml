import Quickshell
import Quickshell.Io

ShellRoot {
  Clock {}
  VolumeControl {
    id: volcontrol
  }

  IpcHandler {
    function increaseVolume() {
      volcontrol.increaseVolume()
    }
    function decreaseVolume() {
      volcontrol.decreaseVolume()
    }
  }
}
