{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
      acbuild
      docker
      lxc
      minikube
      rkt
      virtualbox
      kubernetes
  ];
}
