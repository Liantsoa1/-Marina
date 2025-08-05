FROM ocaml/opam:debian-11

USER root
RUN apt-get update && apt-get install -y \
    make \
    m4 \
    git \
    python3 \
    python3-pip \
    ocaml-native-compilers

RUN pip install flask

USER opam
WORKDIR /home/opam/app

COPY --chown=opam:opam . .

RUN opam install ounit2 -y

RUN make

CMD ["python3", "api.py"]
