{ config, pkgs, ... }:

{
  imports = [
    ../../modules/home-manager.nix
    ../../users/damhiya
    ../../users/high
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "raftchat";
  networking = {
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
    wireless.enable = false;
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        443
        10022
        9001
      ];
      allowedTCPPortRanges = [
        {
          from = 3000;
          to = 3010;
        }
      ];
      allowedUDPPorts = [ ];
    };
  };

  time.timeZone = "Asia/Seoul";
  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    htop
    scripts.nixos-profile
  ];

  services = {
    openssh = {
      enable = true;
      ports = [ 10022 ];
    };
    cron = {
      enable = true;
      systemCronJobs = [
        "*/5 * * * * root /etc/duckdns/duck.sh >/dev/null 2>&1"
      ];
    };
  };

  system.stateVersion = "23.11";
}
