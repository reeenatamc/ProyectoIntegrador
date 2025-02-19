-- Crear un nuevo usuario.
CREATE USER 'pi_user'@'localhost' IDENTIFIED BY 'renata15';

-- Conceder permisos.
GRANT ALL PRIVILEGES ON pi_db.* TO 'pi_user'@'localhost';

-- Aplicar los cambios
FLUSH PRIVILEGES;

-- Crear la base de datos y tablas 
CREATE DATABASE IF NOT EXISTS `pi_db`
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;

USE `pi_db`;

CREATE TABLE IF NOT EXISTS `tipo_arma` (
  `id_tipo_arma` INT NOT NULL AUTO_INCREMENT,
  `nom_tipo_arma` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_tipo_arma`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `arma` (
  `id_arma` INT NOT NULL AUTO_INCREMENT,
  `arma` VARCHAR(45) NULL DEFAULT NULL,
  `tipo_arma_id_tipo_arma` INT NOT NULL,
  PRIMARY KEY (`id_arma`),
  INDEX `fk_arma_tipo_arma1_idx` (`tipo_arma_id_tipo_arma` ASC) VISIBLE,
  CONSTRAINT `fk_arma_tipo_arma1`
    FOREIGN KEY (`tipo_arma_id_tipo_arma`)
    REFERENCES `tipo_arma` (`id_tipo_arma`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `zona` (
  `id_zona` INT NOT NULL,
  `nom_zona` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_zona`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `provincia` (
  `id_provincia` INT NOT NULL,
  `nom_provincia` VARCHAR(45) NOT NULL,
  `media_tasa_educacionbasica_poblacion` FLOAT NOT NULL,
  `media_tasa_educacionbachillerato_poblacion` FLOAT NOT NULL,
  `media_tasa_empleo_inadecuado` FLOAT NOT NULL,
  `media_tasa_pobreza_extrema` FLOAT NOT NULL,
  `media_indice_dh` FLOAT NOT NULL,
  `media_tasa_narcotrafico` FLOAT NOT NULL,
  `zona_id_zona` INT NOT NULL,
  PRIMARY KEY (`id_provincia`),
  INDEX `fk_provincia_zona1_idx` (`zona_id_zona` ASC) VISIBLE,
  CONSTRAINT `fk_provincia_zona1`
    FOREIGN KEY (`zona_id_zona`)
    REFERENCES `zona` (`id_zona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `canton` (
  `id_canton` INT NOT NULL,
  `nom_canton` VARCHAR(45) NOT NULL,
  `Provincia_id_provincia` INT NOT NULL,
  PRIMARY KEY (`id_canton`),
  INDEX `fk_Canton_Provincia1_idx` (`Provincia_id_provincia` ASC) VISIBLE,
  CONSTRAINT `fk_Canton_Provincia1`
    FOREIGN KEY (`Provincia_id_provincia`)
    REFERENCES `provincia` (`id_provincia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `distrito` (
  `id_distrito` VARCHAR(45) NOT NULL,
  `nom_distrito` VARCHAR(45) NULL DEFAULT NULL,
  `Zona_id_zona` INT NOT NULL,
  PRIMARY KEY (`id_distrito`),
  INDEX `fk_Distrito_Zona1_idx` (`Zona_id_zona` ASC) VISIBLE,
  CONSTRAINT `fk_Distrito_Zona1`
    FOREIGN KEY (`Zona_id_zona`)
    REFERENCES `zona` (`id_zona`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `circuito` (
  `id_circuito` VARCHAR(45) NOT NULL,
  `nom_circuito` VARCHAR(45) NULL DEFAULT NULL,
  `Distrito_id_distrito` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_circuito`),
  INDEX `fk_Circuito_Distrito1_idx` (`Distrito_id_distrito` ASC) VISIBLE,
  CONSTRAINT `fk_Circuito_Distrito1`
    FOREIGN KEY (`Distrito_id_distrito`)
    REFERENCES `distrito` (`id_distrito`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `nacionalidad` (
  `id_nacionalidad` INT NOT NULL AUTO_INCREMENT,
  `nombre_nacionalidad` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_nacionalidad`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `detenido` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `edad` INT NOT NULL,
  `sexo` VARCHAR(45) NULL DEFAULT NULL,
  `genero` VARCHAR(45) NULL DEFAULT NULL,
  `estado_civil` VARCHAR(45) NULL DEFAULT NULL,
  `nivel_instruccion` VARCHAR(45) NULL DEFAULT NULL,
  `estatus_migratorio` VARCHAR(45) NULL DEFAULT NULL,
  `num_detenciones` INT NOT NULL DEFAULT '-1',
  `autoidentificacion_etnica` VARCHAR(45) NULL DEFAULT NULL,
  `codigo_icc` VARCHAR(45) NULL DEFAULT NULL,
  `Nacionalidad_id_nacionalidad` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Detenido_Nacionalidad_idx` (`Nacionalidad_id_nacionalidad` ASC) VISIBLE,
  CONSTRAINT `fk_Detenido_Nacionalidad`
    FOREIGN KEY (`Nacionalidad_id_nacionalidad`)
    REFERENCES `nacionalidad` (`id_nacionalidad`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `subcircuito` (
  `id_subcircuito` VARCHAR(45) NOT NULL,
  `nom_subcircuito` VARCHAR(45) NULL DEFAULT NULL,
  `Circuito_id_circuito` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_subcircuito`),
  INDEX `fk_Subcircuito_Circuito1_idx` (`Circuito_id_circuito` ASC) VISIBLE,
  CONSTRAINT `fk_Subcircuito_Circuito1`
    FOREIGN KEY (`Circuito_id_circuito`)
    REFERENCES `circuito` (`id_circuito`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `detencion` (
  `id_detencion` INT NOT NULL AUTO_INCREMENT,
  `fecha_detencion` DATE NULL DEFAULT NULL,
  `hora_detencion` TIME NULL DEFAULT NULL,
  `tipo` VARCHAR(45) NOT NULL DEFAULT 'SIN DATO',
  `condicion` TEXT NULL DEFAULT NULL,
  `movilizacion` TEXT NULL DEFAULT NULL,
  `presunta_flagrancia` VARCHAR(45) NOT NULL DEFAULT 'SIN DATO',
  `presunta_modalidad` TEXT NULL DEFAULT NULL,
  `flagrante_boleta` VARCHAR(45) NOT NULL DEFAULT 'SIN DATO',
  `lugar` TEXT NULL DEFAULT NULL,
  `tipo_lugar` TEXT NULL DEFAULT NULL,
  `infraccion` TEXT NULL DEFAULT NULL,
  `subinfraccion` TEXT NULL DEFAULT NULL,
  `anio` VARCHAR(45) NULL DEFAULT NULL,
  `Detenido_id` INT NOT NULL,
  `arma_id_arma` INT NOT NULL,
  `Subcircuito_id_subcircuito` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_detencion`),
  INDEX `fk_Detencion_Detenido1_idx` (`Detenido_id` ASC) VISIBLE,
  INDEX `fk_Detencion_arma1_idx` (`arma_id_arma` ASC) VISIBLE,
  INDEX `fk_Detencion_Subcircuito1_idx` (`Subcircuito_id_subcircuito` ASC) VISIBLE,
  CONSTRAINT `fk_Detencion_arma1`
    FOREIGN KEY (`arma_id_arma`)
    REFERENCES `arma` (`id_arma`),
  CONSTRAINT `fk_Detencion_Detenido1`
    FOREIGN KEY (`Detenido_id`)
    REFERENCES `detenido` (`id`),
  CONSTRAINT `fk_Detencion_Subcircuito1`
    FOREIGN KEY (`Subcircuito_id_subcircuito`)
    REFERENCES `subcircuito` (`id_subcircuito`)),
  CONSTRAINT `tipo_restrict`
    CHECK (`tipo` IN ('DETENIDO', 'APREHENDIDO', 'SIN DATO')),
  CONSTRAINT `flagrante_boleta_restrict`
    CHECK (`flagrante_boleta` IN ('FLAGRANTE', 'BOLETA', 'SIN DATO')),
  CONSTRAINT `presunta_flagrancia_restrict`
    CHECK (`presunta_flagrancia` IN ('SI', 'NO', 'SIN DATO'))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `parroquia` (
  `id_parroquia` INT NOT NULL AUTO_INCREMENT,
  `nom_parroquia` VARCHAR(80) NULL DEFAULT NULL,
  `Canton_id_canton` INT NOT NULL,
  PRIMARY KEY (`id_parroquia`),
  INDEX `fk_Parroquia_Canton1_idx` (`Canton_id_canton` ASC) VISIBLE,
  CONSTRAINT `fk_Parroquia_Canton1`
    FOREIGN KEY (`Canton_id_canton`)
    REFERENCES `canton` (`id_canton`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

ALTER TABLE `detenido`
  MODIFY COLUMN `num_detenciones` INT NOT NULL DEFAULT '-1',
  ADD CONSTRAINT `num_detenciones_restrict`
    CHECK (`num_detenciones` >= -1);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
