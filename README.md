# 💖 Projet Bienveillance au Quotidien (Application Symfony)

## 🎯 Description du Projet

Cette application web a été développée avec le framework **Symfony 6/7** et Doctrine ORM. Elle vise à encourager les utilisateurs à pratiquer et partager des actions bienveillantes (défis).

Le projet implémente un workflow complet : affichage aléatoire pour le public, proposition de défis par les membres, système de commentaires, et un espace d'administration pour la modération.

## 🛠️ Installation et Configuration

Ce projet utilise une approche "Database First" (BDD existante).

### 1. Cloner le Repository

```bash
git clone https://github.com/matteolvt/Projet_Bienveillance Projet_Bienveillance
cd Projet_Bienveillance
```

### 2. Installer les Dépendances

```bash
composer install
```

### 3. Configuration de la Base de Données

Le projet utilise une base de données MySQL.

**Vérifiez le fichier `.env`** pour vous assurer que la variable `DATABASE_URL` est correctement configurée. Vous devez remplacer les identifiants et le port par ceux de votre machine.

```dotenv
# .env
# Configuration basée sur l'environnement de développement (MAMP/Local) :
DATABASE_URL="mysql://root:root@127.0.0.1:8889/projet_final_bdd?serverVersion=8.0.32&charset=utf8mb4"

# ⚠️ À ADAPTER :
# Remplacer 'root:root' et le port '8889' par les identifiants de votre installation (ex: port 3306)
```

### 4. Importation des Données Initiales (OBLIGATOIRE)

Pour que l'application soit fonctionnelle (défis, utilisateurs, etc.), vous devez importer le fichier SQL fourni.

Prérequis : Créer la base de données vide nommée projet_final_bdd.

# Importer les données à partir du fichier dump à la racine du projet

```bash
mysql -u root -p projet_final_bdd < projet_final_bdd_dump.sql
```

### 5. Lancement du Serveur

symfony server:start

### ✨ Fonctionnalités Clés Implémentées

Front Office (Visiteur/Membre)

Défi Aléatoire : Affichage d'un défi validé au hasard (sans répétition consécutive).

Consultation : Fiche détaillée d'un défi (/defi/{id}) avec section commentaires.

Contribution : Formulaire d'ajout de commentaires/expériences (pour membres).

Proposition : Formulaire pour soumettre un nouveau défi (/proposer-defi).

Back Office (Admin)

Modération : Validation/Suppression des défis en statut en_attente.

CRUD : Gestion complète des Utilisateurs, Défis et Commentaires.

API

Endpoint Aléatoire : Route /api/defi/random pour fournir un défi au format JSON.

Sécurité

Authentification : Login/Logout, Inscription, Gestion des rôles ROLE_ADMIN / ROLE_USER.

### 🗺️ Documentation des Routes

# --- ACCÈS PUBLIC ---

[GET] / -> app_home (Accueil / Défi Aléatoire)
[GET/POST] /login -> app_login (Connexion)
[GET/POST] /register -> app_register (Inscription)
[GET] /defi/{id} -> app_defi_show (Détail d'un défi)

# --- ACCÈS MEMBRE (ROLE_USER) ---

[GET/POST] /proposer-defi -> app_defi_new (Soumission d'un nouveau défi)

# --- ACCÈS ADMINISTRATEUR (ROLE_ADMIN) ---

[GET] /admin -> app_admin (Dashboard de modération)
[GET] /admin/defi/{id}/validate -> app_admin_defi_validate (Validation d'un défi)
[GET] /admin/user/ -> app_admin_user_index (CRUD Utilisateurs)

# --- API (Accès Public) ---

[GET] /api/defi/random -> api_defi_random (Récupère un défi au format JSON)

### 🔑 Identifiants pour le Test

Rôle Administrateur (ROLE_ADMIN)

Email : admin@test.com

Mot de Passe : password

Rôle Utilisateur (ROLE_USER)

Email : Compte créé via la page /register

Mot de Passe : Mot de passe choisi lors de l'inscription
