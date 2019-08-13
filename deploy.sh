#!/bin/bash

if [[ $# -ne 2 ]]; then
  echo "Incorrect number of parameters, use commands: <env> deploy, <env> undeploy"
  exit 1
fi

DEV_ENVIRONMENT="dev"
SIT_ENVIRONMENT="sit"
PREPROD_ENVIRONMENT="preprod"
PROD_ENVIRONMENT="prod"

if [ $1 == ${DEV_ENVIRONMENT} ]; then
  ENVIRONMENT=${DEV_ENVIRONMENT}
  DOMAIN="apps.devtest.onsclofo.uk"
  MAINTENANCE_APP="ras-maintenance-dev"
  MAINTENANCE_URL="ras-maintenance-dev" # PUT IN AS MAY NOT BE THE SAME AS APP NAME IN DIFFERENT ENVIRONMENTS
  FRONTSTAGE_APP="ras-frontstage-dev"
  FRONTSTAGE_URL="ras-frontstage-dev" # PUT IN AS MAY NOT BE THE SAME AS APP NAME IN DIFFERENT ENVIRONMENTS
  TESTING_URL="ras-frontstage-dev-testing"
elif [ $1 == ${SIT_ENVIRONMENT} ]; then
  ENVIRONMENT=${SIT_ENVIRONMENT}
  DOMAIN="apps.devtest.onsclofo.uk"
  MAINTENANCE_APP="ras-maintenance-sit"
  MAINTENANCE_URL="ras-maintenance-sit"
  FRONTSTAGE_APP="ras-frontstage-sit"
  FRONTSTAGE_URL="ras-frontstage-sit"
  TESTING_URL="ras-frontstage-sit-testing"
elif [ $1 == ${PREPROD_ENVIRONMENT} ]; then
  ENVIRONMENT=${PREPROD_ENVIRONMENT}
  DOMAIN="apps.prod.cf5.onsclofo.uk"
  MAINTENANCE_APP="ras-maintenance-preprod"
  MAINTENANCE_URL="ras-maintenance-preprod"
  FRONTSTAGE_APP="ras-frontstage-preprod"
  FRONTSTAGE_URL="surveys.onsdigital.uk"
  TESTING_URL="ras-frontstage-preprod-testing"
elif [ $1 == ${PROD_ENVIRONMENT} ]; then
  ENVIRONMENT=${PROD_ENVIRONMENT}
  DOMAIN="apps.prod.cf5.onsclofo.uk"
  MAINTENANCE_APP="ras-maintenance-prod"
  MAINTENANCE_URL="ras-maintenance-prod"
  FRONTSTAGE_APP="ras-frontstage-prod"
  FRONTSTAGE_URL="surveys.ons.gov.uk"
  TESTING_URL="ras-frontstage-prod-testing"
else
  echo "Unknown environment, currently script only supports: $DEV_ENVIRONMENT, $SIT_ENVIRONMENT, $PREPROD_ENVIRONMENT and $PROD_ENVIRONMENT"
  exit 1
fi

# FIXME: Add other environments

# Target the correct space
cf target -s ${ENVIRONMENT}

# FIXME: Check that the testing url is sufficient, may need to be locked down to just have access within the ons domain

deploy_holding_page() {
 echo "pointing url to holding page & unmapping access to frontstage in $ENVIRONMENT environment"
 cf map-route ${MAINTENANCE_APP} ${DOMAIN} -n ${FRONTSTAGE_URL}
 cf unmap-route ${FRONTSTAGE_APP}  ${DOMAIN} -n ${FRONTSTAGE_URL}
}

create_testing_route() {
 echo "opening a testing url"
 cf map-route ${FRONTSTAGE_APP} ${DOMAIN} -n ${TESTING_URL}
}


undeploy_holding_page() {
 echo "dropping holding page & mapping access to frontstage in $ENVIRONMENT environment"
 cf map-route ${FRONTSTAGE_APP} ${DOMAIN} -n ${FRONTSTAGE_URL}
 cf unmap-route ${MAINTENANCE_APP} ${DOMAIN} -n ${FRONTSTAGE_URL}
 cf unmap-route ${MAINTENANCE_APP} ${DOMAIN} -n ${MAINTENANCE_URL} # Maintenance app unreachable outside of deployment
}

remove_testing_route() {
 echo "removing testing url"
 cf unmap-route ${FRONTSTAGE_APP} ${DOMAIN} -n ${TESTING_URL}
}

case $2 in
 deploy)
   deploy_holding_page
   create_testing_route
   cf apps
   ;;
 undeploy)
   undeploy_holding_page
   remove_testing_route
   cf apps
   ;;
 *)
   echo "use commands: <env> deploy , <env> undeploy "
   ;;
esac


