# [Fitur] Tampilkan status pembayaran UKT di dashboard mahasiswa

**Labels:** `feature`, `priority: medium`, `area: ukt`
**Assignee:** Developer

## Latar Belakang
Mahasiswa saat ini harus membuka menu pembayaran terpisah atau bertanya ke Bagian Keuangan untuk mengetahui status UKT. Informasi ini perlu tampil langsung di dashboard agar mengurangi antrean layanan dan keluhan, terutama menjelang masa KRS (KRS hanya dapat diisi bila UKT lunas).

## Deskripsi
Tambahkan kartu "Status Pembayaran UKT" pada dashboard mahasiswa yang menampilkan status tagihan semester berjalan.

## Kriteria Penerimaan (Acceptance Criteria)
- [ ] Dashboard menampilkan status UKT semester berjalan: **Belum Dibayar**, **Menunggu Konfirmasi**, atau **Lunas**
- [ ] Menampilkan nominal tagihan, batas jatuh tempo, dan tanggal pembayaran terakhir (bila ada)
- [ ] Status diperbarui otomatis setelah callback dari gateway pembayaran diterima
- [ ] Mahasiswa hanya dapat melihat data UKT miliknya sendiri (uji otorisasi)
- [ ] Data dibaca dari cache/read replica agar tidak membebani database utama saat trafik tinggi
- [ ] Waktu respons p95 di bawah 2 detik
- [ ] Unit test dan integration test untuk endpoint status UKT lulus
- [ ] Lolos CI (build, test, SAST, scan dependensi) dan diuji di staging oleh Tester

## Catatan Teknis
- Endpoint usulan: `GET /api/mahasiswa/me/ukt/status`
- Jangan mencatat (log) data pribadi atau nominal tagihan secara lengkap (UU PDP No. 27/2022)

## Alur Kerja
1. Developer membuat branch `feature/status-ukt` dari `main`
2. Membuka Pull Request yang menautkan issue ini (`Closes #<nomor-issue>`)
3. Tester menguji di staging, memberi label `qa-approved` bila lolos
4. Operations menyetujui rilis ke production
