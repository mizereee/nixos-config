{ pkgs, ... }: {
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
}
