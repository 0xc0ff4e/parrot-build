# Instructions
* Start with Parrot HTB Edition | Security Edition
* Clone and enter the repo (git clone)
* ansible-galaxy install -r requirements.yml
* Make sure we have a sudo token (sudo whoami)
* ansible-playbook main.yml


```bash
# Install UV
curl -LsSf https://astral.sh/uv/install.sh | sh
uv tool install ansible --with ansible-lint
# include symlinks to ansible-playbook and co
[ -d "$(uv tool dir)/ansible/bin/" ] && find "$(uv tool dir)/ansible/bin/" -mindepth 1 -maxdepth 1 -type f -executable -regextype posix-extended -regex '^((.+/)?)[^.]+' -print0 | xargs -0 ln -s -t "${HOME}/.local/bin/"

git clone git@github.com:0xc0ff4e/parrot-build.git
cd parrot-build
# ansible-playbook main.yaml --list-tasks
ansible-galaxy install -r requirements.yml
sudo whoami
ansible-playbook main.yml
```


# Adaptations
- remove unnecessary dirs
- make it lint

> Passed: 0 failure(s), 0 warning(s) on 59 files. Last profile that met the validation criteria was 'production'.


- improve idempotency 

```
PLAY RECAP ***********************************************************************************************************************************************************************************
127.0.0.1                  : ok=94   changed=0    unreachable=0    failed=0    skipped=63   rescued=0    ignored=0   
```

- use uv for python management
- use podman instead of docker (just because its already installed on parrot, docker might be more stable though)
- added bloodhound-cli wrapper for easier usage

# TODO
 uninstall tools that i dont use
 tor anonsurf etc
