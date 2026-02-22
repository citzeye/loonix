package main

import (
	"context"
	"os"
	"os/exec"
	"path/filepath"
	"syscall"
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

	home, _ := os.UserHomeDir()
	splashPath := filepath.Join(home, "loonix/.config/media/loonix-splash.mp4")

	// 1. Jalankan MPV Splash Screen (Blocking)
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
	_ = splashCmd.Run()

	// 2. Transisi "Wujud" ke UWSM
	// Kita cari path binary uwsm
	uwsmPath, err := exec.LookPath("uwsm")
	if err != nil {
		return "uwsm not found in PATH"
	}

	// Argumen untuk uwsm
	args := []string{"uwsm", "start", "hyprland-session.target"}

	// Gunakan syscall.Exec untuk mengganti proses Wails menjadi UWSM
	// Ini akan membuat wallpaper, cursor, dan config lo jalan normal
	// karena UWSM mengambil alih environment secara utuh.
	err = syscall.Exec(uwsmPath, args, os.Environ())

	if err != nil {
		return "Failed to exec uwsm: " + err.Error()
	}

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
