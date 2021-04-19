#!/bin/bash

# some options for archive box when running w/ docker
# https://github.com/ArchiveBox/ArchiveBox/wiki/Configuration

ua='"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.190 Safari/537.36"'

docker-compose run archivebox config --set CHROME_BINARY=chromium
docker-compose run archivebox config --set ONLY_NEW=false
docker-compose run archivebox config --set SAVE_MEDIA=false
docker-compose run archivebox config --set SUBMIT_ARCHIVE_DOT_ORG=false
docker-compose run archivebox config --set CURL_USER_AGENT=$ua
docker-compose run archivebox config --set WGET_USER_AGENT=$ua
docker-compose run archivebox config --set CHROME_USER_AGENT=$ua
