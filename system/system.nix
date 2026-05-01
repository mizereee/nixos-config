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
  #ласт ядро линукс
  boot.kernelPackages = pkgs.linuxPackages_latest;

  #Flake (или же пидарасы ебаные)
  nix.settings.experimental-features =
  ["nix-command" "flakes"];
  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Открывает порты для Steam Remote Play
  dedicatedServer.openFirewall = true; # Открывает порты для выделенных серверов (например, Source)
    };
  # services.xserver.libinput.enable = true; #поддержка тачпада

  #ну блять понятно что сеть<3<3<3<3
  networking.networkmanager.enable = true;

  networking.hostName = "nixos" #имя моего хоста СУКА ПИЗДА ВАЖНО ЧТОБ БЫЛО ОДНО



  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  fileSystems."/mnt/gamedisk" = {
    device = "/dev/disk/by-uuid/9CA0D0A9A0D08B62";
    fsType = "ntfs-3g";
    options = [ "rw" "uid=1000" "gid=100" "nofail" ]; # uid 1000 обычно это основной юзер
  };;






}
