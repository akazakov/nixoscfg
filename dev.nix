{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
      bazel
      binutils
      clojure
      gcc
      gdb
      gnumake
      idea.clion
      idea.idea-community
      jdk
      jetty
      leiningen
      llvm
      maven
      mono
      plantuml
      ruby
      scala
      vscode
  ];
}
