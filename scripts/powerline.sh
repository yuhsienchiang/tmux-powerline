#!/usr/bin/env bash
# setting the locale, some users have issues with different locales, this forces the correct one
export LC_ALL=en_US.UTF-8

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $current_dir/utils.sh

main()
{
  # set configuration option variables
  show_flags=$(get_tmux_option "@show-flags" false)
  show_left_icon=$(get_tmux_option "@show-left-icon" smiley)
  show_left_icon_padding=$(get_tmux_option "@left-icon-padding" 1)
  show_military=$(get_tmux_option "@military-time" false)
  #show_left_sep=$(get_tmux_option "@show-left-sep" )
  show_left_sep=$(get_tmux_option "@show-left-sep" )
  #show_right_sep=$(get_tmux_option "@show-right-sep" )
  show_right_sep=$(get_tmux_option "@show-right-sep" )
  show_border_contrast=$(get_tmux_option "@border-contrast" false)
  show_refresh=$(get_tmux_option "@refresh-rate" 5)
  IFS=' ' read -r -a plugins <<< $(get_tmux_option "")
  show_empty_plugins=$(get_tmux_option "@show-empty-plugins" true)

  # Nightfly Color Pallette

  # Background and foreground
  black='#011627'
  white='#c3ccdc'
  
  # Variations of blue-grey
  black_blue='#081e2f'
  dark_blue='#092236'
  deep_blue='#0e293f'
  slate_blue='#2c3043'
  pickle_blue='#38507a'
  regal_blue='#1d3b53'
  steel_blue='#4b6479'
  grey_blue='#1E303E'
  cadet_blue='#a1aab8'
  ash_blue='#acb4c2'
  white_blue='#d6deeb'
  
  # Core theme colors
  yellow='#e3d18a'
  peach='#ffcb8b'
  tan='#ecc48d'
  orange='#f78c6c'
  orchid='#e39aa6'
  dark_red='#fc514e'
  bright_red='#ff5874'
  violet='#c792ea'
  purple='#ae81ff'
  indigo='#5e97ec'
  blue='#82aaff'
  cyan='#7fdbca'
  emerald='#21c7a8'
  green='#a1cd5e'
  pink='#ff79c6'
  # Extra colors
  cyan_blue='#296596'
  bay_blue='#24567F'


  # Handle left icon configuration
  case $show_left_icon in
    smiley)
      left_icon="☺";;
    session)
      left_icon="#S";;
    window)
      left_icon="#W";;
    *)
      left_icon=$show_left_icon;;
  esac

  # Handle left icon padding
  padding=""
  if [ "$show_left_icon_padding" -gt "0" ]; then
    padding="$(printf '%*s' $show_left_icon_padding)"
  fi
  left_icon="$left_icon$padding"

  # Handle powerline option
  right_sep="$show_right_sep"
  right_head=
  right_tail=
  left_sep="$show_left_sep"
  left_head=
  left_tail=

  case $show_flags in
    false)
      flags=""
      current_flags="";;
    true)
      flags="#{?window_flags,#[fg=${steel_blue}]#{window_flags}, }"
      current_flags="#{?window_flags,#[fg=${black}]#{window_flags},}"
  esac

  # sets refresh interval to every 5 seconds
  tmux set-option -g status-interval $show_refresh

  # set the prefix + t time format
  if $show_military; then
    tmux set-option -g clock-mode-style 24
  else
    tmux set-option -g clock-mode-style 12
  fi

  # set length
  tmux set-option -g status-left-length 100
  tmux set-option -g status-right-length 100

  # pane border styling
  if $show_border_contrast; then
    tmux set-option -g pane-active-border-style "fg=${dark_red}"
  else
    tmux set-option -g pane-active-border-style "fg=${bright_red}"
  fi
  tmux set-option -g pane-border-style "fg=${steel_blue}"

  # message styling
  tmux set-option -g message-style "bg=${grey_blue},fg=${white}"

  # status bar
  tmux set-option -g status-style "bg=${black},fg=${white}"

  # Status left
  tmux set-option -g status-left "#[bg=${black},fg=${green}]#{?client_prefix,#[fg=${tan}],}${left_tail}#[bg=${green},fg=${black}]#{?client_prefix,#[bg=${tan}],} ${left_icon} #[fg=${green},bg=${black}]#{?client_prefix,#[fg=${tan}],}${left_sep}"
  powerbg=${black}

  # Window option
  tmux set-window-option -g window-status-current-format "#[fg=${black},bg=${blue}]${left_sep}#[fg=${black},bg=${blue}] #I #[fg=${black},bg=${blue}] #[fg=${black},bg=${blue}]#W${current_flags} #[fg=${blue},bg=${black}]${left_sep}"

  tmux set-window-option -g window-status-format "#[fg=${black},bg=${grey_blue}]${left_sep}#[fg=${steel_blue},bg=${grey_blue}] #I #W${flags}#[fg=${grey_blue},bg=${black}]${left_sep}"
  tmux set-window-option -g window-status-separator "" 
  tmux set-window-option -g window-status-activity-style "bold"
  tmux set-window-option -g window-status-bell-style "bold"
}

# run main function
main
