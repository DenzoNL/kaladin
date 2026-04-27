{ pkgs, ... }:

{
  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    hyprshot
    brightnessctl
    pavucontrol
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    # UWSM owns the systemd target; let it manage the session.
    systemd.enable = false;

    settings = {
      monitor = "DP-2,3440x1440@239.99,auto,1";

      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "QT_QPA_PLATFORMTHEME,kvantum"
        "QT_STYLE_OVERRIDE,kvantum"
      ];

      exec-once = [
        "waybar"
        "hyprpaper"
        "systemctl --user start hyprpolkitagent"
      ];

      "$mod" = "SUPER";
      "$terminal" = "alacritty";
      "$menu" = "walker";

      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 2;
        layout = "dwindle";
      };

      decoration = {
        rounding = 6;
        blur.enabled = false;
      };

      animations.enabled = true;

      input = {
        kb_layout = "us";
        kb_variant = "intl";
        follow_mouse = 1;
        sensitivity = -0.5;
      };

      dwindle = {
        preserve_split = true;
      };

      windowrule = [
        "workspace 1 silent, match:class ^([Vv]ivaldi.*)$"
        "workspace 2 silent, match:class ^(dev\\.zed\\.Zed|[Zz]ed)$"
        "workspace 3 silent, match:class ^([Ss]ignal)$"
        "workspace 3 silent, match:class ^([Kk]arere)$"
        "workspace 3 silent, match:class ^(discord|vesktop|WebCord)$"
        "workspace 4 silent, match:class ^([Ss]team)$"
      ];

      bind = [
        "$mod, RETURN, exec, $terminal"
        "$mod, Q, killactive,"
        "$mod, SPACE, exec, $menu"
        "$mod, L, exec, hyprlock"
        "$mod SHIFT, E, exit,"
        "$mod, V, togglefloating,"
        "$mod, F, fullscreen,"
        "$mod, J, layoutmsg, togglesplit"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"

        ", PRINT, exec, hyprshot -m region"
        "SHIFT, PRINT, exec, hyprshot -m window"
        "CTRL, PRINT, exec, hyprshot -m output"

        "$mod, minus, resizeactive, -100 0"
        "$mod, equal, resizeactive,  100 0"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];

      bindl = [
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPrev, exec, playerctl previous"
      ];
    };
  };

  catppuccin = {
    hyprland.enable = true;
    hyprlock = {
      enable = true;
      useDefaultConfig = false;
    };
    kvantum.enable = true;
    mako.enable = true;
    waybar.enable = true;
  };

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  programs.walker = {
    enable = true;
    runAsService = true;
  };

  programs.waybar = {
    enable = true;
    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 36;
      spacing = 0;

      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "hyprland/window" ];
      modules-right = [ "cpu" "memory" "pulseaudio" "network" "tray" "clock" ];

      "hyprland/workspaces" = {
        format = "{name}";
        on-click = "activate";
      };

      "hyprland/window" = {
        format = "{title}";
        max-length = 80;
        separate-outputs = true;
      };

      cpu = {
        format = "  {usage}%";
        interval = 2;
      };

      memory = {
        format = "  {percentage}%";
        interval = 5;
      };

      pulseaudio = {
        format = "{icon}  {volume}%";
        format-muted = "  muted";
        format-icons.default = [ "" "" "" ];
        on-click = "pavucontrol";
      };

      network = {
        format-wifi = "  {signalStrength}%";
        format-ethernet = "  {ipaddr}";
        format-disconnected = "󰖪  off";
        tooltip-format-wifi = "{essid} ({signalStrength}%)";
      };

      clock = {
        format = "  {:%H:%M}";
        format-alt = "  {:%a %Y-%m-%d  %H:%M}";
        tooltip-format = "<tt>{calendar}</tt>";
      };

      tray = {
        spacing = 12;
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", "Symbols Nerd Font Mono";
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: transparent;
        color: @text;
      }

      #workspaces,
      #window,
      #cpu,
      #memory,
      #pulseaudio,
      #network,
      #clock,
      #tray {
        background: @base;
        border-radius: 10px;
        margin: 4px 3px;
        padding: 0 12px;
      }

      #workspaces {
        padding: 0 6px;
      }

      #workspaces button {
        padding: 0 8px;
        margin: 3px 2px;
        color: @overlay0;
        background: transparent;
        border-radius: 6px;
        border: none;
        transition: all 0.15s ease-in-out;
      }

      #workspaces button:hover {
        background: @surface0;
        color: @text;
      }

      #workspaces button.active {
        background: @accent;
        color: @base;
      }

      #workspaces button.urgent {
        background: @red;
        color: @base;
      }

      #window {
        color: @subtext1;
        font-style: italic;
      }

      #cpu        { color: @yellow; }
      #memory     { color: @green; }
      #pulseaudio { color: @peach; }
      #pulseaudio.muted { color: @overlay0; }
      #network    { color: @blue; }
      #network.disconnected { color: @red; }
      #clock      { color: @accent; font-weight: bold; }

      #tray {
        padding: 0 10px;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
      }
    '';
  };

  services.mako = {
    enable = true;
    settings = {
      default-timeout = 5000;
      border-radius = 6;
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        grace = 2;
      };
      background = [
        {
          color = "rgba(25, 25, 35, 1.0)";
          blur_passes = 2;
        }
      ];
      input-field = [
        {
          size = "300, 50";
          position = "0, -100";
          halign = "center";
          valign = "center";
          outline_thickness = 2;
          dots_center = true;
          fade_on_empty = true;
          placeholder_text = "Password";
        }
      ];
      label = [
        {
          text = "$TIME";
          font_size = 64;
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 600;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "${./wallpaper.jpg}" ];
      wallpaper = [{
        monitor = "DP-2";
        path = "${./wallpaper.jpg}";
      }];
    };
  };
}
