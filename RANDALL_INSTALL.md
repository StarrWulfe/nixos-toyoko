# Installing NixOS on randall

This document provides instructions on how to install NixOS on the `randall` host using `nixos-anywhere`.

## Prerequisites

1.  **`randall` is running a minimal Linux distribution:** The `randall` host must be running a minimal Linux distribution with an SSH server. MX Linux, which is currently installed, should work fine.
2.  **SSH access to `randall`:** You must have SSH access to the `randall` host from the machine where you are running `nixos-anywhere`. You should have passwordless SSH access (e.g., using SSH keys).
3.  **`nixos-anywhere` is installed:** You can run `nixos-anywhere` using `nix run github:nix-community/nixos-anywhere --`.

## Installation Steps

1.  **Ensure `randall` is booted and connected to the network.**

2.  **From your main machine (e.g., `toyoko`), run the following command:**

    ```bash
    nix run github:nix-community/nixos-anywhere -- --flake .#randall root@<randall-ip-address>
    ```

    Replace `<randall-ip-address>` with the IP address of the `randall` host.

    This command will:

    *   Connect to the `randall` host via SSH.
    *   Use `disko` to partition and format the disk according to the configuration in `hosts/randall/disko.nix`.
    *   Install NixOS on the `randall` host using the configuration defined in your flake.
    *   Reboot the `randall` host into the new NixOS installation.

3.  **After the installation is complete, you should be able to SSH into the new NixOS system:**

    ```bash
    ssh j7@<randall-ip-address>
    ```

    The user `j7` is created based on the configuration in `profiles/base/default.nix`. You will need to set a password for the `j7` user on the first login.
