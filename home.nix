{ config,  pkgs, ... }: {
  # Версия Home Manager (оставляем как в системе)
  home.stateVersion = "25.05";

  # Твой софт для пользователя
  home.packages = with pkgs; [
    kitty
    anydesk
    vesktop
    libnotify
    xwayland-satellite
    ntfs3g
    fzf
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
    spawn-at-startup "dbus-update-activation-environment" "--systemd" "WAYLAND_DISPLAY" "DISPLAY" "XDG_CURRENT_DESKTOP"
    spawn-at-startup "xwayland-satellite"
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
        Page_Down { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }
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
        height = 34;

	#Отступы

        spacing = 4;
	margin-top = 8;
	margin-right = 12;
	margin-left = 12;
        
        # Левая часть панели
        modules-left = [ "niri/workspaces"  ];
        
        # Центр
        # modules-center = [ "clock" ];
        
        # Правая часть
        modules-right = [ "tray" "network" "pulseaudio" "hyprland/language" "clock" ];

        # Настройка самих модулей
	"niri/workspaces" = {
          format = "{icon}";
          format-icons = {
            active = "●";
            default = "○";
          };
        };	       
	 "clock" = {
          format = "{:%H:%M  %d.%m.%Y}";
	  tooltip-format = "<tt>{calendar}</tt>";
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
	style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: sans-serif;
        font-size: 14px;
        font-weight: 600;
      }

      window#waybar {
        /* Темно-синий полупрозрачный фон */
        background: rgba(30, 30, 46, 0.85); 
        border-radius: 14px;
        color: #cdd6f4;
      }

      /* Общий стиль для всех "плашек" на панели */
      #workspaces, #window, #clock, #pulseaudio, #network, #tray {
        margin: 4px 6px;
        padding: 2px 14px;
        border-radius: 10px;
        /* Фон самих плашек (чуть темнее панели) */
        background: rgba(24, 24, 37, 0.6); 
      }

      /* Стили для воркспейсов (точек слева) */
      #workspaces button {
        color: #6c7086;
        padding: 0 4px;
        background: transparent;
      }
      #workspaces button:hover {
        background: transparent;
        color: #cdd6f4;
      }
      #workspaces button.active {
        color: #a6da95; /* Зеленый для активного окна */
      }

      /* Раскрашиваем текст модулей */
      #clock { color: #8aadf4; }       /* Голубой */
      #pulseaudio { color: #f9e2af; }  /* Желтый */
      #network { color: #cba6f7; }     /* Фиолетовый */
      #window { color: #cdd6f4; }      /* Белый текст заголовка */
    '';

 };
	programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "alacritty";      # Чтобы консольные приложения открывались в нужном терминале
        layer = "overlay";           # Показывать поверх всех окон
        prompt = "\"❯   \"";         # Красивый значок поиска
        font = "sans-serif:size=14"; # Шрифт и размер
        lines = 10;                  # Количество строк в поиске
        width = 30;                  # Ширина окна
        horizontal-pad = 16;         # Отступы по бокам
        vertical-pad = 12;           # Отступы сверху и снизу
        inner-pad = 8;               # Отступ между строками
        border-width = 2;            # Толщина рамки
        border-radius = 12;          # Закругление углов
      };
      colors = {
        # Важно: цвета здесь в формате RRGGBBAA (последние 2 символа — это прозрачность)
        # "ff" — полностью непрозрачный, "ee" или "cc" — полупрозрачный, "00" — невидимый
        background = "181825ee";      # Темный полупрозрачный фон
        text = "cdd6f4ff";            # Основной текст (бело-серый)
        match = "8aadf4ff";           # Подсветка совпадений (голубой)
        selection = "313244ff";       # Фон выделенной строки (серый)
        selection-text = "cdd6f4ff";  # Текст выделенной строки
        selection-match = "8aadf4ff"; # Совпадение в выделенной строке
        border = "8aadf4ff";          # Цвет рамки (голубой)
      };
    };
  };
	services.mako = {
    enable = true;
    font = "sans-serif 12";
    width = 300;
    height = 100;
    margin = "20";               # Отступ от края экрана
    padding = "15";              # Внутренние отступы текста
    borderSize = 2;              # Толщина рамки
    borderRadius = 12;           # Закругление углов
    backgroundColor = "#181825ee"; # Темный фон как в лаунчере
    borderColor = "#8aadf4ff";     # Голубая рамка
    textColor = "#cdd6f4ff";       # Светлый текст
    defaultTimeout = 5000;         # Уведомление исчезнет само через 5 секунд
  };
   programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake ~/nixos-config";
      cfg = "cd ~/nixos-config";
    };
    oh-my-zsh = {
    enable = true;
    plugins = [
    "git"
    "sudo"
    ];
    theme = "darkblood";
    };
  };
}
