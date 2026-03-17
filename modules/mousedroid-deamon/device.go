package main

import (
	"log"
	"syscall"
	"time"

	"github.com/holoplot/go-evdev"
)

func getAllKey(keymap map[int]evdev.EvCode) []evdev.EvCode{
	allkey := []evdev.EvCode{
		evdev.BTN_LEFT,
		evdev.BTN_RIGHT,
		evdev.BTN_MIDDLE,
		evdev.KEY_FORWARD,
		evdev.KEY_BACK,
		evdev.KEY_NEXTSONG,
		evdev.KEY_PREVIOUSSONG,
		evdev.KEY_PLAYPAUSE,
		evdev.KEY_MUTE,
		evdev.KEY_VOLUMEUP,
		evdev.KEY_VOLUMEDOWN,
	}

	for _, v := range keymap {
		allkey = append(allkey, v)
	}
	return allkey
}

func createDevice() *evdev.InputDevice {
	dev, err := evdev.CreateDevice(
		"fake-device",
		evdev.InputID{
			BusType: 0x03,
			Vendor:  0x4711,
			Product: 0x0816,
			Version: 1,
		},
		map[evdev.EvType][]evdev.EvCode{
			evdev.EV_KEY: getAllKey(keymap),
			evdev.EV_REL: {
				evdev.REL_X,
				evdev.REL_Y,
				evdev.REL_WHEEL,
				evdev.REL_WHEEL_HI_RES,
				evdev.REL_HWHEEL,
				evdev.REL_HWHEEL_HI_RES,
			},
		},
	)
	if err != nil {
		log.Fatalf("failed to create device: %s", err.Error())
	}
	return dev
}
func writeEvent(dev *evdev.InputDevice, typ evdev.EvType, code evdev.EvCode, value int32) {
	time := syscall.NsecToTimeval(int64(time.Now().Nanosecond()))
	dev.WriteOne(&evdev.InputEvent{
		Time:  time,
		Type:  typ,
		Code:  code,
		Value: value,
	})
}

