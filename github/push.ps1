<#
Adds all changes
Commits to local repository w/ message and push to Github

Name: push
Param: null
Return: void
#>
$msg = Read-Host -Prompt 'Message'
git add .
git commit -m "$msg"
git push origin master