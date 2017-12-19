$host.UI.RawUI.WindowTitle = "JARVIS"
# Change foreground to red if run by admin
if($host.UI.RawUI.WindowTitle -like "*administrator*") {
	$host.UI.RawUI.ForegroundColor = "Red"
}

# Aliases
new-item alias:np -value 'C:\Program Files (x86)\Notepad++\notepad++.exe'

# Set city to query for weather
$city = ""
$api_url = "https://api.openweathermap.org/data/2.5/weather?q=" + $city + "&APPID="

# Get weather from https://openweathermap.org/api
$weatherJson = Invoke-RestMethod -Uri $api_url

# Parse JSON object for relevant data
$clouds = $weatherJson.weather.description
$temp = $weatherJson.main.temp * (9 / 5) - 459.67		# Temperature is passed in Kelvin, converted to Fahrenheit
$pressure = $weatherJson.main.pressure
$humidity = $weatherJson.main.humidity
$min_temp = $weatherJson.main.temp_min * (9 / 5) - 459.67
$max_temp = $weatherJson.main.temp_max * (9 / 5) - 459.67

# This takes a long time
# Update-Help