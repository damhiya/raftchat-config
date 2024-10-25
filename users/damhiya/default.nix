{ pkgs, config, ... }@args:
{
  users.users.damhiya = {
    isNormalUser = true;
    home = "/home/damhiya";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    packages = [ pkgs.fish ];
  };
}
