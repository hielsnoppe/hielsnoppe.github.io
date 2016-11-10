atom . &

vagrant up &&
vagrant ssh -c "cd /vagrant && \
/home/vagrant/.rbenv/shims/jekyll serve \
--config _config.yml,_localconfig.yml \
--watch --force_polling --incremental \
-H 0.0.0.0 -P 4000"

xdg-open http://127.0.0.1:4000
