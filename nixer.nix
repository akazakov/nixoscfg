# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, options, lib,  ... }:

let cfg = {
#  defaultRealm = "KERB.IAMUAT.BWCE.IO";
#  domainRealm = "kerb.iamuat.bwce.io";
#  kerberosAdminServer = "kerb.iamuat.bwce.io";
#  kdc = "kerb.iamuat.bwce.io";

 defaultRealm = "CHURROS.LSDEV.FIERYLAB.COM";
 domainRealm = "churros.lsdev.fierylab.com";
 kerberosAdminServer = "churros.lsdev.fierylab.com";
 kdc = "churros.lsdev.fierylab.com";
};


jdk = pkgs.openjdk10;
maven = pkgs.maven.override { inherit jdk; };
krb5Full = pkgs.krb5Full.overrideAttrs (orig: {
    # buildInputs = orig.buildInputs ++ [ pkgs.keyutils ];
  #version = "1.17";
  #src = pkgs.fetchurl {
  #  url = "http://web.mit.edu/kerberos/dist/krb5/1.17/krb5-1.17.tar.gz";
  #  sha256 = "1xc1ly09697b7g2vngvx76szjqy9769kpgn27lnp1r9xln224vjs";
  #};
  patches = [ /home/tyoma/kerberos/kcpytkt.patch ];

});

cifs-utils = pkgs.cifs-utils.overrideAttrs (orig: {
  patches = [ /home/tyoma/kerberos/cifs-upcall.patch ];
 # #src = /home/tyoma/kerberos/tmp/cifs-utils-12323
 });

 #mysystemd = pkgs.systemd.overrideAttrs (orig: {
 #       #src = /home/tyoma/projects/systemd/source ;
 #       patches = [ /home/tyoma/projects/systemd/recursive_mount.patch ];
 #});


 fluentdPort = "24224";
 nixHostIP = "10.233.1.1"; # This is the IP of the nix host from the view of the container. It is baked into NixOS

in
  {
  #nixpkgs.overlays = [
  #  #(import ./overlay/overlay.nix)
  #];

  imports = [
    <nixpkgs/nixos/modules/virtualisation/amazon-image.nix>
    ./common.nix
  ];
  ec2.hvm = true;

  nix = {
    useSandbox = true;
    binaryCaches = [
      "https://cache.nixos.org/"
      "s3://prod-nix-cache/"
    ];
    requireSignedBinaryCaches = false;

    trustedBinaryCaches = [
      "s3://prod-nix-cache/"
    ];
    maxJobs = lib.mkForce 16;
    buildCores = lib.mkForce 16;
    nixPath = options.nix.nixPath.default ++ [
      "hydra-worker-container=${/tmp/hydra-worker-container.nix}"
      "vendored-modules=${/tmp/bundle/modules}"
    ];
  };

  networking = {
    hostName = "nixer";
    hosts = {
      "10.100.15.144" = [ "win-i6mrs9b5lau.kerb.iamuat.bwce.io" "WIN-I6MRS9B5LAU" ];
      "10.100.15.124" = ["sso.iamuat.bwce.io"];
      "172.28.15.226" = ["ak-kerberos-test"];
      #"172.28.15.89" = ["HYDRAETLMSSQL.kerb.iamuat.bwce.io" "HYDRAETLMSSQL"];
      "172.28.9.89" = [  "webserver.hydra.local.me.dev.ls.lsdev.fierylab.com"];
      "127.0.0.1" = [ "nixer" ];
    };
    extraHosts = "";
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 5901 5902 12345 9001 5005];
      logRefusedConnections = true;
      logRefusedUnicastsOnly = true;
      checkReversePath = false;
    };

    nameservers = [
      #"10.100.15.184"
      #"10.100.15.83"
      "172.28.8.43"
      "172.28.15.72"
      "172.28.8.2"
    ];

    nat = {
      enable = true; # nat for the container
      internalInterfaces = ["ve-kolobok" "ve-hydra"];
      externalInterface = "eth0";
    };
  };

  environment = {
    systemPackages = with pkgs; [
      cifs-utils
    ];

    etc."request-key.conf".text = ''
      create cifs.idmap * * /run/current-system/sw/bin/cifs.idmap %k
      create cifs.spnego * * /run/current-system/sw/bin/cifs.upcall %k
    '';

    sessionVariables.LD_LIBRARY_PATH = ["${pkgs.krb5Full.out}/lib"];
  };

  #systemd.package = mysystemd;
  security.wrappers = {
    "mount.cifs".source = "${pkgs.cifs-utils.out}/bin/mount.cifs";
  };
  sound.enable = lib.mkForce false;
  services.udisks2.enable = lib.mkForce false;

  krb5 = {
    enable = true;
    kerberos = krb5Full;
    libdefaults = {
      default_realm = cfg.defaultRealm;
      udp_preference_limit = 1; #  UDP is not open on the firewall
      # default_ccache_name = "KEYRING:user:krb";
    };

    domain_realm = ''${cfg.domainRealm} = ${cfg.defaultRealm}'';
    realms = {
      ${cfg.defaultRealm} = {
        kdc = cfg.kdc;
        admin_server = cfg.kerberosAdminServer;
      };
    };
  };

  boot.postBootCommands = ''
    mkdir -p /helloWorld
    mkdir -p /sbin
    ln -sf /run/current-system/sw/bin/request-key /sbin/request-key
  '';
}
