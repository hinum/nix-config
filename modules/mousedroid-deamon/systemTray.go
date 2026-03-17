package main

import (
	"os"
	"github.com/energye/systray"
)

func startSystray() {
	systray.Run(onReady, onExit)
}

func onReady() {
	systray.SetIcon(icon)
	systray.SetTitle("Mousedroid")
	systray.SetTooltip("TURN THIS OFF IF YOURE NOT USING IT")
	systray.SetOnRClick(func(menu systray.IMenu) {
		menu.ShowMenu()
	})
	quitBtn := systray.AddMenuItem("Quit", "Quit the whole app")
	quitBtn.Click(func() {
		os.Exit(0)
	})
}

func onExit() {
	// clean up here
}
