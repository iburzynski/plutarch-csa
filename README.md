# plutarch-csa
Plutarch dev environment for EMURGO CSA

### 1. **Install `nix`**
***
  - If you're setting up Nix on your system for the first time, try Determinate Systems' **[Zero-to-Nix](https://zero-to-nix.com)** in lieu of the official installer, as it provides an easier tool for **[installing](https://zero-to-nix.com/start/install)** and **[uninstalling](https://zero-to-nix.com/start/uninstall)** Nix.
  - Alternatively, you may follow the instructions for **multi-user installation** for your OS at **[nixos.org](https://nixos.org/download.html)**. This approach will require some additional configuration and it will be harder to uninstall Nix should you need to. It is only recommended if you've previously installed Nix on your system, as it will detect and repair a previous installation as needed.
  - When you are finished installing Nix, close the terminal session and open a fresh one.
***
### 2. **Configure `nix.conf`**
***
  - Edit `/etc/nix/nix.conf`: this requires root access to edit. Use a terminal-based editor like `nano` (i.e.):

      ```sh
      sudo nano /etc/nix/nix.conf
      ```

    >**Note:** if no configuration file exists at `/etc/nix/nix.conf` it's possible the file is located elsewhere, depending on your OS. Run `find / -name "nix.conf" 2>/dev/null` to find the location of the file (this may take several minutes).

  - Modify the file following the instructions below:

    ```
    # Sample /etc/nix/nix.conf

    # Step 2a: Add this line to enable required features if missing (if you used the Zero-to-Nix installer this should already be added)
    experimental-features = nix-command flakes ca-derivations

    # Step 2b: Add your username to trusted-users (also include 'root' to prevent overriding default setting)
    trusted-users = root your-username

    # Step 2c: Avoid unwanted garbage collection with nix-direnv
    keep-outputs = true
    ```

  - **🚨 IMPORTANT!** You must restart the `nix-daemon` to apply the changes

    **Linux:**

      ```sh
      sudo systemctl restart nix-daemon
      ```

    **MacOS:**

      ```sh
      sudo launchctl stop org.nixos.nix-daemon
      sudo launchctl start org.nixos.nix-daemon
      ```

### 3. **Install `direnv` (Optional)**
  - This repository is designed to work with the `direnv` utility to provide convenient automatic loading of the Nix development environment via the `.envrc` file.
  - The `.envrc` file also configures environment variables to build `cabal` outputs in a local directory (`.cabal`) and generates a symlink to the environment's installation of Haskell Language Server (HLS), mitigating potential conflicts with system-wide Haskell tooling in VS Code/Codium.
  - While the environment can be loaded manually without `direnv` (using `nix develop --accept-flake-config`), it is recommended to install and use `direnv` for best experience.
  - You can install `direnv` using Nix with the command `nix profile install nixpkgs#direnv`. This is the recommended method, as versions of `direnv` provided by other package managers (like `apt` on Linux) may be outdated and not support usage with `nix-direnv`. Alternative installation methods are explained [here](https://direnv.net/docs/installation.html).
  - After installation, `direnv` must be "hooked" into your preferred terminal shell by adding a snippet to the shell configuration file(s).
    - For Linux users using `bash`, the following snippet should be added to the bottom of your `~/.bashrc` file:
      ```
      eval "$(direnv hook bash)"
      ```
    - For MacOS users using `zsh`, the following snippet should be added to the bottom of your `~/.zprofile` and `~/.zshrc` files:
      ```
      eval "$(direnv hook zsh)"
      ```
    - Instructions for alternative shells are provided [here](https://direnv.net/docs/hook.html).
  - After completing installation and hooking `direnv` into your preferred terminal shell, open a new terminal session, enter the project directory and run `direnv allow` to allow `direnv` to load the `.envrc` file.

### 4. **Build Haskell project with `cabal`**
  - After entering the project directory in your terminal session and allowing the environment to load via `direnv` (or run `nix develop --accept-flake-config` if not using `direnv`), run `cabal update; cabal build` to update `cabal` and build the Haskell (Plutarch) project.
  - You can use `cabal run` to run the project's executable (in `app/Main.hs`) and serialize the sample contracts to the `compiled` directory.

### 5. **Use bundled VS Codium editor (Optional)**
  - The Nix environment for this project includes a preconfigured instance of VS Codium, which is set up to work out of the box with several preinstalled extensions for completing CSA coursework.
  - The bundled editor can only be used with setups that allow the use of GUI applications (this excludes WSL/WSL2 and remote setups that connect via SSH). If needed, your system-wide installation of VS Code/Codium can be used instead, but may require additional configuration. When you launch VS Code/Codium and open the project folder for the first time, you should receive a popup prompt to install some recommended extensions.
  - To use the bundled editor, after entering the project directory in your terminal session and allowing the environment to load via `direnv` (or run `nix develop --accept-flake-config` if not using `direnv`), run `codium .` to launch the bundled VS Codium instance.