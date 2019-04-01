
{ config, pkgs, ... }:
let
  zinc = pkgs.fetchzip {
    url = "http://downloads.typesafe.com/zinc/0.3.0/zinc-0.3.0.tgz";
    sha256 = "0pax5zim126yqsjwv881iarw7jybsqcsg0jz4px6rgixsp05bxyf";
  };

  myst = pkgs.st.override {
    patches = [
     # (pkgs.fetchpatch {
     #   name = "solr.patch";
     #   url = "https://st.suckless.org/patches/solarized/st-solarized-both-0.8.1.diff";
     #   sha256 = "1hsyfp3fjrh28rl0jm7k1p1kvgpy6b9w79hjz546labwfxv3p3br";
     # })
    ];
  };
in
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
  nixpkgs.config.allowBroken = true;

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
    cifs-utils
    cmake
    coreutils
    ctags
    dnsutils
    dwm
    dmenu
    easyrsa
    file
    firefox
    firejail
    gcc
    git
    git-review
    gnome3.gnome-session
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
    lshw
    lsof
    manpages
    maven
    mdp
    mono
    mosh
    neovim
    nettools
    networkmanager-openvpn
    networkmanagerapplet
    nmap
    notmuch
    openjdk
    openscad
    openssl
    openvpn
    pacman
    pants
    pidgin
    posix_man_pages
    procps
    protobuf3_1
    psmisc
    python
    ripgrep
    ruby
    sbt
    scala_2_11
    screen
    sqlite
    myst
    stdmanpages
    tcpdump
    thunderbird
    tigervnc
    tree
    terraform
    unzip
    usbutils
    vim
    virtmanager
    wget
    wireshark
    wmname
    yubico-piv-tool
    yubikey-personalization-gui
    zinc
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

  services.openssh.enable = true;

  services.xserver.enable = true;
  services.xserver.layout = "us";

  services.xserver.desktopManager.gnome3.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    extraUsers.tyoma = {
        isNormalUser = true;
        uid = 1000;
        extraGroups = [ "vboxusers" "libvirtd" "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal" "wireshark" ];
        createHome = true;
    };
    extraGroups.wireshark = {};
  };

  security.wrappers = {
    "dumpcap" = {
      source = "${pkgs.wireshark.out}/bin/dumpcap";
      group = "wireshark";
      owner = "root";
      setuid = false;
      setgid = false;
      capabilities = "cap_net_raw,cap_net_admin+eip";
    };
  };

  security.sudo.wheelNeedsPassword = false;
  # The NixOS release to be compatible with for stateful data such as databases.
  # system.stateVersion = "17.03";
}
