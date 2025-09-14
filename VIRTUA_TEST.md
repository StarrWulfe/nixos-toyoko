# Testing with the virtua VM

This document provides instructions on how to build and test the `virtua` VM profile.

## Prerequisites

1.  **QEMU is installed:** You must have QEMU installed on your system. You can install it by adding `pkgs.qemu` to your system packages.

## Building the VM

1.  **From your main machine (e.g., `toyoko`), run the following command to build the VM configuration:**

    ```bash
    nixos-rebuild build --flake .#virtua
    ```

    This command will build the `virtua` NixOS configuration and create a script to run the VM. The script will be located in the `result/bin` directory.

## Running the VM

1.  **After the build is complete, you can run the VM using the following command:**

    ```bash
    ./result/bin/run-nixos-vm
    ```

    This will start a QEMU virtual machine with the `virtua` configuration.

2.  **You can then interact with the VM through the QEMU window.** You should see the system boot up and you should be able to log in as the `j7` user.

## SSHing into the VM

You can also SSH into the running VM.

1.  **Run the VM with networking enabled:**

    ```bash
    ./result/bin/run-nixos-vm -net user,hostfwd=tcp::10022-:22
    ```

    This will forward port 10022 on your host machine to port 22 in the VM.

2.  **From another terminal, you can SSH into the VM:**

    ```bash
    ssh j7@localhost -p 10022
    ```

    You will need to set a password for the `j7` user on the first login.
