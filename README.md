# docker-machine-completions
Bash script providing completions for docker-machine

Heavily inspired by the original completions [script](https://github.com/docker/docker/blob/master/contrib/completion/bash/docker) for Docker.

To enable the completions:
 
1. Copy this file inside /etc/bash_completion.d
2. `source` the file directly
3. Copy this file to a given location (e.g. `~/comps/docker-machine_completions`)
       and add the following to your .bashrc: `. ~/comps/docker-machine_completions
