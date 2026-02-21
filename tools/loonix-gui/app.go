package main

import (
	"context"
	"os/exec"
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

// --- FUNGSI SAKTI LOONIX ---

// Ubah nama jadi LaunchHyprland biar sinkron sama main.js
// Kita tambahin parameter password string
func (a *App) LaunchHyprland(password string) string {
	// Logika sementara: Apapun passwordnya (selama gak kosong), dia jalan.
	// Nanti kita bisa ganti jadi pengecekan asli ke sistem.
	if password == "" {
		return "Password is required!"
	}

	// Menjalankan script start-hyprland
	cmd := exec.Command("/usr/local/bin/start-hyprland")
	
	err := cmd.Start()
	if err != nil {
		return "Failed to start Hyprland"
	}

	// Setelah Hyprland dipicu, tutup window login-nya
	runtime.Quit(a.ctx)
	return "Success"
}

// Reboot buat restart mesin
func (a *App) Reboot() {
	_ = exec.Command("reboot").Run()
}

// OpenTTY buat pindah ke TTY lain (misal TTY2)
func (a *App) OpenTTY() {
	// Di Linux, kita bisa pindah tty pake chvt
	_ = exec.Command("sudo", "chvt", "2").Run()
}

// PowerOff buat matiin mesin langsung dari GUI
func (a *App) PowerOff() {
	_ = exec.Command("poweroff").Run()
}
