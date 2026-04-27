{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings.user = {
      name = "Dennis Bogers";
      email = "dennis@bogers.xyz";
    };
    signing = {
      format = "openpgp";
      key = "5FE2A9AD81F0FAD0";
      signByDefault = true;
    };
  };

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-qt;
  };
}
