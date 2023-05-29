#!/usr/bin/env bash
# setting the locale, some users have issues with different locales, this forces the correct one
export LC_ALL=en_US.UTF-8

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $current_dir/utils.sh
source $current_dir/themes/nightfly.sh

main()
{
  # set configuration option variables
  show_flags=$(get_tmux_option "@show-flags" false)
  show_left_icon=$(get_tmux_option "@show-left-icon" smiley)
  show_left_icon_padding=$(get_tmux_option "@left-icon-padding" 1)
  show_military=$(get_tmux_option "@military-time" false)
  
  show_left_sep=$(get_tmux_option "@show-left-sep" )
  show_left_head=$(get_tmux_option "@show-left-head" )
  show_left_tail=$(get_tmux_option "@show-left-tail" )
  
  show_border_contrast=$(get_tmux_option "@border-contrast" false)
  show_refresh=$(get_tmux_option "@refresh-rate" 5)
  IFS=' ' read -r -a plugins <<< $(get_tmux_option "")

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
  left_sep="$show_left_sep"
  left_head="$show_left_head"
  left_tail="$show_left_tail"

  case $show_flags in
    false)
      flags=""
      current_flags="";;
    true)
      flags="#{?window_flags,#[fg=${window_font}]#{window_flags}, }"
      current_flags="#{?window_flags,#[fg=${active_window_font}]#{window_flags},}"
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

  # pane border styling
  if $show_border_contrast; then
    tmux set-option -g pane-active-border-style "fg=${dark_active_border}"
  else
    tmux set-option -g pane-active-border-style "fg=${bright_active_border}"
  fi
  tmux set-option -g pane-border-style "fg=${border}"

  # message styling
  tmux set-option -g message-style "bg=${background},fg=${foreground}"

  # status bar
  tmux set-option -g status-style "bg=${background},fg=${foreground}"

  # Status left
  tmux set-option -g status-left "#[bg=${session_font},fg=${session_tag}]#{?client_prefix,#[fg=${session_prefix_tag}],}${left_tail}#[bg=${session_tag},fg=${session_font}]#{?client_prefix,#[bg=${session_prefix_tag}],} ${left_icon} #[fg=${session_tag},bg=${session_font}]#{?client_prefix,#[fg=${session_prefix_tag}],}${left_sep}"
  
  # Remove right status info
  tmux set-option -g status-right ""

  # Window option
  tmux set-window-option -g window-status-current-format "#[fg=${active_window_font},bg=${active_window_tag}]${left_sep}#[fg=${active_window_font},bg=${active_window_tag}] #I #[fg=${active_window_font},bg=${active_window_tag}] #[fg=${active_window_font},bg=${active_window_tag}]#W${current_flags} #[fg=${active_window_tag},bg=${active_window_font}]${left_sep}"

  tmux set-window-option -g window-status-format "#[fg=${background},bg=${window_tag}]${left_sep}#[fg=${window_font},bg=${window_tag}] #I #W${flags}#[fg=${window_tag},bg=${background}]${left_sep}"

  tmux set-window-option -g window-status-separator "" 
  tmux set-window-option -g window-status-activity-style "bold"
  tmux set-window-option -g window-status-bell-style "bold"
}

# run main function
main
