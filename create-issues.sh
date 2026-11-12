#!/usr/bin/env bash
# Membuat label dan dua Issue pada repositori. Butuh GitHub CLI (gh) yang sudah login.
# Pemakaian: ./create-issues.sh boyvarn61-art/TugasDevops
set -euo pipefail
REPO="${1:?Isi nama repo, contoh: owner/repo}"

mk_label() { gh label create "$1" --color "$2" --description "$3" --repo "$REPO" --force; }
mk_label feature        0e8a16 "Fitur baru"
mk_label bug            d73a4a "Kesalahan/bug"
mk_label performance    fbca04 "Kinerja dan skalabilitas"
mk_label "priority: high"   b60205 "Prioritas tinggi"
mk_label "priority: medium" fbca04 "Prioritas sedang"
mk_label "area: ukt"    1d76db "Modul UKT"
mk_label "area: krs"    1d76db "Modul KRS"
mk_label qa-approved    0e8a16 "Lolos pengujian Tester"
mk_label needs-changes  e99695 "Perlu perbaikan"

# Judul diambil dari baris pertama (tanpa '# '), isi dari baris ke-2 dst.
create() {
  local file="$1"; shift
  local title; title="$(head -n1 "$file" | sed 's/^# //')"
  tail -n +2 "$file" > /tmp/issue_body.md
  gh issue create --repo "$REPO" --title "$title" --body-file /tmp/issue_body.md "$@"
}
create issues/01-fitur-status-ukt.md --label feature --label "priority: medium" --label "area: ukt"
create issues/02-bug-krs-lambat.md  --label bug --label "priority: high" --label "area: krs" --label performance
