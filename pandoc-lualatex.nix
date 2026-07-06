{
  description = "Pandoc + LuaLaTeX environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      forAllSystems = f:
        nixpkgs.lib.genAttrs systems (system:
          f nixpkgs.legacyPackages.${system});
    in
    {
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            pandoc

            texlive.combined.scheme-full

            noto-fonts
            noto-fonts-cjk-sans
            noto-fonts-cjk-serif
          ];

          shellHook = ''
            echo "Pandoc + LuaLaTeX environment"
            pandoc --version
            lualatex --version
          '';
        };
      });
    };
}
