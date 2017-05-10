#cp _themes/jekyll-theme-nielshoppe/assets/fonts/* assets/fonts &&
bundle update &&
bundle exec jekyll build --config _config.yml,_localconfig.yml #--incremental
