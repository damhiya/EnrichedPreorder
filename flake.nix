{
  description = "enriched-preorder development environment";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      forAllSystems =
        function:
        nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (
          system: function nixpkgs.legacyPackages.${system}
        );
    in
    {
      devShells = forAllSystems (
        pkgs:
        let
          rocq-core = pkgs.rocq-core_9_2;
        in
        {
          default = pkgs.mkShell {
            buildInputs = [ rocq-core ];
          };
        }
      );
    };
}
