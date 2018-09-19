# EEC-Scripts

Scripts for EEC (EPLAN Engineering Configuration) to work with git seamlessly.
This Repository should help all guys who start with git and need some helpful scripts to work with EEC and git in combination.

First presented on EEC-Forum 2018 by SPANGLER GMBH.

*We as company SPANGLER GMBH would like to enhance the thought of an open and sharing experience on the EEC-Forum. Therefore we publish some code supporting our presentation on the EEC-Forum 2018. And thereby we hope others can benefit from this, and we hope we can improve the networking on the EEC-Forum.*

This repository gives some starting code to use git with EEC.
The intension is also to collect useful scripts to be used with git and EEC.
For example visualize differences/changes in *.ema makros or handle merging of *.eox files.


## Getting Started

Copy those files you like to use in your own git repository and use it.
If you see possible improvements in the scripts, you are very welcome to create a pull request on GitHub.

The installation scripts (if necessary) are in the corresponding section.


## This repository is under construction

Explanation for each file will follow.


## EOX file merging conflicts

Relevant files:

- `merge-model.sh`
- `stage-merge-model.sh`
- `.gitattributes`


### Prerequisites

The `*.eox` file needs to be located in `./eox/model.eox` so the script works correctly.
If you have it somewhere else, you have to adjust the scripts by your own.


### Steps

You can use it by doing a merge between two branches:

```
git merge feature/other-branch
```

If two people changed the same `*.eox` file, the merge will fail.
Next you execute the following script, to prepare the files, so you can merge them in the EEC program.

```
./merge-model.sh
```

Then you go to the EEC, reload (close and reopen) the `*.eox` file and do a 3-way-merge.
The instructions are printed to the console by the previous script.

After merging the `*.eox` file in the EEC program, you execute the next script to stage all changes.

```
./stage-merge-model.sh
```

Now the `*.eox` file is added to the git staging area and you can finish the merge by:

```
git commit
```


## EOX file (also *.zip, *.docx, *.xlsx, *.pptx)

*Please only use it if you fully understand the impact ;-)*

Relevant files:

- `config.sh`
- `.gitattributes`
- `zippey.exe` and `zippey.py`
- `convert.sh`

The `config.sh` file sets up the smudge and clean filters.

With `convert.sh` you are able to rewrite your whole git history to use the new smudge and clean filters.
**But be careful!!!**
It's recommended to make a backup of your repository before using this script, so you can go back if it's failing.
The script was only tested on a single repository.
Feedback would be great.
It is also recommended, to make yourself familiar with rewriting history in git and understanding the `git filter-branch` command at least partly, before you use it.


## EMA diffing

Relevant files:

- `ema-textconv.sh`
- `config.sh`
- `.gitattributes`

The `config.sh` file sets up the diff command.

You can use it by typing:

```
git diff some-file.ema
```

This script is at a very very beginning stage and if you have ideas to improve the diffing of `*.ema` files, your feedback would be great.


## PDF diffing

Relevant files:

- `pdf-difftool.sh`
- `config.sh`
- `.gitattributes`
- `tests/diff-pdf/*`

The `config.sh` file sets up the diff command.

```
git diff some-file.pdf
```


## git shortcuts

Relevant files:

- `fetchPrune.sh`
- `.gitignore`


## GitLab integration

Relevant files:

- `.gitlab/*`


This folder contains some example templates you can use in GitLab to create milestones and issues.


### Prerequisites

There are not direct software you need to install to use this scripts, but this repository uses software in its scripts.

- [zippey](https://bitbucket.org/OidaTiftla/zippey/src/master/)
- [diff-pdf](https://vslavik.github.io/diff-pdf/)


### Installing

Copy those files you like to use in your own git repository and use it.


## Contributing

If you see possible improvements in the scripts or ave new scripts which would be helpful for other too, you are very welcome to create a pull request on GitHub.

Here is a [guide to contribute](https://guides.github.com/activities/forking/).


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


## Acknowledgments

* Thank you to Peng Xu and his basis work for the [zippey](https://bitbucket.org/sippey/zippey/src/master/) projekt.
* Also thank you to vslavik and his work for the [diff-pdf](https://vslavik.github.io/diff-pdf/) projekt.
