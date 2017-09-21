# all:
#     docker build -t agrdocker/agr_apollo_env .

# push:
#     docker push agrdocker/agr_apollo_env

# pull:
#     docker pull agrdocker/agr_apollo_env

bash:
	docker run -t -i agrdocker/agr_apollo_env bash

run:
	docker run -p 8888:8080 -t -i agrdocker/agr_apollo_env

rundb:
	docker run -p 8888:8080 -t -i -v postgres-data:/var/lib/postgresql agrdocker/agr_apollo_env
