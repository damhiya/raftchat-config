{ pkgs, config, ... }@args:
{
  users.users.high = {
    isNormalUser = true;
    home = "/home/high";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };
}
