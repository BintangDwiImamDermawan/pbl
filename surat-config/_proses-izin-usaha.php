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
  $Q_nik = mysqli_query($conn, "select nik from dokumen_izin_usaha where nik = $nik");
  if(mysqli_num_rows($Q_nik) > 0 ){
    echo "<script>
      alert('NIK SUDAH TERDAFTAR SEBELUMNYA');
      window.history.back();
    </script>";
    exit;
  }

  // 2. LOGIKA VALIDASI UKURAN FILE (MAKS 1 MB)
  $max_size = 1 * 1024 * 1024; // 1 MB dalam bytes
  
  // Daftar semua file yang wajib diperiksa
  $files_to_check = [
    'NPWP' => $_FILES['foto_npwp'],
    'Surat Pengantar' => $_FILES['foto_pengantar'],
    'KK' => $_FILES['foto_kk'],
    'KTP' => $_FILES['foto_ktp'],
    'Surat Domisili' => $_FILES['foto_surat_domisili'],
    'Bukti' => $_FILES['foto_bukti']
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
      // Cek jika file gagal upload atau kosong
      if ($file['error'] !== UPLOAD_ERR_OK) {
          echo "<script>
            alert('Gagal! File $label bermasalah atau belum dipilih.');
            window.history.back();
          </script>";
          exit;
      }
  }

  // Ambil data form
  $nama = $_POST['nama_lengkap'];
  $nama_kbli = $_POST['nama_kbli'];
  $nomor_kbli = $_POST['nomor_kbli'];
  $kecamatan = $_POST['kecamatan'];
  $desa = $_POST['desa'];
  $alamat = $_POST['alamat'];

  // Baca konten file
  $foto_npwp = addslashes(file_get_contents($_FILES['foto_npwp']['tmp_name']));
  $foto_pengantar = addslashes(file_get_contents($_FILES['foto_pengantar']['tmp_name']));
  $foto_kk = addslashes(file_get_contents($_FILES['foto_kk']['tmp_name']));
  $foto_ktp = addslashes(file_get_contents($_FILES['foto_ktp']['tmp_name'])); 
  $foto_surat_domisili = addslashes(file_get_contents($_FILES['foto_surat_domisili']['tmp_name'])); 
  $foto_bukti = addslashes(file_get_contents($_FILES['foto_bukti']['tmp_name'])); 

  // Query insert
  $query = "INSERT INTO `dokumen_izin_usaha`(`nik`, `nama_lengkap`, `nama_kbli`, `nomor_kbli`, `kecamatan`, `desa`, `alamat`, `foto_npwp`, `foto_pengantar`, `foto_kk`, `foto_ktp`, `foto_surat_domisili`, `foto_bukti`) VALUES ('$nik','$nama','$nama_kbli','$nomor_kbli','$kecamatan','$desa','$alamat','$foto_npwp','$foto_pengantar','$foto_kk','$foto_ktp','$foto_surat_domisili','$foto_bukti')";

  $validasi = mysqli_query($conn, $query);
  
  if($validasi){
    // Ambil ID otomatis yang baru saja diinsert
    $id_surat = mysqli_insert_id($conn);

    $qry_dokumen = "INSERT INTO `dokumens`( `nama_dokumen`, `id_warga`, `nama_warga`,`id_surat`,`status`) VALUES ('SIU','$id','$nama','$id_surat' ,'PENDING')";
    mysqli_query($conn, $qry_dokumen);

    echo '<meta http-equiv="refresh" content="1; url=../warga/riwayat.php?note=berhasil">';
  } else {
    echo "<script> 
      alert('Data Gagal Disimpan ke Database');
      window.history.back();
    </script>";
  }

} else {
    header("Location:../surat/surat-izin-usaha.php");
}
?>