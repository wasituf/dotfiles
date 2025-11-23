{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.desktop.mpv;
in
{
  options.modules.desktop.mpv = {
    enable = mkEnableOption "mpv";
  };

  config = mkIf cfg.enable {
    programs.mpv = {
      enable = true;
      scripts = with pkgs; [
        mpvScripts.mpvacious
      ];
      scriptOpts = {
        subs2srs = {
          deck_name = "Mining";
          model_name = "Lapis";
          sentence_field = "SentenceFurigana";
          secondary_field = "Sentence";
          audio_field = "SentenceAudio";
          image_field = "Picture";
          animated_snapshot_enabled = "yes";
          animated_snapshot_height = "300";
          animated_snapshot_quality = "25";
          menu_font_name = "LINE Seed JP_TTF";
          use_ffmpeg = "yes";
          snapshot_quality = "80";
        };
      };
    };

    home.packages = with pkgs; [ ffmpeg ];

    home.file.".config/mpv/mpv.conf".source = ./mpv.conf;
    home.file.".config/mpv/mpv_websocket".source = ./mpv_websocket;
    home.file.".config/mpv/scripts/run_websocket_server.lua".source = ./run_websocket_server.lua;
  };
}
