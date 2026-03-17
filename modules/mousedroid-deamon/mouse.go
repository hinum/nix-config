package main

import "github.com/holoplot/go-evdev"

func mousedown(dev *evdev.InputDevice, code evdev.EvCode, scanValue int32) {
	writeEvent(dev, evdev.EV_MSC, evdev.MSC_SCAN, scanValue)
	writeEvent(dev, evdev.EV_KEY, code, 1)
	writeEvent(dev, evdev.EV_SYN, evdev.SYN_REPORT, 0)
}
func mouseup(dev *evdev.InputDevice, code evdev.EvCode, scanValue int32) {
	writeEvent(dev, evdev.EV_MSC, evdev.MSC_SCAN, scanValue)
	writeEvent(dev, evdev.EV_KEY, code, 0)
	writeEvent(dev, evdev.EV_SYN, evdev.SYN_REPORT, 0)
}
func mousemove(dev *evdev.InputDevice, deltaX int8, deltaY int8) {
	writeEvent(dev, evdev.EV_REL, evdev.REL_X, int32(deltaX))
	writeEvent(dev, evdev.EV_REL, evdev.REL_Y, int32(deltaY))
	writeEvent(dev, evdev.EV_SYN, evdev.SYN_REPORT, 0)
}
func mousescroll(dev *evdev.InputDevice, delta int8) {
	writeEvent(dev, evdev.EV_REL, evdev.REL_WHEEL, int32(delta >> 2))
	writeEvent(dev, evdev.EV_REL, evdev.REL_WHEEL_HI_RES, int32(delta * 30))
	writeEvent(dev, evdev.EV_SYN, evdev.SYN_REPORT, 0)
}
// scroll horizontally
func mousehscroll(dev *evdev.InputDevice, delta int8) {
	writeEvent(dev, evdev.EV_REL, evdev.REL_HWHEEL, int32(delta >> 2))
	writeEvent(dev, evdev.EV_REL, evdev.REL_HWHEEL_HI_RES, int32(delta * 30))
	writeEvent(dev, evdev.EV_SYN, evdev.SYN_REPORT, 0)
}
