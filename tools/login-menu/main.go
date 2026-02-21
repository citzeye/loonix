package main

import (
	"fmt"
	"os"
	"os/exec"
	"github.com/charmbracelet/bubbletea"
)

// 1. DATA: Apa aja yang ada di menu kita?
type model struct {
	choices  []string
	cursor   int
}

func initialModel() model {
	return model{
		choices: []string{"🚀 Launch Loonix", "🖥️ Manual Shell", "💤 Power Off"},
	}
}

func (m model) Init() tea.Cmd { return nil }

// 2. LOGIKA: Apa yang terjadi pas tombol ditekan?
func (m model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	switch msg := msg.(type) {
	case tea.KeyMsg:
		switch msg.String() {
		case "ctrl+c", "q": return m, tea.Quit
		case "up", "k": if m.cursor > 0 { m.cursor-- }
		case "down", "j": if m.cursor < len(m.choices)-1 { m.cursor++ }
		case "enter":
			// Kita simpan pilihan terakhir dan keluar dari program Go
			return m, tea.Quit
		}
	}
	return m, nil
}

// 3. TAMPILAN: Gimana bentuk menunya di layar?
func (m model) View() string {
	s := "╔═════════════════════════════════╗\n"
	s += "║       WELCOME TO LOONIX         ║\n"
	s += "╚═════════════════════════════════╝\n\n"

	for i, choice := range m.choices {
		cursor := "  " 
		if m.cursor == i {
			cursor = "👉" // Penanda pilihan
		}
		s += fmt.Sprintf("%s %s\n", cursor, choice)
	}

	s += "\n(Use arrows to navigate, Enter to select)\n"
	return s
}

func main() {
	p := tea.NewProgram(initialModel())
	m, err := p.Run()
	if err != nil {
		fmt.Printf("Error: %v", err)
		os.Exit(1)
	}

	// Setelah user milih dan keluar, kita eksekusi perintahnya
	finalModel := m.(model)
	switch finalModel.cursor {
	case 0: // Launch
		cmd := exec.Command("/usr/local/bin/start-hyprland")
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr
		cmd.Stdin = os.Stdin
		_ = cmd.Run()
	case 1: // Shell
		fmt.Println("Entering Manual Shell...")
		return
	case 2: // Power Off
		_ = exec.Command("poweroff").Run()
	}
}
