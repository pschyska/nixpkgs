{ callPackage, makeFontsConf, gnome2, buildFHSUserEnv }:

let
  mkStudio = opts: callPackage (import ./common.nix opts) {
    fontsConf = makeFontsConf {
      fontDirectories = [];
    };
    inherit (gnome2) GConf gnome_vfs;
    inherit buildFHSUserEnv;
  };
  stableVersion = {
    version = "2020.3.1.26"; # "Android Studio Arctic Fox (2020.3.1)"
    sha256Hash = "NE2FgjXtXTCVrCWRakqPhzAGn3blpf0OugJSKviPVBs=";
  };
  betaVersion = {
    version = "2021.1.1.17"; # "Android Studio Bumblebee (2021.1.1) Beta 4"
    sha256Hash = "5WLUgCmdrK0PArc4eQQTNbEokq4DReKRwsZOWKb+Td4=";
  };
  latestVersion = { # canary & dev
    version = "2021.2.1.3"; # "Android Studio Chipmunk (2021.2.1) Canary 3"
    sha256Hash = "sha256-xIVdM28NDadvJklDIw71iJ7Z5GPVJ1ZDJ+t1y+bt8cE=";
  };
in {
  # Attributes are named by their corresponding release channels

  stable = mkStudio (stableVersion // {
    channel = "stable";
    pname = "android-studio";
  });

  beta = mkStudio (betaVersion // {
    channel = "beta";
    pname = "android-studio-beta";
  });

  dev = mkStudio (latestVersion // {
    channel = "dev";
    pname = "android-studio-dev";
  });

  canary = mkStudio (latestVersion // {
    channel = "canary";
    pname = "android-studio-canary";
  });
}
