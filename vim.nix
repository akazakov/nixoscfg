{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (vim_configurable.customize {
      name = "vim";
      vimrcConfig.customRC = builtins.readFile ./vimrc;
      vimrcConfig.vam.knownPlugins = pkgs.vimPlugins;
      vimrcConfig.vam.pluginDictionaries = [
        { names = [
            "Solarized"
          ];
        }
      ];
    })
  ];
  programs.vim.defaultEditor = true;
}
