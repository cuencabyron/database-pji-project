-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 26-11-2025 a las 05:11:57
-- Versión del servidor: 9.1.0
-- Versión de PHP: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `portal_pji_project`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `customer`
--

DROP TABLE IF EXISTS `customer`;
CREATE TABLE IF NOT EXISTS `customer` (
  `customer_id` char(36) NOT NULL,
  `name` varchar(200) NOT NULL,
  `email` varchar(254) NOT NULL,
  `phone` varchar(25) NOT NULL,
  `address` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `customer`
--

INSERT INTO `customer` (`customer_id`, `name`, `email`, `phone`, `address`, `active`, `created_at`, `updated_at`) VALUES
('1626806f-cfc5-441a-a63f-6a1a5f3e072c', 'Juan Pérez', 'juan.perez@gmail.mx', '5512345678', 'Av. Reforma 200, CDMX', 1, '2025-11-25 13:01:15', '2025-11-25 13:01:15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `payment`
--

DROP TABLE IF EXISTS `payment`;
CREATE TABLE IF NOT EXISTS `payment` (
  `payment_id` char(36) NOT NULL,
  `customer_id` char(36) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `currency` char(3) NOT NULL DEFAULT 'MXN',
  `method` varchar(30) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pending',
  `external_ref` varchar(100) NOT NULL,
  `paid_at` datetime NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`payment_id`),
  KEY `fk_customer_payment` (`customer_id`)
) ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `service`
--

DROP TABLE IF EXISTS `service`;
CREATE TABLE IF NOT EXISTS `service` (
  `service_id` char(36) NOT NULL,
  `customer_id` char(36) NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`service_id`),
  KEY `fk_customer_service` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `service_price_range`
--

DROP TABLE IF EXISTS `service_price_range`;
CREATE TABLE IF NOT EXISTS `service_price_range` (
  `range_id` char(36) NOT NULL,
  `service_id` char(36) NOT NULL,
  `min_monthly_rent` decimal(12,2) NOT NULL,
  `max_monthly_rent` decimal(12,2) NOT NULL,
  `annual_price` decimal(12,2) NOT NULL,
  `currency` char(3) NOT NULL DEFAULT 'MXN',
  `description` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`range_id`),
  KEY `fk_range_service` (`service_id`)
) ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `session`
--

DROP TABLE IF EXISTS `session`;
CREATE TABLE IF NOT EXISTS `session` (
  `session_id` char(36) NOT NULL,
  `customer_id` char(36) NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `started_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ended_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`session_id`),
  KEY `fk_customer_session` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `session`
--

INSERT INTO `session` (`session_id`, `customer_id`, `user_agent`, `status`, `started_at`, `ended_at`, `created_at`, `updated_at`) VALUES
('3d4dce6d-ce65-4ed4-bfdb-10ee75fbc404', '1626806f-cfc5-441a-a63f-6a1a5f3e072c', 'Chrome/119 Win10', 'ended', '2025-11-25 16:14:53', '2025-11-25 16:14:53', '2025-11-25 16:14:53', '2025-11-25 16:14:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `verification`
--

DROP TABLE IF EXISTS `verification`;
CREATE TABLE IF NOT EXISTS `verification` (
  `verification_id` char(36) NOT NULL,
  `customer_id` char(36) NOT NULL,
  `session_id` char(36) NOT NULL,
  `payment_id` char(35) NOT NULL,
  `type` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'pending',
  `attempts` int NOT NULL DEFAULT '0',
  `expires_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `verified_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`verification_id`),
  KEY `fk_payment_verification` (`payment_id`),
  KEY `fk_customer_verification` (`customer_id`),
  KEY `fk_session_verification` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `fk_customer_payment` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`);

--
-- Filtros para la tabla `service`
--
ALTER TABLE `service`
  ADD CONSTRAINT `fk_customer_service` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`);

--
-- Filtros para la tabla `service_price_range`
--
ALTER TABLE `service_price_range`
  ADD CONSTRAINT `fk_range_service` FOREIGN KEY (`service_id`) REFERENCES `service` (`service_id`);

--
-- Filtros para la tabla `session`
--
ALTER TABLE `session`
  ADD CONSTRAINT `fk_customer_session` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`);

--
-- Filtros para la tabla `verification`
--
ALTER TABLE `verification`
  ADD CONSTRAINT `fk_customer_verification` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `fk_payment_verification` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`payment_id`),
  ADD CONSTRAINT `fk_session_verification` FOREIGN KEY (`session_id`) REFERENCES `session` (`session_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
