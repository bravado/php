#!/usr/bin/env bash
tag=${1:-latest}
cid=$(docker run -d --rm -v $(pwd)/tests:/var/www/html bravado/apache:${tag})


ip=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $cid)

echo waiting for apache
sleep 5

out=$(curl $ip/phpinfo.php)

docker logs $cid

echo $out


docker stop $cid
