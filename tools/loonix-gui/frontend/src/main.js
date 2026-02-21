import './app.css';
import { LaunchHyprland, Reboot, PowerOff, OpenTTY } from '../wailsjs/go/main/App';

const userField = document.getElementById("username");
const passField = document.getElementById("password");
const msgElement = document.getElementById("message");

// --- LOGIC: SESSION ---
const sessionMenu = document.querySelector('.session-dropdown');
const currentSessionText = document.getElementById('current-session');

// Toggle klik buat nampilin list (kita buat simpel pake prompt atau menu)
sessionMenu.onclick = () => {
    // Simulasi: Nanti bisa lo ganti pake menu beneran
    const choices = ["Hyprland", "Swiftgui", "Console"];
    let currentIndex = choices.indexOf(currentSessionText.innerText);
    let nextIndex = (currentIndex + 1) % choices.length;
    
    currentSessionText.innerText = choices[nextIndex];
    console.log("Session changed to: " + choices[nextIndex]);
};

// --- LOGIC: AUTO FOCUS & LAST LOGIN ---
window.onload = () => {
    const lastUser = localStorage.getItem("lastLogin");
    if (lastUser) {
        userField.value = lastUser;
        passField.focus(); // Jika ada user terakhir, langsung minta password
    } else {
        userField.focus(); // Jika baru, isi username dulu
    }
}

// --- LOGIC: LAUNCH / LOGIN ---
window.launch = function () {
    const user = userField.value;
    const pass = passField.value;

    if (!user || !pass) {
        showError("Fields cannot be empty!");
        return;
    }

    LaunchHyprland(pass).then((result) => {
        if (result === "Success") {
            localStorage.setItem("lastLogin", user); // Simpan user buat boot berikutnya
            msgElement.innerText = "Launching Loonix...";
            msgElement.style.color = "#4ade80";
        } else {
            showError(result);
            passField.value = "";
            passField.focus();
        }
    });
};

// --- LOGIC: ACTION BUTTONS ---
window.reboot = () => Reboot();
window.poweroff = () => PowerOff();
window.openTTY = () => OpenTTY();

// --- HELPER: ERROR MESSAGE ---
function showError(text) {
    msgElement.innerText = text;
    msgElement.style.color = "#f87171";
    // Opsional: Tambahin efek getar di sini nanti
}

// --- LISTENERS: KEYBOARD ---
// Biar di kolom mana pun lo pencet Enter, dia langsung Launch
[userField, passField].forEach(el => {
    el.addEventListener("keydown", (e) => {
        if (e.key === "Enter") window.launch();
    });
});
