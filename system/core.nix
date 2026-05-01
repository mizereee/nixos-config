{ config, pkgs, ... }:

{ #мой пользователь(если будут другие то и другие)
  users.users.miscere = {
    isNormalUser = true;
    description = "miscere";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
    shell = pkgs.zsh;
  };
  #консольная расскладка
  console.keyMap = "ua-utf";

  #моя временая зона
  time.timeZone = "Europe/Kyiv";

 #локализации(или локали, я не понял если честно)
  i18n.defaultLocale = "ru_UA.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "uk_UA.UTF-8";
    LC_IDENTIFICATION = "uk_UA.UTF-8";
    LC_MEASUREMENT = "uk_UA.UTF-8";
    LC_MONETARY = "uk_UA.UTF-8";
    LC_NAME = "uk_UA.UTF-8";
    LC_NUMERIC = "uk_UA.UTF-8";
    LC_PAPER = "uk_UA.UTF-8";
    LC_TELEPHONE = "uk_UA.UTF-8";
    LC_TIME = "uk_UA.UTF-8";
  };
}
