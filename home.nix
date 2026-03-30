{ config, pkgs, ... }:

{
  home.username = "chamod";
  home.homeDirectory = "/home/chamod";
  home.stateVersion = "25.11";
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo I use nix btw";
      nixswitch = "sudo nixos-rebuild switch --flake ~/nixconfig#Chronos";
      nixtest = "sudo nixos-rebuild test --flake ~/nixconfig#Chronos";
    };
  };

  #----------------------Hyprland----------------------------
  # This tells Home Manager to manage your home files
  home.file.".config/hypr" = {
    source = ./dotfiles/hypr; # Relative to this .nix file
    recursive = true; # Links the entire directory, not just the folder
  };
  home.file.".config/hypr/colors.conf".text = with config.lib.stylix.colors; ''
    $base      = ${base00}
    $mantle    = ${base01}
    $surface0  = ${base03}
    $text      = ${base05}
    $lavender  = ${base07}
    $red       = ${base08}
    $orange    = ${base09}
    $yellow    = ${base0A}
    $green     = ${base0B}
    $teal      = ${base0C}
    $blue      = ${base0D}
    $pink      = ${base0E}
  '';

  #----------------------Waybar----------------------------
  programs.waybar = {
    enable = true;
    systemd.enable = true; # Ensures the service is managed by systemd
  };
  # You can do the same for other apps
  home.file.".config/waybar/config.jsonc".source = ./dotfiles/waybar/config.jsonc;
  home.file.".config/waybar/style.css".source = ./dotfiles/waybar/style.css;
  home.file.".config/waybar/power_menu.xml".source = ./dotfiles/waybar/power_menu.xml;
  # Disable Stylix's full waybar takeover
  stylix.targets.waybar.enable = false;

  # Generate a colors-only CSS file Stylix-side
  home.file.".config/waybar/colors.css".text = with config.lib.stylix.colors; ''
    @define-color base   #${base00};
    @define-color mantle #${base01};
    @define-color crust  #${base02};
    @define-color surface0 #${base03};
    @define-color surface1 #${base04};
    @define-color surface2 #${base05};
    @define-color text   #${base06};
    @define-color lavender #${base07};
    @define-color red    #${base08};
    @define-color orange #${base09};
    @define-color yellow #${base0A};
    @define-color green  #${base0B};
    @define-color teal   #${base0C};
    @define-color blue   #${base0D};
    @define-color pink   #${base0E};
    @define-color flamingo #${base0F};
  '';

  #----------------------Fuzzel----------------------------
  stylix.targets.fuzzel.enable = false;

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        dpi-aware = "yes";
        width = 70;
        lines = 7;
        line-height = 25;
        terminal = "foot";
        layer = "overlay";
        vertical-pad = 20;
        inner-pad = 10;
      };
      colors = with config.lib.stylix.colors; {
        background = "${base00}f2";
        text = "${base05}ff";
        match = "${base08}ff";
        selection = "${base01}ff";
        selection-text = "${base05}ff";
        selection-match = "${base08}ff";
        border = "${base02}ff";
      };
      border = {
        width = 1;
        radius = 12;
      };
    };
  };

  #----------------------Neovim----------------------------
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "/home/chamod/nixconfig/dotfiles/nvim";
  stylix.targets.neovim.enable = false;

  home.file.".config/nvim/lua/config/theme.lua".text = with config.lib.stylix.colors; ''
    return {
      base00 = '#${base00}',
      base01 = '#${base01}',
      base02 = '#${base02}',
      base03 = '#${base03}',
      base04 = '#${base04}',
      base05 = '#${base05}',
      base06 = '#${base06}',
      base07 = '#${base07}',
      base08 = '#${base08}',
      base09 = '#${base09}',
      base0A = '#${base0A}',
      base0B = '#${base0B}',
      base0C = '#${base0C}',
      base0D = '#${base0D}',
      base0E = '#${base0E}',
      base0F = '#${base0F}',
    }
  '';
  # home.file.".config/foot".source = ./dotfiles/foot;
  # home.file.".config/nvim".source = ./dotfiles/nvim;

  #----------------------Packages that installed for User----------------------------
  home.packages = with pkgs; [
    libnotify
    hyprsunset
    hyprshot
    playerctl
    pavucontrol
    discord
    telegram-desktop
    heroic
    mangohud
    mpv
    imv
    obs-studio
    fastfetch

    tree-sitter
    lua-language-server # Lua
    nixd # Nix
    bash-language-server # Bash

    stylua # Lua formatter
    nixfmt # Nix formatter
    shfmt # Bash formatter

    yazi

    # Add more packages here
  ];

  #----------------------Packages that installed for User----------------------------
  # Fix the GTK4 legacy warning
  gtk.gtk4.theme = null;

  stylix.targets.hyprland.enable = true;

  programs.brave.enable = true;

  #----------------------Foot----------------------------
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font Mono:size=11";
        pad = "10x10";
      };
      colors-dark = {
        background = "1e1e2e"; # base
        foreground = "cdd6f4"; # text
        regular0 = "45475a"; # surface1
        regular1 = "f38ba8"; # red
        regular2 = "a6e3a1"; # green
        regular3 = "f9e2af"; # yellow
        regular4 = "89b4fa"; # blue
        regular5 = "f5c2e7"; # pink
        regular6 = "94e2d5"; # teal
        regular7 = "bac2de"; # subtext1
        bright0 = "585b70"; # surface2
        bright1 = "f38ba8"; # red
        bright2 = "a6e3a1"; # green
        bright3 = "f9e2af"; # yellow
        bright4 = "89b4fa"; # blue
        bright5 = "f5c2e7"; # pink
        bright6 = "94e2d5"; # teal
        bright7 = "a6adc8"; # subtext0
        alpha = "0.8";
      };
    };
  };
  stylix.targets.foot.enable = false;

  #----------------------Git----------------------------
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

  #----------------------Quickshell----------------------------
  # programs.quickshell = {
  #   enable = true;
  #   # Optional: Ensure it has systemd integration enabled
  #   systemd.enable = true;
  # };

  #----------------------Firefox----------------------------
  # programs.firefox = {
  #   enable = true;
  #   profiles.default = {
  #     id = 0;
  #     name = "default";
  #     isDefault = true;
  #   };
  # };
  #
  # stylix.targets.firefox.profileNames = [ "default" ];

  #----------------------Other Utilities----------------------------
  services.hypridle.enable = true;
  services.mako = {
    enable = true;
    settings.default-timeout = 5000;
  };
  services.hyprpolkitagent.enable = true;

  programs.hyprlock.enable = true;
  programs.neovim.enable = true;
  programs.btop = {
    enable = true;
    # settings = {
    #   color_theme = "catppuccin_mocha"; # Or "catppuccin_mocha", "nord", etc.
    #   # theme_background = false;    # Set to false to keep your terminal's transparency
    # };
  };
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "${config.stylix.image}" ];
      wallpaper = [ ",${config.stylix.image}" ];
    };
  };
}
