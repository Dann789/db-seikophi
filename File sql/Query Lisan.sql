-- Join 3 Tabel
SELECT k.id AS id_karyawan, k.nama AS nama_karyawan, k.alamat, k.no_hp, k.posisi, s.id AS id_shift, 
s.hari, s.jam_masuk, s.jam_pulang
FROM karyawan k
INNER JOIN shift_karyawan sk ON k.id = sk.id_karyawan
INNER JOIN shift s ON sk.id_shift = s.id
-- WHERE k.nama LIKE '%n';
-- ORDER BY FIELD(s.hari, 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'), 
ORDER BY FIELD(s.id, 'SS1', 'SS2', 'SL1', 'SL2', 'RB1', 'RB2', 'KM1', 'KM2', 'JM1', 'JM2', 'SB1', 'SB2', 'MG1', 'MG2');

-- Menampilkan Durasi Kerja
SELECT k.id AS id_karyawan, k.nama AS nama_karyawan, k.alamat, k.no_hp, k.posisi, s.id AS id_shift, 
s.hari, s.jam_masuk, s.jam_pulang, 
CASE
	WHEN s.jam_pulang < s.jam_masuk THEN
		TIMEDIFF(ADDTIME(s.jam_pulang, '24:00:00'), s.jam_masuk)
	ELSE
		TIMEDIFF(s.jam_pulang, s.jam_masuk)
END AS durasi_kerja
FROM karyawan k
INNER JOIN shift_karyawan sk ON k.id = sk.id_karyawan
INNER JOIN shift s ON sk.id_shift = s.id;

-- Menampilkan nama, posisi, dan hari bekerja
SELECT k.nama, k.posisi, s.hari
FROM karyawan k
INNER JOIN shift_karyawan sk ON k.id = sk.id_karyawan
INNER JOIN shift s ON sk.id_shift = s.id;