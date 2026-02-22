package main

import (
	"context"
	"os"
	"os/exec"
	"path/filepath"

	"github.com/wailsapp/wails/v2/pkg/runtime"
)

// App struct
type App struct {
	ctx context.Context
}

// NewApp creates a new App application struct
func NewApp() *App {
	return &App{}
}

// startup dipanggil saat aplikasi jalan
func (a *App) startup(ctx context.Context) {
	a.ctx = ctx
}

// --- FUNGSI SAKTI LOONIX WKWKWKWWKWK---
func (a *App) LaunchHyprland(password string) string {
	if password == "" {
		return "Password is required!"
	}

	// Ambil path HOME USER otomatis
	home, _ := os.UserHomeDir()
	splashPath := filepath.Join(home, "loonix/.config/media/loonix-splash.mp4")

	// 1. Jalankan MPV Splash Screen (Blocking/Menunggu video beres)
	splashCmd := exec.Command("mpv",
		"--vo=gpu",
		"--hwdec=auto",
		"--fs",
		"--no-osc",
		"--no-osd-bar",
		"--cursor-autohide=always",
		"--no-input-default-bindings",
		splashPath,
	)

	// Pakai .Run() supaya baris di bawahnya nunggu sampe video selesai muter
	_ = splashCmd.Run()

	// 2. Jalankan script start-hyprland
	// Pakai .Start() supaya Go bisa langsung lanjut ke Quit tanpa nunggu Hyprland mati
	cmd := exec.Command("/usr/local/bin/start-hyprland")
	err := cmd.Start()
	if err != nil {
		return "Failed to start Hyprland"
	}

	// 3. Keluar dari aplikasi login-menu (Wails)
	runtime.Quit(a.ctx)
	return "Success"
}

// Reboot buat restart komputer mahal lu
func (a *App) Reboot() {
	_ = exec.Command("reboot").Run()
}

// OpenTTY biar lu bisa pindah ke TTY lain (misal TTY2)
func (a *App) OpenTTY() {
	// Pastikan user sudah masuk sudoers NOPASSWD untuk chvt
	_ = exec.Command("sudo", "chvt", "2").Run()
}

// PowerOff buat matiin komputer mahal lu langsung dari GUI
func (a *App) PowerOff() {
	_ = exec.Command("poweroff").Run()
}
