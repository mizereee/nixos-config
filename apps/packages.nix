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
    telegram-desktop
    easyeffects
    rust-analyzer
    cargo
    rustc
    gcc
    pkg-config
    openssl
    rustfmt
    clippy
    helix
    jdk21
    unstable.noctalia-shell
  ];
}
