git tag -d deploy-prod

git add .
git commit -m "New"
git tag deploy-prod
git push origin deploy-prod
