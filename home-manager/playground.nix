{ config, pkgs, lib, inputs, unstable, nixGL, ... }:

{
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    pkgs.hello
  ];
}