-- 1. Tambah Pembelian Bahan Baku
   DELIMITER //
   CREATE PROCEDURE sp_tambah_pembelian_bahan(
	   IN id VARCHAR(5),
       IN karyawan_id VARCHAR(5),
       IN tanggal_pembelian DATE,
       IN total_pembelian DECIMAL(10, 2),
       IN supplier_id VARCHAR(5)
   )
   BEGIN
       INSERT INTO pembelian_bahan (id, karyawan_id, tanggal, total_pembelian, supplier_id)
       VALUES (id, karyawan_id, tanggal_pembelian, total_pembelian, supplier_id);
   END //
   DELIMITER ;
   
CALL sp_tambah_pembelian_bahan('PB053', 'K0116', '2023-01-09',  20000, 'S0310');
DELETE FROM pembelian_bahan WHERE id = 'PB053';
INSERT INTO bahan_masuk VALUES('BM053', 'Es Batu', '2023-01-09', 10, 'PB053');
DELETE FROM bahan_masuk WHERE id = 'BM053';

DROP PROCEDURE IF EXISTS sp_tambah_pembelian_bahan;

-- 2. Update Harga Produk
DELIMITER //
CREATE PROCEDURE sp_update_harga_produk(
    IN produk_id VARCHAR(5),
    IN new_harga INT(11)
)
BEGIN
    UPDATE produk SET harga = new_harga WHERE id = produk_id;
END //
DELIMITER ;

SET @produk_id = 'P060';
SET @new_harga = 50000;
CALL sp_update_harga_produk(@produk_id, @new_harga);

DROP PROCEDURE IF EXISTS sp_update_harga_produk;

-- 3. Total Pembelian Pelanggan
   DELIMITER //
   CREATE PROCEDURE sp_total_pembelian_pelanggan(
       IN nama_pelanggan VARCHAR(45)
   )
   BEGIN
        SELECT p.nama AS nama_pelanggan, SUM(t.total_harga) AS total_pembelian
		FROM transaksi t
		JOIN pelanggan p ON t.pelanggan_id = p.id
		WHERE p.nama = nama_pelanggan;
   END //
   DELIMITER ;

CALL sp_total_pembelian_pelanggan('Salma');
CALL sp_total_pembelian_pelanggan('Yoga');
CALL sp_total_pembelian_pelanggan('Lukman');

DROP PROCEDURE IF EXISTS sp_total_pembelian_pelanggan;

-- 4. Total Pembelian Tiap Bahan
DELIMITER //
CREATE PROCEDURE sp_total_pembelian_bahan(
    IN bahan VARCHAR(45)
)
BEGIN
    SELECT bm.nama_bahan, SUM(pb.total_pembelian) AS total_pembelian
    FROM bahan_masuk bm
    INNER JOIN pembelian_bahan pb ON bm.pembelian_bahan_id = pb.id
    WHERE bm.nama_bahan = bahan;
END //
DELIMITER ;

CALL sp_total_pembelian_bahan('Es Batu');

DROP PROCEDURE IF EXISTS sp_total_pembelian_bahan;

-- 5. Jumlah Bahan Masuk Berdasarkan Hari/Tanggal
   DELIMITER //
   CREATE PROCEDURE sp_hitung_jumlah_bahan_masuk_per_hari(
       IN tanggal_hari_ini DATE
   )
   BEGIN
       SELECT tanggal, SUM(jumlah) AS total_bahan_masuk
       FROM bahan_masuk
       WHERE tanggal = tanggal_hari_ini;
   END //
   DELIMITER ;
CALL sp_hitung_jumlah_bahan_masuk_per_hari('2022-12-21');
CALL sp_hitung_jumlah_bahan_masuk_per_hari('2023-01-03');

DROP PROCEDURE IF EXISTS sp_hitung_jumlah_bahan_masuk_per_hari;

-- Untuk Melihat Total Tiap Bahan Baku
SELECT nama_bahan, SUM(jumlah) AS total_bahan
FROM bahan_masuk
GROUP BY nama_bahan;

-- 6. Update Informasi Karyawan (Berdasarkan ID)
SELECT * FROM karyawan;
   DELIMITER //
   CREATE PROCEDURE sp_update_info_karyawan(
       IN karyawan_id VARCHAR(5),
       IN new_address VARCHAR(85),
       IN new_phone VARCHAR(15)
   )
   BEGIN
       UPDATE karyawan SET alamat = new_address, no_hp = new_phone 
       WHERE id = karyawan_id;
   END //
   DELIMITER ;

SET @karyawan_id = 'K0101';
SET @new_address = 'Jl. Araya';
SET @new_phone = '089012345678';
CALL sp_update_info_karyawan(@karyawan_id, @new_address, @new_phone);

CALL sp_update_info_karyawan('K0101', 'Jl. Araya', '089012345678');
CALL sp_update_info_karyawan('K0101', 'Jl. Blimbing', '082555444777');
DROP PROCEDURE IF EXISTS sp_update_info_karyawan;