# Étape 1 : Utiliser une image de base OCaml avec opam
FROM ocaml/opam:debian-11

# Étape 2 : Installer les outils nécessaires
USER root
RUN apt-get update && apt-get install -y \
    make \
    m4 \
    git \
    python3 \
    python3-pip

# Étape 3 : Installer Flask pour l'API
RUN pip install flask

# Étape 4 : Changer d'utilisateur pour opam
USER opam
WORKDIR /home/opam/app

# Étape 5 : Copier les fichiers du projet
COPY --chown=opam:opam . .

# Étape 6 : Installer les dépendances OCaml
RUN opam install ounit2 -y

# Étape 7 : Compiler marina
RUN make

# Étape 8 : Lancer le serveur Flask
CMD ["python3", "api.py"]
