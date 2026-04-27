{ config,  pkgs, ... }: {
  # Версия Home Manager (оставляем как в системе)
  home.stateVersion = "25.05";

  # Твой софт для пользователя
  home.packages = with pkgs; [
    fuzzel
    kitty
    # тут можно добавлять личный софт
  ];
  programs.alacritty = {
    enable = true;
  settings = {
      window = {
        # Уровень непрозрачности (0.0 — полностью прозрачный, 1.0 — сплошной)
        opacity = 1.0; 
        
        # Внутренние отступы от краев окна
        padding = {
          x = 12;
          y = 12;
        };
      };
    };
 };

  # Включаем Git для пользователя
  programs.git.enable = true;
  programs.git.userName = "Bard";
  programs.git.userEmail = "your-email@example.com";

  # Включаем управление конфигами программ через Home Manager
  programs.kitty.enable = true;
  programs.kitty.settings = {
    font_size = "12.0";
    background_opacity = "0.9";
  };
  xdg.configFile."niri/config.kdl".text = ''
   spawn-at-startup "alacritty"
   spawn-at-startup "waybar"
    input {
        keyboard {
            xkb {
                layout "us,ru"
                options "grp:caps_toggle"
            }
        }
        mouse {
            accel-profile "flat"
        }
    }

    layout {
        gaps 12
        center-focused-column "never"
        default-column-width { proportion 0.5; }
        focus-ring {
            width 2
            active-color "#7fc8ff"
            inactive-color "#505050"
        }
    }

    spawn-at-startup "alacritty"

    binds {
        Mod+Return { spawn "alacritty"; }
        Mod+D { spawn "fuzzel"; }
        Mod+Q { close-window; }
        Mod+Shift+E { quit; }

        Mod+Left  { focus-column-left; }
        Mod+Right { focus-column-right; }
        Mod+Up    { focus-window-up; }
        Mod+Down  { focus-window-down; }

        Mod+H { focus-column-left; }
        Mod+L { focus-column-right; }
        Mod+K { focus-window-up; }
        Mod+J { focus-window-down; }

        Mod+Shift+Left  { move-column-left; }
        Mod+Shift+Right { move-column-right; }
        Mod+Shift+Up    { move-window-up; }
        Mod+Shift+Down  { move-window-down; }

        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        
        Mod+Shift+1 { move-column-to-workspace 1; }
        Mod+Shift+2 { move-column-to-workspace 2; }
        Mod+Shift+3 { move-column-to-workspace 3; }
        Mod+Shift+4 { move-column-to-workspace 4; }

        Mod+F { maximize-column; }
        Mod+Shift+F { fullscreen-window; }

        // Управление звуком
        XF86AudioRaiseVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"; }
        XF86AudioLowerVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
        XF86AudioMute        { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }

        // Скриншоты (grim + slurp)
        Print { spawn "sh" "-c" "grim -g \"$(slurp)\" ~/Pictures/screenshot-$(date +'%Y-%m-%d-%H%M%S').png"; }
    }

    window-rule {
        match app-id="steam" title="Friends List"
        default-column-width {}
    }

    window-rule {
        match app-id="cs2"
        open-fullscreen true
    }

    window-rule {
        match app-id="fuzzel"
        focus-ring { off; }
    };
   '';
   programs.waybar = {
    enable = true;
   # systemd.enable = true; # Чтобы Waybar сам запускался вместе с Niri
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 4;
        
        # Левая часть панели
        modules-left = [ "niri/workspaces" "niri/window" ];
        
        # Центр
        modules-center = [ "clock" ];
        
        # Правая часть
        modules-right = [ "tray" "network" "pulseaudio" "hyprland/language" ];

        # Настройка самих модулей
        "clock" = {
          format = "{:%H:%M  %d.%m.%Y}";
        };
        "pulseaudio" = {
          format = "Vol: {volume}%";
          format-muted = "Muted";
        };
        "network" = {
          format-wifi = "WiFi: {essid}";
          format-ethernet = "Eth: Connected";
          format-disconnected = "Offline";
        };
        "hyprland/language" = {
          format = "Lang: {}";
          format-en = "US";
          format-ru = "RU";
        };
      };
    };
  };
}
