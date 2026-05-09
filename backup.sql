-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 09, 2026 at 10:52 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `emart`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel-cache-75317a99a5103c38cd1d1293e1bb96f2', 'i:1;', 1778089164),
('laravel-cache-75317a99a5103c38cd1d1293e1bb96f2:timer', 'i:1778089164;', 1778089164),
('laravel-cache-a3affa0d1e1a3c72b78aa984c3367a05', 'i:1;', 1770794500),
('laravel-cache-a3affa0d1e1a3c72b78aa984c3367a05:timer', 'i:1770794500;', 1770794500),
('laravel-cache-a75f3f172bfb296f2e10cbfc6dfc1883', 'i:2;', 1770797002),
('laravel-cache-a75f3f172bfb296f2e10cbfc6dfc1883:timer', 'i:1770797002;', 1770797002),
('laravel-cache-d56b592203268b7854471ab6908f19a1', 'i:1;', 1777923289),
('laravel-cache-d56b592203268b7854471ab6908f19a1:timer', 'i:1777923289;', 1777923289);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2025-12-23 01:07:18', '2025-12-23 01:07:18');

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

CREATE TABLE `cart_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cart_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cart_items`
--

INSERT INTO `cart_items` (`id`, `cart_id`, `product_id`, `quantity`, `created_at`, `updated_at`) VALUES
(3, 1, 24, 1, '2026-01-30 05:01:11', '2026-01-30 05:01:11');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Smartphones', 'smartphones', 'Latest smartphones and mobile devices', '2025-12-23 00:59:30', '2025-12-23 00:59:30'),
(2, 'Laptops', 'laptops', 'High-performance laptops and notebooks', '2025-12-23 00:59:30', '2025-12-23 00:59:30'),
(3, 'Tablets', 'tablets', 'Tablets and iPad devices', '2025-12-23 00:59:30', '2025-12-23 00:59:30'),
(4, 'Accessories', 'accessories', 'Phone cases, chargers, and other accessories', '2025-12-23 00:59:30', '2025-12-23 00:59:30'),
(5, 'Audio', 'audio', 'Headphones, earbuds, and speakers', '2025-12-23 00:59:30', '2025-12-23 00:59:30'),
(6, 'Wearables', 'wearables', 'Smartwatches and fitness trackers', '2025-12-23 00:59:30', '2025-12-23 00:59:30');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_12_23_054326_create_personal_access_tokens_table', 1),
(5, '2025_12_23_054335_add_role_to_users_table', 1),
(6, '2025_12_23_054337_create_categories_table', 1),
(7, '2025_12_23_054339_create_products_table', 1),
(8, '2025_12_23_054341_create_carts_table', 1),
(9, '2025_12_23_054342_create_cart_items_table', 1),
(10, '2025_12_23_054358_create_orders_table', 1),
(11, '2025_12_23_054400_create_order_items_table', 1),
(12, '2025_12_23_054401_create_reviews_table', 1),
(13, '2026_01_06_090002_add_two_factor_columns_to_users_table', 1),
(14, '2026_01_30_105532_add_payment_fields_to_orders_table', 1),
(15, '2026_01_30_194046_add_sandbox_transaction_id_to_orders_table', 1),
(16, '2026_01_31_213614_add_is_admin_to_users_table', 1),
(17, '2026_01_31_213927_create_wishlists_table', 1),
(18, '2026_02_01_085827_create_order_status_histories_table', 1),
(19, '2026_02_01_085837_add_tracking_fields_to_orders_table', 1),
(20, '2026_02_01_091344_update_order_status_enum_values', 1),
(21, '2026_02_01_092645_remove_status_check_constraint_from_orders', 1),
(22, '2026_02_01_170143_add_is_featured_to_products_table', 2),
(23, '2026_02_01_193239_modify_order_status_enum', 3),
(24, '2026_02_02_000000_modify_order_status_enum', 3),
(25, '2026_04_30_000001_add_google_id_to_users_table', 4),
(26, '2026_05_05_000001_add_cascade_constraints_to_all_foreign_keys', 5),
(27, '2026_05_05_000002_fix_created_by_cascade_on_order_status_histories', 6);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `payment_method` varchar(255) NOT NULL DEFAULT 'cash_on_delivery',
  `sandbox_transaction_id` varchar(255) DEFAULT NULL,
  `payment_status` varchar(255) NOT NULL DEFAULT 'pending',
  `stripe_payment_intent_id` varchar(255) DEFAULT NULL,
  `stripe_checkout_session_id` varchar(255) DEFAULT NULL,
  `payment_amount` decimal(10,2) DEFAULT NULL,
  `paid_at` timestamp NULL DEFAULT NULL,
  `status` enum('pending','processing','completed','shipped','delivered','cancelled') DEFAULT 'pending',
  `tracking_number` varchar(255) DEFAULT NULL,
  `shipped_at` timestamp NULL DEFAULT NULL,
  `delivered_at` timestamp NULL DEFAULT NULL,
  `shipping_address` text NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `total_amount`, `payment_method`, `sandbox_transaction_id`, `payment_status`, `stripe_payment_intent_id`, `stripe_checkout_session_id`, `payment_amount`, `paid_at`, `status`, `tracking_number`, `shipped_at`, `delivered_at`, `shipping_address`, `phone`, `created_at`, `updated_at`) VALUES
