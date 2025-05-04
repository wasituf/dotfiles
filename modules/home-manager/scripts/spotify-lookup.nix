{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
{
  options.custom-pkgs.spotify-lookup = {
    package = mkOption {
      type = types.package;
      default = pkgs.writeShellScriptBin "spotify-lookup" ''
        CLIENT_ID_FILE="${config.age.secrets.spotify_client_id.path}"
        CLIENT_SECRET_FILE="${config.age.secrets.spotify_client_secret.path}"

        if [[ ! -f "$CLIENT_ID_FILE" ]]; then
          echo "Error: Spotify Client ID file not found at $CLIENT_ID_FILE"
          exit 1
        fi

        if [[ ! -f "$CLIENT_SECRET_FILE" ]]; then
          echo "Error: Spotify Client Secret file not found at $CLIENT_SECRET_FILE"
          exit 1
        fi

        CLIENT_ID=$(cat "$CLIENT_ID_FILE" | tr -d '\n')
        CLIENT_SECRET=$(cat "$CLIENT_SECRET_FILE" | tr -d '\n')

        TOKEN_DIR="/tmp"
        TOKEN_FILE_NAME="spotify_token.txt"
        TOKEN_FILE_PATH="$TOKEN_DIR/$TOKEN_FILE_NAME"
        TOKEN_EXPIRY="55min"

        TOKEN_STATUS=$(fd "$TOKEN_FILE_NAME" "$TOKEN_DIR" --newer "$TOKEN_EXPIRY")

        if [[ -n "$TOKEN_STATUS" ]]; then
          ACCESS_TOKEN=$(cat "$TOKEN_FILE_PATH")
        else
          ENCODED_STRING=$(echo -n "$CLIENT_ID:$CLIENT_SECRET" | base64 | tr -d '\n')

          TOKEN_RESPONSE=$(curl -s -X POST -H "Authorization: Basic $ENCODED_STRING" \
            -H "Content-Type: application/x-www-form-urlencoded" \
            -d "grant_type=client_credentials" \
            "https://accounts.spotify.com/api/token")

          ACCESS_TOKEN=$(echo "$TOKEN_RESPONSE" | jq -r '.access_token')

          if [ -z "$ACCESS_TOKEN" ]; then
            echo "Failed to get access token."
            exit 1
          fi

          # Save the access token to the file
          echo "$ACCESS_TOKEN" >"$TOKEN_FILE_PATH"
        fi

        # Search for a song (replace with your desired song and artist)
        SEARCH_QUERY=$1
        ENCODED_SEARCH_QUERY=$(echo "$SEARCH_QUERY" | sed 's/ /%20/g')

        # Make the search request and extract the Spotify URL of the first result
        SPOTIFY_URL=$(curl -s -X GET "https://api.spotify.com/v1/search?q=$ENCODED_SEARCH_QUERY&type=track" \
          -H "Authorization: Bearer $ACCESS_TOKEN" | jq -r '.tracks.items[0].external_urls.spotify')

        if [ -n "$SPOTIFY_URL" ]; then
          echo "Spotify URL for '$SEARCH_QUERY': $SPOTIFY_URL"
        else
          echo "No Spotify URL found for '$SEARCH_QUERY'."
        fi
      '';
      description = "Script to get spotify song URLs.";
    };
  };
}
