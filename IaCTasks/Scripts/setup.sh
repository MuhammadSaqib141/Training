env_file="env.json"

cat $env_file | jq 'to_entries | map(
            if .key | contains("servicebus") then 
                {(.key): .value},{(.value + "__fullyQualifiedNamespace"): (.value + ".servicebus.windows.net")}
            elif .key | contains("storage") then
                {(.key): .value},{(.value + "__serviceUri"): (.value + ".blob.core.windows.net")}
            elif .key | contains("keyvault") then
                {(.key): .value},{(.value + "keyvault"): (.value + ".vault.azure.net")}
            elif .key | contains("appconfig") then
                {(.key): .value},{(.value + "config"): (.value + ".azconfig.io")}
            else              
                {(.key): .value}
            end
            ) | add' > env.tmp && mv env.tmp $env_file
