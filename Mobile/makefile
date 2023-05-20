.PHONY: all run_dev_web run_dev_mobile build_appbundle_stg run_unit clean upgrade lint format build_dev_mobile help watch gen run_stg_mobile run_prd_mobile build_apk_dev build_apk_stg build_apk_prd purge build pg

all: lint format run_dev_mobile

# Adding a help file: https://gist.github.com/prwhite/8168133#gistcomment-1313022
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

run_unit: ## Runs unit tests
	@echo "╠ Running the tests"
	@fvm flutter test || (echo "Error while running tests"; exit 1)

clean: ## Cleans the environment
	@echo "╠ Cleaning the project..."
	@rm -rf pubspec.lock
	@fvm flutter clean
	@fvm flutter pub get

watch: ## Watches the files for changes
	@echo "╠ Watching the project..."
	@fvm flutter pub run build_runner watch --delete-conflicting-outputs

build: ## Build the files for changes
	echo "╠ Building the project..."
	fvm flutter pub run build_runner build --delete-conflicting-outputs


gen: ## Generates the assets
	@echo "╠ Generating the assets..."
	@fvm flutter pub get
	@fvm flutter packages pub run build_runner build

format: ## Formats the code
	@echo "╠ Formatting the code"
	@dart format lib .
	@fvm flutter pub run import_sorter:main
	@fvm flutter format lib

lint: ## Lints the code
	@echo "╠ Verifying code..."
	@dart analyze . || (echo "Error in project"; exit 1)

upgrade: clean ## Upgrades dependencies
	@echo "╠ Upgrading dependencies..."
	@fvm flutter pub upgrade

commit: format lint run_unit
	@echo "╠ Committing..."
	git add .
	git commit

run_dev_web: ## Runs the web application in dev
	@echo "╠ Running the app"
	@fvm flutter run -d chrome --dart-define=ENVIRONMENT=dev

run_dev_mobile: ## Runs the mobile application in dev
	@echo "╠ Running the app"
	@fvm flutter run --flavor development -t lib/main_development.dart

run_stg_mobile: ## Runs the mobile application in dev
	@echo "╠ Running the app"
	@fvm flutter run --flavor staging -t lib/main_staging.dart

run_prd_mobile: ## Runs the mobile application in dev
	@echo "╠ Running the app"
	@fvm flutter run --flavor production -t lib/main_production.dart

build_apk_dev: ## Runs the mobile application in dev
	@fvm flutter clean
	@fvm flutter pub get
	@fvm flutter build apk --flavor development -t lib/main.dart --dart-define=flavor=dev

build_apk_stg: ## Runs the mobile application in staging
	@fvm flutter clean
	@fvm flutter pub get
	@fvm flutter build apk -t lib/main.dart --dart-define=flavor=stg

build_apk_prod: ## Runs the mobile application in prod
	@fvm flutter clean
	@fvm flutter pub get
	@fvm flutter build apk --flavor production -t lib/main_production.dart

build_appbundle_stg: ## Runs the mobile application in staging
	fvm flutter build appbundle --dart-define=flavor=stg

purge: ## Purges the Flutter
	@pod deintegrate
	@fvm flutter clean
	@fvm flutter pub get
pg: ## Flutter pub get
	@fvm flutter pub get