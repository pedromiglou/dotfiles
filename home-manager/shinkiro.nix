{ config, lib, pkgs, unstable, nixGL, ... }:

{
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    autenticacao-gov-pt-bin
    ansible
    brave
    discord
    fastfetch
    gimp
    gamemode
    gamescope
    (heroic.override {
      extraPkgs = pkgs': with pkgs'; [
        gamescope
        gamemode
      ];
    })
    hyprpolkitagent
    hyprshot
    librewolf
    unstable.noctalia-shell
    obsidian
    onlyoffice-desktopeditors
    spotify
    steam
    supertux
    terminator
    terraform
    # tokyo-night-gtk
    tree
    vlc
    vscode
    wget
  ];

  programs.git.enable = true;
  programs.java.enable = true;
  programs.starship.enable = true;
}