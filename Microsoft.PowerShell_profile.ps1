$host.UI.RawUI.WindowTitle = "JARVIS"
# Change foreground to red if run by admin
if($host.UI.RawUI.WindowTitle -like "*administrator*") {
	$host.UI.RawUI.ForegroundColor = "Red"
}

# Aliases
new-item alias:np -value 'C:\Program Files (x86)\Notepad++\notepad++.exe'

# Welcome message
$welcome = "Welcome, Mr. Farrell"

try {
	# Set city to query for weather
	$city = "Endicott"
	$api_url = "https://api.openweathermap.org/data/2.5/weather?q=" + $city + "&units=imperial&APPID=81044f3b09ae3a70b0625db9f068f1a1"

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

	Clear-Host
	Write-Host "`n"$welcome
	Write-Host "The weather today is" $weather "`n And the current temperature is "$temp
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