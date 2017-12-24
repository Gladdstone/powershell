$host.UI.RawUI.WindowTitle = "JARVIS"
# Change foreground to red if run by admin
if($host.UI.RawUI.WindowTitle -like "*administrator*") {
	$host.UI.RawUI.ForegroundColor = "Red"
}

#-----------------------
# Aliases
#-----------------------
# IDEs
new-item alias:np -value "C:\Program Files (x86)\Notepad++\notepad++.exe"
new-item alias:phpstorm -value "C:\Program Files\JetBrains\PhpStorm 2017.3\bin\phpstorm64.exe"
new-item alias:intellij -value "C:\Program Files\JetBrains\IntelliJ IDEA 2017.1.2\bin\idea64.exe"
new-item alias:pycharm -value "C:\Program Files\JetBrains\PyCharm 2017.1.2\bin\pycharm64.exe"
new-item alias:webstorm -value "C:\Program Files\JetBrains\WebStorm 2017.3\bin\webstorm64.exe"
# Touch
function touch {set-content -Path ($args[0]) -Value ($null)}
# Github
function github($c, $r) {
	switch($c) {
		"init" {
			C:\Users\JosephFarrell\Documents\WindowsPowerShell\github\init.ps1 $r
		}
		default {
			"You can initialize and pull from an existing repository with init"
		}
	}
}

# Welcome message
$welcome = "
          _______  _        _______  _______  _______  _______       _______  _______    
|\     /|(  ____ \( \      (  ____ \(  ___  )(       )(  ____ \     (       )(  ____ )   
| )   ( || (    \/| (      | (    \/| (   ) || () () || (    \/     | () () || (    )|   
| | _ | || (__    | |      | |      | |   | || || || || (__         | || || || (____)|   
| |( )| ||  __)   | |      | |      | |   | || |(_)| ||  __)        | |(_)| ||     __)   
| || || || (      | |      | |      | |   | || |   | || (           | |   | || (\ (      
| () () || (____/\| (____/\| (____/\| (___) || )   ( || (____/\ _   | )   ( || ) \ \__ _ 
(_______)(_______/(_______/(_______/(_______)|/     \|(_______/( )  |/     \||/   \__/(_)
                                                               |/                        
 _______  _______  _______  _______  _______  _        _       
(  ____ \(  ___  )(  ____ )(  ____ )(  ____ \( \      ( \      
| (    \/| (   ) || (    )|| (    )|| (    \/| (      | (      
| (__    | (___) || (____)|| (____)|| (__    | |      | |      
|  __)   |  ___  ||     __)|     __)|  __)   | |      | |      
| (      | (   ) || (\ (   | (\ (   | (      | |      | |      
| )      | )   ( || ) \ \__| ) \ \__| (____/\| (____/\| (____/\
|/       |/     \||/   \__/|/   \__/(_______/(_______/(_______/
                                                               
"			

try {
	# Set city to query for weather
	$city = ""
	$api_url = "https://api.openweathermap.org/data/2.5/weather?q=" + $city + "&units=imperial&APPID="

	# Get weather from https://openweathermap.org/api
	$weatherJson = Invoke-RestMethod -Uri $api_url

	# Parse JSON object for relevant data
	$weather = $weatherJson.weather.description
	$temp = $weatherJson.main.temp
	$pressure = $weatherJson.main.pressure
	$humidity = $weatherJson.main.humidity
	$min_temp = $weatherJson.main.temp_min
	$max_temp = $weatherJson.main.temp_max
	$sunrise_mill = $weatherJson.sys.sunrise					# Sent in unix time
	$sunset_mill = $weatherJson.sys.sunset
	$sunrise = [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($sunrise_mill))
	$sunset = [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($sunset_mill))

	$weather_output = "
	The weather today is $weather
	And the current temperature is $temp
	
	    _\/_                                 
     /o\\            \       /          //o\        Sunrise will take place at $sunrise, this morning
      |                .-'-.              |         And sunset will occur at $sunset.
    __|______     --  /     \  --     ____|__
             `~^~^~^~^~^~^~^~^~^~^~^~`
			 
	"
	
	#Clear-Host
	Write-Host "`n"$welcome
	Write-Host "`n"$weather_output
}
catch {
	$ErrorMessage = $_.Exception.Message
	$FailedItem = $_.Exception.ItemName
	# Error message
	$error = "I am unable to access $FailedItem at this time. Apologies for the inconvenience." 
	Write-Host "`n"
	Write-Host $welcome"`n"
	Write-Host $error
}
# This takes a long time
# Update-Help