package main

import "github.com/holoplot/go-evdev"

func mediaPress(dev *evdev.InputDevice, code byte, value int32) {
	switch code {
		case 1:
			writeEvent(dev, evdev.EV_KEY, evdev.KEY_FORWARD, value)
		case 1 << 1:
			writeEvent(dev, evdev.EV_KEY, evdev.KEY_BACK, value)
		case 1 << 2:
			writeEvent(dev, evdev.EV_KEY, evdev.KEY_NEXTSONG, value)
		case 1 << 3:
			writeEvent(dev, evdev.EV_KEY, evdev.KEY_PREVIOUSSONG, value)
		case 1 << 4:
			writeEvent(dev, evdev.EV_KEY, evdev.KEY_PLAYPAUSE, value)
		case 1 << 5:
			writeEvent(dev, evdev.EV_KEY, evdev.KEY_MUTE, value)
		case 1 << 6:
			writeEvent(dev, evdev.EV_KEY, evdev.KEY_VOLUMEUP, value)
		case 1 << 7:
			writeEvent(dev, evdev.EV_KEY, evdev.KEY_VOLUMEDOWN, value)
	}
}
func modifierPress(dev *evdev.InputDevice, code byte, value int32) {
	switch code {
		case 1:
			writeEvent(dev, evdev.EV_KEY, evdev.KEY_LEFTCTRL, value)
		case 1 << 1:
			writeEvent(dev, evdev.EV_KEY, evdev.KEY_LEFTSHIFT, value)
		case 1 << 2:
			writeEvent(dev, evdev.EV_KEY, evdev.KEY_LEFTALT, value)
		case 1 << 3:
			writeEvent(dev, evdev.EV_KEY, evdev.KEY_LEFTMETA, value)
		case 1 << 4:
			writeEvent(dev, evdev.EV_KEY, evdev.KEY_RIGHTCTRL, value)
		case 1 << 5:
			writeEvent(dev, evdev.EV_KEY, evdev.KEY_RIGHTSHIFT, value)
		case 1 << 6:
			writeEvent(dev, evdev.EV_KEY, evdev.KEY_RIGHTALT, value)
		case 1 << 7:
			writeEvent(dev, evdev.EV_KEY, evdev.KEY_RIGHTMETA, value)
	}
}
func keypress(dev *evdev.InputDevice, code byte, modifier byte) {
	modifierPress(dev, modifier, 1)
	writeEvent(dev, evdev.EV_MSC, evdev.MSC_SCAN, int32(code) + 0x7000)
	writeEvent(dev, evdev.EV_KEY, keymap[int(code)], 1)
	writeEvent(dev, evdev.EV_SYN, evdev.SYN_REPORT, 0)
	modifierPress(dev, modifier, 0)
	writeEvent(dev, evdev.EV_MSC, evdev.MSC_SCAN, int32(code) + 0x7000)
	writeEvent(dev, evdev.EV_KEY, keymap[int(code)], 0)
	writeEvent(dev, evdev.EV_SYN, evdev.SYN_REPORT, 0)
}
func mediapress(dev *evdev.InputDevice, code byte) {
	mediaPress(dev, code, 1)
	writeEvent(dev, evdev.EV_SYN, evdev.SYN_REPORT, 0)
	mediaPress(dev, code, 0)
	writeEvent(dev, evdev.EV_SYN, evdev.SYN_REPORT, 0)
}

