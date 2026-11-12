# [Bug] Halaman KRS lambat saat akses serentak

**Labels:** `bug`, `priority: high`, `area: krs`, `performance`
**Assignee:** Developer, dengan review Operations

## Deskripsi Masalah
Pada periode pengisian KRS, halaman KRS memuat sangat lambat (bahkan timeout) ketika ribuan mahasiswa mengakses bersamaan. Mahasiswa gagal mengisi KRS tepat waktu dan keluhan ke Bagian Akademik meningkat.

## Langkah Mereproduksi
1. Buka halaman KRS saat jam sibuk (atau jalankan load test dengan banyak pengguna virtual)
2. Naikkan jumlah pengguna bersamaan secara bertahap ke 500, lalu 2.000, lalu 5.000
3. Amati waktu muat halaman dan tingkat error

## Hasil yang Diharapkan
Halaman KRS tetap responsif (p95 di bawah 2 detik, error rate di bawah 1%) hingga 5.000 pengguna bersamaan.

## Hasil Aktual
- Waktu muat melonjak hingga puluhan detik, muncul HTTP 502/504
- CPU server dan koneksi database mendekati batas
- (isi dengan angka dari monitoring/log)

## Dugaan Akar Penyebab
- Kapasitas tetap pada satu server, tanpa load balancer dan auto scaling
- Query daftar mata kuliah/jadwal berulang tanpa cache
- Pembacaan data ditujukan ke database utama (belum ada read replica)
- Proses berat (cetak KRS, notifikasi) dijalankan sinkron

## Usulan Perbaikan
- [ ] Cache Redis untuk jadwal dan daftar mata kuliah
- [ ] Arahkan query baca ke read replica
- [ ] Pindahkan proses berat ke antrean asinkron (queue)
- [ ] Auto scaling (min 3, maks 15 instance) dengan scheduled scaling pra-KRS
- [ ] Tambahkan load test (k6/JMeter) 5.000 pengguna virtual di staging

## Kriteria Selesai
- [ ] Load test 5.000 pengguna bersamaan lulus: p95 di bawah 2 detik, error rate di bawah 1%
- [ ] CPU rata-rata di bawah 70%, koneksi DB di bawah 80% batas
- [ ] Alarm monitoring aktif untuk latency dan error rate halaman KRS
- [ ] Rilis lewat pipeline CI/CD dan disetujui Operations

## Informasi Tambahan
Lingkungan: production (server lokal). Lampirkan tangkapan layar monitoring atau log bila ada.
