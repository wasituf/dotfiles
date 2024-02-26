#!/run/current-system/sw/bin/bash

flag_file=".recording_flag"

option=$1

# Store ffmpeg options in an array
ffmpeg_options=(
)

if [ -e "$flag_file" ]; then
    # Stop recording
    kill "$(pgrep ffmpeg)"
    rm "$flag_file"
    ACTION=$(dunstify -i "$HOME/Icons/screen_cap.png" \
    -t 5000 \
    --action="default,openRecording" \
    -a "Screen Recording" \
    "Capture" \
    "<br>Screen Recording stopped. <i>Click to open directory</i>"
  )
else
    # Create flag file
    touch "$flag_file"

    # Notify
    dunstify -i "$HOME/Icons/screen_cap.png" \
      -t 3000 \
      -a "Screen Recording" \
      "Capture" \
      "Screen Recording in progress..."

    # Audio source
    audio_source=""
    case "$option" in
      "system")
        ffmpeg_option+=(
          -f pulse 
          -i alsa_output.pci-0000_29_00.6.analog-stereo.monitor
        )
        ;;
      "mic")
        ffmpeg_options+=(
          -f pulse 
          -i alsa_input.pci-0000_29_00.6.analog-stereo
        )
        ;;
      "both")
        ffmpeg_options+=(
          -f pulse 
          -i alsa_output.pci-0000_29_00.6.analog-stereo.monitor
          -i alsa_input.pci-0000_29_00.6.analog-stereo
        )
        ;;
      "silent")
        ;;
    esac

    # Add options
    ffmpeg_options+=(
    -video_size 1920x1080
    -framerate 60
    -f x11grab
    -i :0.0
    -c:v h264_nvenc
    -preset slow
    -b:v 15M
    -vf format=yuv420p
  )

    # Add output path
    path="$HOME/Recordings/$(date +%F_%T).mp4"
    ffmpeg_options+=("$path")

    # Start Recording
    ffmpeg "${ffmpeg_options[@]}"
fi

case "$ACTION" in
  "default")
    pcmanfm "$HOME/Recordings"
    ;;
  "2")
    pcmanfm "$HOME/Recordings"
    ;;
esac
