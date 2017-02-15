#atom . &

#vagrant up &&
#vagrant ssh -c "cd /vagrant && \
#/home/vagrant/.rbenv/shims/jekyll serve \
#--config _config.yml,_localconfig.yml \
#--watch --force_polling --incremental \
#-H 0.0.0.0 -P 4000"
jekyll build --config _config.yml,_localconfig.yml --watch --incremental --force_polling

#xdg-open http://127.0.0.1:4000

export LANG="en_US.UTF-8"
#exec start-stop-daemon --start \
#start-stop-daemon --start \
#--make-pid --pidfile /var/run/jekyll.pid \
#--chuid vagrant:vagrant --chdir /vagrant/ \
#--exec /home/vagrant/.rbenv/shims/jekyll -- build --config _config.yml,_localconfig.yml --watch --force_polling --incremental
