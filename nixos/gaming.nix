{ config, lib, pkgs, unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    (heroic.override {
      extraPkgs = pkgs': with pkgs'; [
        gamescope
        gamemode
      ];
    })
    supertux
  ];

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
  programs.steam.enable = true;
}