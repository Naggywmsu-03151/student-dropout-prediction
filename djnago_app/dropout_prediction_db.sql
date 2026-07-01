-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 01, 2026 at 05:34 PM
-- Server version: 12.3.2-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dropout_prediction_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add prediction record', 7, 'add_predictionrecord'),
(26, 'Can change prediction record', 7, 'change_predictionrecord'),
(27, 'Can delete prediction record', 7, 'delete_predictionrecord'),
(28, 'Can view prediction record', 7, 'view_predictionrecord');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$1000000$R7EitT9GmR9zV2yRaR91M1$bDP0QUx3jBsYx3C7++yOgi+jp6KoF4BkNJIz1eCf9rQ=', '2026-07-01 15:20:31.262709', 1, 'naggymuhadja', '', '', 'naggy@gmail.com', 1, 1, '2026-07-01 15:14:48.177916');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(7, 'predictor', 'predictionrecord'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2026-07-01 15:14:09.962383'),
(2, 'auth', '0001_initial', '2026-07-01 15:14:10.265964'),
(3, 'admin', '0001_initial', '2026-07-01 15:14:10.330074'),
(4, 'admin', '0002_logentry_remove_auto_add', '2026-07-01 15:14:10.334301'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2026-07-01 15:14:10.338348'),
(6, 'contenttypes', '0002_remove_content_type_name', '2026-07-01 15:14:10.383140'),
(7, 'auth', '0002_alter_permission_name_max_length', '2026-07-01 15:14:10.419203'),
(8, 'auth', '0003_alter_user_email_max_length', '2026-07-01 15:14:10.436217'),
(9, 'auth', '0004_alter_user_username_opts', '2026-07-01 15:14:10.440902'),
(10, 'auth', '0005_alter_user_last_login_null', '2026-07-01 15:14:10.473134'),
(11, 'auth', '0006_require_contenttypes_0002', '2026-07-01 15:14:10.474448'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2026-07-01 15:14:10.478871'),
(13, 'auth', '0008_alter_user_username_max_length', '2026-07-01 15:14:10.497949'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2026-07-01 15:14:10.517578'),
(15, 'auth', '0010_alter_group_name_max_length', '2026-07-01 15:14:10.538198'),
(16, 'auth', '0011_update_proxy_permissions', '2026-07-01 15:14:10.544227'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2026-07-01 15:14:10.566402'),
(18, 'predictor', '0001_initial', '2026-07-01 15:14:10.604433'),
(19, 'sessions', '0001_initial', '2026-07-01 15:14:10.630227');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('3fcuh3xj0jvcv3r5sxmblbboicghw5gx', '.eJxVjDkOwjAQAP-yNbISx3a8Kenzhsh7gAPIlnJUiL-jSCmgnRnNG6a0b3naV12mWWCAFi6_jBI_tRxCHqncq-FatmUmcyTmtKsZq-jrerZ_g5zWDAOodx6tqHBPGqnDSNK7jhw7Yo9ohUOrllzTBU4YvVgXQtMzqm1uFuHzBfYLN-U:1wewgk:0dTNBhyW1pMF8Xx8Ifk5lluj3NWuo08q_X4um8hTguM', '2026-07-15 15:17:22.286585'),
('abgmimxgsasa7e2s04k5fulnmeulx47b', '.eJxVjDkOwjAQAP-yNbISx3a8Kenzhsh7gAPIlnJUiL-jSCmgnRnNG6a0b3naV12mWWCAFi6_jBI_tRxCHqncq-FatmUmcyTmtKsZq-jrerZ_g5zWDAOodx6tqHBPGqnDSNK7jhw7Yo9ohUOrllzTBU4YvVgXQtMzqm1uFuHzBfYLN-U:1wewjn:u0J9jSktAmyvNvUBQYyfiWBBBXr-sFz3adi541VsyM4', '2026-07-15 15:20:31.265491');

-- --------------------------------------------------------

--
-- Table structure for table `predictor_predictionrecord`
--

CREATE TABLE `predictor_predictionrecord` (
  `id` bigint(20) NOT NULL,
  `student_name` varchar(150) NOT NULL,
  `student_number` varchar(50) NOT NULL,
  `age` double NOT NULL,
  `gender` int(11) NOT NULL,
  `family_income` double NOT NULL,
  `internet_access` int(11) NOT NULL,
  `study_hours_per_day` double NOT NULL,
  `attendance_rate` double NOT NULL,
  `assignment_delay_days` double NOT NULL,
  `travel_time_minutes` double NOT NULL,
  `part_time_job` int(11) NOT NULL,
  `scholarship` int(11) NOT NULL,
  `stress_index` double NOT NULL,
  `gpa` double NOT NULL,
  `semester_gpa` double NOT NULL,
  `cgpa` double NOT NULL,
  `semester` int(11) NOT NULL,
  `department` int(11) NOT NULL,
  `parental_education` int(11) NOT NULL,
  `dropout_probability` double NOT NULL,
  `predicted_class` int(11) NOT NULL,
  `risk_level` varchar(10) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `predictor_predictionrecord`
--

INSERT INTO `predictor_predictionrecord` (`id`, `student_name`, `student_number`, `age`, `gender`, `family_income`, `internet_access`, `study_hours_per_day`, `attendance_rate`, `assignment_delay_days`, `travel_time_minutes`, `part_time_job`, `scholarship`, `stress_index`, `gpa`, `semester_gpa`, `cgpa`, `semester`, `department`, `parental_education`, `dropout_probability`, `predicted_class`, `risk_level`, `created_at`, `created_by_id`) VALUES
(1, 'Sultan Rahim', '2026-5557', 18, 1, 55741, 0, 4.7, 0.86, 0, 8, 0, 0, 1.9, 2.54, 2.43, 2.56, 1, 4, 3, 0.3830141008676564, 0, 'MEDIUM', '2026-07-01 15:14:57.816755', 1),
(2, 'Hakim Hassan', '2026-5803', 22, 0, 34110, 0, 3.1, 0.96, 2, 53, 0, 1, 3.8, 2.51, 2.65, 2.53, 0, 3, 0, 0.7094391446909604, 1, 'HIGH', '2026-07-01 15:14:57.823681', 1),
(3, 'Halima Yasin', '2026-5374', 21, 0, 34935, 0, 2.2, 0.97, 0, 17, 1, 1, 3.3, 3.43, 3.41, 3.5, 1, 2, 2, 0.31324145500445555, 0, 'LOW', '2026-07-01 15:14:57.827774', 1),
(4, 'Halima Yasin', '2026-9179', 21, 0, 44867, 1, 2.7, 0.81, 1, 12, 0, 0, 3.5, 3.53, 3.65, 3.51, 0, 1, 2, 0.2821033385166981, 0, 'LOW', '2026-07-01 15:14:57.831458', 1),
(5, 'Aina Yasin', '2026-7916', 21, 1, 55322, 1, 5, 0.89, 1, 51, 0, 0, 2.1, 3.87, 3.87, 3.79, 0, 0, 1, 0.20539250884716354, 0, 'LOW', '2026-07-01 15:14:57.834988', 1),
(6, 'Tariq Hassan', '2026-5889', 27, 0, 20752, 1, 5.9, 0.92, 2, 87, 1, 0, 2.9, 3.08, 3, 3.01, 0, 2, 1, 0.5635470488248542, 1, 'MEDIUM', '2026-07-01 15:14:57.839469', 1),
(7, 'Sultan Umar', '2026-2290', 17, 1, 54757, 1, 4.2, 0.84, 1, 7, 0, 1, 2.5, 3.26, 3.41, 3.33, 2, 1, 0, 0.2565454697477915, 0, 'LOW', '2026-07-01 15:14:57.843262', 1),
(8, 'Layla Rahim', '2026-9479', 25, 0, 17787, 1, 0.7, 0.42, 6, 72, 1, 0, 9, 1.63, 1.8, 1.68, 1, 2, 3, 0.9799001174996423, 1, 'HIGH', '2026-07-01 15:14:57.846898', 1),
(9, 'Malik Umar', '2026-8744', 18, 0, 20471, 0, 4.4, 0.81, 1, 13, 0, 1, 1.1, 2.87, 2.7, 2.82, 3, 1, 1, 0.35628129370319817, 0, 'MEDIUM', '2026-07-01 15:14:57.850440', 1),
(10, 'Halima Salih', '2026-8350', 23, 1, 16939, 0, 1.1, 0.52, 14, 88, 0, 0, 6.4, 1.61, 1.57, 1.58, 0, 1, 1, 0.9933268303425642, 1, 'HIGH', '2026-07-01 15:14:57.854781', 1),
(11, 'Hakim Abubakar', '2026-7396', 18, 0, 19016, 0, 1.2, 0.54, 5, 16, 0, 0, 9.5, 1.24, 1.2, 1.24, 3, 0, 1, 0.9758747794011527, 1, 'HIGH', '2026-07-01 15:14:57.858389', 1),
(12, 'Nur Umar', '2026-8811', 27, 1, 19105, 0, 2, 0.54, 15, 29, 1, 0, 7.7, 2.02, 2.21, 2.04, 0, 2, 0, 0.9853842411913161, 1, 'HIGH', '2026-07-01 15:14:57.862058', 1),
(13, 'Yusuf Karim', '2026-6147', 26, 0, 24490, 0, 5.4, 0.83, 0, 56, 0, 0, 4.8, 3.78, 3.81, 3.69, 0, 3, 2, 0.31457307271231205, 0, 'LOW', '2026-07-01 15:14:57.865538', 1),
(14, 'Amina Ismail', '2026-8179', 17, 1, 11188, 0, 1.9, 0.6, 9, 14, 0, 1, 7.2, 1.51, 1.36, 1.48, 0, 1, 2, 0.9722619757581963, 1, 'HIGH', '2026-07-01 15:14:57.871839', 1),
(15, 'Rashid Karim', '2026-5325', 21, 0, 56346, 0, 4.7, 0.92, 0, 38, 0, 0, 4.9, 3.56, 3.66, 3.49, 2, 4, 1, 0.30708694194428976, 0, 'LOW', '2026-07-01 15:14:57.876106', 1),
(16, 'Farida Hassan', '2026-3442', 17, 1, 22889, 0, 5.3, 0.98, 3, 86, 1, 0, 1.2, 2.88, 2.98, 2.89, 3, 4, 0, 0.5664924470838306, 1, 'MEDIUM', '2026-07-01 15:14:57.880508', 1),
(17, 'Sultan Ismail', '2026-3900', 17, 1, 43897, 0, 2.2, 0.92, 1, 36, 0, 1, 1.6, 3.75, 3.86, 3.83, 3, 4, 1, 0.22638625859866748, 0, 'LOW', '2026-07-01 15:14:57.884294', 1),
(18, 'Sultan Karim', '2026-1387', 21, 0, 36263, 0, 5.2, 0.95, 3, 53, 0, 1, 2.3, 2.54, 2.43, 2.6, 3, 2, 2, 0.6541969891271038, 1, 'MEDIUM', '2026-07-01 15:14:57.888588', 1),
(19, 'Layla Zulkifli', '2026-6139', 23, 1, 53384, 0, 3.4, 0.86, 2, 19, 1, 0, 1.3, 3.1, 3.13, 3.2, 0, 0, 3, 0.37679394512273284, 0, 'MEDIUM', '2026-07-01 15:14:57.892415', 1),
(20, 'Zara Musa', '2026-7592', 17, 0, 48577, 1, 3, 0.82, 1, 60, 0, 1, 4.6, 3.98, 4.03, 4.01, 0, 2, 2, 0.30348567780451574, 0, 'LOW', '2026-07-01 15:14:57.896118', 1),
(21, 'Bakr Yasin', '2026-4501', 26, 1, 31405, 1, 4.7, 0.84, 3, 75, 0, 1, 3.7, 3.33, 3.24, 3.32, 2, 3, 3, 0.554862645036401, 1, 'MEDIUM', '2026-07-01 15:14:57.899733', 1),
(22, 'Iman Hassan', '2026-8461', 27, 1, 63506, 0, 3.1, 0.99, 0, 35, 1, 0, 3.9, 3.69, 3.81, 3.62, 0, 1, 3, 0.2908082935575908, 0, 'LOW', '2026-07-01 15:14:57.904540', 1),
(23, 'Farida Rahim', '2026-3184', 27, 0, 29671, 0, 3.6, 0.84, 3, 59, 0, 0, 3.8, 3.44, 3.56, 3.48, 3, 0, 1, 0.5467060573461063, 1, 'MEDIUM', '2026-07-01 15:14:57.908516', 1),
(24, 'Sultan Latif', '2026-8206', 23, 1, 53081, 0, 4.5, 1, 3, 65, 1, 1, 3.4, 3.5, 3.6, 3.57, 2, 4, 3, 0.4588338104513389, 0, 'MEDIUM', '2026-07-01 15:14:57.912180', 1),
(25, 'Zara Osman', '2026-1320', 20, 1, 12471, 0, 0.6, 0.48, 12, 32, 0, 1, 7.3, 1.37, 1.33, 1.38, 3, 0, 1, 0.9897668608867942, 1, 'HIGH', '2026-07-01 15:14:57.915740', 1),
(26, 'Kamal Umar', '2026-9751', 23, 0, 45558, 1, 3.2, 0.88, 2, 33, 1, 1, 1, 3.65, 3.64, 3.63, 3, 1, 3, 0.246309045679476, 0, 'LOW', '2026-07-01 15:14:57.919960', 1),
(27, 'Yusuf Hassan', '2026-8705', 19, 0, 17564, 1, 1.1, 0.57, 14, 53, 1, 0, 6.1, 1.51, 1.49, 1.48, 3, 2, 3, 0.9892589985835978, 1, 'HIGH', '2026-07-01 15:14:57.928418', 1),
(28, 'Bakr Zulkifli', '2026-5198', 17, 0, 20678, 0, 0.6, 0.7, 14, 30, 0, 0, 7.4, 1.7, 1.6, 1.69, 0, 4, 1, 0.9875563346756624, 1, 'HIGH', '2026-07-01 15:14:57.932022', 1),
(29, 'Iman Hassan', '2026-1672', 21, 0, 30732, 0, 5.1, 0.92, 0, 44, 1, 1, 4, 2.75, 2.93, 2.69, 1, 0, 2, 0.5239935008253446, 1, 'MEDIUM', '2026-07-01 15:14:57.935515', 1),
(30, 'Bakr Osman', '2026-5397', 24, 0, 16882, 1, 0.5, 0.51, 9, 51, 1, 0, 8, 1.56, 1.53, 1.61, 2, 4, 3, 0.9831015724981572, 1, 'HIGH', '2026-07-01 15:14:57.939563', 1),
(31, 'Iman Zulkifli', '2026-5526', 26, 1, 17613, 1, 0.9, 0.68, 11, 8, 1, 1, 7.1, 1.32, 1.19, 1.26, 2, 2, 2, 0.9834094891860392, 1, 'HIGH', '2026-07-01 15:14:57.943665', 1),
(32, 'Salma Salih', '2026-9698', 24, 1, 35749, 1, 4, 0.84, 3, 7, 0, 1, 2, 3.27, 3.16, 3.31, 2, 4, 2, 0.3319971283270564, 0, 'MEDIUM', '2026-07-01 15:14:57.947342', 1),
(33, 'Farida Karim', '2026-5853', 20, 0, 14118, 0, 0.9, 0.57, 11, 45, 0, 0, 7.4, 2.3, 2.18, 2.35, 2, 4, 2, 0.9682722420489152, 1, 'HIGH', '2026-07-01 15:14:57.950951', 1),
(34, 'Rashid Ismail', '2026-1841', 25, 1, 10893, 0, 0.6, 0.4, 8, 86, 1, 0, 8.1, 1.23, 1.38, 1.24, 3, 3, 3, 0.9913165444023821, 1, 'HIGH', '2026-07-01 15:14:57.954836', 1),
(35, 'Tariq Osman', '2026-8381', 27, 0, 20312, 0, 0.6, 0.43, 11, 24, 1, 0, 6.3, 2.12, 2.32, 2.04, 3, 4, 1, 0.9614173977573529, 1, 'HIGH', '2026-07-01 15:14:57.958674', 1),
(36, 'Bakr Zulkifli', '2026-8699', 20, 0, 26503, 1, 4.4, 0.92, 0, 89, 0, 0, 2.7, 2.95, 2.85, 2.96, 1, 0, 3, 0.5413034505984269, 1, 'MEDIUM', '2026-07-01 15:14:57.962405', 1),
(37, 'Amina Umar', '2026-5728', 21, 0, 13824, 1, 0.6, 0.61, 11, 19, 0, 0, 8.8, 1.3, 1.46, 1.37, 0, 0, 1, 0.9889344237270219, 1, 'HIGH', '2026-07-01 15:14:57.966051', 1),
(38, 'Aina Rahim', '2026-9502', 24, 0, 52361, 0, 4, 0.86, 2, 60, 1, 1, 2.6, 3.2, 3.01, 3.15, 0, 2, 0, 0.49426751881744735, 0, 'MEDIUM', '2026-07-01 15:14:57.970341', 1),
(39, 'Bakr Hassan', '2026-6153', 22, 1, 50802, 1, 5.9, 0.84, 3, 46, 0, 0, 3.3, 3.87, 3.8, 3.91, 2, 3, 0, 0.2768663485265611, 0, 'LOW', '2026-07-01 15:14:57.974375', 1),
(40, 'Amina Rahim', '2026-8941', 24, 1, 18889, 0, 1.5, 0.63, 4, 29, 1, 1, 9.5, 1.15, 1.2, 1.2, 1, 2, 1, 0.9772911553119397, 1, 'HIGH', '2026-07-01 15:14:57.977938', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `predictor_predictionrecord`
--
ALTER TABLE `predictor_predictionrecord`
  ADD PRIMARY KEY (`id`),
  ADD KEY `predictor_prediction_created_by_id_bcf70ec3_fk_auth_user` (`created_by_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `predictor_predictionrecord`
--
ALTER TABLE `predictor_predictionrecord`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `predictor_predictionrecord`
--
ALTER TABLE `predictor_predictionrecord`
  ADD CONSTRAINT `predictor_prediction_created_by_id_bcf70ec3_fk_auth_user` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
