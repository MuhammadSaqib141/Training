# Description
It looks like something happened about 15 minutes ago.
How can you determine what containers ran in the last 20 minutes?


    
________________________
docker ps -a --filter "status=exited" --format "table {{.ID}}\t{{.Image}}\t{{.Status}}"
