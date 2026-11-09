# Recipes.io - UTS Pemrograman Mobile

Aplikasi mobile Flutter untuk mencari resep masakan, menyimpannya ke daftar favorit, dan mengelola catatan resep pribadi.

## Identitas Mahasiswa
- **Nama:** I Putu Budha Aditya
- **NIM:** 2415051006
- **Kelas:** PTI 5A
- **Mata Kuliah:** Pemrograman Mobile

## Fitur Utama
1. **Pencarian Resep (REST API):** Mencari resep dari berbagai belahan dunia menggunakan TheMealDB API.
2. **Detail Resep:** Menampilkan gambar, kategori, bahan-bahan, dan instruksi memasak.
3. **Favorit (Shared State):** Menyimpan resep ke database. Jumlah favorit otomatis tersinkronisasi di halaman Home.
4. **CRUD Database:** Tambah favorit (Create), Lihat daftar (Read), Edit catatan (Update), dan Hapus (Delete).
5. **Validasi & Feedback:** Form dengan validasi, AlertDialog untuk konfirmasi hapus, serta SnackBar untuk notifikasi berhasil/gagal.
6. **Responsive Layout:** Tampilan menyesuaikan ukuran layar (NavigationBar untuk Mobile, NavigationRail untuk Tablet/Web).

## Tech Stack & Integrasi
- **Framework:** Flutter (Dart)
- **State Management:** Provider (ChangeNotifier)
- **REST API:** [TheMealDB API](https://www.themealdb.com/api.php) (GET)
- **Backend/Database:** [Supabase](https://supabase.com/) (PostgreSQL)

## Arsitektur Aplikasi
Project ini menerapkan *Separation of Concerns* dengan alur dependensi satu arah:
`UI (Screens/Widgets) → State (Provider) → Repository → Service (API/Supabase)`

Struktur folder:
```text
lib/
├── main.dart           # Entry point & Provider setup
├── models/             # Definisi data (Meal, SavedRecipe)
├── services/           # Komunikasi dengan API & Supabase
├── repositories/       # Abstraksi sumber data
├── providers/          # State management aplikasi
├── screens/            # Halaman aplikasi (Home, Search, dll)
└── widgets/            # Komponen UI reusable (MealCard, ErrorView, dll)
```

## Cara Menjalankan Project
1. Pastikan Flutter SDK Sudah Terinstall di Komputer
2. Clone Repo ini: `git clone https://github.com/budhaaditya12323-boop/UTS_2415051006_IPutuBudhaAditya`
3. Jalankan ini:
```
flutter pub get
flutter run
```