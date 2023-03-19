echo "Cloning..."
  mv /var/www/chitanka/web/content /root 2>/dev/null 1>/dev/null
  rm -fr /var/www/chitanka
  git clone https://github.com/chitanka/chitanka-production.git chitanka 2>/dev/null 1>/dev/null
  rm -fr chitanka/web/content
  mv chitanka /var/www/
  mv /root/content /var/www/chitanka/web/
  echo $(date) > /var/www/chitanka/web/update.log
  cp /var/www/chitanka/app/config/parameters.yml.dist /var/www/chitanka/app/config/parameters.yml
  line="database_password:  ~"
  rep="database_password:  chitanka"
  sed -i "s/${line}/${rep}/g" /var/www/chitanka/app/config/parameters.yml
  line="exitWithMessage('maintenance');"
  rep=""
  sed -i "s/${line}/${rep}/g" /var/www/chitanka/web/index.php
  cd /var/www/chitanka
  # git stash; git pull
  chmod -R g+rw var/cache var/log var/spool web/cache
  chgrp -R www-data var/cache var/log var/spool web/cache
