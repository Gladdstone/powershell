<#
Initialize and pull an existing Github repo

Name: init
Param: repo - name of repository to connect to
Return: void
#>
param(
	[string]$r
)
git init
git remote add origin https://github.com/Gladdstone/$repo
git pull origin master