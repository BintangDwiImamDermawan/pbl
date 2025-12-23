<?php 
// error reporting
error_reporting(E_ALL);
ini_set('display_errors', 1);

// link config
include "../config/conn.php";
include "../config/auth.php";

if($_SERVER['REQUEST_METHOD'] == "POST"){

  $id = $_SESSION['id_warga'];
  $nik = $_POST['nik'];

  // 1. Validasi NIK terdaftar
  $Q_nik = mysqli_query($conn, "select nik from dokumen_rumah where nik = $nik");
  if(mysqli_num_rows($Q_nik) > 0 ){
    echo "<script>
      alert('NIK SUDAH TERDAFTAR SEBELUMNYA');
      window.history.back();
    </script>";
    exit;
  }

  // 2. LOGIKA VALIDASI UKURAN FILE (MAKS 1 MB)
  $max_size = 1 * 1024 * 1024; // 1 MB dalam bytes
  
  // Daftar input file yang ada di form Anda
  $files_to_check = [
    'Sertifikat' => $_FILES['foto_sertifikat'],
    'Akta Mendirikan' => $_FILES['foto_akta_mendirikan'],
    'KK' => $_FILES['foto_kk'],
    'KTP' => $_FILES['foto_ktp'],
    'BPPBB' => $_FILES['foto_BPPBB'],
    'Surat Tidak Sengketa' => $_FILES['foto_surat_tidak_sengketa']
  ];

  foreach ($files_to_check as $label => $file) {
      // Cek jika ukuran melebihi 1MB
      if ($file['size'] > $max_size) {
          echo "<script>
            alert('Gagal! Ukuran file $label terlalu besar (Maksimal 1 MB)');
            window.history.back();
          </script>";
          exit;
      }
      // Cek jika ada error upload (misal file tidak dipilih)
      if ($file['error'] !== UPLOAD_ERR_OK) {
          echo "<script>
            alert('Gagal! File $label bermasalah atau belum diunggah.');
            window.history.back();
          </script>";
          exit;
      }
  }

  // Jika lolos validasi, ambil data teks
  $nama = $_POST['nama_lengkap'];
  $kecamatan = $_POST['kecamatan'];
  $desa = $_POST['desa'];
  $alamat = $_POST['alamat'];

  // Baca konten file menjadi blob
  $foto_sertifikat = addslashes(file_get_contents($_FILES['foto_sertifikat']['tmp_name']));
  $foto_akta_rumah = addslashes(file_get_contents($_FILES['foto_akta_mendirikan']['tmp_name']));
  $foto_kk = addslashes(file_get_contents($_FILES['foto_kk']['tmp_name']));
  $foto_ktp = addslashes(file_get_contents($_FILES['foto_ktp']['tmp_name'])); 
  $foto_bppbb = addslashes(file_get_contents($_FILES['foto_BPPBB']['tmp_name'])); 
  $foto_surat_sengketa = addslashes(file_get_contents($_FILES['foto_surat_tidak_sengketa']['tmp_name']));

  // Query insert ke dokumen_rumah
  $query = "INSERT INTO `dokumen_rumah`( `nik`, `nama_lengkap`, `kecamatan`, `desa`, `alamat`, `foto_sertifikat`, `foto_akta_mendirikan`, `foto_kk`, `foto_ktp`, `foto_BPPBB`, `foto_surat_tidak_sengketa`) VALUES ('$nik','$nama','$kecamatan','$desa','$alamat','$foto_sertifikat','$foto_akta_rumah','$foto_kk','$foto_ktp','$foto_bppbb','$foto_surat_sengketa')";

  $validasi = mysqli_query($conn, $query);

  if($validasi){
    // Mengambil ID surat yang baru saja masuk secara otomatis
    $id_surat = mysqli_insert_id($conn);

    // Masukkan log status ke tabel dokumens
    $qry_dokumen = "INSERT INTO `dokumens`( `nama_dokumen`, `id_warga`, `nama_warga`,`id_surat`,`status`) VALUES ('SRM','$id','$nama','$id_surat' ,'PENDING')";
    mysqli_query($conn, $qry_dokumen);

    echo '<meta http-equiv="refresh" content="1; url=../warga/riwayat.php?note=berhasil">';

  } else {
    echo "<script> 
      alert('Terjadi kesalahan saat menyimpan data.');
      window.history.back();
    </script>";
  }

} else {
    header("Location:../surat/surat-rumah.php");
}
?>