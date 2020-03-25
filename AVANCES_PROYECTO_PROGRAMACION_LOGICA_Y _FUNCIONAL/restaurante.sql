-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-03-2020 a las 22:15:22
-- Versión del servidor: 10.4.8-MariaDB
-- Versión de PHP: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `restaurante`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estados`
--

CREATE TABLE `estados` (
  `idEstado` int(11) NOT NULL,
  `nombreEstado` varchar(300) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='guarada los estados de los productos y usuarios';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `insumos`
--

CREATE TABLE `insumos` (
  `idInsumo` int(11) NOT NULL,
  `nombre` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `cantidad` double NOT NULL,
  `precioUnitario` double NOT NULL,
  `importe` double NOT NULL,
  `fecha` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `listapedidos`
--

CREATE TABLE `listapedidos` (
  `idListaPedidos` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `total` double NOT NULL,
  `fecha` date NOT NULL DEFAULT current_timestamp(),
  `fk_PlatilloBebida` int(11) NOT NULL,
  `fk_Pedidos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migration`
--

CREATE TABLE `migration` (
  `version` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `apply_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `migration`
--

INSERT INTO `migration` (`version`, `apply_time`) VALUES
('m000000_000000_base', 1584908385),
('m130524_201442_init', 1584908395),
('m190124_110200_add_verification_token_column_to_user_table', 1584908395);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `idListaPedidos` int(11) NOT NULL,
  `dirreccion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `platillobebida`
--

CREATE TABLE `platillobebida` (
  `idBebidaPlatillo` int(11) NOT NULL,
  `nombre` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `Descripcion` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `img` varchar(400) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fk_Estado` int(11) NOT NULL,
  `fk_precio` int(11) NOT NULL,
  `tipoPlatilloBebida` enum('Platillo','Bebida','','') COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `precio`
--

CREATE TABLE `precio` (
  `idPrecio` int(11) NOT NULL,
  `precioFinal` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `auth_key` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_reset_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT 10,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  `verification_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`id`, `username`, `auth_key`, `password_hash`, `password_reset_token`, `email`, `status`, `created_at`, `updated_at`, `verification_token`) VALUES
(1, 'limbergh', '0N2BcTPHFAC_v8FZi2oXclTaN5G05Un3', '$2y$13$VH./iNbWYaarRh37pDKLK.Yhgl8gxXxEX0xdkyGgBn1SFausLg7ve', NULL, 'limbergh@gmail.com', 10, 1584909554, 1584909554, 'a4Ju8-FSE7bBWBtCg40486IpneR9QjKM_1584909553');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `idVentas` int(11) NOT NULL,
  `total` double NOT NULL,
  `fecha` date NOT NULL DEFAULT current_timestamp(),
  `fk_idusuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `estados`
--
ALTER TABLE `estados`
  ADD PRIMARY KEY (`idEstado`);

--
-- Indices de la tabla `insumos`
--
ALTER TABLE `insumos`
  ADD PRIMARY KEY (`idInsumo`);

--
-- Indices de la tabla `listapedidos`
--
ALTER TABLE `listapedidos`
  ADD PRIMARY KEY (`idListaPedidos`),
  ADD KEY `fk_Pedidos` (`fk_Pedidos`),
  ADD KEY `fk_PlatilloBebida` (`fk_PlatilloBebida`);

--
-- Indices de la tabla `migration`
--
ALTER TABLE `migration`
  ADD PRIMARY KEY (`version`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`idListaPedidos`);

--
-- Indices de la tabla `platillobebida`
--
ALTER TABLE `platillobebida`
  ADD PRIMARY KEY (`idBebidaPlatillo`),
  ADD KEY `fk_Estado` (`fk_Estado`),
  ADD KEY `fk_precio` (`fk_precio`);

--
-- Indices de la tabla `precio`
--
ALTER TABLE `precio`
  ADD PRIMARY KEY (`idPrecio`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `password_reset_token` (`password_reset_token`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`idVentas`),
  ADD KEY `fk_idusuario` (`fk_idusuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `estados`
--
ALTER TABLE `estados`
  MODIFY `idEstado` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `insumos`
--
ALTER TABLE `insumos`
  MODIFY `idInsumo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `listapedidos`
--
ALTER TABLE `listapedidos`
  MODIFY `idListaPedidos` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `idListaPedidos` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `platillobebida`
--
ALTER TABLE `platillobebida`
  MODIFY `idBebidaPlatillo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `precio`
--
ALTER TABLE `precio`
  MODIFY `idPrecio` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `idVentas` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `listapedidos`
--
ALTER TABLE `listapedidos`
  ADD CONSTRAINT `listapedidos_ibfk_1` FOREIGN KEY (`fk_Pedidos`) REFERENCES `pedidos` (`idListaPedidos`),
  ADD CONSTRAINT `listapedidos_ibfk_2` FOREIGN KEY (`fk_PlatilloBebida`) REFERENCES `platillobebida` (`idBebidaPlatillo`);

--
-- Filtros para la tabla `platillobebida`
--
ALTER TABLE `platillobebida`
  ADD CONSTRAINT `platillobebida_ibfk_1` FOREIGN KEY (`fk_Estado`) REFERENCES `estados` (`idEstado`) ON UPDATE CASCADE,
  ADD CONSTRAINT `platillobebida_ibfk_2` FOREIGN KEY (`fk_precio`) REFERENCES `precio` (`idPrecio`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`fk_idusuario`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
