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
  $Q_nik = mysqli_query($conn, "select nik from dokumen_sktm where nik = $nik");
  if(mysqli_num_rows($Q_nik) > 0 ){
    echo "<script>
      alert('NIK SUDAH TERDAFTAR SEBELUMNYA');
      window.history.back();
    </script>";
    exit;
  }

  // 2. LOGIKA VALIDASI UKURAN FILE (MAKS 1 MB)
  $max_size = 1 * 1024 * 1024; // 1 MB dalam bytes
  
  // Daftar input file sesuai name di form HTML Anda
  $files_to_check = [
    'Surat Tidak Mampu' => $_FILES['surat_tidak_mampu'],
    'Foto Rumah' => $_FILES['fotorumah'],
    'Foto KK' => $_FILES['fotokk'],
    'Foto Slip Gaji' => $_FILES['fotoslip'],
    'Foto Tagihan' => $_FILES['fototagihan']
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
      // Cek jika ada error upload (file tidak dipilih atau rusak)
      if ($file['error'] !== UPLOAD_ERR_OK) {
          echo "<script>
            alert('Gagal! File $label bermasalah atau belum dipilih.');
            window.history.back();
          </script>";
          exit;
      }
  }

  // Ambil data teks
  $nama_lengkap = $_POST['nama_lengkap'];
  $agama = $_POST['agama'];
  $pekerjaan = $_POST['pekerjaan'];
  $alamat = $_POST['alamat'];

  // Baca konten file menjadi blob
  $surat_tidak_mampu = addslashes(file_get_contents($_FILES['surat_tidak_mampu']['tmp_name']));
  $foto_rumah =  addslashes(file_get_contents($_FILES['fotorumah']['tmp_name']));
  $foto_kk =  addslashes(file_get_contents($_FILES['fotokk']['tmp_name']));
  $foto_slip =  addslashes(file_get_contents($_FILES['fotoslip']['tmp_name'])); 
  $foto_tagihan =  addslashes(file_get_contents($_FILES['fototagihan']['tmp_name']));

  // Query insert ke dokumen_sktm
  $query = "INSERT INTO `dokumen_sktm`( `nik`, `nama_lengkap`, `agama`, `pekerjaan`, `alamat`, `foto_persetujuan`, `foto_rumah`, `foto_kk`, `foto_slip_gaji`, `foto_tagihan`) VALUES ('$nik','$nama_lengkap','$agama','$pekerjaan','$alamat','$surat_tidak_mampu','$foto_rumah','$foto_kk','$foto_slip','$foto_tagihan')";

  $cek = mysqli_query($conn, $query);

  if($cek){
    // Mengambil ID otomatis yang baru saja dibuat
    $id_surat = mysqli_insert_id($conn);

    // Query insert ke tabel dokumens
    $qry_dokumen = "INSERT INTO `dokumens`( `nama_dokumen`, `id_warga`, `nama_warga`,`id_surat`,`status`) VALUES ('SKTM','$id','$nama_lengkap','$id_surat' ,'PENDING')";
    mysqli_query($conn, $qry_dokumen);

    echo '<meta http-equiv="refresh" content="1; url=../warga/riwayat.php?note=berhasil">';

  } else {
    echo "<script> 
      alert('Terjadi kesalahan saat menyimpan data.');
      window.history.back();
    </script>";
  }

} else {
    header("Location:../surat/surat-SKTM.php");
}
?>