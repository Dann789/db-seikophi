-- 1. VIEW Employee
CREATE VIEW EmployeeView AS
SELECT k.id AS karyawan_id, k.nama AS nama_karyawan, k.posisi AS posisi, s.id AS shift_id, s.hari, s.jam_masuk, s.jam_pulang
FROM karyawan k
JOIN shift_karyawan sk ON k.id = sk.id_karyawan
JOIN shift s ON sk.id_shift = s.id
ORDER BY FIELD(s.hari, 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu');

SELECT * FROM EmployeeView;

-- 2. VIEW Penjualan harian
CREATE VIEW penjualan_harian_vw AS
SELECT tanggal AS tinggal_penjualan, SUM(total_harga) AS total_harian
FROM transaksi
GROUP BY tanggal;

SELECT * FROM penjualan_harian_vw;

-- 3. VIEW Top 5 Makanan terlaku
CREATE VIEW top_makanan_terlaku_vw AS
SELECT
    p.nama AS nama_produk,
    SUM(pd.jumlah_produk) AS total_dibeli
FROM
    produk_dibeli pd
JOIN transaksi t ON pd.transaksi_id = t.id
JOIN produk p ON pd.produk_id = p.id
WHERE
    p.jenis = 'Makanan'
GROUP BY
    p.nama
ORDER BY
    total_dibeli DESC
LIMIT 5;

SELECT * FROM top_makanan_terlaku_vw;

-- Tambahan untuk melihat produk yang tidak terjual
SELECT * FROM produk;

SELECT p.nama, p.jenis
FROM produk p
LEFT JOIN produk_dibeli pd ON  pd.produk_id = p.id
WHERE p.jenis IN ('Makanan', 'Minuman') AND pd.produk_id IS NULL
ORDER BY p.jenis;

SELECT p.jenis, COUNT(*) AS jumlah_tidak_terjual
FROM produk p
LEFT JOIN produk_dibeli pd ON  pd.produk_id = p.id
WHERE p.jenis IN ('Makanan', 'Minuman') AND pd.produk_id IS NULL
GROUP BY p.jenis;

-- 4. VIEW Top 5 Minuman terlaku
CREATE VIEW top_minuman_vw AS
SELECT
    p.nama AS nama_produk,
    SUM(pd.jumlah_produk) AS total_pembelian
FROM
    produk_dibeli pd
    JOIN produk p ON pd.produk_id = p.id
    JOIN transaksi t ON pd.transaksi_id = t.id
WHERE
    p.jenis = 'Minuman'
GROUP BY
    pd.produk_id
ORDER BY
    total_pembelian DESC
LIMIT 5;

SELECT * FROM top_minuman_vw;

-- 5. VIEW total penjualan produk
CREATE VIEW total_penjualan_produk_vw AS
SELECT `pd`.`produk_id` AS `produk_id`, `p`.`nama` AS `nama_produk`, sum(`pd`.`jumlah_produk`) AS `total_penjualan` 
FROM (`produk_dibeli` `pd` join `produk` `p` on(`pd`.`produk_id` = `p`.`id`)) 
GROUP BY `pd`.`produk_id`, `p`.`nama`;

SELECT * FROM total_penjualan_produk_vw;

-- 6. VIEW pembelian bahan ke supplier
CREATE VIEW pembelian_bahan_supplier_vw AS
SELECT `pb`.`id` AS `id`, `pb`.`tanggal` AS `tanggal`, `pb`.`total_pembelian` AS `total_pembelian`, 
`s`.`nama` AS `nama_supplier`, `s`.`perusahaan` AS `perusahaan`, `s`.`alamat` AS `alamat` 
FROM (`pembelian_bahan` `pb` join `supplier` `s` on(`pb`.`supplier_id` = `s`.`id`));

SELECT * FROM pembelian_bahan_supplier_vw;