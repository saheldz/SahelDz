-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Oct 24, 2025 at 04:50 PM
-- Server version: 11.8.3-MariaDB-log
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u497064961_Saheldz`
--

-- --------------------------------------------------------

--
-- Table structure for table `branding_projects`
--

CREATE TABLE `branding_projects` (
  `id` int(11) NOT NULL,
  `client_id` int(11) DEFAULT NULL,
  `project_name` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL COMMENT 'NULL = tous les admins/employés',
  `type` enum('sale','order','stock_low','system') DEFAULT 'sale',
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `link` varchar(500) DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `type`, `title`, `message`, `link`, `is_read`, `created_at`) VALUES
(1, NULL, 'sale', '🎉 Nouvelle vente: Netflix', 'Client a acheté \'Netflix\' pour 15.99€\nCommande: ORD-20251024-A4E5D0\nCode livré: NET-6CA256EC', '/admin-orders.php?order_id=3', 0, '2025-10-24 00:49:30'),
(2, NULL, 'sale', '🎉 Nouvelle vente: Netflix', 'Client a acheté \'Netflix\' pour 15.99€\nCommande: ORD-20251024-13C69D\nCode livré: NET-2E38A40B', '/admin-orders.php?order_id=4', 0, '2025-10-24 00:54:19'),
(3, NULL, 'sale', '🎉 Nouvelle vente: Adobe Creative Cloud', 'Client a acheté \'Adobe Creative Cloud\' pour 54.99€\nCommande: ORD-20251024-947BC8\nCode livré: test test test', '/admin-orders.php?order_id=5', 0, '2025-10-24 05:53:55');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `order_number` varchar(50) NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `status` enum('pending','processing','completed','cancelled') DEFAULT 'pending',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `item_id`, `order_number`, `item_name`, `price`, `status`, `notes`, `created_at`, `updated_at`) VALUES
(1, 3, 1, 'ORD-20251024-39E6C1', 'Netflix', 15.99, 'pending', NULL, '2025-10-24 00:27:08', '2025-10-24 00:27:08'),
(2, 3, 1, 'ORD-20251024-F136C2', 'Netflix', 15.99, 'completed', 'CODE: NET-F89A5451\n\nINFORMATIONS:\nEmail: demo1@example.com\nMotdepasse: Pass3188', '2025-10-24 00:38:20', '2025-10-24 00:38:20'),
(3, 3, 1, 'ORD-20251024-A4E5D0', 'Netflix', 15.99, 'completed', 'CODE: NET-6CA256EC\n\nINFORMATIONS:\nEmail: demo2@example.com\nMotdepasse: Pass1770', '2025-10-24 00:49:30', '2025-10-24 00:49:30'),
(4, 3, 1, 'ORD-20251024-13C69D', 'Netflix', 15.99, 'completed', 'CODE: NET-2E38A40B\n\nINFORMATIONS:\nEmail: demo3@example.com\nMotdepasse: Pass8668', '2025-10-24 00:54:19', '2025-10-24 00:54:19'),
(5, 3, 4, 'ORD-20251024-947BC8', 'Adobe Creative Cloud', 54.99, 'completed', 'CODE: test test test\n\nINFORMATIONS:\ntest', '2025-10-24 05:53:55', '2025-10-24 05:53:55');

-- --------------------------------------------------------

--
-- Table structure for table `order_files`
--

CREATE TABLE `order_files` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `file_size` int(11) DEFAULT NULL,
  `uploaded_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_messages`
--

CREATE TABLE `order_messages` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `is_client` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `code`, `name`, `description`, `category`, `created_at`) VALUES
(1, 'dashboard_view', 'Voir le Tableau de Bord', 'Accéder au tableau de bord principal', 'Dashboard', '2025-10-23 17:57:56'),
(2, 'dashboard_stats', 'Voir les Statistiques', 'Voir les statistiques et métriques', 'Dashboard', '2025-10-23 17:57:56'),
(3, 'pos_access', 'Accéder au POS', 'Accéder au système de point de vente', 'POS', '2025-10-23 17:57:56'),
(4, 'pos_sell', 'Effectuer des Ventes', 'Créer et finaliser des ventes', 'POS', '2025-10-23 17:57:56'),
(5, 'pos_refund', 'Faire des Remboursements', 'Effectuer des remboursements', 'POS', '2025-10-23 17:57:56'),
(6, 'smm_access', 'Accéder aux Commandes SMM', 'Accéder au module SMM', 'SMM', '2025-10-23 17:57:56'),
(7, 'smm_api_config', 'Configurer l\'API SMM', 'Configurer et modifier la clé API', 'SMM', '2025-10-23 17:57:56'),
(8, 'smm_create_order', 'Créer des Commandes SMM', 'Créer de nouvelles commandes SMM', 'SMM', '2025-10-23 17:57:56'),
(9, 'smm_view_orders', 'Voir les Commandes SMM', 'Consulter les commandes SMM', 'SMM', '2025-10-23 17:57:56'),
(10, 'smm_view_services', 'Voir les Services SMM', 'Consulter la liste des services', 'SMM', '2025-10-23 17:57:56'),
(11, 'smm_add_funds', 'Gérer les Fonds SMM', 'Ajouter et gérer les fonds', 'SMM', '2025-10-23 17:57:56'),
(12, 'branding_access', 'Accéder au Branding', 'Accéder au module branding', 'Branding', '2025-10-23 17:57:56'),
(13, 'branding_create_project', 'Créer des Projets', 'Créer de nouveaux projets branding', 'Branding', '2025-10-23 17:57:56'),
(14, 'branding_edit_project', 'Modifier des Projets', 'Modifier les projets existants', 'Branding', '2025-10-23 17:57:56'),
(15, 'branding_delete_project', 'Supprimer des Projets', 'Supprimer des projets', 'Branding', '2025-10-23 17:57:56'),
(16, 'branding_upload_files', 'Upload de Fichiers', 'Uploader des fichiers dans les projets', 'Branding', '2025-10-23 17:57:56'),
(17, 'branding_create_service', 'Créer des Services', 'Créer de nouveaux services branding', 'Branding', '2025-10-23 17:57:56'),
(18, 'websites_access', 'Accéder aux Sites Web', 'Accéder au module sites web', 'Sites Web', '2025-10-23 17:57:56'),
(19, 'websites_create', 'Créer des Sites', 'Créer de nouveaux projets de sites web', 'Sites Web', '2025-10-23 17:57:56'),
(20, 'websites_manage', 'Gérer les Sites', 'Gérer les projets de sites web', 'Sites Web', '2025-10-23 17:57:56'),
(21, 'digital_access', 'Accéder aux Produits Digitaux', 'Accéder au module produits digitaux', 'Produits Digitaux', '2025-10-23 17:57:56'),
(22, 'digital_create_product', 'Créer des Produits', 'Créer de nouveaux produits', 'Produits Digitaux', '2025-10-23 17:57:56'),
(23, 'digital_sell', 'Vendre des Produits', 'Effectuer des ventes de produits digitaux', 'Produits Digitaux', '2025-10-23 17:57:56'),
(24, 'digital_manage_accounts', 'Gérer les Comptes', 'Gérer les comptes et stocks', 'Produits Digitaux', '2025-10-23 17:57:56'),
(25, 'digital_create_category', 'Créer des Catégories', 'Créer et gérer les catégories', 'Produits Digitaux', '2025-10-23 17:57:56'),
(26, 'orders_access', 'Accéder aux Commandes', 'Accéder à la gestion des commandes', 'Commandes', '2025-10-23 17:57:56'),
(27, 'orders_view_all', 'Voir Toutes les Commandes', 'Voir toutes les commandes (pas seulement les siennes)', 'Commandes', '2025-10-23 17:57:56'),
(28, 'orders_manage', 'Gérer les Commandes', 'Modifier et gérer les commandes', 'Commandes', '2025-10-23 17:57:56'),
(29, 'orders_delete', 'Supprimer des Commandes', 'Supprimer des commandes', 'Commandes', '2025-10-23 17:57:56'),
(30, 'clients_access', 'Accéder aux Clients', 'Accéder à la gestion des clients', 'Clients', '2025-10-23 17:57:56'),
(31, 'clients_create', 'Créer des Clients', 'Ajouter de nouveaux clients', 'Clients', '2025-10-23 17:57:56'),
(32, 'clients_edit', 'Modifier des Clients', 'Modifier les informations clients', 'Clients', '2025-10-23 17:57:56'),
(33, 'clients_delete', 'Supprimer des Clients', 'Supprimer des clients', 'Clients', '2025-10-23 17:57:56'),
(34, 'clients_view_history', 'Voir l\'Historique Client', 'Voir l\'historique complet des clients', 'Clients', '2025-10-23 17:57:56'),
(35, 'admin_users', 'Gérer les Utilisateurs', 'Gérer les comptes utilisateurs', 'Administration', '2025-10-23 17:57:56'),
(36, 'admin_permissions', 'Gérer les Permissions', 'Assigner des permissions aux utilisateurs', 'Administration', '2025-10-23 17:57:56'),
(37, 'admin_roles', 'Gérer les Rôles', 'Gérer les rôles et leurs permissions', 'Administration', '2025-10-23 17:57:56'),
(38, 'admin_settings', 'Paramètres Système', 'Accéder aux paramètres système', 'Administration', '2025-10-23 17:57:56');

-- --------------------------------------------------------

--
-- Table structure for table `product_downloads`
--

CREATE TABLE `product_downloads` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `download_token` varchar(100) NOT NULL,
  `download_count` int(11) DEFAULT 0,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_downloads`
