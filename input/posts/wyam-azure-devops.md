---
Title: Wyam, Azure DevOps and GitHub Pages
Published: 3/10/2019
Tags: [C#, Wyam, Continuous Integration, GitHub Pages, Azure DevOps]
author: Johan Vergeer
---
Publishing a static site with a static content generator can be fully automated. In this case I'm using [Wyam](https://wyam.io/), a static site generator, [GitHub Pages](https://pages.github.com/) for hosting and [Azure DevOps](https://azure.microsoft.com/en-us/solutions/devops/) for build and deployment. Of course there are a ton of other ways to do this, but right now I'll show you the way that I chose to use.

This post will mainly focus on automated build and deployment, since there are a lot of great online resources on how to setup Wyam on your local machine.

# GitHub setup

As I said, I'm using GitHub Pages to host my site. You can use it for free for any static website. By default GitHub Pages supports [Jelyll](https://jekyllrb.com/) with some out of the box themes and plugins. I used Jekyll in the past, but I found Wyam easier to work with.

To create a personal blog on GitHub Pages, you should create a Git repository named `yourusername.github.io`. When you do this, GitHub will automatically create the site for you, and use the `master` branch for the site content. So once you created the repository, don't use the master branch, but create a new branch that will contain your working files. I named my working branch `source`.

Perform the following commands after you created the repository on GitHub to setup the branches.

<?# Tip ?>
Make sure you __don't__ include README and .gitignore when creating the repository on GitHub
<?#/ Tip ?>

```bash
git clone git@github.com:yourusername/yourusername.github.io.git
cd yourusername.github.io
git branch source
git checkout source
git push -u origin source
```

These command will clone the repository from GitHub, create a new branch named `source`, push the new branch to GitHub and makes `source` the default branch. You can check whether you are on the source branch with this command: 

```powershell
PS> git status
On branch source
```
