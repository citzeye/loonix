package main

import (
	"fmt"
	"os"
	"os/exec"
	tea "github.com/charmbracelet/bubbletea"
)

type model struct {
	choices []string
	cursor  int
}

func initialModel() model {
	return model{
		choices: []string{"🚀 Launch Loonix", "🖥️ Manual Shell", "💤 Power Off"},
	}
}

func (m model) Init() tea.Cmd { return nil }

func (m model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	switch msg := msg.(type) {
	case tea.KeyMsg:
		switch msg.String() {
		case "ctrl+c", "q": return m, tea.Quit
		case "up", "k": if m.cursor > 0 { m.cursor-- }
		case "down", "j": if m.cursor < len(m.choices)-1 { m.cursor++ }
		case "enter": return m, tea.Quit
		}
	}
	return m, nil
}

func (m model) View() string {
	s := "╔═════════════════════════════════╗\n"
	s += "║        WELCOME TO LOONIX        ║\n"
	s += "╚═════════════════════════════════╝\n\n"
	for i, choice := range m.choices {
		cursor := "  "
		if m.cursor == i { cursor = "👉" }
		s += fmt.Sprintf("%s %s\n", cursor, choice)
	}
	s += "\n(Use arrows to navigate, Enter to select)\n"
	return s
}

// Fungsi utama yang dipanggil dari main.go
func StartTUI() {
	p := tea.NewProgram(initialModel())
	m, err := p.Run()
	if err != nil {
		fmt.Printf("Error: %v", err)
		os.Exit(1)
	}

	finalModel := m.(model)
	switch finalModel.cursor {
	case 0:
		cmd := exec.Command("sh", "-c", "exec Hyprland")
		cmd.Stdout, cmd.Stderr, cmd.Stdin = os.Stdout, os.Stderr, os.Stdin
		_ = cmd.Run()
	case 1:
		fmt.Println("Entering Manual Shell...")
	case 2:
		_ = exec.Command("poweroff").Run()
	}
}