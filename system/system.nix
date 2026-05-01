{ config, pkgs, ... }:
{
#Мой сладенький любимый груб лоадер(маму его пинал)
  boot.loader = {
   efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot";
   };
   grub = {
   enable = true;
   device = "nodev";
   efiSupport = true;
   useOSProber = true;
   configurationLimit = 5;
   };
 };
  #Flake (или же пидарасы ебаные)
  nix.settings.experimental-features =
  ["nix-command" "flakes"];
  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Открывает порты для Steam Remote Play
  dedicatedServer.openFirewall = true; # Открывает порты для выделенных серверов (например, Source)
};
