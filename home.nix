{ config,  pkgs, ... }: {
  # Версия Home Manager (оставляем как в системе)
  home.stateVersion = "25.05";

  # Твой софт для пользователя
  home.packages = with pkgs; [
    fuzzel
    kitty
    # тут можно добавлять личный софт
  ];

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
{
  programs.niri = {
    enable = true;
    settings = {
      input = {
        keyboard = {
          xkb = {
            # Переключение раскладки на Alt+Shift
            layout = "us,ru";
            options = "grp:alt_shift_toggle";
          };
        };
        mouse = {
          # Отключаем акселерацию для точного аима в играх
          accel-profile = "flat"; 
        };
      };

      layout = {
        # Отступы между окнами и краями экрана
        gaps = 12;
        center-focused-column = "never";

        # Окна по умолчанию занимают половину экрана
        default-column-width = { proportion = 0.5; };

        # Рамка вокруг активного окна
        focus-ring = {
          enable = true;
          width = 2;
          active.color = "#7fc8ff";
          inactive.color = "#505050";
        };
      };

      spawn-at-startup = [
        { command = [ "alacritty" ]; }
      ];

      binds = {
        "Mod+Return".action.spawn = "alacritty";
        "Mod+D".action.spawn = "fuzzel";
        "Mod+Q".action.close-window = {};
        "Mod+Shift+E".action.quit = {};

        # Управление фокусом (стрелки)
        "Mod+Left".action.focus-column-left = {};
        "Mod+Right".action.focus-column-right = {};
        "Mod+Up".action.focus-window-up = {};
        "Mod+Down".action.focus-window-down = {};

        # Управление фокусом (vim-like)
        "Mod+H".action.focus-column-left = {};
        "Mod+L".action.focus-column-right = {};
        "Mod+K".action.focus-window-up = {};
        "Mod+J".action.focus-window-down = {};

        # Перемещение окон
        "Mod+Shift+Left".action.move-column-left = {};
        "Mod+Shift+Right".action.move-column-right = {};
        "Mod+Shift+Up".action.move-window-up = {};
        "Mod+Shift+Down".action.move-window-down = {};

        # Воркспейсы (цифры)
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        
        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        "Mod+Shift+4".action.move-column-to-workspace = 4;

        # Полноэкранный режим
        "Mod+F".action.maximize-column = {};
        "Mod+Shift+F".action.fullscreen-window = {};
      };

      # Правила: например, чтобы список друзей Steam не ломал тайлинг
      window-rules = [
        {
          matches = [ { app-id = "steam"; title = "Friends List"; } ];
          default-column-width = {};
        }
      ];
    };
  };
}
