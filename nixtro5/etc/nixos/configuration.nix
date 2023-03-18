  # Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];
    
  # make ready for nix flakes
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';  

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  networking.hostName = "nixtro5"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  

  # Set your time zone.
  time.timeZone = "America/Bogota";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_CO.UTF-8";
    LC_IDENTIFICATION = "es_CO.UTF-8";
    LC_MEASUREMENT = "es_CO.UTF-8";
    LC_MONETARY = "es_CO.UTF-8";
    LC_NAME = "es_CO.UTF-8";
    LC_NUMERIC = "es_CO.UTF-8";
    LC_PAPER = "es_CO.UTF-8";
    LC_TELEPHONE = "es_CO.UTF-8";
    LC_TIME = "es_CO.UTF-8";
  };

  services = {
    # hotspot
    create_ap = {
      enable = true;
      settings = {
        INTERNET_IFACE = "cni0";
        WIFI_IFACE = "wlp4s0";
        SSID = "Nixtro5";
        PASSPHRASE = "9096312iv";
      };
    };

    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ]; # nvidia / amdgpu
      desktopManager.plasma5.enable = true;

      layout = "us"; # latam / us
      xkbVariant = "";

    
      displayManager = {
        autoLogin.enable = true;
        autoLogin.user = "ivan";

        sddm = {
          enable = true;
          theme = "Breeze-Dark";
        };
      };
    };

    # sound
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };


    # CUPS
    printing.enable = true;

  };

  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  
  # Configure console keymap
  console.keyMap = "us";


  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # bluetooth
  #services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.package = pkgs.bluezFull; # connection guide: https://functor.tokyo/blog/2018-12-20-playstation-bluetooth-controller

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ivan = {
    isNormalUser = true;
    description = "ivan";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # editor
      kate
      jetbrains.webstorm
      lapce
      vscode
      postman
      # browser
      google-chrome # use blowfish for gpg kdewallet
      brave
      # testing
      k6
      # 3d
      blender
      sweethome3d.application
      # gaming
      steam
      mgba
      dolphin-emu
      ppsspp
    ];
  };

  fonts.fonts = with pkgs; [
    fira
    (nerdfonts.override { fonts = [ "FiraCode" "FiraMono" ]; })
  ];

  security.sudo.extraRules= [{  
    users = [ "ivan" ];
    commands = [
       { command = "ALL" ;
         options= [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
      }
    ];
  }];


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # K3s
  # This is required so that pod can reach the API server (running on port 6443 by default)
  networking.firewall.allowedTCPPorts = [ 6443 ];
  services.k3s.enable = true;
  services.k3s.role = "server";
  services.k3s.extraFlags = toString [
    # "--kubelet-arg=v=4" # Optionally add additional args to k3s
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # pkgs.k3s # kubernetes
    libsForQt5.bismuth # tile manager
    killall # terminate programs
    wget # downloader
    pciutils # show pci hardware
    inxi # show graphics configuration
    glxinfo # show graphic card details
    gnome.gnome-disk-utility # write iso files
    #openssh

    # multi iso boot:
    # find the ventoyWeb script -> $ sudo find / | grep VentoyWeb
    # start the ventoy web server -> sudo bash <full_path>/VentoyWeb.sh
    # navigate to the site and install
    ventoy-bin
    vial # keyboard config
    hwinfo # hardware info
    
    # compress
    zip
    gnutar
    ark # kde

    #shell
    neofetch
    xplr # file manager
    ranger # file viewer
    starship # cross shell prompt (git info, etc)
    terminal-typeracer # warmup
    exa # improve ls
    alacritty # opengl terminal
    
    # version control
    git
    git-crypt
    gnupg
    lazygit
    gitui
    jq
    
    # compilers
    rustc
    cargo
    nodejs
    go
    gcc11

    # editor
    helix
    
    # lsp
    rust-analyzer # rust
    nodePackages_latest.typescript-language-server # ts
    marksman # markdown
    gopls # golang
    nil # nix

    ##container
    podman
    distrobox

    # chat
    zoom-us
    discord
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  # experimental
  #nix.settings.experimental-features = [ "nix-command" ];

}