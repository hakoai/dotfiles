{ lib, ... }:
let
  skillRoot = ../files/agent-skills;

  # ディレクトリ内のスキル名を列挙する。.gitkeep のような
  # ディレクトリ以外のエントリは無視する。
  skillNames =
    dir:
    lib.attrNames (lib.filterAttrs (_: type: type == "directory") (builtins.readDir dir));

  # 1 つのスキルを 1 エントリとしてリンクする。ディレクトリごと
  # リンクすると各エージェントのビルトインや未管理スキルを
  # 隠してしまうため、必ずスキル単位で張る。
  linkSkills =
    target: dir:
    lib.listToAttrs (
      map (name: {
        name = "${target}/skills/${name}";
        value.source = "${dir}/${name}";
      }) (skillNames dir)
    );

  forAgent =
    target: dirs: lib.mkMerge (map (dir: linkSkills target dir) dirs);
in
{
  home.file = lib.mkMerge [
    (forAgent ".claude" [
      "${skillRoot}/common"
      "${skillRoot}/claude"
    ])
    (forAgent ".codex" [
      "${skillRoot}/common"
      "${skillRoot}/codex"
    ])
  ];
}
