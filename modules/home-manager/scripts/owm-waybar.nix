{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
{
  options.custom-pkgs.owm-waybar = {
    package = mkOption {
      type = types.package;
      default = pkgs.writeTextFile {
        name = "owm-waybar";
        destination = "/bin/owm-waybar";
        executable = true;
        text = ''
          #!/usr/bin/env bash

          ICON_FILE="$1"
          API=$(cat ${config.age.secrets.owm_api.path})
          VERSION="2.5"
          LAT="23.811436"
          LON="90.423412"
          DATA=$(curl -s "https://api.openweathermap.org/data/$VERSION/weather?lat=$LAT&lon=$LON&units=metric&appid=$API")

          TEMP=$(echo "$DATA" | jq -r '.main.temp')
          TEMP_ROUNDED=$(echo "($TEMP+0.5)/1" | bc)
          WEATHER=$(echo "$DATA" | jq -r '.weather[0].main')
          FEEL=$(echo "$DATA" | jq -r '.main.feels_like')
          HUMIDITY=$(echo "$DATA" | jq -r '.main.humidity')
          SUNRISE=$(echo "$DATA" | jq -r '.sys.sunrise' | xargs -I {} date -d @"{}" +"%H:%M %p")
          SUNSET=$(echo "$DATA" | jq -r '.sys.sunset' | xargs -I {} date -d @"{}" +"%H:%M %p")

          ICON_CODE=$(echo "$DATA" | jq -r '.weather[0].id')
          STATUS=$(echo "$DATA" | jq -r '.weather[0].icon')
          if [[ "$STATUS" == *d ]]; then
            TIMING="day"
          else
            TIMING="night"
          fi

          # RESULT=$(jq -r --arg k "wi-owm-$TIMING-$ICON_CODE" '
          #   map(select(has($k)))
          #   | first
          #   | .[$k]
          # ' "$ICON_FILE")

          case "$STATUS" in
            "01d") RESULT="☀️" ;;
            "01n") RESULT="🌕" ;;
            "02d") RESULT="🌤️" ;;
            "02n") RESULT="🌤️" ;;
            "03d") RESULT="☁️" ;;
            "03n") RESULT="☁️" ;;
            "04d") RESULT="🌥️" ;;
            "04n") RESULT="🌥️" ;;
            "09d") RESULT="🌦️" ;;
            "09n") RESULT="🌦️" ;;
            "10d") RESULT="🌨️" ;;
            "10n") RESULT="🌨️" ;;
            "11d") RESULT="🌩️" ;;
            "11n") RESULT="🌩️" ;;
            "13d") RESULT="❄️" ;;
            "13n") RESULT="❄️" ;;
            "50d") RESULT="🌫️" ;;
            "50n") RESULT="🌫️" ;;
          esac

          JSON_STRING="{
            \"text\": \"$RESULT $TEMP_ROUNDED\",
            \"tooltip\": \"Weather: $WEATHER\\nTemp: $TEMP°C (feels like $FEEL°C)\\nHumidity: $HUMIDITY%\\n\\nSunrise: $SUNRISE\\nSunset: $SUNSET\",
            \"class\": [\"owm-icon\", \"$TIMING\"]
          }"

          if [[ "$1" == "--icon" ]]; then
            curl -s "https://openweathermap.org/img/wn/$STATUS.png" --output /tmp/owm-icon.png
            echo "/tmp/owm-icon.png"
            exit 0
          else
            echo "$JSON_STRING" | jq -c .
            exit 0
          fi
        '';
      };
      description = "Script to fetch weather data from openweathermap to display in waybar.";
    };
  };
}
