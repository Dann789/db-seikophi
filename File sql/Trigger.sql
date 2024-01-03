-- 1. Trigger Setelah Menambah Produk Baru
CREATE TABLE riwayat_produk (
	id_riwayat INT AUTO_INCREMENT PRIMARY KEY,
    pesan TEXT,
    waktu_penambahan TIMESTAMP
);
DROP TABLE riwayat_produk;

DELIMITER //
CREATE TRIGGER tambah_produk_baru
AFTER INSERT ON produk
FOR EACH ROW
BEGIN 
	DECLARE pesan_produk TEXT;
    IF NEW.jenis = 'Makanan' THEN
        SET pesan_produk = CONCAT('Produk Makanan "', NEW.nama, '" berhasil ditambahkan');
    ELSEIF NEW.jenis = 'Minuman' THEN
        SET pesan_produk = CONCAT('Produk Minuman "', NEW.nama, '" berhasil ditambahkan');
    ELSE
        SET pesan_produk = 'Produk berhasil ditambahkan';
    END IF;
    
    INSERT INTO riwayat_produk (pesan, waktu_penambahan)
    VALUES (pesan_produk, NOW());
END //
DELIMITER ;

INSERT INTO produk (id, nama, harga, jenis) 
VALUES('P066', 'Nasi Bakso', 15000, 'Makanan');

DROP TRIGGER IF EXISTS tambah_produk_baru;

SELECT * FROM produk;
SELECT * FROM riwayat_produk;

SELECT jenis, COUNT(*) AS jumlah
FROM produk
GROUP BY jenis;