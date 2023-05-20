# example makefile
#
.PHONY: all help pull start stop
all: stop pull start

help: ## This help dialog.
	@IFS=$$'\n' ; \
	help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//'`); \
	for help_line in $${help_lines[@]}; do \
		IFS=$$'#' ; \
		help_split=($$help_line) ; \
		help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		printf "%-30s %s\n" $$help_command $$help_info ; \
	done


pull: ## Runs unit tests
	@echo "Pulling latest changes"
	@git add .
	@git reset --hard
	@git pull
stop:
	@echo "Stopping app"
	@pm2 stop "dating_backend"
start: ## Starting app
	@echo "Starting app"
	@pm2 start main.py --name "dating_backend" --interpreter python3
