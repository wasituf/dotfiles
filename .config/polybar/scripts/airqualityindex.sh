#!/bin/sh

TOKEN="23eb3d2e4ddcefddb6b49e16cc4df1b0a8f7aab0"
CITY="bangladesh/dhaka/us-consulate"

API="https://api.waqi.info/feed"

if [ -n "$CITY" ]; then
    aqi=$(curl -sf "$API/$CITY/?token=$TOKEN")
else
    location=$(curl -sf https://location.services.mozilla.com/v1/geolocate?key=geoclue)

    if [ -n "$location" ]; then
        location_lat="$(echo "$location" | jq '.location.lat')"
        location_lon="$(echo "$location" | jq '.location.lng')"

        aqi=$(curl -sf "$API/geo:$location_lat;$location_lon/?token=$TOKEN")
    fi
fi

if [ -n "$aqi" ]; then
    if [ "$(echo "$aqi" | jq -r '.status')" = "ok" ]; then
        aqi=$(echo "$aqi" | jq '.data.aqi')
        label=""

        if [ "$aqi" -lt 50 ]; then
            echo "%{F#009966} %{F-}$label Good"
        elif [ "$aqi" -lt 100 ]; then
            echo "%{F#ffde33} %{F-}$label Moderate"
        elif [ "$aqi" -lt 150 ]; then
            echo "%{F#ff9933} %{F-}$label Sensitive"
        elif [ "$aqi" -lt 200 ]; then
            echo "%{F#cc0033} %{F-}$label Unhealthy"
        elif [ "$aqi" -lt 300 ]; then
            echo "%{F#660099} %{F-}$label Very Unhealthy"
        else
            echo "%{F#7e0023} %{F-}$label Hazardous"
        fi
    else
        echo "$aqi" | jq -r '.data'
    fi
fi
