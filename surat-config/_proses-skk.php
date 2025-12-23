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
  $Q_nik = mysqli_query($conn, "select nik from dokumen_skk where nik = $nik");
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
    'Surat Rumah Sakit' => $_FILES['surat_rumah_sakit'],
    'KTP Pelapor' => $_FILES['ktp_pelapor'],
    'Surat Pengantar' => $_FILES['surat_pengantar'],
    'Akte Nikah' => $_FILES['akte_nikah']
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
      // Cek jika file belum dipilih atau error upload
      if ($file['error'] !== UPLOAD_ERR_OK) {
          echo "<script>
            alert('Gagal! File $label bermasalah atau belum diunggah.');
            window.history.back();
          </script>";
          exit;
      }
  }

  // Ambil data teks
  $nama = $_POST['nama_lengkap'];
  $jenis_kelamin = $_POST['jenis_kelamin'];
  $pekerjaan = $_POST['pekerjaan'];
  $alamat = $_POST['alamat'];
  $penyebab = $_POST['penyebab'];
  $tanggal = $_POST['tanggal_kematian'];

  // Konversi file menjadi blob
  $foto_surat_rs = addslashes(file_get_contents($_FILES['surat_rumah_sakit']['tmp_name']));
  $foto_ktp =  addslashes(file_get_contents($_FILES['ktp_pelapor']['tmp_name']));
  $foto_surat_pengantar =  addslashes(file_get_contents($_FILES['surat_pengantar']['tmp_name']));
  $foto_akte_nikah =  addslashes(file_get_contents($_FILES['akte_nikah']['tmp_name'])); 

  // Query insert ke dokumen_skk
  $query = "INSERT INTO `dokumen_skk`( `nik`,`nama_lengkap`, `jenis_kelamin`, `pekerjaan`, `alamat`, `penyebab`, `tanggal_kematian`, `foto_surat_RS`, `foto_ktp_pelapor`, `foto_surat_pengantar`, `foto_akte_nikah`) VALUES ('$nik','$nama','$jenis_kelamin','$pekerjaan','$alamat','$penyebab','$tanggal','$foto_surat_rs','$foto_ktp','$foto_surat_pengantar','$foto_akte_nikah')";

  $validasi = mysqli_query($conn, $query);

  if($validasi){
    // Mengambil ID otomatis yang baru saja dibuat
    $id_surat = mysqli_insert_id($conn);

    // Masukkan log ke tabel dokumens
    $qry_dokumen = "INSERT INTO `dokumens`( `nama_dokumen`, `id_warga`, `nama_warga`,`id_surat`,`status`) VALUES ('SKK','$id','$nama','$id_surat' ,'PENDING')";
    mysqli_query($conn, $qry_dokumen);

    echo '<meta http-equiv="refresh" content="1; url=../warga/riwayat.php?note=berhasil">';

  } else {
    echo "<script> 
      alert('Data Gagal Disimpan');
      window.history.back();
    </script>";
  }

} else {
    header("Location:../surat/surat-SKK.php");
}
?>