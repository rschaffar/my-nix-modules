{
  description = "Reusable NixOS and Home Manager profile modules";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      # Helper to import a module and make it system-agnostic
      importModule = path: import path;
    in
    {
      # Home Manager modules - import individually or use 'all'
      homeModules = {
        # Profiles namespace modules will be added here as we migrate them
      };

      # NixOS modules - import individually or use 'all'
      nixosModules = {
        # NixOS modules will be added here as we migrate them
      };
    };
}
