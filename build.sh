cd site/_themes/my-website-theme && gulp && cd ../../.. &&
xsltproc -o site/about/cv.html xsl/cv.xsl data/cv.rdf &&
jekyll build --config _config.yml,_localconfig.yml --incremental
