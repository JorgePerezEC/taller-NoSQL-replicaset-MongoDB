# TALLER: Implementación de bases de Datos NoSQL con nodos (Replica Set)

## Despliegue local de un Replica Set de MongoDB con docker-compose

Configuración local del servidor MongoDB con un conjunto de réplicas usando docker-compose.

El conector de la base de datos de MongoDB utiliza transacciones para soportar escrituras anidadas.

### Tienes dos soluciones:

1. Usar [MongoDB Atlas](https://www.mongodb.com/atlas/database). It is a free-service where we can create MongoDB cluster that supports replication.
2. Configurar un servidor local de MongoDB con replicación.

## Tech Stack

- [Docker](https://docs.docker.com/get-docker/) (docker-compose)
- YAML
- Bash

## Instalación

Clona el proyecto

```bash
  $ git clone git@github.com:AlaeddineMessadi/Mongodb-Replica-Set-docker-compose.git mongodb-replset
```

Ingresa al directorio raiz

```bash
  $ cd mongodb-replset
```

Iniciar el servidor

```bash
  $ ./start.sh
```

Si no usaste el script `./start.sh`, entonces deberías ejecutar `$ docker exec mongo1 /scripts/init.sh` después de ejecutar `$ docker-compose up -d` para inicializar el conjunto de réplicas en tus servidores.

Stop the server

```bash
  $ ./stop.sh

  # or

  $ docker-compose down
```

Una vez se esté ejecutando el docker con los réplica set podemos verificarlo con el siguiente comando en nuestro terminal.

```bash
  $ docker ps
```

## Configuración

Ingresa al bash de MongoDB dentro de uno de nuestros dockers:

```bash
  $ docker exec -it <nombre_del_contenedor> mongosh
```

Verificar el Estado del Replicaset:

```bash
  > rs.status()
```

## Simulación de fallo de un nodo de nuestro replica set

Verificar el nodo que sea primario y detenemos el nodo identificando cual es el docker que lo contiene.

```bash
  $ docker ps
```
Detén el contenedor que deseas simular como caído.

```bash
  $ docker stop <nombre_del_contenedor>
```
Por ejemplo, si el contenedor PRIMARY se llama `mongo1` entonces el comando sería:

```bash
  $ docker stop mongo1
```
## Forzar un Failover (Conmutación por error)

Para probar la capacidad de recuperación y la disponibilidad de tu replicaset, puedes forzar un failover. Esto simula el escenario en el que el nodo primario falla y otro nodo se convierte en primario.

Ingresa al nodo primario.

```bash
  $ docker exec -it <nombre_del_contenedor_primario> mongosh
```

```bash
  > rs.stepDown()
```