(1, 4, 1439.99, 'stripe', NULL, 'pending', NULL, NULL, 1439.99, NULL, 'shipped', NULL, NULL, NULL, '46/8 St.benedict\'s Street col-13, Colombo, western 01300', '0773323826', '2026-01-30 05:32:33', '2026-02-01 04:01:55'),
(2, 4, 1439.99, 'cash_on_delivery', NULL, 'pending', NULL, NULL, 1439.99, NULL, 'pending', NULL, NULL, NULL, '46/8 St.benedict\'s Street col-13, Colombo, western 01300', '0773323826', '2026-01-30 05:37:13', '2026-01-30 05:37:13'),
(3, 4, 2869.98, 'stripe', NULL, 'pending', NULL, NULL, 2869.98, NULL, 'pending', NULL, NULL, NULL, '46/8 St.benedict\'s Street col-13, Colombo, western 01300', '0773323826', '2026-01-30 05:37:44', '2026-01-30 05:37:44'),
(4, 4, 2869.98, 'stripe', NULL, 'pending', NULL, NULL, 2869.98, NULL, 'pending', NULL, NULL, NULL, '46/8 St.benedict\'s Street col-13, Colombo, western 01300', '0773323826', '2026-01-30 05:42:27', '2026-01-30 05:42:27'),
(5, 4, 2869.98, 'stripe', NULL, 'pending', NULL, NULL, 2869.98, NULL, 'pending', NULL, NULL, NULL, '46/8 St.benedict\'s Street col-13, Colombo, western 01300', '0773323826', '2026-01-30 05:42:49', '2026-01-30 05:42:49'),
(6, 4, 2869.98, 'stripe', NULL, 'pending', NULL, NULL, 2869.98, NULL, 'pending', NULL, NULL, NULL, '46/8 St.benedict\'s Street col-13, Colombo, western 01300', '0773323826', '2026-01-30 05:55:57', '2026-01-30 05:55:57'),
(7, 4, 310869.98, 'card', NULL, 'paid', NULL, NULL, 310869.98, '2026-01-30 14:13:37', 'pending', NULL, NULL, NULL, '46/8 St.benedict\'s Street col-13, Colombo, western 01300', '0773323826', '2026-01-30 14:13:37', '2026-01-30 14:13:37'),
(8, 4, 1769.98, 'card', NULL, 'paid', NULL, NULL, 1769.98, '2026-02-01 03:38:04', 'pending', NULL, NULL, NULL, '46/8 st benedicts street, colombo, western 01300', '0773323825', '2026-02-01 03:38:04', '2026-02-01 03:38:04'),
(9, 4, 385010.00, 'cash_on_delivery', NULL, 'pending', NULL, NULL, 385010.00, NULL, 'shipped', NULL, '2026-02-01 14:09:56', NULL, '282/7 High Level Rd, Nugegoda, western 10250', '0773323825', '2026-02-01 13:59:28', '2026-02-01 14:09:56'),
(10, 4, 264010.00, 'card', NULL, 'paid', NULL, NULL, 264010.00, '2026-02-01 14:00:43', 'processing', NULL, NULL, NULL, '282/7 High Level Rd, Nugegoda, western 10250', '0112345674', '2026-02-01 14:00:42', '2026-02-01 14:09:34'),
(11, 4, 264010.00, 'card', NULL, 'paid', NULL, NULL, 264010.00, '2026-04-27 03:56:52', 'pending', NULL, NULL, NULL, '46/8 St.benedict\'s Street col-13, Colombo, western 01300', '0773323826', '2026-04-27 03:56:51', '2026-04-27 03:56:52'),
(12, 4, 82510.00, 'card', NULL, 'paid', NULL, NULL, 82510.00, '2026-04-27 03:59:00', 'pending', NULL, NULL, NULL, '46/8 St.benedict\'s Street col-13, Colombo, western 01300', '0773323826', '2026-04-27 03:58:59', '2026-04-27 03:59:00'),
(13, 4, 132010.00, 'card', NULL, 'paid', NULL, NULL, 132010.00, '2026-04-27 04:04:50', 'pending', NULL, NULL, NULL, '46/8 St.benedict\'s Street col-13, Colombo, western 01300', '0773323826', '2026-04-27 04:04:49', '2026-04-27 04:04:50'),
(14, 4, 264010.00, 'stripe', NULL, 'pending', NULL, NULL, 264010.00, NULL, 'pending', NULL, NULL, NULL, '46/8 St.benedict\'s Street col-13, Colombo, western 01300', '0773323826', '2026-04-27 04:13:23', '2026-04-27 04:13:23'),
(15, 4, 264010.00, 'stripe', NULL, 'pending', NULL, NULL, 264010.00, NULL, 'pending', NULL, NULL, NULL, '46/8 St.benedict\'s Street col-13, Colombo, western 01300', '0773323826', '2026-04-27 04:15:14', '2026-04-27 04:15:14'),
(16, 4, 264010.00, 'stripe', NULL, 'paid', 'pi_3TQltXJVisgPXE9D1eoLlYoP', 'cs_test_b1zNZVArV9sxGob2AcKNtL9x4z6BIGUAXRxTAZe6zd9aYiD85uI4z44era', 264010.00, '2026-04-27 04:26:10', 'processing', NULL, NULL, NULL, '46/8 St.benedict\'s Street col-13, Colombo, western 01300', '0773323826', '2026-04-27 04:22:43', '2026-04-27 04:26:10'),
(17, 4, 264010.00, 'stripe', NULL, 'paid', 'pi_3TQlw4JVisgPXE9D1PyoQB0O', 'cs_test_b1zcxtmmWF90OVPDIPDrPUv6CfhedPEMVNMUoSX1aYmShZeNTsVIOTY5Vg', 264010.00, '2026-04-27 04:28:47', 'processing', NULL, NULL, NULL, '46/8 St.benedict\'s Street col-13, Colombo, western 01300', '0773323826', '2026-04-27 04:27:27', '2026-04-27 04:28:47'),
(18, 4, 264010.00, 'stripe', NULL, 'paid', 'pi_3TRuOpJVisgPXE9D1Xc5YIFH', 'cs_test_b1qAAbYaIZ610BMEKBQU92NwIBFtAW1NpZaC2vyjw5esCNoiifDRGJear1', 264010.00, '2026-04-30 07:43:12', 'processing', NULL, NULL, NULL, '46/8 St.benedict\'s Street col-13, Colombo, western 01300', '0773323826', '2026-04-30 07:42:35', '2026-04-30 07:43:12'),
(19, 9, 82510.00, 'stripe', NULL, 'paid', 'pi_3TTReiJVisgPXE9D1b42S68B', 'cs_test_b1ApZmQ0HqlPlzFWmvRIZOPSEm2ENyH4FfhwPGFAaS0d5gRdl5oFG5EQwV', 82510.00, '2026-05-04 13:26:13', 'processing', NULL, NULL, NULL, '46/8 St.Benedict\'s Street, Colombo, western 01300', '0773323826', '2026-05-04 13:24:59', '2026-05-04 13:26:13');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `price`, `created_at`, `updated_at`) VALUES
(1, 9, 2, 1, 350000.00, '2026-02-01 13:59:28', '2026-02-01 13:59:28'),
(2, 10, 24, 1, 240000.00, '2026-02-01 14:00:42', '2026-02-01 14:00:42'),
(3, 11, 24, 1, 240000.00, '2026-04-27 03:56:51', '2026-04-27 03:56:51'),
(4, 12, 12, 1, 75000.00, '2026-04-27 03:58:59', '2026-04-27 03:58:59'),
(5, 13, 15, 1, 120000.00, '2026-04-27 04:04:49', '2026-04-27 04:04:49'),
(6, 14, 24, 1, 240000.00, '2026-04-27 04:13:23', '2026-04-27 04:13:23'),
(7, 15, 24, 1, 240000.00, '2026-04-27 04:15:14', '2026-04-27 04:15:14'),
(8, 16, 24, 1, 240000.00, '2026-04-27 04:22:43', '2026-04-27 04:22:43'),
(9, 17, 24, 1, 240000.00, '2026-04-27 04:27:27', '2026-04-27 04:27:27'),
(10, 18, 15, 2, 120000.00, '2026-04-30 07:42:35', '2026-04-30 07:42:35'),
(11, 19, 12, 1, 75000.00, '2026-05-04 13:24:59', '2026-05-04 13:24:59');

