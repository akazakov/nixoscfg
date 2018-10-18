{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
      binutils
      clojure
      idea.idea-community
      jdk
      leiningen
      mono
      ruby
      scala
  ];
}
