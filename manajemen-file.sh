#!/bin/bash

isEnterPressed() {  # Fungsi untuk menunggu user menekan Enter
    echo ""
    read -p "Tekan [Enter] untuk kembali ke menu..."
}

while true; do      # Loop utama untuk menampilkan menu terus-menerus hingga user memilih keluar
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
    #flag read -p digunakan untuk membaca input dari user dan menyimpannya dalam variabel $pilihan
    echo ""

    case $pilihan in
        1)             
            # Menu untuk menampilkan direktori aktif saat ini
            echo "-----------------------------------------"
            echo "        Direktori Aktif Saat Ini         "
            echo "-----------------------------------------"
            pwd
            isEnterPressed;;

        2)
            # Menu untuk menampilkan isi direktori saat ini
            echo "-----------------------------------------"
            echo "        Isi Direktori Saat Ini           "
            echo "-----------------------------------------"
            ls -F
            #flag -F digunakan untuk menambahkan simbol khusus pada nama file/folder:
            # - / untuk folder
            # - * untuk file yang dapat dieksekusi
            isEnterPressed;;

        3)
            # Menu untuk membuat folder
            echo "----------------------------------------"
            echo "            Buat Folder Baru            "
            echo "----------------------------------------"
            read -p "Masukkan nama folder baru: " nama_folder
            if [ -z "$nama_folder" ]; then
                #flag -z digunakan untuk memeriksa apakah variabel $nama_folder kosong
                echo "Nama folder tidak boleh kosong!"
            else
                #flag mkdir digunakan untuk membuat folder dengan nama yang diberikan oleh user. 
                #Jika berhasil, akan menampilkan pesan sukses, jika gagal akan menampilkan pesan error
                mkdir "$nama_folder" && echo "Folder '$nama_folder' berhasil dibuat." || echo "Gagal membuat folder."
            fi
            #fi digunakan untuk menutup blok if
            isEnterPressed;;
            
        4)
            # Menu untuk membuat file baru
            echo "----------------------------------------"
            echo "             Buat File Baru             "
            echo "----------------------------------------"
            read -p "Masukkan nama file baru (contoh: data.txt): " nama_file
            if [ -z "$nama_file" ]; then
                echo "Nama file tidak boleh kosong!"
            else
                #flag touch digunakan untuk membuat file dengan nama yang diberikan oleh user. 
                touch "$nama_file" && echo "File '$nama_file' berhasil dibuat." || echo "Gagal membuat file."
            fi
            isEnterPressed;;

        5)
            # Menu untuk menyalin file
            echo "----------------------------------------"
            echo "              Salin File                "
            echo "----------------------------------------"
            read -p "Masukkan nama file sumber: " file_sumber
            read -p "Masukkan nama/lokasi file tujuan: " file_tujuan
            if [ -f "$file_sumber" ]; then
                #flag cp digunakan untuk menyalin file dari lokasi sumber ke lokasi tujuan.
                cp "$file_sumber" "$file_tujuan" && echo "File berhasil disalin ke '$file_tujuan'." || echo "Gagal menyalin file."
            else
                echo "File sumber '$file_sumber' tidak ditemukan!"
            fi
            isEnterPressed;;

        6)
            # Menu untuk memindahkan/rename file
            echo "----------------------------------------"
            echo "          Pindah / Rename File          "
            echo "----------------------------------------"
            read -p "Masukkan nama file asal: " file_asal
            read -p "Masukkan nama baru atau lokasi tujuan: " file_baru
            #flag -e digunakan untuk memeriksa apakah file atau folder dengan nama yang diberikan oleh user ada di direktori saat ini. 
            #Jika file/folder ditemukan, maka perintah mv akan dijalankan untuk memindahkan atau merename file tersebut. 
            #Jika file/folder tidak ditemukan, maka akan menampilkan pesan error.
            if [ -e "$file_asal" ]; then
                #flag mv digunakan untuk memindahkan file dari lokasi asal ke lokasi baru atau untuk merename file dengan nama baru.
                mv "$file_asal" "$file_baru" && echo "File/Folder berhasil dipindah/di-rename." || echo "Gagal memproses."
            else
                echo "File atau folder asal tidak ditemukan!"
            fi
            isEnterPressed;;

        7)
            # Menu untuk menghapus file/folder
            echo "---------------------------------------"
            echo "          Hapus File / Folder          "
            echo "---------------------------------------"
            echo "1. Hapus File"
            echo "2. Hapus Folder"
            read -p "Pilih target (1/2): " target_hapus
            
            if [ "$target_hapus" == "1" ]; then
                read -p "Masukkan nama file yang ingin dihapus: " hapus_file
                #flag -f digunakan untuk memeriksa apakah file dengan nama yang diberikan oleh user ada di direktori saat ini. 
                #Jika file ditemukan, maka perintah rm akan dijalankan untuk menghapus file tersebut.
                if [ -f "$hapus_file" ]; then
                    rm "$hapus_file" && echo "File '$hapus_file' berhasil dihapus." || echo "Gagal menghapus file."
                else
                    echo "File tidak ditemukan!"
                fi
            elif [ "$target_hapus" == "2" ]; then
                read -p "Masukkan nama folder yang ingin dihapus: " hapus_folder
                #flag -d digunakan untuk memeriksa apakah folder dengan nama yang diberikan oleh user ada di direktori saat ini. 
                #Jika folder ditemukan, maka perintah rm akan dijalankan untuk menghapus folder tersebut.
                if [ -d "$hapus_folder" ]; then
                    rm -r "$hapus_folder" && echo "Folder '$hapus_folder' beserta isinya berhasil dihapus." || echo "Gagal menghapus folder."
                else
                    echo "Folder tidak ditemukan!"
                fi
            else
                echo "Pilihan tidak valid."
            fi
            isEnterPressed;;
        8)
            echo "Terima kasih telah menggunakan sistem manajemen file Linux. Sampai jumpa!"
            #flag exit digunakan untuk keluar dari program dengan status 0, yang menandakan bahwa program selesai dengan sukses.
            exit 0;;
        *)
            # Jika pilihan tidak valid
            echo "Pilihan tidak valid! Silakan pilih menu 1 sampai 8."
            isEnterPressed;;
    #esac digunakan untuk menutup blok case
    esac
#done digunakan untuk menutup blok while, yang berarti bahwa
#program akan kembali ke awal menu setelah setiap operasi selesai, 
#sehingga user dapat melakukan operasi lain atau keluar dari program.
done