# Makefile pour MLOps NLP Project

.PHONY: all etl train evaluate export_onnx deploy clean

install:
	# Installer les dépendances du projet
	python -m pip install --upgrade pip
	pip install -r requirements.txt

all: etl train evaluate

# Exécuter le pipeline ETL complet
etl:
	python etl/pipeline.py

# Entraîner le modèle
train:
	python models/train.py

# Évaluer le modèle
evaluate:
	python models/evaluate.py

# Exporter le modèle au format ONNX
export_onnx:
	python models/export_onnx.py

# Déployer l'API sur Google Cloud Function
deploy:
	bash ci_cd/deploy_google_function.sh

# Nettoyer les fichiers générés (logs, modèles, etc.)
clean:
	rm -rf models/*.onnx models/*.pkl data/processed/* logs/*

# Lancer l'API localement (via uvicorn)
serve:
	uvicorn api.main:app --reload