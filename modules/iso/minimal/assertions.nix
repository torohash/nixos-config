{ credentials, ... }:
let
  defaultUsername = credentials.default_username or "";
  defaultPassword = credentials.default_password or "";
in {
  assertions = [
    {
      assertion = defaultUsername != "";
      message = "local/credentials.nix: default_username は空文字にできません。";
    }
    {
      assertion = defaultPassword != "";
      message = "local/credentials.nix: default_password は空文字にできません。";
    }
    {
      assertion = defaultUsername != "CHANGE_ME";
      message = "local/credentials.nix: default_username を CHANGE_ME から変更してください。";
    }
    {
      assertion = defaultPassword != "CHANGE_ME";
      message = "local/credentials.nix: default_password を CHANGE_ME から変更してください。";
    }
  ];
}
