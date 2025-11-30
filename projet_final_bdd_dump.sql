-- MySQL dump 10.13  Distrib 8.0.40, for macos12.7 (arm64)
--
-- Host: 127.0.0.1    Database: projet_final_bdd
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `citation`
--

DROP TABLE IF EXISTS `citation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `citation` (
  `citation_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `text` text NOT NULL,
  `author` varchar(100) NOT NULL,
  `date_ajout` datetime NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`citation_id`),
  KEY `citation_ibfk_1` (`user_id`),
  CONSTRAINT `citation_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citation`
--

LOCK TABLES `citation` WRITE;
/*!40000 ALTER TABLE `citation` DISABLE KEYS */;
INSERT INTO `citation` VALUES (1,'Nature','La nature ne fait rien en vain.','Aristote','2025-11-23 17:21:24',1);
/*!40000 ALTER TABLE `citation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commentaire`
--

DROP TABLE IF EXISTS `commentaire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `commentaire` (
  `commentaire_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `text` text NOT NULL,
  `date` datetime NOT NULL,
  `statut` enum('en_attente','en_verification','poste') NOT NULL,
  `type_commentaire` enum('experience','aide') NOT NULL,
  `date_moderation` datetime DEFAULT NULL,
  `user_id` int NOT NULL,
  `defi_id` int DEFAULT NULL,
  PRIMARY KEY (`commentaire_id`),
  KEY `fk_commentaire_defi` (`defi_id`),
  KEY `commentaire_ibfk_1` (`user_id`),
  CONSTRAINT `commentaire_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_commentaire_defi` FOREIGN KEY (`defi_id`) REFERENCES `defi` (`defi_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commentaire`
--

LOCK TABLES `commentaire` WRITE;
/*!40000 ALTER TABLE `commentaire` DISABLE KEYS */;
INSERT INTO `commentaire` VALUES (3,'Retour de Admin','Ça m\'a permis de prendre conscience que j\'utilisais trop de plastique','2025-11-30 00:22:03','poste','experience',NULL,1,1),(4,'Retour de Matteo','Ça m\'a vraiment fait du bien, moi qui suis h24 sur les écrans.','2025-11-30 01:04:12','poste','experience',NULL,9,29);
/*!40000 ALTER TABLE `commentaire` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `defi`
--

DROP TABLE IF EXISTS `defi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `defi` (
  `defi_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `statut` enum('realisable','realise','en_attente') NOT NULL DEFAULT 'en_attente',
  `date_moderation` datetime DEFAULT NULL,
  `user_id` int NOT NULL,
  `commentaire_id` int DEFAULT NULL,
  PRIMARY KEY (`defi_id`),
  KEY `defi_ibfk_1` (`user_id`),
  KEY `defi_ibfk_2` (`commentaire_id`),
  CONSTRAINT `defi_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `defi_ibfk_2` FOREIGN KEY (`commentaire_id`) REFERENCES `commentaire` (`commentaire_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `defi`
--

LOCK TABLES `defi` WRITE;
/*!40000 ALTER TABLE `defi` DISABLE KEYS */;
INSERT INTO `defi` VALUES (1,'Zéro Plastique','Remplacer les gobelets par du verre.','realisable',NULL,1,NULL),(2,'Offrir un café','Achetez ou préparez un café pour un collègue ou un ami sans raison particulière.','realisable','2025-11-29 22:06:47',1,NULL),(3,'Message aux parents','Envoyez un message ou appelez vos parents juste pour leur dire que vous les aimez.','realisable','2025-11-29 22:06:47',1,NULL),(4,'Zéro déchet','Ramassez un déchet par terre dans la rue et jetez-le dans une poubelle.','realisable','2025-11-29 22:06:47',1,NULL),(5,'Compliment sincère','Faites un compliment sincère à un inconnu ou à un proche sur sa tenue ou son travail.','realisable','2025-11-29 22:06:47',1,NULL),(6,'Laisser sa place','Laissez votre place assise à quelqu\'un d\'autre dans les transports en commun.','realisable','2025-11-29 22:06:47',1,NULL),(10,'Le sourire contagieux','Souriez franchement à trois inconnus que vous croisez aujourd\'hui.','realisable','2025-11-30 01:51:46',1,NULL),(11,'La porte ouverte','Tenez la porte à la personne qui arrive derrière vous, même si elle est encore un peu loin.','realisable','2025-11-30 01:51:46',1,NULL),(12,'Message surprise','Envoyez un SMS bienveillant à un ami à qui vous n\'avez pas parlé depuis longtemps.','realisable','2025-11-30 01:51:46',1,NULL),(13,'Compliment gratuit','Faites un compliment sincère à un collègue ou un camarade sur son travail ou sa tenue.','realisable','2025-11-30 01:51:46',1,NULL),(14,'Opération Propreté','Ramassez un déchet par terre dans la rue et jetez-le à la poubelle.','realisable','2025-11-30 01:51:46',1,NULL),(15,'Café suspendu','Payez le café de la personne suivante ou offrez-en un à un collègue.','realisable','2025-11-30 01:51:46',1,NULL),(16,'Zéro critique','Passez une journée entière sans critiquer personne (ni vous-même !).','realisable','2025-11-30 01:51:46',1,NULL),(17,'Appel famille','Appelez vos parents ou grands-parents juste pour prendre des nouvelles.','realisable','2025-11-30 01:51:46',1,NULL),(18,'Laisser sa place','Cédez votre place assise dans les transports ou laissez passer quelqu\'un avec peu d\'articles à la caisse.','realisable','2025-11-30 01:51:46',1,NULL),(19,'Le Post-it gentil','Laissez un petit mot d\'encouragement sur le bureau d\'un collègue ou sur le frigo.','realisable','2025-11-30 01:51:46',1,NULL),(20,'Écoute active','Lors d\'une conversation, écoutez vraiment sans couper la parole et sans préparer votre réponse.','realisable','2025-11-30 01:51:46',1,NULL),(21,'Donner une seconde vie','Triez vos vêtements et mettez de côté ceux que vous pouvez donner à une association.','realisable','2025-11-30 01:51:46',1,NULL),(22,'Merci patron','Remerciez votre responsable ou un professeur pour quelque chose de spécifique qu\'il vous a appris.','realisable','2025-11-30 01:51:46',1,NULL),(23,'Journée piéton','Laissez la voiture au garage et faites vos trajets à pied ou en vélo si possible.','realisable','2025-11-30 01:51:46',1,NULL),(24,'Cuisiner pour autrui','Préparez un petit plat ou un gâteau et partagez-le avec vos voisins ou collègues.','realisable','2025-11-30 01:51:46',1,NULL),(25,'Pourboire généreux','Laissez un pourboire un peu plus élevé que d\'habitude au serveur ou au livreur.','realisable','2025-11-30 01:51:46',1,NULL),(26,'Lettre manuscrite','Écrivez une vraie lettre ou une carte postale à quelqu\'un que vous aimez.','realisable','2025-11-30 01:51:46',1,NULL),(27,'Aider à porter','Proposez votre aide à quelqu\'un qui semble galérer avec ses courses ou une valise.','realisable','2025-11-30 01:51:46',1,NULL),(28,'Pardonner','Lâchez prise sur une petite rancune qui ne sert à rien. Pardonnez intérieurement.','realisable','2025-11-30 01:51:46',1,NULL),(29,'Déconnexion','Passez une soirée sans écrans pour être pleinement présent avec vos proches.','realisable','2025-11-30 01:51:46',1,NULL),(30,'Saluer les invisibles','Dites un vrai bonjour chaleureux au chauffeur de bus, à l\'agent d\'entretien ou au caissier.','realisable','2025-11-30 01:51:46',1,NULL),(31,'Partager son savoir','Prenez 10 minutes pour expliquer quelque chose que vous maîtrisez à quelqu\'un qui demande de l\'aide.','realisable','2025-11-30 01:51:46',1,NULL),(32,'L\'eau c\'est la vie','Évitez d\'acheter des bouteilles en plastique aujourd\'hui, utilisez une gourde.','realisable','2025-11-30 01:51:46',1,NULL),(33,'Encouragement public','Laissez un avis positif (Google/TripAdvisor) sur un petit commerce que vous appréciez.','realisable','2025-11-30 01:51:46',1,NULL),(34,'Don de sang','Vérifiez si vous pouvez donner votre sang et prenez rendez-vous.','realisable','2025-11-30 01:51:46',1,NULL),(35,'Planter une graine','Plantez une fleur ou une plante, ou offrez-en une.','realisable','2025-11-30 01:51:46',1,NULL),(36,'Patience au volant','Laissez passer un piéton ou une voiture qui attend de s\'insérer, avec le sourire.','realisable','2025-11-30 01:51:46',1,NULL),(37,'Partager un livre','Donnez un livre que vous avez déjà lu à quelqu\'un qui pourrait l\'aimer.','realisable','2025-11-30 01:51:46',1,NULL),(38,'Dire je t\'aime','Dites-le à votre partenaire, vos enfants ou vos parents sans raison spéciale.','realisable','2025-11-30 01:51:46',1,NULL),(39,'Gratitude du soir','Avant de dormir, notez 3 choses positives qui sont arrivées dans votre journée.','realisable','2025-11-30 01:51:46',1,NULL);
/*!40000 ALTER TABLE `defi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `defi_proposition`
--

DROP TABLE IF EXISTS `defi_proposition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `defi_proposition` (
  `defi_proposition_id` int NOT NULL AUTO_INCREMENT,
  `defi_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`defi_proposition_id`),
  KEY `defi_id` (`defi_id`),
  KEY `defi_proposition_ibfk_2` (`user_id`),
  CONSTRAINT `defi_proposition_ibfk_1` FOREIGN KEY (`defi_id`) REFERENCES `defi` (`defi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `defi_proposition`
--

LOCK TABLES `defi_proposition` WRITE;
/*!40000 ALTER TABLE `defi_proposition` DISABLE KEYS */;
/*!40000 ALTER TABLE `defi_proposition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `don`
--

DROP TABLE IF EXISTS `don`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `don` (
  `don_id` int NOT NULL AUTO_INCREMENT,
  `montant` float NOT NULL,
  `anonyme` tinyint(1) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`don_id`),
  KEY `don_ibfk_1` (`user_id`),
  CONSTRAINT `don_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `don`
--

LOCK TABLES `don` WRITE;
/*!40000 ALTER TABLE `don` DISABLE KEYS */;
/*!40000 ALTER TABLE `don` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `role` enum('admin','client') NOT NULL,
  `name` varchar(100) NOT NULL,
  `surname` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','Admin','Super','admin@test.com','$2y$13$mJs7NuxhKvI/5qhNIluAd.9bn6lD4R/LIbm5MJ2wkflLl6GsJOvD2','2025-11-23 16:21:24'),(7,'client','Martin','Sophie','sophie@test.com','$2y$13$NLF8WC7Dxo9SX2XKOSdjUe9EZtEtqPB9qAVo2KoJVGgj236KsxQ.O','2025-11-29 23:16:54'),(9,'client','Matteo','Livrozet','matteo@test.com','$2y$13$PDr6Qz7YDOphGij6wMkiP.IN1c0EOJ/AXuy9qnvVEBED5zjDpqky6','2025-11-30 00:03:44');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-30 20:23:35
