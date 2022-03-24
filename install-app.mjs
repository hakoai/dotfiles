#!/usr/bin/env zx


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

// fisher install
$.shell = '/usr/bin/fish'
$.prefix = ''
if (await nothrow($`type fisher`).exitCode !== 0) {
    await $`curl -sL https://git.io/fisher | source && fisher update`
}
await $`fisher update`

if (await nothrow($`type omf`).exitCode !== 0) {
    await $`curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > install`
    await $`fish install --noninteractive --yes`
}
await $`omf update`


if (await nothrow($`type fnm`).exitCode !== 0) {
    await $`curl -fsSL https://fnm.vercel.app/install > install`
    await $`fish install -y --noninteractive`
}

// fzf install
if (await nothrow($`type fzf`).exitCode !== 0) {
    await $`git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf`
    await $`~/.fzf/install --all`
}
