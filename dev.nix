{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
      binutils
      clojure
      idea.clion
      idea.idea-community
      vscode
      jdk
      leiningen
      mono
      ruby
      scala
      plantuml
      gcc
      gnumake
      llvm
  ];
}
