{ config,  pkgs, ... }:
{
  home.packages = with pkgs; [
    kitty
    anydesk
    vesktop
    libnotify
    xwayland-satellite
    ntfs3g
    fzf
    discord
    prismlauncher
    telegram-desktop

    ];
}
