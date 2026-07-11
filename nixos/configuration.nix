# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Allow NFS NAS access.
  boot.supportedFilesystems = [ "nfs" ];

  # Config Nvidia Open Drivers
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;
  hardware.nvidia.modesetting.enable = true;

  # Define your hostname.
  networking.hostName = "shinkiro"; 

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_NUMERIC = "pt_PT.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
    LC_TIME = "pt_PT.UTF-8";
  };

  # Configure console keymap
  console = {
    keyMap = "pt-latin1";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Cinnamon Desktop Environment & SDDM.
  services.displayManager.sddm.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;

  # Enable the Hyprland Window Manager & SDDM Wayland.
  services.displayManager.sddm.wayland.enable = true;
  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "pt";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.miglou = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      librewolf
    ];
  };
  
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = true;
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
  programs.git.enable = true;
  programs.java.enable = true;
  programs.starship.enable = true;
  programs.steam.enable = true;
  programs.waybar.enable = true;

  environment.systemPackages = with pkgs; [
    ansible
    brave
    # brightnessctl
    discord
    distrobox
    fastfetch
    gimp
    (heroic.override {
      extraPkgs = pkgs': with pkgs'; [
        gamescope
        gamemode
      ];
    })
    hyprpaper
    hyprpolkitagent
    hyprshot
    nfs-utils
    # nwg-look
    obsidian
    onlyoffice-desktopeditors
    rofi
    spotify
    stow
    supertux
    terminator
    terraform
    # tokyo-night-gtk
    tree
    vlc
    # vscodium
    vscode
    wget
  ];

  # storage optimization options
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Enable Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Config Docker.
  virtualisation.docker.enable = true;
  hardware.nvidia-container-toolkit.enable = true;
  users.extraGroups.docker.members = [ "miglou" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}

