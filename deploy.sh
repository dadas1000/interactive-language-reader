#!/usr/bin/env sh
# abort on errors
set -e
# build
yarn run build
# navigate into the build output directorycd dist
# if you are deploying to a custom domain
# echo 'www.example.com' > CNAME
git init
git add -A
git commit -m 'deploy'
git push -f git@github.com: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/interactive-language-reader.git master:gh-pages
cd -