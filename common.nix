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
    apg
    avahi
    bc
    bind   # nslookup, dig
    binutils # strgings etc
    calibre
    chromium
    chromium
    cifs-utils
    cmake
    coreutils
    ctags
    dnsutils
    easyrsa
    file
    file
    firefox
    firejail
    gcc
    git
    git-review
    gnucash
    gnumake
    gnupg
    go
    google-chrome
    hexchat
    idea.idea-community
    indent
    keepassxc
    keyutils
    keyutils # keyrings
    krb5Full.dev
    libreoffice
    libvirt
    linuxPackages.perf
    lm_sensors
    lm_sensors
    lshw
    lsof
    manpages
    manpages
    mdp
    mono
    mosh
    neovim
    nettools
    networkmanager-openvpn
    networkmanagerapplet
    nmap
    notmuch
    openscad
    openssl
    openvpn
    pacman
    pidgin
    posix_man_pages
    procps
    protobuf3_1
    psmisc
    psmisc
    python
    ripgrep
    ripgrep
    ruby
    sbt
    scala_2_11
    screen
    sqlite
    stdmanpages
    tcpdump
    thunderbird
    tigervnc
    tigervnc
    tree
    tree
    unzip
    usbutils
    vim
    vim
    virtmanager
    wget
    wget
    wireshark
    yubico-piv-tool
    yubikey-personalization-gui
    zookeeper
    zoom-us
  ];
  programs.zsh.enable = true;
  programs.java.enable = true;

  services.avahi.enable = true;
  services.udev.packages = [ pkgs.libu2f-host ];
  services.xserver.xkbOptions = "ctrl:nocaps";
  virtualisation.libvirtd.enable = true;
  networking.firewall.checkReversePath = false;
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.guest.enable =  true;
  virtualisation.docker.enable =  true;

  services.openssh.enable = true;

  services.xserver.enable = true;
  services.xserver.layout = "us";

  services.xserver.desktopManager.gnome3.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.tyoma = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "vboxusers" "libvirtd" "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal" "docker"];
    createHome = true;
  };

  security.sudo.wheelNeedsPassword = false;
  programs.bash.interactiveShellInit = builtins.readFile ./bashrc;
}
