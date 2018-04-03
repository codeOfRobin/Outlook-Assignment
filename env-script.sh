if [ -f ./env-vars.sh ]
then
source ./env-vars.sh
fi
#no `else` case needed if the CI works as expected
sourcery --templates ./Templates --sources ./OutlookAssignment --output ./OutlookAssignment/Forecast\ Integration/ --args apiKey=$API_KEY