PROJ=skel/goweb
PORTS=8081:8081

DF=Dockerfile.app
GIT_REMOTE_DEV=dokku@${DEP_DEV_IP}:${PROJ}
GIT_REMOTE_PROD=dokku@${DEP_PROD_IP}:${PROJ}

# usage
usage:
	@echo "make build -- build the app"
	@echo "make pkg   -- package the app (builds docker container)"
	@echo "make run   -- run the app here"
	@echo "make stg   -- deploy to staging/dev environment"
	@echo "make prod  -- deploy to prod"
	@echo "make diag  -- see if stuff is ok / diagnose"

# **** -> Deployment targets

build:
	env GOARCH=amd64 GOOS=darwin go build -o darwin.app *.go
	env GOARCH=amd64 GOOS=linux  go build -o linux.app *.go
dbg:
	docker run -it --entrypoint /bin/sh ${PROJ}
pkg: build
	docker build -f ${DF} -t ${PROJ} .
run:
	docker run -it -p ${PORTS} ${PROJ}
stg: pkg
	docker image save ${PROJ} | bzip2 | ssh -i ${DEP_DEV_KEY} vagrant@${DEP_DEV_IP} "bzcat - | sudo docker image load"
	git push ${GIT_REMOTE_DEV} master
prod:
	docker image save ${PROJ} | ssh -i ${DEP_PROD_KEY} vagrant@${DEP_PROD_IP} sudo docker image load
	git push ${GIT_REMOTE_PROD} master
diag:
	env SSH_AUTH_SOCK= ssh -i ${DEP_DEV_KEY} vagrant@${DEP_DEV_IP} cal

# **** <- The end of deployment targets.
