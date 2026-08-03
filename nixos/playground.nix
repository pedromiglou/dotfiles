{ config, lib, pkgs, unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    pkgs.hello
  ];
}