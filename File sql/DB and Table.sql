CREATE DATABASE seikophi;

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema seikophi
-- -----------------------------------------------------

USE `seikophi` ;

-- -----------------------------------------------------
-- Table `seikophi`.`produk`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seikophi`.`produk` (
  `id` VARCHAR(5) NOT NULL,
  `nama` VARCHAR(45) NOT NULL,
  `harga` INT NOT NULL,
  `jenis` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `seikophi`.`produk_dibeli`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seikophi`.`produk_dibeli` (
  `transaksi_id` VARCHAR(5) NOT NULL,
  `produk_id` VARCHAR(5) NOT NULL,
  `jumlah_produk` INT NOT NULL,
  PRIMARY KEY (`transaksi_id`, `produk_id`))
ENGINE = InnoDB;

ALTER TABLE `produk_dibeli`
  ADD CONSTRAINT `produk_dibeli_ibfk_1` FOREIGN KEY (`produk_id`) REFERENCES `produk` (`id`),
  ADD CONSTRAINT `produk_dibeli_ibfk_3` FOREIGN KEY (`transaksi_id`) REFERENCES `transaksi` (`id`);


-- -----------------------------------------------------
-- Table `seikophi`.`shift`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seikophi`.`shift` (
  `id` VARCHAR(5) NOT NULL,
  `hari` VARCHAR(10) NOT NULL,
  `jam_masuk` TIME NOT NULL,
  `jam_pulang` TIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `seikophi`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seikophi`.`supplier` (
  `id` VARCHAR(5) NOT NULL,
  `nama` VARCHAR(45) NOT NULL,
  `alamat` VARCHAR(100) NOT NULL,
  `no_hp` VARCHAR(15) NOT NULL,
  `perusahaan` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;
ALTER TABLE `supplier`
  ADD KEY `id` (`id`);


-- -----------------------------------------------------
-- Table `seikophi`.`transaksi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seikophi`.`transaksi` (
  `id` VARCHAR(5) NOT NULL,
  `pelanggan_id` VARCHAR(5) NOT NULL,
  `karyawan_id` VARCHAR(5) NOT NULL,
  `jenis_transaksi` VARCHAR(45) NOT NULL,
  `tanggal` DATE NOT NULL,
  `total_harga` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

ALTER TABLE `transaksi`
  ADD KEY `id` (`id`),
  ADD KEY `pelanggan_id` (`pelanggan_id`),
  ADD KEY `karyawan_id` (`karyawan_id`);

ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`pelanggan_id`) REFERENCES `pelanggan` (`id`),
  ADD CONSTRAINT `transaksi_ibfk_2` FOREIGN KEY (`karyawan_id`) REFERENCES `karyawan` (`id`);


-- -----------------------------------------------------
-- Table `seikophi`.`bahan_keluar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seikophi`.`bahan_keluar` (
  `id` VARCHAR(5) NOT NULL,
  `produk_id` VARCHAR(5) NOT NULL,
  `nama_bahan` VARCHAR(45) NOT NULL,
  `tanggal` DATE NOT NULL,
  `jumlah` INT NOT NULL,
  `bahan_masuk_id` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

ALTER TABLE `bahan_keluar`
  ADD KEY `bahan_masuk_id` (`bahan_masuk_id`),
  ADD KEY `produk_id` (`produk_id`);

ALTER TABLE `bahan_keluar`
  ADD CONSTRAINT `bahan_keluar_ibfk_1` FOREIGN KEY (`bahan_masuk_id`) REFERENCES `bahan_masuk` (`id`),
  ADD CONSTRAINT `bahan_keluar_ibfk_3` FOREIGN KEY (`produk_id`) REFERENCES `produk` (`id`);


-- -----------------------------------------------------
-- Table `seikophi`.`bahan_masuk`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seikophi`.`bahan_masuk` (
  `id` VARCHAR(5) NOT NULL,
  `nama_bahan` VARCHAR(45) NOT NULL,
  `tanggal` DATE NOT NULL,
  `jumlah` INT NOT NULL,
  `pembelian_bahan_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

ALTER TABLE `bahan_masuk`
  ADD KEY `id` (`id`),
  ADD KEY `pembelian_bahan_id` (`pembelian_bahan_id`);

ALTER TABLE `bahan_masuk`
  ADD CONSTRAINT `pembelian_bahan_id` FOREIGN KEY (`pembelian_bahan_id`) REFERENCES `pembelian_bahan` (`id`);


-- -----------------------------------------------------
-- Table `seikophi`.`karyawan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seikophi`.`karyawan` (
  `id` VARCHAR(5) NOT NULL,
  `nama` VARCHAR(45) NOT NULL,
  `alamat` VARCHAR(85) NOT NULL,
  `no_hp` VARCHAR(15) NOT NULL,
  `posisi` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;
ALTER TABLE `karyawan`
  ADD KEY `id` (`id`);


-- -----------------------------------------------------
-- Table `seikophi`.`pelanggan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seikophi`.`pelanggan` (
  `id` VARCHAR(5) NOT NULL,
  `nama` VARCHAR(45) NOT NULL,
  `no_hp` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;
ALTER TABLE `pelanggan`
  ADD KEY `id` (`id`);


-- -----------------------------------------------------
-- Table `seikophi`.`pembelian_bahan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seikophi`.`pembelian_bahan` (
  `id` VARCHAR(5) NOT NULL,
  `karyawan_id` VARCHAR(5) NOT NULL,
  `tanggal` DATETIME NOT NULL,
  `total_pembelian` INT NOT NULL,
  `supplier_id` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

ALTER TABLE `pembelian_bahan`
  ADD KEY `id` (`id`),
  ADD KEY `supplier_id` (`supplier_id`),
  ADD KEY `karyawan_id` (`karyawan_id`);

ALTER TABLE `pembelian_bahan`
  ADD CONSTRAINT `pembelian_bahan_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`),
  ADD CONSTRAINT `pembelian_bahan_ibfk_3` FOREIGN KEY (`karyawan_id`) REFERENCES `karyawan` (`id`);


CREATE TABLE shift_karyawan (
    id_karyawan VARCHAR(5) NOT NULL,
    id_shift VARCHAR(5) NOT NULL,
    FOREIGN KEY (id_karyawan) REFERENCES karyawan(id),
    FOREIGN KEY (id_shift) REFERENCES shift(id)
);

ALTER TABLE `shift_karyawan`
  ADD CONSTRAINT `shift_karyawan_ibfk_1` FOREIGN KEY (`karyawan_id`) REFERENCES `karyawan` (`id`),
  ADD CONSTRAINT `shift_karyawan_ibfk_2` FOREIGN KEY (`shift_id`) REFERENCES `shift` (`id`);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;