--

INSERT INTO `product_downloads` (`id`, `order_id`, `item_id`, `download_token`, `download_count`, `expires_at`, `created_at`) VALUES
(1, 1, 1, '478a02d18b3e5d3a4664c4beb76a3220b6542453c62f7ec6e50ec715e1f5294c', 0, '2025-11-23 00:27:08', '2025-10-24 00:27:08');

-- --------------------------------------------------------

--
-- Table structure for table `product_stock`
--

CREATE TABLE `product_stock` (
  `id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `product_code` varchar(255) NOT NULL,
  `product_key` text DEFAULT NULL,
  `status` enum('available','sold','reserved') DEFAULT 'available',
  `is_reusable` tinyint(1) NOT NULL DEFAULT 0,
  `sold_to_user_id` int(11) DEFAULT NULL,
  `sold_at` timestamp NULL DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `max_uses` int(11) DEFAULT 1,
  `used_count` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_stock`
--

INSERT INTO `product_stock` (`id`, `item_id`, `product_code`, `product_key`, `status`, `is_reusable`, `sold_to_user_id`, `sold_at`, `order_id`, `notes`, `created_at`, `updated_at`, `max_uses`, `used_count`) VALUES
(30, 10, 'dsdvsdv', 'dcqscq', 'sold', 0, NULL, '2025-10-24 09:20:49', NULL, 'Type: Compte générique\nVendu à: Client anonyme', '2025-10-24 08:18:28', '2025-10-24 09:20:49', 1, 0),
(31, 10, 'efqfqfq', 'egefa', 'sold', 0, NULL, '2025-10-24 16:33:18', NULL, 'Type: Compte générique\nVendu à: amine', '2025-10-24 08:25:22', '2025-10-24 16:33:18', 1, 0),
(32, 10, 'jkbjk', '', 'available', 1, NULL, NULL, NULL, 'Clé réutilisable', '2025-10-24 08:38:50', '2025-10-24 08:38:50', 1, 0),
(33, 10, 'hjv hv', '', 'available', 1, NULL, NULL, NULL, 'Clé réutilisable', '2025-10-24 08:47:01', '2025-10-24 08:47:01', 1, 0),
(34, 10, 'hjv hv', '', 'available', 1, NULL, NULL, NULL, 'Clé réutilisable', '2025-10-24 08:47:01', '2025-10-24 08:47:01', 1, 0),
(35, 10, 'hhkvkv', '', 'available', 1, NULL, NULL, NULL, 'Clé réutilisable', '2025-10-24 08:47:16', '2025-10-24 08:47:16', 1, 0),
(36, 10, 'hhkvkv', '', 'available', 1, NULL, NULL, NULL, 'Clé réutilisable', '2025-10-24 08:47:16', '2025-10-24 08:47:16', 1, 0),
(37, 10, 'dfqsefqfq', '', 'available', 1, NULL, NULL, NULL, 'Clé réutilisable', '2025-10-24 09:07:18', '2025-10-24 09:07:18', 200, 0);

-- --------------------------------------------------------

--
-- Table structure for table `project_files`
--

CREATE TABLE `project_files` (
  `id` int(11) NOT NULL,
  `project_id` int(11) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_path` varchar(500) DEFAULT NULL,
  `file_type` varchar(100) DEFAULT NULL,
  `file_size` bigint(20) DEFAULT NULL,
  `file_category` varchar(50) DEFAULT NULL,
  `thumbnail_path` varchar(500) DEFAULT NULL,
  `uploaded_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `display_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `permissions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`permissions`)),
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `display_name`, `description`, `permissions`, `created_at`) VALUES
(1, 'super_admin', 'Super Administrateur', 'Accès complet au système', '{\"all\": true}', '2025-10-23 17:37:16'),
(2, 'admin', 'Administrateur', 'Gestion des utilisateurs et commandes', '{\"manage_users\": true, \"manage_orders\": true, \"view_reports\": true}', '2025-10-23 17:37:16'),
(3, 'client', 'Client', 'Utilisateur standard avec wallet', '{\"create_orders\": true, \"view_wallet\": true}', '2025-10-23 17:37:16'),
(4, 'employee', 'Employé', 'Gestion des commandes uniquement', '{\"manage_orders\": true, \"view_orders\": true}', '2025-10-23 17:37:16');

