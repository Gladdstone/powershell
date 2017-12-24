<#
Reset with either soft or hard

Name: reset
Param: null
Return: void
#>
$type = Read-Host -Prompt "Put changes back into staging? [Y|N]"
switch($type) {
	"y" {
		git reset --soft HEAD~1
	}
	"n" {
		git reset --hard HEAD~1
	}
	default {
		github reset
	}
}