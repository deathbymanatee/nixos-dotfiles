{
  pkgs,
  config,
  inputs,
  ...
}:
{
  modules = [ inputs.river-kwm.nixosModules.default ];
}
