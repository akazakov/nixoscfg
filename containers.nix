{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    docker
    lxc
    minikube
    rkt
    virtualbox
    kubernetes
  ];
}
