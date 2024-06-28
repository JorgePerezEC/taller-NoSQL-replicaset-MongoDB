#!/bin/bash

# Esperar unos segundos para asegurar que MongoDB esté listo
sleep 10

# Configuración del conjunto de réplicas
mongosh <<EOF
var config = {
    "_id": "rs0",
    "members": [
        { "_id": 0, "host": "mongo1:27017" },
        { "_id": 1, "host": "mongo2:27017" },
        { "_id": 2, "host": "mongo3:27017" }
    ]
};
rs.initiate(config, { force: true });
rs.status();
EOF
