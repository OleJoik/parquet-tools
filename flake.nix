{
  description = "Apache Parquet Tools flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.default = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;

      parquetToolsJar = pkgs.fetchurl {
        url = "https://repo1.maven.org/maven2/org/apache/parquet/parquet-tools/1.11.2/parquet-tools-1.11.2.jar";
        sha256 = "sha256-wMrG/ALYayOqsYX2HGK/onPh/8MqkdA8o7GUSfqq1ZM=";
      };

    in pkgs.stdenv.mkDerivation {
      name = "parquet-tools";
      buildInputs = [ pkgs.hadoop pkgs.makeWrapper ];

      dontUnpack = true;

      installPhase = ''
        mkdir -p $out/bin $out/share
        cp ${parquetToolsJar} $out/share/parquet-tools.jar

        makeWrapper ${pkgs.hadoop}/bin/hadoop $out/bin/parquet-tools \
          --add-flags "jar $out/share/parquet-tools.jar"
      '';
    };

    apps.x86_64-linux.default = {
      type = "app";
      program = "${self.packages.x86_64-linux.default}/bin/parquet-tools";
    };
    devShells.default = nixpkgs.legacyPackages.${system}.mkShell {
      buildInputs = [ self.packages.${system}.default ];
    };
  };
}
