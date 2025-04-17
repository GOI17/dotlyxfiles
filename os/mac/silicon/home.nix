{ pkgs }:

with import ../../../env.nix;

{
  home.packages = with pkgs; [
    raycast
  ];
  home.username = user;
  home.homeDirectory = home;
  # this is internal compatibility configuration 
  # for home-manager, don't change this!
  home.stateVersion = "23.05";
  # Let home-manager install and manage itself.
  programs.home-manager.enable = true;
  home.sessionVariables = {
    EDITOR = "vim";
  };
  programs.zsh = import "${dotfilesDirectory}/shell/zsh/zsh.nix";
  home.file = {
    ".wezterm.lua".source = "${dotfilesDirectory}/terminals/wezterm/wezterm.lua";
    ".config/nvim-nvchad".source = "${dotfilesDirectory}/editors/nvim-nvchad";
    ".config/nvim-nvchad".force = true;
    ".config/nvim-astro".source = "${dotfilesDirectory}/editors/nvim-astro";
    ".config/nvim-astro".force = true;
    ".config/nvim-scratch".source = "${dotfilesDirectory}/editors/nvim-scratch";
    ".config/nvim-scratch".force = true;
  };
}
