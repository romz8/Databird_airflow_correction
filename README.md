# Airflow + dbt + BigQuery Pipeline

## Description

Ce projet montre comment déployer un pipeline **Airflow + dbt** sous Docker pour orchestrer des transformations de données sur **BigQuery**, à partir d’un dataset de type Bike Store.

L'objectif est de construire un workflow ELT complet en environnement conteneurisé et de l’automatiser avec **Airflow**.

## Technologies utilisées
- **Docker** : pour la conteneurisation.
- **Apache Airflow** : pour l'orchestration de workflows.
- **dbt (Data Build Tool)** : pour la transformation des données.
- **BigQuery** : entrepôt de données cloud.
- **GCP Service Account** : pour l’authentification sécurisée.

## Fonctionnalités
- Conteneur Docker unique intégrant Airflow et dbt.
- Synchronisation des répertoires `dags/` et `dbt/` via volumes Docker.
- Pipeline ELT déclenché par Airflow via un **BashOperator**.
- Création automatisée de vues et tables dans BigQuery via dbt.

## Structure du projet

```
/projet_final
├── dags/                    # DAGs Airflow
│   └── dbt_pipeline_dag.py
├── dbt/                     # Projet dbt (modèles, sources)
│   ├── models/
│   ├── dbt_project.yml
│   └── .dbt_profiles/profiles.yml
├── Dockerfile               # Dockerfile Airflow + dbt
├── requirements.txt         # Dépendances Python
├── .env                     # Variables d'environnement (ex : credentials GCP)
```

## Instructions

1. Construire l'image Docker
   ```bash
   docker build -t dbt_pipeline .
   ```

2. Lancer le conteneur
   ```bash
   docker run -d --name airflow-standalone \
     --env-file .env \
     -p 8080:8080 \
     -v ./dags:/opt/airflow/dags \
     -v ./dbt:/opt/airflow/dbt dbt_pipeline
   ```

3. Accéder à l'interface Airflow : http://localhost:8080

4. Déclencher le DAG `dbt_pipeline_dag` pour lancer le `dbt run`.

## Objectifs pédagogiques

- Automatiser l’exécution de modèles dbt via Airflow.
- Apprendre à configurer un environnement ELT complet sous Docker.
- Intégrer Airflow et dbt pour orchestrer des pipelines vers BigQuery.

## Pré-requis

* Docker Desktop ou Docker Engine installé
* Compte Google Cloud Platform avec un dataset BigQuery prêt à l’emploi
* Service Account JSON avec droits sur BigQuery (au moins BigQuery Admin + Storage Viewer)
* dbt Cloud ou dbt Core installé en local pour debug éventuel (facultatif)
* Accès à un terminal compatible Unix (Linux/macOS ou WSL pour Windows)
