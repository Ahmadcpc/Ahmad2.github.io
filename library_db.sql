-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 16, 2024 at 04:16 PM
-- Server version: 8.0.17
-- PHP Version: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `library_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `description` text,
  `library_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`id`, `title`, `author`, `description`, `library_id`) VALUES
(1, 'Book Title 1', 'Author 1', 'This is a brief description of Book Title 1. It provides insights into the story and its background.', 1),
(2, 'Book Title 2', 'Author 2', 'This is a brief description of Book Title 2. It is about a thrilling adventure.', 1),
(3, 'Book Title 3', 'Author 3', 'This is a brief description of Book Title 3. A fictional story set in ancient times.', 1),
(4, 'Book Title 4', 'Author 4', 'This is a brief description of Book Title 4. A modern-day mystery.', 1),
(5, 'Book Title 5', 'Author 5', 'This is a brief description of Book Title 5. A classic novel loved by many.', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('library','user') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`) VALUES
(1, 'test', 'scrypt:32768:8:1$SQ8fQMXBIh0Miv8g$45d77a182f2dff82a0378dedbfb096bd3a3d9b6ce2b5c5a150b3c71487dc20d88cc4a371ae921553fbbbeec7c9a64c258384a060d06c50236a46991e19974c5f', 'library'),
(2, 'test', 'scrypt:32768:8:1$GkbEKeecBQz9DXHC$4a00c2bb588c6cad95fc48abf74f718393e51983da93f50265acd694bb0658fd7435ae82e10810a25284747875d80bd64f253d81621093b4028d2978d33aa833', 'user'),
(3, 'test', 'scrypt:32768:8:1$piBWIzebls5PdYUU$89a973d1b193a275bfa15c68796b2ce9375b6f146fa793632d2101eae7358ae24898048d9a7565c070b205e54a2a6a7d6bda34eb8a01a6c90f5f97cfb432c52a', 'library'),
(4, 'library1', '$2b$12$4QfQsOUbN3XJfgJdbNQlLeV.vL50/MktJftIV2irZ95onEVNEXw.e', 'library'),
(5, 'user1', '$2b$12$4QfQsOUbN3XJfgJdbNQlLeV.vL50/MktJftIV2irZ95onEVNEXw.e', 'user'),
(6, 'test', 'scrypt:32768:8:1$rgCCddmGcpHnuer8$1ec2398a73f3c64b2f23571f0e211c240eada0cc9465af9db6f9d7938ec09e4922a237c8e0964dc634a00f1d5f952508b053f229c1149122e843a024df8c8f70', 'library');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`),
  ADD KEY `library_id` (`library_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `books_ibfk_1` FOREIGN KEY (`library_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
