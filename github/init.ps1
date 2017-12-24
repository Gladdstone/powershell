<#
Initialize and pull an existing Github repo
In the future, this will also create the repo with the Github API

Name: init
Param: repo - name of repository to connect to
Return: void
#>
$repo = Read-Host -Prompt 'Input repository name'
git init
git remote add origin https://github.com/Gladdstone/$repo
git pull origin master