-- --------------------------------------------------------

--
-- Table structure for table `order_status_histories`
--

CREATE TABLE `order_status_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('pending','processing','shipped','delivered','cancelled') NOT NULL,
  `notes` text DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_status_histories`
--

INSERT INTO `order_status_histories` (`id`, `order_id`, `status`, `notes`, `created_by`, `created_at`) VALUES
(1, 10, 'processing', NULL, 1, '2026-02-01 19:39:34'),
(2, 9, 'shipped', NULL, 1, '2026-02-01 19:39:56');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 4, 'LAPTOP-PBFEEIH1', '4b8c637b6289af69d81321ab5b99b68376be7d36b7cec8fc94e5798a977ef007', '[\"*\"]', '2026-02-11 01:50:40', NULL, '2026-02-11 01:35:05', '2026-02-11 01:50:40');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock_quantity` int(11) NOT NULL DEFAULT 0,
  `low_stock_threshold` int(11) NOT NULL DEFAULT 10,
  `image_path` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `category_id`, `name`, `slug`, `description`, `price`, `stock_quantity`, `low_stock_threshold`, `image_path`, `is_active`, `is_featured`, `created_at`, `updated_at`) VALUES
(1, 1, 'iPhone 15 Pro', 'iphone-15-pro', 'Latest iPhone with A17 Pro chip, titanium design, and advanced camera system', 399000.00, 50, 10, '/images/products/iphone-15-pro.png', 1, 0, '2025-12-23 00:59:30', '2025-12-23 00:59:30'),
(2, 1, 'Samsung Galaxy S24', 'samsung-galaxy-s24', 'Flagship Samsung phone with AI features and stunning display', 350000.00, 44, 10, '/images/products/samsung-galaxy-s24.png', 1, 0, '2025-12-23 00:59:30', '2026-02-01 13:59:28'),
(4, 2, 'MacBook Pro 16\"', 'macbook-pro-16', 'Powerful laptop with M3 Pro chip for professionals', 750000.00, 25, 5, '/images/products/macbook-pro-16.png', 1, 0, '2025-12-23 00:59:30', '2025-12-23 00:59:30'),
(5, 2, 'Dell XPS 15', 'dell-xps-15', 'Premium Windows laptop with stunning display', 540000.00, 30, 8, '/images/products/dell-xps-15.png', 1, 0, '2025-12-23 00:59:30', '2025-12-23 00:59:30'),
(6, 2, 'Lenovo ThinkPad X1', 'lenovo-thinkpad-x1', 'Business laptop with excellent keyboard and durability', 480000.00, 20, 5, '/images/products/lenovo-thinkpad-x1.png', 1, 0, '2025-12-23 00:59:30', '2025-12-23 00:59:30'),
(7, 3, 'iPad Pro 12.9\"', 'ipad-pro-129', 'Professional tablet with M2 chip and ProMotion display', 330000.00, 35, 10, '/images/products/ipad-pro-129.png', 1, 0, '2025-12-23 00:59:30', '2025-12-23 00:59:30'),
(8, 3, 'Samsung Galaxy Tab S9', 'samsung-galaxy-tab-s9', 'Premium Android tablet with S Pen included', 240000.00, 28, 8, '/images/products/samsung-tab-s9.png', 1, 0, '2025-12-23 00:59:30', '2025-12-23 00:59:30'),
(10, 4, 'Phone Case Premium', 'phone-case-premium', 'Protective case with military-grade drop protection', 9000.00, 150, 30, '/images/products/phone-case.png', 1, 0, '2025-12-23 00:59:30', '2025-12-23 00:59:30'),
(11, 4, 'Wireless Charging Pad', 'wireless-charging-pad', '15W fast wireless charger for all Qi-enabled devices', 15000.00, 75, 15, '/images/products/wireless-charger.png', 1, 0, '2025-12-23 00:59:30', '2025-12-23 00:59:30'),
(12, 5, 'AirPods Pro 2', 'airpods-pro-2', 'Premium wireless earbuds with active noise cancellation', 75000.00, 58, 15, '/images/products/airpods-pro-2.png', 1, 0, '2025-12-23 00:59:30', '2026-05-04 13:26:13'),
(13, 5, 'Sony WH-1000XM5', 'sony-wh-1000xm5', 'Industry-leading noise cancelling headphones', 120000.00, 40, 10, '/images/products/sony-wh1000xm5.png', 1, 0, '2025-12-23 00:59:30', '2025-12-23 00:59:30'),
(15, 6, 'Apple Watch Series 9', 'apple-watch-series-9', 'Advanced smartwatch with health and fitness features', 120000.00, 42, 10, '/images/products/apple-watch-9.png', 1, 0, '2025-12-23 00:59:30', '2026-04-30 07:43:12'),
(16, 6, 'Samsung Galaxy Watch 6', 'samsung-galaxy-watch-6', 'Feature-rich smartwatch for Android users', 90000.00, 38, 10, '/images/products/samsung-watch-6.png', 1, 0, '2025-12-23 00:59:30', '2025-12-23 00:59:30'),
(18, 2, 'Asus Tuf A-15', 'asus-tuf-A-15', 'asus-tuf-A-15', 280000.00, 13, 10, '/storage/products/WJBYEsoTdW68RSf1WaSlP7UzwmpCKHXHABbzFCnG.jpg', 1, 0, '2026-01-30 04:45:51', '2026-01-30 14:13:37'),
(19, 2, 'MacBook Pro 16\" M3 Max', 'macbook-pro-16-m3-max', 'The most powerful MacBook Pro ever with M3 Max chip, stunning Liquid Retina XDR display, and up to 22 hours of battery life. Perfect for professionals.', 750000.00, 15, 5, '/images/products/macbook-pro.png', 1, 0, '2026-01-30 04:52:00', '2026-01-30 04:52:00'),
(20, 2, 'Dell XPS 15 9530', 'dell-xps-15-9530', 'Premium laptop with InfinityEdge display, 13th Gen Intel Core i7, NVIDIA RTX 4050, and stunning platinum silver finish.', 570000.00, 20, 5, '/images/products/dell-xps.png', 1, 0, '2026-01-30 04:52:00', '2026-01-30 04:52:00'),
(21, 2, 'HP Spectre x360 14', 'hp-spectre-x360-14', '2-in-1 convertible laptop with 360-degree hinge, Intel Evo platform, stunning OLED display, and premium gem-cut design.', 480000.00, 18, 5, '/images/products/hp-spectre.png', 1, 0, '2026-01-30 04:52:00', '2026-01-30 04:52:00'),
(22, 2, 'Lenovo ThinkPad X1 Carbon Gen 11', 'lenovo-thinkpad-x1-carbon-gen-11', 'Business ultrabook with legendary ThinkPad keyboard, military-grade durability, 13th Gen Intel processors, and all-day battery life.', 525000.00, 25, 5, '/images/products/lenovo-thinkpad.png', 1, 0, '2026-01-30 04:52:00', '2026-01-30 04:52:00'),
(23, 2, 'ASUS ZenBook 14 OLED', 'asus-zenbook-14-oled', 'Ultra-portable laptop with stunning OLED display, NumberPad 2.0, Intel Core i7, and premium royal blue finish.', 390000.00, 19, 5, '/images/products/asus-zenbook.png', 1, 0, '2026-01-30 04:52:00', '2026-01-30 14:13:37'),
(24, 2, 'Acer Swift 3 SF314', 'acer-swift-3-sf314', 'Lightweight and portable laptop with AMD Ryzen 7, full HD display, and all-day battery life. Perfect for students and professionals.', 240000.00, 24, 10, '/images/products/acer-swift.png', 1, 0, '2026-01-30 04:52:00', '2026-04-27 04:28:47'),
(25, 2, 'MSI GF63 Thin Gaming Laptop', 'msi-gf63-thin-gaming', 'Affordable gaming laptop with NVIDIA RTX 4050, 144Hz display, RGB keyboard, and powerful cooling system.', 360000.00, 12, 5, '/images/products/msi-gaming.png', 1, 0, '2026-01-30 04:52:00', '2026-01-30 04:52:00'),
(26, 2, 'Razer Blade 15 Advanced', 'razer-blade-15-advanced', 'Premium gaming laptop with RTX 4070, QHD 240Hz display, per-key RGB keyboard, and CNC aluminum unibody.', 840000.00, 8, 3, '/images/products/razer-blade.png', 1, 0, '2026-01-30 04:52:00', '2026-01-30 04:52:00'),
(27, 2, 'Microsoft Surface Laptop 5', 'microsoft-surface-laptop-5', 'Elegant laptop with Alcantara keyboard deck, PixelSense touchscreen, 12th Gen Intel Core, and premium platinum finish.', 450000.00, 16, 5, '/images/products/microsoft-surface.png', 1, 0, '2026-01-30 04:52:00', '2026-01-30 04:52:00'),
(28, 2, 'LG Gram 17 (2024)', 'lg-gram-17-2024', 'Ultra-lightweight 17\" laptop weighing just 2.98 lbs, with Intel 13th Gen processors, long battery life, and military-grade durability.', 510000.00, 14, 5, '/images/products/lg-gram.png', 1, 0, '2026-01-30 04:52:00', '2026-01-30 04:52:00');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `rating` int(10) UNSIGNED NOT NULL DEFAULT 5,
  `review` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('8F2ky3TUExjmDdBVNQEXgjb2YotfWvBRVHfAIl89', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiNVVDYnJ3QkZuS2NWSThCQjBmdGdRWDd1UWFGdkh1VkxvUE9LaUV2SSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjM6InVybCI7YTowOnt9czoyMToicGFzc3dvcmRfaGFzaF9zYW5jdHVtIjtzOjYwOiIkMnkkMTIkai56cjl0WTlKcGN5dW1tUFg4eDlRZXVEQ21jc2Z1OG9CZjBpOHcwc1RJUUpNekVCYXc5M0siO30=', 1777923774),
('FXllhcBdz0I0IMpUSjl9ic5xhR4sJ6oXUlU8iAv8', 4, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoidFlBNUZZcHdNejUzc1hJSDJjZENrNjRvejJrREhKZ2R2cUQ1bUZCQSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9wcm9kdWN0cyI7czo1OiJyb3V0ZSI7czoxNDoicHJvZHVjdHMuaW5kZXgiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aTo0O3M6MjE6InBhc3N3b3JkX2hhc2hfc2FuY3R1bSI7czo2MDoiJDJ5JDEyJENOa3A3R0x4QlBTblA5UHFDSUxaOE9IV05IcjFNUHd3YU1CMzR2T21sRXV4SWJibTFabC95Ijt9', 1777284410),
('K7l9StFM9pByiK0dLruD0rKmxG0yNVCwWWIccL9y', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiZWN2T09lbVZTNnQ4T1p2N29URmlEanJXUHVuOTA4eUc3UTJXUDRZbiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hdXRoL2dvb2dsZSI7czo1OiJyb3V0ZSI7czoxMToiYXV0aC5nb29nbGUiO31zOjU6InN0YXRlIjtzOjQwOiI1cXRYQUpzWkxSVTNBT1RsMkhEWUlxMUtPUzFvZGZZMExsZTlCODRZIjt9', 1777558297),
('nfmm20cnA35fIXw7GWISAQ3kvHesarKS5tzyj66H', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiZ0Z2NFA4ZXVXV0pxa21OOWZBc3NnV0Q0cUgzM0dHc1k3TXdOMUxaciI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hdXRoL2dvb2dsZSI7czo1OiJyb3V0ZSI7czoxMToiYXV0aC5nb29nbGUiO31zOjU6InN0YXRlIjtzOjQwOiJ5NzAwMjlGQ0JpeHZHUnZHbU1FUVlqRXQwZjIzY2M0OE56NlAydE8wIjt9', 1777923188),
('TuCbESGCYk8kKQ544dW721TYib6hIiKFNIdn9S0O', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidzVCalhzSkw0TFY0eERZNVh1SmJmeThSUW1qanRyNHM3ZmRDRHJJSiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fX0=', 1777558639),
('ulrUaqP7aK3UDlKcskajVaAixoCoA9TsO60T9UC4', 4, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiblRMVHlMc1o4Y0lDazBqZGZDSFh0NFRMZkUxTVNBY0FJUnhmcFduQSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6NDt9', 1778089108);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `google_id` varchar(255) DEFAULT NULL,
  `google_avatar` varchar(255) DEFAULT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  `role` enum('admin','customer') NOT NULL DEFAULT 'customer',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `two_factor_secret` text DEFAULT NULL,
  `two_factor_recovery_codes` text DEFAULT NULL,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `current_team_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_photo_path` varchar(2048) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `google_id`, `google_avatar`, `is_admin`, `role`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `remember_token`, `current_team_id`, `profile_photo_path`, `created_at`, `updated_at`) VALUES
(1, 'Admin User', 'admin@emart.com', NULL, NULL, 1, 'admin', NULL, '$2y$12$j.zr9tY9JpcyummPX8x9QeuDCmcsfu8oBf0i8w0sTIQJMzEBaw93K', NULL, NULL, NULL, 'UW3hnUMTjRujbgUHK3MAtfZn4IBucmgRyZEwKcU4yP86ky5OlAx39UtfdSF4', NULL, NULL, '2025-12-23 00:59:30', '2025-12-23 00:59:30'),
(2, 'John Doe', 'john@example.com', NULL, NULL, 0, 'customer', NULL, '$2y$12$aZiK2R4/5trKDS1IplEHFu4AN3B7G90/FntDH/DSvawu79qtXIprW', NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-23 00:59:30', '2025-12-23 00:59:30'),
(3, 'Jane Smith', 'jane@example.com', NULL, NULL, 0, 'customer', NULL, '$2y$12$6T8IGY/xUwNDinOcD6/XmeS/xCtPwcQIXSN80ryPmeiZryTDiA.8m', NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-23 00:59:30', '2025-12-23 00:59:30'),
(4, 'Chamodth De Silva', 'jeromedesilva44@gmail.com', NULL, NULL, 0, 'customer', NULL, '$2y$12$CNkp7GLxBPSnP9PqCILZ8OHWNHr1MPwwaMB34vOmlEuxIbbm1Zl/y', NULL, NULL, NULL, '8m8ZpS4m6h77S3fCuYHhxqA2b1M4juSyTyWefhsZ4Q4RqohM8jITeUrwU7hO', NULL, NULL, '2026-01-05 23:21:53', '2026-01-05 23:21:53'),
(5, 'chama', 'desilvahasitha14@gmail.com', '100313003104811688788', 'https://lh3.googleusercontent.com/a/ACg8ocLQIhAWgP0ZUgQhNC1SVk9oXDAnvsCk3Y3AnQU0z76RwYAgwbBj=s96-c', 0, 'customer', NULL, '$2y$12$.Tg/RvQJbQfKH/PSb8ZFdOpyCxLnDC7kU9w1EVyp4lTE3SU4SOR9m', NULL, NULL, NULL, 'XXeOnhV09kajHShUlqqK7OLONMihQILrLRnBXpJEyrRjuO7myPZvhIJEhPIe', NULL, NULL, '2026-01-06 09:38:15', '2026-04-30 08:42:46'),
(6, 'Test User', 'test@example.com', NULL, NULL, 0, 'customer', NULL, '$2y$12$M1FKrNbYTO7EKkQ3GEVuBe5dIvQxH6gcIX66XINEp3JpLAxB3eiWS', NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-06 14:33:16', '2026-01-06 14:33:16'),
(7, 'Admin Test', 'admin_test@example.com', NULL, NULL, 0, 'customer', NULL, '$2y$12$cZgB7iHWVt1xAKggrHacUOiHU6DRnRfiA/BJobHSMpEUcfPGzeaaO', NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-08 00:45:56', '2026-01-08 00:45:56'),
(8, 'Unique User', 'unique_user@example.com', NULL, NULL, 0, 'customer', NULL, '$2y$12$Pz0hxAXmVzhG0Q3wSei.meqxZGO/kQ/JyL6t7kZVov9/22pLnkXVa', NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-28 05:51:18', '2026-01-28 05:51:18'),
(9, 'desilva Hashitha', 'desilvahashitha14@gmail.com', '116776340320671099361', 'https://lh3.googleusercontent.com/a/ACg8ocKBw8KTlvRapDPpBDvWHOh6C7jxcH86PVf00n64PjOoLlLlpw=s96-c', 0, 'customer', NULL, '$2y$12$t1d3TlfzZqG4wtzXHKQ6POMRC8tim2QTKhGL4y.V7/29T53YedEEe', NULL, NULL, NULL, 'YbZ2Whs54QVGCu02Ot7u3ZMtyBsGSPpO1fpTlHuNYZq3Utgo1xufQVGYIT6F', NULL, NULL, '2026-04-30 08:42:31', '2026-04-30 08:42:31');

-- --------------------------------------------------------

--
-- Table structure for table `wishlists`
--

CREATE TABLE `wishlists` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `carts_user_id_foreign` (`user_id`);

--
-- Indexes for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cart_items_cart_id_foreign` (`cart_id`),
  ADD KEY `cart_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_slug_unique` (`slug`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_user_id_foreign` (`user_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_items_order_id_foreign` (`order_id`),
  ADD KEY `order_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `order_status_histories`
--
ALTER TABLE `order_status_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_status_histories_order_id_foreign` (`order_id`),
  ADD KEY `order_status_histories_created_by_foreign` (`created_by`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `products_slug_unique` (`slug`),
  ADD KEY `products_category_id_foreign` (`category_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reviews_user_id_foreign` (`user_id`),
  ADD KEY `reviews_product_id_foreign` (`product_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_google_id_unique` (`google_id`);

--
-- Indexes for table `wishlists`
--
ALTER TABLE `wishlists`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `wishlists_user_id_product_id_unique` (`user_id`,`product_id`),
  ADD KEY `wishlists_product_id_foreign` (`product_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `order_status_histories`
--
ALTER TABLE `order_status_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `wishlists`
--
ALTER TABLE `wishlists`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `cart_items_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cart_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `order_status_histories`
--
ALTER TABLE `order_status_histories`
  ADD CONSTRAINT `order_status_histories_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_status_histories_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reviews_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `wishlists`
--
ALTER TABLE `wishlists`
  ADD CONSTRAINT `wishlists_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `wishlists_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
