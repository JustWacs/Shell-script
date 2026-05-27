#!/bin/bash

# Fungsi untuk menahan tampilan agar user bisa membaca output sebelum kembali ke menu
tekan_enter() {
    echo ""
    read -p "Tekan [Enter] untuk kembali ke menu..."
}

# Loop utama program menggunakan 'while true' agar terus berjalan sampai user memilih keluar
while true; do
    clear
    echo "========================================="
    echo "       SISTEM MANAJEMEN FILE LINUX       "
    echo "========================================="
    echo "1. Tampilkan direktori aktif"
    echo "2. Tampilkan isi direktori"
    echo "3. Buat folder baru"
    echo "4. Buat file baru"
    echo "5. Salin file"
    echo "6. Pindah / rename file"
    echo "7. Hapus file/folder"
    echo "8. Keluar"
    echo "========================================="
    read -p "Pilih menu: " pilihan
    echo ""

    case $pilihan in
        1)
            echo "--- Direktori Aktif Saat Ini ---"
            pwd
            tekan_enter
            ;;
        2)
            echo "--- Isi Direktori Saat Ini ---"
            ls -F
            tekan_enter
            ;;
        3)
            echo "--- Buat Folder Baru ---"
            read -p "Masukkan nama folder baru: " nama_folder
            if [ -z "$nama_folder" ]; then
                echo "Nama folder tidak boleh kosong!"
            else
                mkdir "$nama_folder" && echo "Folder '$nama_folder' berhasil dibuat." || echo "Gagal membuat folder."
            fi
            tekan_enter
            ;;
        4)
            echo "--- Buat File Baru ---"
            read -p "Masukkan nama file baru (contoh: data.txt): " nama_file
            if [ -z "$nama_file" ]; then
                echo "Nama file tidak boleh kosong!"
            else
                touch "$nama_file" && echo "File '$nama_file' berhasil dibuat." || echo "Gagal membuat file."
            fi
            tekan_enter
            ;;
        5)
            echo "--- Salin File ---"
            read -p "Masukkan nama file sumber: " file_sumber
            read -p "Masukkan nama/lokasi file tujuan: " file_tujuan
            if [ -f "$file_sumber" ]; then
                cp "$file_sumber" "$file_tujuan" && echo "File berhasil disalin ke '$file_tujuan'." || echo "Gagal menyalin file."
            else
                echo "File sumber '$file_sumber' tidak ditemukan!"
            fi
            tekan_enter
            ;;
        6)
            echo "--- Pindah / Rename File ---"
            read -p "Masukkan nama file asal: " file_asal
            read -p "Masukkan nama baru atau lokasi tujuan: " file_baru
            if [ -e "$file_asal" ]; then
                mv "$file_asal" "$file_baru" && echo "File/Folder berhasil dipindah/di-rename." || echo "Gagal memproses."
            else
                echo "File atau folder asal tidak ditemukan!"
            fi
            tekan_enter
            ;;
        7)
            echo "--- Hapus File / Folder ---"
            echo "1. Hapus File"
            echo "2. Hapus Folder"
            read -p "Pilih target (1/2): " target_hapus
            
            if [ "$target_hapus" == "1" ]; then
                read -p "Masukkan nama file yang ingin dihapus: " hapus_file
                if [ -f "$hapus_file" ]; then
                    rm "$hapus_file" && echo "File '$hapus_file' berhasil dihapus." || echo "Gagal menghapus file."
                else
                    echo "File tidak ditemukan!"
                fi
            elif [ "$target_hapus" == "2" ]; then
                read -p "Masukkan nama folder yang ingin dihapus: " hapus_folder
                if [ -d "$hapus_folder" ]; then
                    rm -r "$hapus_folder" && echo "Folder '$hapus_folder' beserta isinya berhasil dihapus." || echo "Gagal menghapus folder."
                else
                    echo "Folder tidak ditemukan!"
                fi
            else
                echo "Pilihan tidak valid."
            fi
            tekan_enter
            ;;
        8)
            echo "Terima kasih telah menggunakan sistem manajemen file Linux. Sampai jumpa!"
            exit 0
            ;;
        *)
            echo "Pilihan tidak valid! Silakan pilih menu 1 sampai 8."
            tekan_enter
            ;;
    esac
done