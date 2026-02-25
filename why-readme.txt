Linux: Simple untuk Developer, Bukan untuk User
"Simple buat developer ≠ simple buat user"
Ini kalimat powerful soal Linux.

Masalahnya: Linux itu "Simple" Versi Developer
Developer bilang: "Simple! Tinggal bikin file konfigurasi di /etc/whatever/config.conf terus restart service. Gampang banget!"
User bilang: "WTF itu /etc? Kenapa gak ada tombol Settings-nya? Harus pake nano? Itu apaan?"
Developer bilang: "Simple! Tinggal sudo pacman -Syu buat update semua."
User bilang: "Lupa password tadi pake apa. Takut ngerusak sistem. Takut bentrok. Takut... takut... takut..."

Windows & Android: Simple Versi User
Mereka paham:
User gak peduli cara kerja di belakang layar
User pengen sesuatu yang langsung "works out of the box"
User butuh konsistensi — tombol Close di pojok kanan atas SELALU di situ
User butuh safety net — kalo salah klik, masih ada jalan balik
Android: Mau ganti wallpaper? Tekan lama di homescreen → pilih wallpaper. Selesai. Gak perlu baca manual 20 halaman.
Windows: Mau install printer? Colok USB → "Finding drivers..." → selesai. Bukan "cari driver di situs pabrik, compile sendiri, berdoa biar gak kernel panic".

"Simple ala Linux itu egois"
Linux itu kayak restoran koki selebriti:
Kokinya: "Resep saya simple banget! Tinggal tumis bawang putih 3 detik tepat, tambah 2.5ml minyak truffle, taburi garam Himalaya yang digiling pake batu meteor."
Pengunjung: "Bang, cuma mau nasi goreng kayak di warteg..."

Jembatan Yang Hilang: OPSI!
Linux itu seharusnya memberi kebebasan, bukan memaksa suatu "cara" pake. Kalo mau pake mouse — harusnya ada opsi. Kalo mau pake keyboard — harusnya ada opsi. Kalo mau setup sekali terus lupa — harusnya ada opsi.
TAPI KENYATAANNYA:
Mau setting WiFi pake GUI? Kadang harus install NetworkManager dulu, padahal default pake iwd yang cuma command line
Mau ganti tema? Buka 3 folder beda, edit 5 file konfigurasi, atau pake GNOME Tweaks yang bahkan gak keinstall secara default
Mau matiin laptop ketika tutup? Cari di 4 tempat beda (Settings, dconf, file konfigurasi, dsb.)

Solusi Seharusnya
Dual-path configuration:
Path A (User-friendly): Ada GUI Settings yang lengkap. Mau setting apapun bisa lewat GUI. Tombol "Reset to default" jelas. Tooltips jelas. Preview real-time.
Path B (Power-user): File konfigurasi tetap ada buat yang mau ngoprek. Bisa diakses via terminal. Dokumentasi jelas.
Contoh ideal:
NetworkManager + nmtui (terminal UI) + nmcli (command line) + file konfigurasi
GParted + parted CLI
GNOME Settings + dconf + gsettings
TAPI kenapa banyak distro yang setengah-setengah? Defaultnya CLI doang, GUI-nya option yang harus diinstall manual.



Kenapa Ini Bisa Terjadi?
Developer ngoding buat dirinya sendiri — mereka butuh CLI, ya mereka bikin CLI. Urusan user belakangan.
"Kalo mau pake Linux, harus mau belajar" — mentalitas gatekeeping.
Sumber daya terbatas — bikin GUI itu ribet. Bikin CLI doang lebih cepet.
Egosistem pecah — 1001 distro, 1001 cara, 1001 dokumentasi.


Yang Sebenarnya Dibutuhkan:
Linux dengan filosofi:
OPSI, bukan paksaan
User journey yang mulus
Konsistensi di semua level
Gak perlu jadi developer buat bisa pake
Ini yang disebut "User Experience" — sesuatu yang selama ini dianggap angin lalu sama developer Linux.


Project Ini: Sebuah Jawaban
Project ini lahir dari frustrasi melihat GUI yang:
"Terlalu teknis"
"Boomer banget"
"Gak intuitive"
Versi yang dibuat:
Tetep functional (buat yang butuh control detail)
Tapi tampilannya modern (buat yang muak sama UI boomer)
Tetep ada opsi (mode "simple" dan "advanced")
Menjadi jembatan antara developer (yang butuh technical control) dan user (yang butuh kemudahan).


Kesimpulan
Muak sama "simple versi developer" yang sebenernya ribet buat user
Pengen Linux punya OPSI, bukan paksaan, atau ketidak-peduli-an, gratis = seadanya
Project ini adalah langkah kecil benerin ini
Gak sendiri harusnya— banyak orang ngerasa gini, cuma mereka diem aja atau pindah ke Mac/windows
Linux butuh lebih banyak yang ngerti desain, ngerti UX, dan berani bilang "INI JELEK, BIKIN YANG LEBIH BAGUS".

Project ini bukan untuk menghina developer Linux. Ini adalah kritik konstruktif dan solusi nyata untuk masalah nyata.
Dan kritik gua yang paling utama adalah :
"Kenapa developer linux tidak diwajibkan sebagai team, dalam artian anda boleh bikin aplikasi dengan syarat minimal 2 orang, 1 untuk backend/code dan 1 lagi untuk frontend/gui, anda boleh buat seorang diri asalkan serius mengerjakan keduanya."
"Atau buat repo khusus yang hanya berisi aplikasi netral dalam artian tidak hanya memuja keyboard dan tidak hanya memuja mouse, kedua opsi harus ada dan perlakuan setara."