-- --------------------------------------------------------

--
-- Table structure for table `shop_categories`
--

CREATE TABLE `shop_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `type` enum('service','product') NOT NULL,
  `icon` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `sort_order` int(11) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shop_categories`
--

INSERT INTO `shop_categories` (`id`, `name`, `slug`, `type`, `icon`, `description`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES
(9, 'Streaming', 'streaming', 'product', '🎬', 'Abonnements streaming (Netflix, Disney+, etc.)', 0, 1, '2025-10-24 06:30:16', '2025-10-24 08:17:33'),
(10, 'Logiciels', 'logiciels', 'product', '💻', 'Licences logiciels (Office, Adobe, etc.)', 1, 1, '2025-10-24 06:30:16', '2025-10-24 08:17:39'),
(26, 'nnn', 'nnn', 'product', '🎬', NULL, 0, 1, '2025-10-24 07:26:08', '2025-10-24 08:17:41');

-- --------------------------------------------------------

--
-- Table structure for table `shop_items`
--

CREATE TABLE `shop_items` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `type` enum('service','product') NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `short_description` varchar(500) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `icon` varchar(50) DEFAULT NULL,
  `delivery_time` varchar(100) DEFAULT NULL,
  `is_subscription` tinyint(1) DEFAULT 0,
  `subscription_period` enum('monthly','yearly') DEFAULT NULL,
  `status` enum('available','unavailable','coming_soon') DEFAULT 'available',
  `featured` tinyint(1) DEFAULT 0,
  `sort_order` int(11) DEFAULT 0,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shop_items`
--

INSERT INTO `shop_items` (`id`, `category_id`, `type`, `name`, `slug`, `description`, `short_description`, `price`, `icon`, `delivery_time`, `is_subscription`, `subscription_period`, `status`, `featured`, `sort_order`, `created_by`, `created_at`, `updated_at`) VALUES
(10, 9, 'product', 'Netflix Premium', 'netflix-premium', 'Compte Netflix Premium 4K - 4 écrans simultanés', NULL, 15.00, '🎬', '1 mois', 0, NULL, 'available', 0, 0, 1, '2025-10-24 06:48:04', '2025-10-24 06:48:04'),
(11, 10, 'product', 'Office 365', 'office-365', 'Licence Microsoft Office 365 complète', NULL, 35.00, '💻', '1 an', 0, NULL, 'available', 0, 0, 1, '2025-10-24 06:48:04', '2025-10-24 06:48:04'),
(12, 26, '', 'tedt', 'tedt', '', '', 0.02, '', '1 mois', 0, NULL, 'available', 0, 0, 2, '2025-10-24 08:21:27', '2025-10-24 08:21:27'),
(13, 26, '', 'ttttt', 'ttttt', 'scq', '', 1.00, '', '1 mois', 0, NULL, 'available', 0, 0, 2, '2025-10-24 08:23:56', '2025-10-24 08:23:56'),
(14, 26, '', 'ffddss', 'ffddss', 'DEZFZ', '', 111.00, '', '1 mois', 0, NULL, 'available', 0, 0, 2, '2025-10-24 09:24:07', '2025-10-24 09:24:07'),
(15, 26, '', 'rzef', 'rzef', '', '', 11.00, '', '1 mois', 0, NULL, 'available', 0, 0, 2, '2025-10-24 09:51:50', '2025-10-24 09:51:50');

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `plan_id` int(11) NOT NULL,
  `status` enum('trial','active','suspended','cancelled','expired') DEFAULT 'active',
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `next_billing_date` date DEFAULT NULL,
  `trial_ends_at` date DEFAULT NULL,
  `cancelled_at` timestamp NULL DEFAULT NULL,
  `cancel_reason` text DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `billing_period` enum('daily','weekly','monthly','quarterly','yearly') NOT NULL,
  `auto_renew` tinyint(1) DEFAULT 1,
  `payment_method` varchar(50) DEFAULT 'wallet',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscription_history`
--

CREATE TABLE `subscription_history` (
  `id` int(11) NOT NULL,
  `subscription_id` int(11) NOT NULL,
  `action` varchar(50) NOT NULL COMMENT 'created, renewed, suspended, cancelled, expired, reactivated',
  `old_status` varchar(50) DEFAULT NULL,
  `new_status` varchar(50) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT 0.00,
  `description` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscription_items`
--

CREATE TABLE `subscription_items` (
  `id` int(11) NOT NULL,
  `subscription_id` int(11) NOT NULL,
  `item_type` enum('service','product','feature') DEFAULT 'service',
  `item_name` varchar(255) NOT NULL,
  `item_description` text DEFAULT NULL,
  `quantity` int(11) DEFAULT 1,
  `unit_price` decimal(10,2) DEFAULT 0.00,
  `total_price` decimal(10,2) DEFAULT 0.00,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscription_plans`
--

CREATE TABLE `subscription_plans` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `billing_period` enum('daily','weekly','monthly','quarterly','yearly') NOT NULL DEFAULT 'monthly',
  `trial_days` int(11) DEFAULT 0,
  `features` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`features`)),
  `max_users` int(11) DEFAULT NULL,
  `max_storage` int(11) DEFAULT NULL COMMENT 'En MB',
  `status` enum('active','inactive','archived') DEFAULT 'active',
  `is_popular` tinyint(1) DEFAULT 0,
  `sort_order` int(11) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subscription_plans`
--

INSERT INTO `subscription_plans` (`id`, `name`, `description`, `price`, `billing_period`, `trial_days`, `features`, `max_users`, `max_storage`, `status`, `is_popular`, `sort_order`, `created_at`, `updated_at`) VALUES
(1, 'Plan Starter', 'Parfait pour débuter', 9.99, 'monthly', 7, '[\"Jusqu\'\\u00e0 3 utilisateurs\",\"5 GB de stockage\",\"Support par email\",\"Rapports basiques\"]', 3, 5120, 'active', 0, 1, '2025-10-23 19:25:32', '2025-10-23 19:25:32'),
(2, 'Plan Pro', 'Pour les professionnels exigeants', 29.99, 'monthly', 14, '[\"Jusqu\'\\u00e0 10 utilisateurs\",\"50 GB de stockage\",\"Support prioritaire\",\"Rapports avanc\\u00e9s\",\"API Access\",\"Int\\u00e9grations tierces\"]', 10, 51200, 'active', 1, 2, '2025-10-23 19:25:32', '2025-10-23 19:25:32'),
(3, 'Plan Enterprise', 'Solution complète pour entreprises', 99.99, 'monthly', 30, '[\"Utilisateurs illimit\\u00e9s\",\"Stockage illimit\\u00e9\",\"Support 24\\/7\",\"Rapports personnalis\\u00e9s\",\"API illimit\\u00e9e\",\"Int\\u00e9grations avanc\\u00e9es\",\"Manager d\\u00e9di\\u00e9\",\"SLA garanti\"]', NULL, NULL, 'active', 0, 3, '2025-10-23 19:25:32', '2025-10-23 19:25:32');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `wallet_id` int(11) NOT NULL,
  `type` enum('credit','debit','refund','fee') NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `balance_before` decimal(10,2) NOT NULL,
  `balance_after` decimal(10,2) NOT NULL,
  `description` text DEFAULT NULL,
  `reference` varchar(100) DEFAULT NULL,
  `order_id` varchar(100) DEFAULT NULL,
  `status` enum('pending','completed','failed','cancelled') DEFAULT 'completed',
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `wallet_id`, `type`, `amount`, `balance_before`, `balance_after`, `description`, `reference`, `order_id`, `status`, `created_by`, `created_at`) VALUES
(1, 3, 'credit', 1000.00, 0.00, 1000.00, '', 'CREDIT-1761264961-3', NULL, 'completed', 1, '2025-10-24 00:16:01');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `preferred_currency` varchar(3) DEFAULT 'EUR',
  `language` varchar(5) DEFAULT 'fr',
  `theme` varchar(20) DEFAULT 'light',
  `role_id` int(11) DEFAULT 3,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `email_verified` tinyint(1) DEFAULT 0,
  `last_login` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `full_name`, `phone`, `company`, `profile_picture`, `preferred_currency`, `language`, `theme`, `role_id`, `status`, `email_verified`, `last_login`, `created_at`, `updated_at`) VALUES
(1, 'haddoud.amine@hotmail.com', '$2y$10$0a7Mz8kl4LY61IO7M51vXuDnkIwDVjkjKgMDh5ICeN0k0Lnn.FLEC', 'Amine', NULL, NULL, NULL, 'EUR', 'fr', 'light', 1, 'active', 1, '2025-10-24 05:29:44', '2025-10-23 17:37:16', '2025-10-24 05:29:44'),
(2, 'hhdhxhdjfk@gmail.com', '$2y$10$ykCaQYvts2vrJ/VsgOFcWOdtzVALwfQOAVDkgBZQB5dZlDFcfyutC', 'employé', '0541029808', 'Prototype', NULL, 'EUR', 'fr', 'light', 4, 'active', 0, '2025-10-24 07:55:04', '2025-10-23 17:39:11', '2025-10-24 07:55:04'),
(3, 'clienttest@gmail.com', '$2y$10$/8ukSNDKS0381wNhaIrrz.QkqFjU1dZKpc2UR6kpaIdedWPStIDu2', 'clienttest', '141241', '', NULL, 'EUR', 'fr', 'light', 3, 'active', 0, NULL, '2025-10-23 19:08:42', '2025-10-23 19:08:42');

-- --------------------------------------------------------

--
-- Table structure for table `user_permissions`
--

CREATE TABLE `user_permissions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `granted_at` timestamp NULL DEFAULT current_timestamp(),
  `granted_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_permissions`
