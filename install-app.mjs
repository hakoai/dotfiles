#!/usr/bin/env zx
$.verbose = false;

// fish install
if (await nothrow($`type fish`).exitCode !== 0) {
    if (await nothrow($`[[ -f /etc/debian_version ]]`).exitCode === 0) {
        await $`sudo apt-get update`
        await $`sudo apt-get install software-properties-common -y`
        await $`sudo apt-add-repository ppa:fish-shell/release-3`
        await $`sudo apt-get update`
        await $`sudo apt-get install fish -y`
    }
}

// mosh install
if (await nothrow($`type mosh`).exitCode !== 0) {
    if (await nothrow($`[[ -f /etc/debian_version ]]`).exitCode === 0) {
        await $`sudo apt-get update`
        await $`sudo apt-get install mosh -y`
    }
}

// tmux install
if (await nothrow($`type tmux`).exitCode !== 0) {
    if (await nothrow($`[[ -f /etc/debian_version ]]`).exitCode === 0) {
        await $`sudo apt-get update`
        await $`sudo apt-get install tmux -y`
    }
}

if(await nothrow($`[ -d "${os.homedir()}/.tmux/plugins/tpm" ]`).exitCode !== 0) {
    await $`git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
}

// unzip install
if (await nothrow($`type unzip`).exitCode !== 0) {
    if (await nothrow($`[[ -f /etc/debian_version ]]`).exitCode === 0) {
        await $`sudo apt-get update`
        await $`sudo apt-get install unzip -y`
    }
}

await $`sudo chsh $USER -s $(which fish)`

// fisher install
$.shell = '/usr/bin/fish'
$.prefix = ''
if (await nothrow($`type fisher`).exitCode !== 0) {
    await $`curl -sL https://git.io/fisher | source && fisher update`
}
await $`fisher update`

if (await nothrow($`type omf`).exitCode !== 0) {
    await $`curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | bash -s -- --noninteractive --yes`
}
await $`omf update`


if (await nothrow($`type fnm`).exitCode !== 0) {
    await $`curl -fsSL https://fnm.vercel.app/install | bash`
}

// fzf install
if (await nothrow($`type fzf`).exitCode !== 0) {
    await $`git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf`
    await $`~/.fzf/install --all`
}
