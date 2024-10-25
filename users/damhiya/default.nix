{ pkgs, config, ... }@args:
{
  users.users.damhiya = {
    isNormalUser = true;
    home = "/home/damhiya";
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
    ];
    packages = [ pkgs.fish ];
  };

  home-manager.users.damhiya = {
    imports = [ ./programs ];
    home.username = "damhiya";
    home.homeDirectory = "/home/damhiya";
    home.stateVersion = "24.05";
  };
}
