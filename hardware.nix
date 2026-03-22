{ config, pkgs, lib, ... }:
{
  # AMD GPU
  hardware.graphics = {
    enable = true;
    enable32Bit = true;        # needed for Steam/Wine
  };
  
  # ROCm for Blender GPU rendering
  #hardware.amdgpu.opencl.enable = true;

  # Bluetooth (hardware enable)
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Audio (hardware side)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  services.pulseaudio.enable = false;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;  # default, increase to 75 if you do heavy Blender work
  };

}
