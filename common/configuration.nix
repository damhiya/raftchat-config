{ config, pkgs, ... }:

{
  imports = [
    ../modules/home-manager.nix
    ../users/damhiya
    ../users/high
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
        2052
        2083
        2082
        2086
        2087
        2096
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
    # compressors
    zip
    unzipNLS
    zstd
    lz4
    p7zip

    # network
    wget

    # system management
    htop
    btop
    pstree
    killall
    tree
    tmux
    bat
    silver-searcher
    delta
    duf
    fastfetch
    scripts.nixos-profile

    # development
    vim
    git
    github-runner
  ];

  virtualisation.docker.enable = true;
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