--

INSERT INTO `user_permissions` (`id`, `user_id`, `permission_id`, `granted_at`, `granted_by`) VALUES
(1, 1, 36, '2025-10-23 17:57:56', NULL),
(2, 1, 37, '2025-10-23 17:57:56', NULL),
(3, 1, 38, '2025-10-23 17:57:56', NULL),
(4, 1, 35, '2025-10-23 17:57:56', NULL),
(5, 1, 12, '2025-10-23 17:57:56', NULL),
(6, 1, 13, '2025-10-23 17:57:56', NULL),
(7, 1, 17, '2025-10-23 17:57:56', NULL),
(8, 1, 15, '2025-10-23 17:57:56', NULL),
(9, 1, 14, '2025-10-23 17:57:56', NULL),
(10, 1, 16, '2025-10-23 17:57:56', NULL),
(11, 1, 30, '2025-10-23 17:57:56', NULL),
(12, 1, 31, '2025-10-23 17:57:56', NULL),
(13, 1, 33, '2025-10-23 17:57:56', NULL),
(14, 1, 32, '2025-10-23 17:57:56', NULL),
(15, 1, 34, '2025-10-23 17:57:56', NULL),
(16, 1, 2, '2025-10-23 17:57:56', NULL),
(17, 1, 1, '2025-10-23 17:57:56', NULL),
(18, 1, 21, '2025-10-23 17:57:56', NULL),
(19, 1, 25, '2025-10-23 17:57:56', NULL),
(20, 1, 22, '2025-10-23 17:57:56', NULL),
(21, 1, 24, '2025-10-23 17:57:56', NULL),
(22, 1, 23, '2025-10-23 17:57:56', NULL),
(23, 1, 26, '2025-10-23 17:57:56', NULL),
(24, 1, 29, '2025-10-23 17:57:56', NULL),
(25, 1, 28, '2025-10-23 17:57:56', NULL),
(26, 1, 27, '2025-10-23 17:57:56', NULL),
(27, 1, 3, '2025-10-23 17:57:56', NULL),
(28, 1, 5, '2025-10-23 17:57:56', NULL),
(29, 1, 4, '2025-10-23 17:57:56', NULL),
(30, 1, 6, '2025-10-23 17:57:56', NULL),
(31, 1, 11, '2025-10-23 17:57:56', NULL),
(32, 1, 7, '2025-10-23 17:57:56', NULL),
(33, 1, 8, '2025-10-23 17:57:56', NULL),
(34, 1, 9, '2025-10-23 17:57:56', NULL),
(35, 1, 10, '2025-10-23 17:57:56', NULL),
(36, 1, 18, '2025-10-23 17:57:56', NULL),
(37, 1, 19, '2025-10-23 17:57:56', NULL),
(38, 1, 20, '2025-10-23 17:57:56', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_sessions`
--

CREATE TABLE `user_sessions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `session_token` varchar(255) NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_sessions`
--

INSERT INTO `user_sessions` (`id`, `user_id`, `session_token`, `ip_address`, `user_agent`, `expires_at`, `created_at`) VALUES
(1, 1, 'dcdfb4dbbbcfafa7a7fe29bf630bf2357946301bf06a82488ed8da6274f1d4c8', '105.102.150.50', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-22 17:37:25', '2025-10-23 17:37:25'),
(7, 1, '0f084808e3ad0453b67471c1775d1ca19ca23abbf137ad6f92c061528f76db0e', '105.102.150.50', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', '2025-11-22 19:29:37', '2025-10-23 19:29:37'),
(12, 2, '1c5945ff5bc08a6da27c45a22f014018cbbebaba26fd900772d3eda61ec8ab98', '105.102.150.50', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-22 21:39:15', '2025-10-23 21:39:15'),
(25, 3, 'b05f496255356206f86db0ab390b27d121f750facddd27342229c235a8cd5f97', '105.102.150.50', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-23 01:08:40', '2025-10-24 01:08:40'),
(26, 2, 'd4a9050863a41fafe02df3243012fb14d0974c6ad329f0ca371f4ebda26128ba', '105.102.150.50', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-23 01:59:32', '2025-10-24 01:59:32'),
(27, 2, '93ac037b2d6c2949a497445749cab87fe83455f5b19e4bce1dc9f446face2017', '105.102.150.50', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-23 02:49:55', '2025-10-24 02:49:55'),
(28, 1, 'de3e4179f0dfc557bc4ae7816c290c0fe47f43e2e4633db8966d13528075f7f8', '105.99.8.220', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-23 05:19:37', '2025-10-24 05:19:37'),
(29, 1, '2b9a270c0ae4808562c81681b0847d2dd908375ae3e1bb193c90e77901f979b0', '105.99.8.220', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-23 05:25:35', '2025-10-24 05:25:35'),
(30, 1, 'a1eec756b0c8795d66fadc8f95d4f80b7534628f58bf010703dee51e5eed4a22', '105.99.8.220', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-23 05:27:11', '2025-10-24 05:27:11'),
(31, 1, 'c1138bc0c89f12ad1ad48d401fe88f0214388220d7ca3f0e79d101efc34bd80d', '105.99.8.220', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-23 05:29:44', '2025-10-24 05:29:44'),
(32, 3, '03211557715dab606f6a4f1f0536981441ba2031f840e51466b33cb57fd44cab', '105.99.8.220', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-23 05:30:03', '2025-10-24 05:30:03'),
(33, 2, '864a83b48f224bd64ac10359a4e2b8e6a627425a1ce114b90bf42748f47aa9bb', '105.99.8.220', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-23 05:50:02', '2025-10-24 05:50:02'),
(34, 2, 'c5e71457bf0e517ee340ac9f6091624a223fea8c4f6cce17b6689b384e4a6556', '105.99.8.220', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-23 07:55:04', '2025-10-24 07:55:04');

-- --------------------------------------------------------

--
-- Table structure for table `wallets`
--

CREATE TABLE `wallets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `balance` decimal(10,2) DEFAULT 0.00,
  `currency` varchar(3) DEFAULT 'EUR',
  `status` enum('active','frozen','closed') DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `wallets`
--

INSERT INTO `wallets` (`id`, `user_id`, `balance`, `currency`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 0.00, 'EUR', 'active', '2025-10-23 17:37:16', '2025-10-23 17:37:16'),
(2, 2, 0.00, 'EUR', 'active', '2025-10-23 17:39:11', '2025-10-23 17:39:11'),
(3, 3, 881.05, 'EUR', 'active', '2025-10-23 19:08:42', '2025-10-24 05:53:55');

-- --------------------------------------------------------

--
-- Table structure for table `wallet_transactions`
--

CREATE TABLE `wallet_transactions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` enum('credit','debit') NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `wallet_transactions`
--

INSERT INTO `wallet_transactions` (`id`, `user_id`, `type`, `amount`, `description`, `created_at`) VALUES
(1, 3, 'debit', 15.99, 'Commande: Netflix (ORD-20251024-39E6C1)', '2025-10-24 00:27:08'),
(2, 3, 'debit', 15.99, 'Commande: Netflix (ORD-20251024-F136C2)', '2025-10-24 00:38:20'),
(3, 3, 'debit', 15.99, 'Commande: Netflix (ORD-20251024-A4E5D0)', '2025-10-24 00:49:30'),
(4, 3, 'debit', 15.99, 'Commande: Netflix (ORD-20251024-13C69D)', '2025-10-24 00:54:19'),
(5, 3, 'debit', 54.99, 'Commande: Adobe Creative Cloud (ORD-20251024-947BC8)', '2025-10-24 05:53:55');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `branding_projects`
--
ALTER TABLE `branding_projects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id` (`client_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_read` (`is_read`),
  ADD KEY `idx_created` (`created_at`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_number` (`order_number`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_item` (`item_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_order_number` (`order_number`);

--
-- Indexes for table `order_files`
--
ALTER TABLE `order_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_order` (`order_id`);

--
-- Indexes for table `order_messages`
--
ALTER TABLE `order_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_order` (`order_id`),
  ADD KEY `idx_created` (`created_at`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `product_downloads`
--
ALTER TABLE `product_downloads`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `download_token` (`download_token`),
  ADD KEY `idx_order` (`order_id`),
  ADD KEY `idx_token` (`download_token`);

--
-- Indexes for table `product_stock`
--
ALTER TABLE `product_stock`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_item` (`item_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_sold_to` (`sold_to_user_id`);

--
-- Indexes for table `project_files`
--
ALTER TABLE `project_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `idx_name` (`name`);

--
-- Indexes for table `shop_categories`
--
ALTER TABLE `shop_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `idx_type` (`type`),
  ADD KEY `idx_slug` (`slug`),
  ADD KEY `idx_active` (`is_active`);

--
-- Indexes for table `shop_items`
--
ALTER TABLE `shop_items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_category` (`category_id`),
  ADD KEY `idx_type` (`type`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_featured` (`featured`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_plan_id` (`plan_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_next_billing` (`next_billing_date`);

--
-- Indexes for table `subscription_history`
--
ALTER TABLE `subscription_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_subscription_id` (`subscription_id`),
  ADD KEY `idx_action` (`action`);

--
-- Indexes for table `subscription_items`
--
ALTER TABLE `subscription_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_subscription_id` (`subscription_id`),
  ADD KEY `idx_item_type` (`item_type`);

--
-- Indexes for table `subscription_plans`
--
ALTER TABLE `subscription_plans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_price` (`price`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_wallet_id` (`wallet_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `role_id` (`role_id`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `user_permissions`
--
ALTER TABLE `user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_permission` (`user_id`,`permission_id`),
  ADD KEY `permission_id` (`permission_id`),
  ADD KEY `granted_by` (`granted_by`);

--
-- Indexes for table `user_sessions`
--
ALTER TABLE `user_sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `session_token` (`session_token`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `idx_session_token` (`session_token`);

--
-- Indexes for table `wallets`
--
ALTER TABLE `wallets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- Indexes for table `wallet_transactions`
--
ALTER TABLE `wallet_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_created` (`created_at`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `branding_projects`
--
ALTER TABLE `branding_projects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `order_files`
--
ALTER TABLE `order_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_messages`
--
ALTER TABLE `order_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT for table `product_downloads`
--
ALTER TABLE `product_downloads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `product_stock`
--
ALTER TABLE `product_stock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `project_files`
--
ALTER TABLE `project_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `shop_categories`
--
ALTER TABLE `shop_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `shop_items`
--
ALTER TABLE `shop_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscription_history`
--
ALTER TABLE `subscription_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscription_items`
--
ALTER TABLE `subscription_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscription_plans`
--
ALTER TABLE `subscription_plans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user_permissions`
--
ALTER TABLE `user_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT for table `user_sessions`
--
ALTER TABLE `user_sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `wallets`
--
ALTER TABLE `wallets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `wallet_transactions`
--
ALTER TABLE `wallet_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `branding_projects`
--
ALTER TABLE `branding_projects`
  ADD CONSTRAINT `branding_projects_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`);

--
-- Constraints for table `order_files`
--
ALTER TABLE `order_files`
  ADD CONSTRAINT `order_files_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_messages`
--
ALTER TABLE `order_messages`
  ADD CONSTRAINT `order_messages_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_downloads`
--
ALTER TABLE `product_downloads`
  ADD CONSTRAINT `product_downloads_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_stock`
--
ALTER TABLE `product_stock`
  ADD CONSTRAINT `product_stock_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `shop_items` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `project_files`
--
ALTER TABLE `project_files`
  ADD CONSTRAINT `project_files_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `branding_projects` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `shop_items`
--
ALTER TABLE `shop_items`
  ADD CONSTRAINT `shop_items_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `shop_categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `shop_items_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD CONSTRAINT `subscriptions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `subscriptions_ibfk_2` FOREIGN KEY (`plan_id`) REFERENCES `subscription_plans` (`id`);

--
-- Constraints for table `subscription_history`
--
ALTER TABLE `subscription_history`
  ADD CONSTRAINT `subscription_history_ibfk_1` FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `subscription_history_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `subscription_items`
--
ALTER TABLE `subscription_items`
  ADD CONSTRAINT `subscription_items_ibfk_1` FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`wallet_id`) REFERENCES `wallets` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Constraints for table `user_permissions`
--
ALTER TABLE `user_permissions`
  ADD CONSTRAINT `user_permissions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_permissions_ibfk_3` FOREIGN KEY (`granted_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `user_sessions`
--
ALTER TABLE `user_sessions`
  ADD CONSTRAINT `user_sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `wallets`
--
ALTER TABLE `wallets`
  ADD CONSTRAINT `wallets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
