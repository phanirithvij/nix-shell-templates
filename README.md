## What

Templates for working in the nix ecosystem

- shell.nix
  - normal/npins/niv
- flake templates
  - TODO: built into nix flakes, do I need copier for this? maybe step 2 after
    `nix flake init -t`?
- devenv templates
- configure project environment via nixos modules (for common use cases)
  - eg. treefmt dprint custom pre-configured enable and disable
  - nixos/home-manager/nix-darwin independent
  - devenv does it I guess, but can the end user use it to create own modules?
    eg. treefmt-nix, dream2nix
  - use wrapper-manager, somehow
  - TODO: just improve devenv to provide community templates + community modules
    along with official modules?
- pre-configured editor setups

- [x] python
- [ ] go
- [ ] zig
  - when I learn it
- [ ] rust
  - when I learn it
- [ ] bash
  - shellcheck, etc.
- [ ] node
  - datastar
- [ ] playwright
  - see datastar
- [ ] numtide/devshell
- [ ] numtide/treefmt-nix
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
    - but repos need to be lean so git clone can be quick for each project
      template init

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

- [ ] how does a flake consumer consume an npins based project?
  - `flake = false` and manual config? provide a flake?
