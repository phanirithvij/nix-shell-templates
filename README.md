## What

Templates for nix-shell (shell.nix)

- [x] python
- [ ] go
- [ ] zig
  - when I learn it
- [ ] rust
  - when I learn it
- [ ] bash
  - treefmt, shellcheck, etc.
- [ ] node
  - datastar
- [ ] playwright
  - see datastar
- [ ] android sdk
  - see oclock + processing android pr
- editor setups for all the above?
  - maybe `nix shell` will launch a tmuxp?
  - need cheats keybind to work with direnv tho?
  - nvim + lsp etc.
  - global + local overrides?
- [ ] common tools
  - treefmt
  - dprint (md)
  - mdsh (zimbatim/slides)
  - slides (maaslalani/slides)
  - npins/nixfmt-rfc-style
  - navi cheats (fzf)
    - direnv bash interactive shell bind navi bug workaround
      - detect if direnv, warn and provide solution
      - solution: global hm setting
  - espanso cheats?
    - allow extending global setup via project level espanso cheats
  - process-compose?
    - valkey
  - juspay/services-flake?
    - but it is a flake? so flake-compat? or use flakes?
    - so if I need this use the flake config?
    - might be best to combine both repos?
    - but repos need to be lean so git clone can be quick for each project template init

- multi-select?
  - like zig+node+playwright
  - maybe setup a fake flake to facilitate templates feature?
  - but don't use flakes in output templates?

## Why

Can't be bothered to retype all the quirks everytime

### TODO

- [ ] flake-templates repo (same repo?)
  - has builtin template support
  - but npins > flakes for simple things
  - also nix develop launches tmuxp+navi

