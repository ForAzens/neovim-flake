{ pkgs, plugins, inputs, lib ? pkgs.lib, ... }:

final: prev:

# https://all-dressed-programming.com/posts/nix-yarn/
let
  node_modules = prev.pkgs.mkYarnPackage {
    name = "prettier-d-node-modules";
    src = inputs.prettierd;
  };


  prettierd = prev.pkgs.stdenv.mkDerivation {
    name = "prettierd";
    src = inputs.prettierd;
    buildInputs = [pkgs.yarn node_modules];
    buildPhase = ''
      ln -s ${node_modules}/libexec/@fsouza/prettierd/node_modules node_modules
      ${pkgs.yarn}/bin/yarn --offline build 
    '';
    installPhase = ''
      mkdir $out
      mv dist $out/dist
      ln -s ${node_modules}/libexec/@fsouza/prettierd/node_modules $out/
      cp ${inputs.prettierd}/package.json $out/
      cp -r ${inputs.prettierd}/bin/ $out/bin/
    '';
   };
in
{
  nodePackages = prev.nodePackages // { prettierd = prettierd; };
}
