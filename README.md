# RAS-maintenance pages

This project contains the static files used to display the ras-frontstage site maintenance page. It uses a variable called `MAINTENANCE_TEMPLATE ` which determines which 
maintenance page is shown.

## Setup
Install dependencies using the Makefile:
```bash
make build
```
Alternatively install dependencies by using pipenv:

```bash
pipenv install --dev
```

## Run the application
Run with Makefile:
```bash
make start
```
Alternatively run manually with:
```bash
pipenv run python run.py
```

## Testing
To run tests with Makefile:
```bash
make test
```
Alternatively you can run it manually:
```bash
pipenv run pytest tests
```

# Blue green deployment

To route calls from frontstage to the holding page run

```
./deploy <env> deploy
```


Where env is the required environment on cloud foundry, this script currently supports dev and sit enivronments.
To use other environments update the config at the top of deploy.sh.
```
  ENVIRONMENT=${SIT_ENVIRONMENT}
  DOMAIN="apps.devtest.onsclofo.uk"
  MAINTENANCE_APP="ras-maintenance-sit"
  MAINTENANCE_URL="ras-maintenance-sit"
  FRONTSTAGE_APP="ras-frontstage-sit"
  FRONTSTAGE_URL="ras-frontstage-sit"
  TESTING_URL="ras-frontstage-sit-testing"
  ```


Once the deployment has been smoke tested to route calls back to the frontstage.

```
./deploy <env> undeploy
```
