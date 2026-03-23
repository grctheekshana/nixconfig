{ config, pkgs, ...}:

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
    recursive = true;         # Links the entire directory, not just the folder
  };

  # You can do the same for other apps
  home.file.".config/waybar".source = ./dotfiles/waybar;
  home.file.".config/fuzzel".source = ./dotfiles/fuzzel;
  home.file.".config/foot".source = ./dotfiles/foot;

  home.packages =  with pkgs; [
    # git
    libnotify
    hyprsunset
    hyprshot
    playerctl
    foot
    # brave
    pavucontrol
    # libsForQt5.qt5ct
    # kdePackages.qt6ct
    # libsForQt5.qtstyleplugin-kvantum
    # nwg-look
    # adw-gtk3
    gnome-themes-extra
    # glib
    adwaita-icon-theme  # Standard GNOME icons
    discord
    telegram-desktop
    heroic
    mpv
    imv
    obs-studio
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

  programs.firefox.enable = true;

  #services.waybar.enable = true;
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
    platformTheme.name = "gtk";
    style.name = "Adwaita-dark"; 
  }; 


  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
