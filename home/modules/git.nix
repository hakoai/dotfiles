{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "hakoai";
      user.email = "hakoai64@gmail.com";

      url."https://github.com/".insteadOf = [
        "git@github.com:"
        "ssh://git@github.com/"
      ];
    };
  };
}