var keymap = map[int]evdev.EvCode{
	// Letters A-Z
	0x04: evdev.KEY_A,
	0x05: evdev.KEY_B,
	0x06: evdev.KEY_C,
	0x07: evdev.KEY_D,
	0x08: evdev.KEY_E,
	0x09: evdev.KEY_F,
	0x0A: evdev.KEY_G,
	0x0B: evdev.KEY_H,
	0x0C: evdev.KEY_I,
	0x0D: evdev.KEY_J,
	0x0E: evdev.KEY_K,
	0x0F: evdev.KEY_L,
	0x10: evdev.KEY_M,
	0x11: evdev.KEY_N,
	0x12: evdev.KEY_O,
	0x13: evdev.KEY_P,
	0x14: evdev.KEY_Q,
	0x15: evdev.KEY_R,
	0x16: evdev.KEY_S,
	0x17: evdev.KEY_T,
	0x18: evdev.KEY_U,
	0x19: evdev.KEY_V,
	0x1A: evdev.KEY_W,
	0x1B: evdev.KEY_X,
	0x1C: evdev.KEY_Y,
	0x1D: evdev.KEY_Z,

	// Numbers (1-9, 0)
	0x1E: evdev.KEY_1,
	0x1F: evdev.KEY_2,
	0x20: evdev.KEY_3,
	0x21: evdev.KEY_4,
	0x22: evdev.KEY_5,
	0x23: evdev.KEY_6,
	0x24: evdev.KEY_7,
	0x25: evdev.KEY_8,
	0x26: evdev.KEY_9,
	0x27: evdev.KEY_0,

	// Standard Control & Punctuation
	0x28: evdev.KEY_ENTER,
	0x29: evdev.KEY_ESC,
	0x2A: evdev.KEY_BACKSPACE,
	0x2B: evdev.KEY_TAB,
	0x2C: evdev.KEY_SPACE,
	0x2D: evdev.KEY_MINUS,
	0x2E: evdev.KEY_EQUAL,
	0x2F: evdev.KEY_LEFTBRACE,
	0x30: evdev.KEY_RIGHTBRACE,
	0x31: evdev.KEY_BACKSLASH,
	0x32: evdev.KEY_BACKSLASH, // Non-US # and ~
	0x33: evdev.KEY_SEMICOLON,
	0x34: evdev.KEY_APOSTROPHE,
	0x35: evdev.KEY_GRAVE,
	0x36: evdev.KEY_COMMA,
	0x37: evdev.KEY_DOT,
	0x38: evdev.KEY_SLASH,
	0x39: evdev.KEY_CAPSLOCK,

	// Function Keys (F1-F12)
	0x3A: evdev.KEY_F1,
	0x3B: evdev.KEY_F2,
	0x3C: evdev.KEY_F3,
	0x3D: evdev.KEY_F4,
	0x3E: evdev.KEY_F5,
	0x3F: evdev.KEY_F6,
	0x40: evdev.KEY_F7,
	0x41: evdev.KEY_F8,
	0x42: evdev.KEY_F9,
	0x43: evdev.KEY_F10,
	0x44: evdev.KEY_F11,
	0x45: evdev.KEY_F12,

	// Navigation & Editing
	0x46: evdev.KEY_SYSRQ, // Print Screen
	0x47: evdev.KEY_SCROLLLOCK,
	0x48: evdev.KEY_PAUSE,
	0x49: evdev.KEY_INSERT,
	0x4A: evdev.KEY_HOME,
	0x4B: evdev.KEY_PAGEUP,
	0x4C: evdev.KEY_DELETE,
	0x4D: evdev.KEY_END,
	0x4E: evdev.KEY_PAGEDOWN,
	0x4F: evdev.KEY_RIGHT,
	0x50: evdev.KEY_LEFT,
	0x51: evdev.KEY_DOWN,
	0x52: evdev.KEY_UP,

	// Numpad
	0x53: evdev.KEY_NUMLOCK,
	0x54: evdev.KEY_KPSLASH,
	0x55: evdev.KEY_KPASTERISK,
	0x56: evdev.KEY_KPMINUS,
	0x57: evdev.KEY_KPPLUS,
	0x58: evdev.KEY_KPENTER,
	0x59: evdev.KEY_KP1,
	0x5A: evdev.KEY_KP2,
	0x5B: evdev.KEY_KP3,
	0x5C: evdev.KEY_KP4,
	0x5D: evdev.KEY_KP5,
	0x5E: evdev.KEY_KP6,
	0x5F: evdev.KEY_KP7,
	0x60: evdev.KEY_KP8,
	0x61: evdev.KEY_KP9,
	0x62: evdev.KEY_KP0,
	0x63: evdev.KEY_KPDOT,

	// F13-F24
	0x68: evdev.KEY_F13,
	0x69: evdev.KEY_F14,
	0x6A: evdev.KEY_F15,
	0x6B: evdev.KEY_F16,
	0x6C: evdev.KEY_F17,
	0x6D: evdev.KEY_F18,
	0x6E: evdev.KEY_F19,
	0x6F: evdev.KEY_F20,
	0x70: evdev.KEY_F21,
	0x71: evdev.KEY_F22,
	0x72: evdev.KEY_F23,
	0x73: evdev.KEY_F24,

	// Multimedia bits in KEYMAP
	0x7F: evdev.KEY_MUTE,
	0x80: evdev.KEY_VOLUMEDOWN,
	0x81: evdev.KEY_VOLUMEUP,

	// Modifiers (Standalone)
	0xE0: evdev.KEY_LEFTCTRL,
	0xE1: evdev.KEY_LEFTSHIFT,
	0xE2: evdev.KEY_LEFTALT,
	0xE3: evdev.KEY_LEFTMETA, // Windows Key
	0xE4: evdev.KEY_RIGHTCTRL,
	0xE5: evdev.KEY_RIGHTSHIFT,
	0xE6: evdev.KEY_RIGHTALT,
	0xE7: evdev.KEY_RIGHTMETA,
};

