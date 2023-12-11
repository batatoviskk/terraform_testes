#!/bin/bash
#####################################################################################################################
#----------------------------------------------------------------------------------------
# Variables to Environment
#----------------------------------------------------------------------------------------
AZENV=qas

#####################################################################################################################
#----------------------------------------------------------------------------------------
# Colors messages
#----------------------------------------------------------------------------------------
GREEN='\033[0;32m'
BGREEN='\033[1;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color
UGREEN='\033[4;32m'
ONYELLOW='\033[43m'
ONRED='\033[41m'
ONGREEN='\033[42m'

#--------------------------------------------
# Makefile
#---------------------------------------------
FILES='Makefile'

config_subscription() {
AZENV=$(echo $AZENV | awk '{print toupper($0)}')
if [[ "$AZENV" = "DEV" ||  "$AZENV" = "QAS" || "$AZENV" = "PRD" ]]; then   
        SUB=$(az account  list -o table | grep $AZENV | awk '{print $3}')
          az account set --subscription $SUB
        
        for i in $SUB
        do
           echo "Subscription selected was:  ${i:0:15} ---> Wow : You're CURIOUS!!! HEIN. Said Mandalorian"
           echo ""
        done 

AZENV=$(echo $AZENV | awk '{print tolower($0)}')
else 
        echo "Erro: O nome da Subscription esta incorreto, valores Validos: DEV | QAS | PRD "
        exit 1 
fi 
}


common_process_to__create()  {
   [ ! -L  ${FILES} ] &&  rm  Makefile  &&  ln -s ../Makefile  Makefile && sleep 1
    sleep 5
    make tf-setup AZENV="${AZENV}"
    sleep 5
    make all AZENV="${AZENV}"
    sleep 10
    make auto-create-environent AZENV="${AZENV}"
    sleep 40

}


common_process_to__preinstall()  {
   [ ! -L  ${FILES} ] &&  rm  Makefile  &&  ln -s ../Makefile  Makefile && sleep 1
    sleep 5
    make tf-setup AZENV="${AZENV}"
    sleep 2
    make all AZENV="${AZENV}"
    sleep 5

}



common_process_to__destroy() {
  make tf-setup AZENV="${AZENV}"
  sleep 5
  make all
  sleep 10
  make auto-destroy-environment  AZENV="${AZENV}"
  sleep 30   

}







#--------------------------------------------
# PRE install Validade environment
#---------------------------------------------

pre() {
   
  echo "#-------------------------------------------------------------------------------------------"
        echo -e "# ${ONGREEN} Access to Subscription to create environment: ${AZENV}  ${NC}         "
  echo "#-------------------------------------------------------------------------------------------"
      config_subscription
      sleep 5

  
  echo    "#----------------------------------------------------------------------------------------------"
  echo -e "# ${ONGREEN}  Starting Resource Group  ${NC}..."
  echo    "#----------------------------------------------------------------------------------------------"
  cd 00-resource-groups
     common_process_to__preinstall
  echo  ""
  cd ..

  echo "#----------------------------------------------------------------------------------------------"
  echo -e "# ${ONGREEN} Starting Resource Group-Backend ${NC}"
  echo "#----------------------------------------------------------------------------------------------"
  cd 00-resource-groups-backend
     common_process_to__preinstall
  cd ..
  echo  ""

  echo "#----------------------------------------------------------------------------------------------"
  echo -e "# ${ONGREEN} Starting Networking ${NC}.."
  echo "#----------------------------------------------------------------------------------------------"  

  cd 01-networking
     common_process_to__preinstall
  cd ..
  echo ""


  echo "#----------------------------------------------------------------------------------------------"
  echo -e "# ${ONGREEN} Starting Networking-Delegation ${NC}"
  echo "#----------------------------------------------------------------------------------------------"
   cd 01-networking-delegation
      common_process_to__preinstall
  cd ..
  echo ""

  echo "#----------------------------------------------------------------------------------------------"
  echo -e "# ${ONGREEN} Starting Router ${NC}"
  echo "#----------------------------------------------------------------------------------------------"

  cd 02-router
     common_process_to__preinstall
  cd ..
  echo ""


  echo "#----------------------------------------------------------------------------------------------"
  echo -e "# ${ONGREEN} Starting Databricks ${NC}"
  echo "#----------------------------------------------------------------------------------------------"
  cd 04-databricks
     common_process_to__preinstall 
    cd ..
  echo ""


  echo "#----------------------------------------------------------------------------------------------"
  echo -e "# ${ONGREEN} Starting Databricks Cluster ${NC}"
  echo "#----------------------------------------------------------------------------------------------"
  cd 04-databricks-clusters
    make databricks-renew-token
    sleep 2
    common_process_to__preinstall
  cd ..
  echo ""


  echo "#----------------------------------------------------------------------------------------------"
  echo -e "# ${ONGREEN} Starting Datafactory ${NC}"
  echo "#----------------------------------------------------------------------------------------------"
  cd 05-datafactory
     common_process_to__preinstall
  cd ..
  echo ""


}



