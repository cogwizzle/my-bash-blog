# I Built a Bash Static Site Generator (Fight Me!)
If you have been a web developer for the past 10 years, you have probably heard of static site generators. For those of you who have been living under a rock, a static site generator is a way of building a series of static HTML pages and resources and publishing those to the web using [Github Pages](https://pages.github.com/), [Netlify](https://www.netlify.com/), or similar services.

So back to my "sins." I built a static site generator using Bash scripts. Bash is likely one of the most hated languages. It rivals PHP, which I also love, as the most hated language on the internet. Well to that I say, "Fight me!"

Bash is so cool. It isn't my first language of choice, but it is always there and it is dependable. I love the fact that you have the ability to do really powerful things from the shell using it.

## What I Built
Back to this static site generator I built, [gh-pages-blog](https://github.com/cogwizzle/gh-pages-blog). It is designed to work in Github Pages or Netlify. I wanted a simple way to build static pages, but I didn't want to have to have a person install anything to do it. I did not achieve the second goal. But that is ok with me because what I made is dope.

## Features
- Install script that installs dependencies via Homebrew.
- Markdown to HTML conversion.
- sqlite3 database for keeping track of posts, and publish status.
- scripts for adding new posts, and generating an index.html file.
- A JavaScriptless blog site. I have all of the SEO!!!

This thing is extremely easy to modify. Fire up NeoVim (the best editor) in the terminal and change whatever you want. It is highly remixable because it is written in bash.

## The Future
I intend to add additional plugins to my static site generator in my copy so that I can add project pages for other stuff that I've built like, this static site I built for [Dungeon World](https://dungeonworldcharacter.com/) or this [pretend doctors form](https://cogwizzle.github.io/playtime-doctor-chart/) for my daughter. It is easy enough to modify you can make it do whatever you want using the existing scripts as an example.

## This Post is a Fever Dream
This post is a bit more manic than I intended it to be, but I had a pretty good time writing it. I hope that you both enjoy the static site generator example I provided and are encouraged to give Bash a chance at solving your creative problems.
