git tag -d deploy-dev
git add .
git commit -m "New"
git push -u origin main
git tag deploy-dev
git push --force deploy-dev
