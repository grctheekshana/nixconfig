{ config, pkgs, ... }:

{
  home.username = "chamod";
  home.homeDirectory = "/home/chamod";
  home.stateVersion = "25.11";
  programs.bash = {
    enable = true;
    shellAliases = {
      chamod = "echo I use nix btw";
    };
  };

  # This tells Home Manager to manage your home files
  home.file.".config/hypr" = {
    source = ./dotfiles/hypr; # Relative to this .nix file
    recursive = true; # Links the entire directory, not just the folder
  };

  # You can do the same for other apps
  home.file.".config/waybar".source = ./dotfiles/waybar;
  home.file.".config/fuzzel".source = ./dotfiles/fuzzel;
  home.file.".config/foot".source = ./dotfiles/foot;

  # home.sessionVariables = {
  #   QT_QPA_PLATFORMTHEME = "gtk3";
  # };

  home.packages = with pkgs; [
    libnotify
    hyprsunset
    hyprshot
    playerctl
    foot
    pavucontrol
    gnome-themes-extra
    adwaita-icon-theme # Standard GNOME icons
    discord
    telegram-desktop
    heroic
    mangohud
    mpv
    imv
    obs-studio

    tree-sitter
    lua-language-server # Lua
    nixd # Nix
    bash-language-server # Bash

    stylua # Lua formatter
    nixfmt # Nix formatter
    shfmt # Bash formatter

    # Add more packages here
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "grctheekshana";
        email = "email.grctheekshana@gmail.com";
      };
      init = {
        defaultBranch = "main";
      };
      # Move any other extraConfig items here inside settings
    };
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true; # Ensures the service is managed by systemd
  };

  # programs.quickshell = {
  #   enable = true;
  #   # Optional: Ensure it has systemd integration enabled
  #   systemd.enable = true;
  # };

  programs.firefox.enable = true;

  services.hypridle.enable = true;
  services.mako = {
    enable = true;
    settings.default-timeout = 5000;
  };
  services.hyprpolkitagent.enable = true;

  programs.fuzzel.enable = true;
  programs.hyprlock.enable = true;
  programs.neovim.enable = true;
  programs.btop.enable = true;

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "adw-gtk3-dark";
  };

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    gtk4.theme = null; # use GTK4's built-in Adwaita
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
