# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./common.nix
  ];

  environment.systemPackages = with pkgs; [
    thinkfan
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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


  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";
}
