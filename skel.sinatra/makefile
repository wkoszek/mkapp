PROJ=skel/sinatra
PORTS=8081:80

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

test:
	bundler exec ruby app.rb
bundle:
	bundler install
pkg:
	docker build -f ${DF} -t ${PROJ} .
dbg:
	docker run -it --entrypoint /bin/sh ${PROJ}
run:
	docker run -it -p ${PORTS} ${PROJ}
stg: pkg
	docker image save ${PROJ} | env SSH_AUTH_SOCK= ssh -i ${DEP_DEV_KEY} vagrant@${DEP_DEV_IP} sudo docker image load
	git push ${GIT_REMOTE_DEV} master
prod:
	docker image save ${PROJ} | xz | pv | ssh ubuntu@${DEP_PROD_IP} "unxz - | sudo docker image load"
	git push ${GIT_REMOTE_PROD} master
diag:
	env SSH_AUTH_SOCK= ssh -i ${DEP_DEV_KEY} vagrant@${DEP_DEV_IP} cal

# **** <- The end of deployment targets.
