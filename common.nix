# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./containers.nix
      ./vim.nix
      ./dev.nix
    ];

  nix = {
	  useSandbox = true;
	  maxJobs = 16;
	  buildCores = 16;
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
     # thinkfan
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
     tree
     usbutils
     vim
     virtmanager
     wget
     yubico-piv-tool
     yubikey-personalization-gui
     openssl
     ripgrep
     pants
     manpages
     psmisc
     apg 		# Password gen
     bind		# nslookup, dig
     binutils	# strgings etc
     chromium
     git
     git-review
     idea.idea-community
     maven
     openjdk10
     python
     ruby
     sbt
     scala_2_11
     screen
     tcpdump
     tigervnc
     unzip
     vim
     wget
     xmove
     tree
     cifs-utils
     file
     keyutils
     mono54
     krb5Full.dev
     protobuf3_1
     lsof
     gnumake
     cmake
     gcc
     ctags
     wireshark
     zookeeper
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
  # system.stateVersion = "17.03";
}
