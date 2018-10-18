# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nix.useSandbox = true;
  nixpkgs.overlays = [
    (import ./overlay/overlay.nix)
  ];

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./containers.nix
      ./vim.nix
      ./dev.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #boot.initrd.luks.devices.crypted.device = "/dev/nvme0n1p3";
  #fileSystems."/".device = "/dev/mapper/crypted";

  networking.hosts = {
    "127.0.0.1" = ["ba.ca.com"];
  };
  networking.hostName = "carbonara"; # Define your hostname.
  networking.firewall = {
    enable = true;
    allowedUDPPortRanges = [ {from = 32768; to = 61000; } ];
    allowedUDPPorts = [ 1900 5353 ];
    allowedTCPPorts = [ 8008 8009 ];
    logRefusedConnections = true;
    logRefusedUnicastsOnly = true;

  };
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.wireless.networks = {
    kramerica = (import ./private/wifi.nix);
  };

  time.timeZone = "US/Eastern";


  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
     # communication
     libreoffice
     mdp
     hexchat
     notmuch
     thunderbird
     zoom-us

     # networking
     avahi
     dnsutils
     mosh
     networkmanager-openvpn
     networkmanagerapplet

     # HW
     thinkfan
     lm_sensors


     bc
     procps
     coreutils
     nettools
     calibre
     chromium
     easyrsa
     file
     firefox
     firejail
     gnupg
     go
     google-chrome
     indent
     keepassxc
     libvirt
     lm_sensors
     manpages
     nmap
     openvpn
     pacman
     pidgin
     posix_man_pages
     ripgrep
     stdmanpages
     tor-browser-bundle-bin
     tree
     usbutils
     vim
     virtmanager
     wget
     yubico-piv-tool
     yubikey-personalization-gui
   ];
  #nixpkgs.config.hardware.u2f.enable = true;
  programs.zsh.enable = true;
  programs.java.enable = true;

  services.avahi.enable = true;
  services.udev.packages = [ pkgs.libu2f-host ];
  services.xserver.xkbOptions = "ctrl:nocaps";
  #services.ntp.enable = true;
  virtualisation.libvirtd.enable = true;
  networking.firewall.checkReversePath = false;
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.guest.enable =  true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.kdm.enable = true;
  # services.xserver.desktopManager.kde4.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.extraUsers.tyoma = {
     isNormalUser = true;
     uid = 1000;
     extraGroups = [ "vboxusers" "libvirtd" "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal" ];
     createHome = true;
   };

  security.sudo.wheelNeedsPassword = false;
  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";
}
