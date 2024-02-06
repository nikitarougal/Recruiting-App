code=$(cat scripts/apex/assignCurrentUser.apex)        
echo "${code/PermName/$1}" > temp.apex
sfdx force:apex:execute -f temp.apex
rm temp.apex