
all: ../.ansible.cfg ../.aliases ../.screenrc ../.ssh/config ../.zshrc ../.oh-my-zsh

clean: ../.ansible.cfg ../.aliases ../.screenrc ../.ssh/config ../.zshrc
	rm $<

CWD=$(shell pwd)

../.ansible.cfg: ansible.cfg
	-cd $(HOME) && ln -fs $(CWD)/$< .$<

../.aliases: aliases
	-cd $(HOME) && ln -fs $(CWD)/$< .$<

../.screenrc: screenrc
	-cd $(HOME) && ln -fs $(CWD)/$< .$<

../.ssh/config: ssh/config
	-cd $(HOME) && ln -fs $(CWD)/$< .$<

../.zshrc: zshrc
	-cd $(HOME) && ln -fs $(CWD)/$< .$<

../.oh-my-zsh:
	git clone https://github.com/lukaspustina/oh-my-zsh.git $(HOME)/.oh-my-zsh

