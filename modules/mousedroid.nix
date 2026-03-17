{
  perSystem = {pkgs, ...}: {
    packages.mousedroid = pkgs.stdenv.mkDerivation {
      name = "mousedroid";
      buildInputs = with pkgs; [wxGTK33 asio cmake git];

      src = pkgs.fetchFromGitHub {
        owner = "darusc";
        repo = "Mousedroid";
        rev = "3d077786c4ab333f648fc3c2b2ad668203af09b2";
        hash = "sha256-7qwADm+7m7TBJWlG7pqFtynb/RTcVm9O2z7Ri+ITm8g=";
      };

      configurePhase = ''
        git apply ${./patches/mousedroid.patch}
        cd server
        cmake -B"cmake" -DCMAKE_BUILD_TYPE=Release
        cd cmake
      '';

      buildPhase = ''
        make
      '';

      installPhase = ''
        cd ..
        mkdir -p $out

        cp cmake/bin/Mousedroid $out/
        cp icon.png $out/
        cp -r adb/* $out/adb/ 2>/dev/null || echo "No ADB folder found, skipping..."

        # Generate config.ini inside dist
        cat << EOF > $out/config.ini
        MINIMIZE_TASKBAR=0
        MOVE_SENSITIVITY=10
        RUN_STARTUP=0
        SCROLL_SENSITIVITY=3
        EOF

        mkdir -p $out/share/applications
        cat << EOF > $out/share/applications/mousedroid.desktop
        [Desktop Entry]
        Name=Mousedroid
        Exec=$out/Mousedroid
        Icon=$out/mousedroid/icon.png
        Type=Application
        Terminal=false
        Categories=Utility;
        EOF

        mkdir -p $out/etc/udev/rules.d
        echo 'KERNEL=="uinput", TAG+="uaccess"' > $out/etc/udev/rules.d/50-uinput.rules
      '';
    };
  };
}
