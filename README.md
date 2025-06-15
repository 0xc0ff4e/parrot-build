** Make sure to pip install ansible, apt has an older copy **

# Instructions
* Start with Parrot HTB Edition
* Install Ansible (python3 -m pip install ansible)
* Clone and enter the repo (git clone)
* ansible-galaxy install -r requirements.yml
* Make sure we have a sudo token (sudo whoami)
* ansible-playbook main.yml

to see which tasks would be executed: 
* ansible-playbook main.yaml --list-tasks 

```bash
# add private ssh key 'c0ffee4dd1ct-pwnbox'


curl -LsSf https://astral.sh/uv/install.sh | sh
uv tool install ansible
# include symlinks to ansible-playbook and co
[ -d "$(uv tool dir)/ansible/bin/" ] && find "$(uv tool dir)/ansible/bin/" -mindepth 1 -maxdepth 1 -type f -executable -regextype posix-extended -regex '^((.+/)?)[^.]+' -print0 | xargs -0 ln -s -t "${HOME}/.local/bin/"

git clone git@github.com:0xc0ff4e/parrot-build.git
cd parrot-build
ansible-playbook main.yaml --list-tasks 
ansible-galaxy install -r requirements.yml
sodo whoami 
ansible-playbook main.yml
```

# Off-Video Changes
* Mate-Terminal Colors, I show how to configure it here (https://www.youtube.com/watch?v=2y68gluYTcc). I just did the steps in that video on my old VM to backup the color scheme, then copied it to this repo.
* Evil-Winrm/Certipy/SharpCollection/CME/Impacket, will make a video for these soon
* Updated BurpSuite Activation. Later versions of ansible would hang if a shell script started a process that didn't die. Put a timeout on the java process
