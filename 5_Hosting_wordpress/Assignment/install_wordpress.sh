if [ -d "/srv/www/wordpress" ]; then
    echo "WordPress is already downloaded."
else
    curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www
fi
