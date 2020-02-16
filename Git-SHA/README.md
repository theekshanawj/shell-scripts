# shell-scripts
Utility shell scripts


# Git SHA Shell Script 

This Shell scripts can be used to extract the Git-SHA of a given repository and of a given branch.

## Usage 

Call the Script as follows
```
./git-version.sh <GIT_URL> <BRANCH> <DIRECTORY>

```

|Argument|Usage|Format| Required (Default Values)|
|---|---|---|---|
GIT_URL| Repository in this URL will be cloned| https://github.com/username/repo_name.git (For private Repos https://username:password@github.com/username/repo_name.git) | Yes
| BRANCH| Branch in the specified repo to extract the SHA| `origin/master` | No (`origin/master`)
| DIRECTORY | Repo will be cloned to this directory | `/directory` | No (Working directory)|

## What will happen

1. Repository given by `GIT_URL` will be cloned to the `DIRECTORY` folder 
2. If a copy of the Repo exists, only pull the latest from GIT
3. Git-SHA of the specified branch by `BRANCH` will be displayed in the Shell

## Notes

1. Remember to `chmod 755 ./git-version.sh`
2. No terminal indication when `git clone`, `git pull` is executed
3. Fell free to use this to your requirements