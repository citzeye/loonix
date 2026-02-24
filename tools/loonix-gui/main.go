package main

import (
	"embed"
	"os"

	"github.com/wailsapp/wails/v2"
	"github.com/wailsapp/wails/v2/pkg/options"
	"github.com/wailsapp/wails/v2/pkg/options/assetserver"
	"github.com/wailsapp/wails/v2/pkg/options/linux"
)

//go:embed all:frontend/dist
var assets embed.FS

func main() {
	// Step TUI Fallback: Cek argumen --tui
	if len(os.Args) > 1 && os.Args[1] == "--tui" {
		StartTUI()
		return
	}

	app := NewApp()

	err := wails.Run(&options.App{
		Title:            "Loonix Login",
		Width:            1024,
		Height:           768,
		Frameless:        true,
		AlwaysOnTop:      true,
		AssetServer: &assetserver.Options{
			Assets: assets,
		},
		BackgroundColour: &options.RGBA{R: 0, G: 0, B: 0, A: 0},
		OnStartup:        app.startup,
		Bind: []interface{}{
			app,
		},
		Linux: &linux.Options{
			WindowIsTranslucent: true,
		},
	})

	if err != nil {
		println("Error:", err.Error())
	}
}