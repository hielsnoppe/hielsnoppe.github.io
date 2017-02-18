xsltproc -o about/index.html _xsl/cv.xsl _data/cv.rdf &&
jekyll build --config _config.yml,_localconfig.yml --incremental