#--------------------------------------------
# CREATE environment
#---------------------------------------------
up() {
   
  echo "#-------------------------------------------------------------------------------------------"
        echo -e "# ${ONGREEN} Access to Subscription to create environment: ${AZENV}  ${NC}         "
  echo "#-------------------------------------------------------------------------------------------"
      config_subscription
      sleep 5

  
  echo    "#----------------------------------------------------------------------------------------------"
  echo -e "# ${ONGREEN}  Starting Resource Group  ${NC}..."
  echo    "#----------------------------------------------------------------------------------------------"
  cd 00-resource-groups
     common_process_to__create  
  echo  ""
  cd ..

  echo "#----------------------------------------------------------------------------------------------"
  echo -e "# ${ONGREEN} Starting Resource Group-Backend ${NC}"
  echo "#----------------------------------------------------------------------------------------------"
  cd 00-resource-groups-backend
     common_process_to__create
  cd ..
  echo  ""

  echo "#----------------------------------------------------------------------------------------------"
  echo -e "# ${ONGREEN} Starting Networking ${NC}.."
  echo "#----------------------------------------------------------------------------------------------"  

  cd 01-networking
     common_process_to__create   
  cd ..
  echo ""


  echo "#----------------------------------------------------------------------------------------------"
  echo -e "# ${ONGREEN} Starting Networking-Delegation ${NC}"
  echo "#----------------------------------------------------------------------------------------------"
   cd 01-networking-delegation
      common_process_to__create
  cd ..
  echo ""

  echo "#----------------------------------------------------------------------------------------------"
  echo -e "# ${ONGREEN} Starting Router ${NC}"
  echo "#----------------------------------------------------------------------------------------------"

  cd 02-router
     common_process_to__create
  cd ..
  echo ""


  echo "#----------------------------------------------------------------------------------------------"
  echo -e "# ${ONGREEN} Starting Databricks ${NC}"
  echo "#----------------------------------------------------------------------------------------------"
  cd 04-databricks
     common_process_to__create 
    cd ..
  echo ""


  echo "#----------------------------------------------------------------------------------------------"
  echo -e "# ${ONGREEN} Starting Databricks Cluster ${NC}"
  echo "#----------------------------------------------------------------------------------------------"
  cd 04-databricks-clusters
    make databricks-renew-token
    sleep 5
    common_process_to__create
  cd ..
  echo ""


  echo "#----------------------------------------------------------------------------------------------"
  echo -e "# ${ONGREEN} Starting Datafactory ${NC}"
  echo "#----------------------------------------------------------------------------------------------"
  cd 05-datafactory
     common_process_to__create
  cd ..
  echo ""


}

#--------------------------------------------
# DESTROY environment
#---------------------------------------------

down() {
  echo "#-------------------------------------------------------------------------------------------"
         echo -e "# ${ONGREEN} Access to Subscription - to destroy environment  "${AZENV}"  ${NC}";
  echo "#-------------------------------------------------------------------------------------------"

      config_subscription
      sleep 2

   
  echo "#----------------------------------------------------------------------------------------------"
  echo -e "# ${ONRED} Destroying Datafactory ${NC}"
  echo "#----------------------------------------------------------------------------------------------"
  cd 05-datafactory
     common_process_to__destroy
  cd ..
  echo ""

  echo "#----------------------------------------------------------------------------------------------"
  echo -e "# ${ONRED} Destroying Databricks Cluster ${NC}"
  echo "#----------------------------------------------------------------------------------------------"
  cd 04-databricks-clusters
    make databricks-renew-token
    common_process_to__destroy  
  cd ..
  echo ""


  echo "#----------------------------------------------------------------------------------------------"
  echo -e "# ${ONRED} Destroying Databricks ${NC}"
  echo "#----------------------------------------------------------------------------------------------"
  cd 04-databricks
     common_process_to__destroy
  cd ..
  echo ""

  echo "#----------------------------------------------------------------------------------------------"
  echo -e "# ${ONRED} Destroying Router ${NC}"
  echo "#----------------------------------------------------------------------------------------------"

  cd 02-router
     common_process_to__destroy   
  cd ..
  echo ""

  echo "#----------------------------------------------------------------------------------------------"
  echo -e "# ${ONRED} Destroying Networking-Delegation ${NC}"
  echo "#----------------------------------------------------------------------------------------------"
   cd 01-networking-delegation
      common_process_to__destroy
  cd ..
  echo ""

  echo "#----------------------------------------------------------------------------------------------"
  echo -e "# ${ONRED} Destroying Networking ${NC}.."
  echo "#----------------------------------------------------------------------------------------------"  

  cd 01-networking
     common_process_to__destroy
  cd ..
  echo ""


  echo "#----------------------------------------------------------------------------------------------"
  echo -e "# ${ONRED} Destroying Resouce Group-Backend ${NC}"
  echo "#----------------------------------------------------------------------------------------------"
  cd 00-resource-groups-backend
     common_process_to__destroy
  cd ..
  echo  ""


  echo "#----------------------------------------------------------------------------------------------"
  echo "# ${ONRED} Destroying Resouce Group ${NC} ..."
  echo "#----------------------------------------------------------------------------------------------"
  cd 00-resource-groups
     common_process_to__destroy
  echo  ""
  cd ..

}

#--------------------------------------------
# CONDITIONALS environment
#---------------------------------------------

case $1 in
  up)
    up
    ;;
  pre)
    pre
    ;;    
  config)
    config
    ;;
  down)
    down
    ;;
  *)
    echo "Usage: $0 {up|config|down|pre}"
    ;;
esac