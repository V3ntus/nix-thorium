{
  description = "Thorium using Nix Flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    version = "124.0.6367.218";
  in {
    ##### x86_64-linux #####
    packages.x86_64-linux = let
      pkgs = import nixpkgs {system = "x86_64-linux";};
    in {
      thorium-avx = let
        inherit pkgs version;
        name = "thorium-avx";
        src = pkgs.fetchurl {
          url = "https://github.com/Alex313031/thorium/releases/download/M${version}/thorium_browser_${version}_AVX.AppImage";
          sha256 = "sha256-xwFB5uPNAaM9JhulJHIdKgWuo+eO0CGCBqUupcs4rnA=";
        };
        appimageContents = pkgs.appimageTools.extractType2 {inherit name src;};
      in
        pkgs.appimageTools.wrapType2 {
          inherit name version src;
          extraInstallCommands = ''
            install -m 444 -D ${appimageContents}/thorium-browser.desktop $out/share/applications/thorium-browser.desktop
            install -m 444 -D ${appimageContents}/thorium.png $out/share/icons/hicolor/512x512/apps/thorium.png
            substituteInPlace $out/share/applications/thorium-browser.desktop \
            --replace 'Exec=thorium --no-sandbox %U' 'Exec=${name} %U'
          '';
        };

      thorium-avx2 = let
        inherit pkgs version;
        name = "thorium-avx2";
        src = pkgs.fetchurl {
          url = "https://github.com/Alex313031/thorium/releases/download/M${version}/thorium_browser_${version}_AVX2.AppImage";
          sha256 = "sha256-y15pJWps+CdU9zNz+8eobBv09ENHJmUt14d9D+tzj98=";
        };
        appimageContents = pkgs.appimageTools.extractType2 {inherit name src;};
      in
        pkgs.appimageTools.wrapType2 {
          inherit name version src;
          extraInstallCommands = ''
            install -m 444 -D ${appimageContents}/thorium-browser.desktop $out/share/applications/thorium-browser.desktop
            install -m 444 -D ${appimageContents}/thorium.png $out/share/icons/hicolor/512x512/apps/thorium.png
            substituteInPlace $out/share/applications/thorium-browser.desktop \
            --replace 'Exec=thorium --no-sandbox %U' 'Exec=${name} %U'
          '';
        };

      thorium-sse3 = let
        inherit pkgs version;
        name = "thorium-sse3";
        src = pkgs.fetchurl {
          url = "https://github.com/Alex313031/thorium/releases/download/M${version}/thorium_browser_${version}_SSE3.AppImage";
          sha256 = "sha256-eDUFcVitJTVrIOlYZBT6ueTLDOXWYljkwYU4q6ozYZs=";
        };
        appimageContents = pkgs.appimageTools.extractType2 {inherit name src;};
      in
        pkgs.appimageTools.wrapType2 {
          inherit name version src;
          extraInstallCommands = ''
            install -m 444 -D ${appimageContents}/thorium-browser.desktop $out/share/applications/thorium-browser.desktop
            install -m 444 -D ${appimageContents}/thorium.png $out/share/icons/hicolor/512x512/apps/thorium.png
            substituteInPlace $out/share/applications/thorium-browser.desktop \
            --replace 'Exec=thorium --no-sandbox %U' 'Exec=${name} %U'
          '';
        };

      # AVX is compatible with most CPUs
      default = self.packages.x86_64-linux.thorium-avx;
    };

    apps.x86_64-linux = {
      thorium-avx = {
        type = "app";
        program = "${self.packages.x86_64-linux.thorium-avx}/bin/thorium-avx";
      };

      thorium-avx2 = {
        type = "app";
        program = "${self.packages.x86_64-linux.thorium-avx2}/bin/thorium-avx2";
      };

      thorium-sse3 = {
        type = "app";
        program = "${self.packages.x86_64-linux.thorium-sse3}/bin/thorium-sse3";
      };

      default = self.apps.x86_64-linux.thorium-avx;
    };

    ##### aarch64-linux #####
    packages.aarch64-linux = {
      thorium = let
        pkgs = import nixpkgs {system = "aarch64-linux";};
        name = "thorium";
        inherit version;
        src = pkgs.fetchurl {
          url = "https://github.com/Alex313031/Thorium-Raspi/releases/download/M${version}/Thorium_Browser_${version}_arm64.AppImage";
          sha256 = "sha256-gS3/f7wq5adOLZuS2T8SWfme/Z1bFqHSpMLUsENKlcw=";
        };
        appimageContents = pkgs.appimageTools.extractType2 {inherit name src;};
      in
        pkgs.appimageTools.wrapType2 {
          inherit name version src;
          extraInstallCommands = ''
            install -m 444 -D ${appimageContents}/thorium-browser.desktop $out/share/applications/thorium-browser.desktop
            install -m 444 -D ${appimageContents}/thorium.png $out/share/icons/hicolor/512x512/apps/thorium.png
            substituteInPlace $out/share/applications/thorium-browser.desktop \
            --replace 'Exec=thorium --no-sandbox %U' 'Exec=${name} %U'
          '';
        };

      default = self.packages.aarch64-linux.thorium;
    };

    apps.aarch64-linux = {
      thorium = {
        type = "app";
        program = "${self.packages.aarch64-linux.thorium}/bin/thorium";
      };

      default = self.apps.aarch64-linux.thorium;
    };
  };
}
