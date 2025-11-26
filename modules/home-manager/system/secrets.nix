{ ... }:
{
  age.secrets = {
    spotify_client_id.file = ../../../secrets/spotify_client_id.age;
    spotify_client_secret.file = ../../../secrets/spotify_client_secret.age;
    owm_api.file = ../../../secrets/owm_api.age;
  };
}
