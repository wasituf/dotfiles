let
  wasituf = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFHfli5Z8g+IymiSpW73QZAwewvOe4EVe17fN8iRzCh2 wasit.allin1@proton.me";
  users = [ wasituf ];

  ws = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEiP/3JhJJpUG5w3NeATOFWF6+d9LBUAlCrWFbkzaUu+ root@ws";
  systems = [ ws ];
in
{
  # Example
  # "secret1.age".publicKeys = [ wasituf ];
  # "secret2.age".publicKeys = users ++ systems;

  "spotify_client_id.age".publicKeys = users;
  "spotify_client_secret.age".publicKeys = users;
  "owm_api.age".publicKeys = users;
}
