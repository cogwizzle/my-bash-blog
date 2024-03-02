Recently I built another tool,
[<u>https://dungeonworldcharacter.com/</u>](https://dungeonworldcharacter.com/),
as a static site that uses very little JavaScript in comparison with
today’s modern goliaths. If you want to see more about that project
check out this blog post
[<u>here</u>](https://cogwizzle.com/dungeon%20world%20character%20sheet.html).
In the retrospective of the project I noted that I would’ve built it
differently if I had to do it all over again. I would’ve used
[<u>progressive
enhancement</u>](https://en.wikipedia.org/wiki/Progressive_enhancement#:~:text=Progressive%20enhancement%20is%20a%20strategy,receive%20the%20enhanced%20version%20instead.)
over top of a traditionally server rendered application.

Today I’m excited to announce a new tool that does just this! I’ve built
a progressively enhanced PWA experience that works better with
JavaScript, but still functions without it. I built this application for
two reasons. The tool is called
[<u>https://dice.dungeon-tools.com/</u>](https://dice.dungeon-tools.com/).

<img src="/dungeon-tools-dice-app/image1.png"
style="width:6.5in;height:5.20833in" />

*Figure 1: Dice App*

# What is it?

This is a dice app that allows players to easily roll digital dice for
Tabletop Role playing experiences. It will work with or without
JavaScript. The site runs primarily on PHP. I built the PHP only
experience first. It works with a slightly degraded experience if you
use the PHP only experience. Every dice roll causes the page to refresh
but it works.

The app really shines with the JavaScript enabled experience. For
starters it is a PWA. It allows folks to install the application like it
is a native app as well as cache resources so that it is really fast on
subsequent page loads. Additionally the PWA uses JavaScript exclusively
to roll the dice and updates the UI with the results. You can see up to
your last 8 rolls on screen.  
  
The small amount of JavaScript that does exist on the site is written
using HATEOAS as an inspiration for keeping track of state. The
handwritten JavaScript is only 40 lines long including comments. The
forms and UI that composed the PHP native experience were able to inform
how the JavaScript application state should run.

In addition to the progressively enhanced JavaScript experience we chose
to go with Picocss this time around. This gives us light and dark themes
based on the users preferences as well as some really sane defaults when
it comes to plain Jane HTML element styling.

## API

In addition to the app native functionality I also built a HATEOAS
inspired REST API. I will likely tie this feature directly into the
Dungeon World Character app to allow for the app to roll dice. The API
is simple. We have d4, d6, d8, d10, d12, and d20 endpoints. The format
is
[<u>https://dice.dungeontools.com/api/d4</u>](https://dice.dungeontools.com/api/d4).
These APIs are open and free to use.

# Retrospective

There are still small tweaks to be made to the dice app. I need to
download and cache the Pico CSS library and I have one small cache issue
that isn’t affecting any of the application execution. Obviously the
plan is to patch those few things up over the next couple of days. Aside
from those small pieces I’m actually really happy with using this
progressive enhancement technique to build high quality experiences on
the web.

This application is really small so it was an easy case study on the
progressively enhancing a web application. I’d like to continue this
style of development to build high performance web applications in the
future. Perhaps some of this technique can be moved over to some of my
other projects. I love how little JavaScript is required. It brings me
back to the early days of my career.

PicoCSS is a joy to work with. I really like how simple it is to get
started and how little custom CSS you have to write in order for it to
look nice. I do think that for larger projects it might not be the ideal
choice. I’m looking into other libraries like
[<u>Bulma</u>](https://bulma.io/) for future projects. PicoCSS is great
if you don’t want to do a lot of customization. I feel like Bulma is a
bit heavier than PicoCSS but has more flexibility. If you want the
ultimate control over everything you can’t go wrong with
[<u>Tailwind</u>](https://tailwindcss.com/).

I’m currently using Cloudways by Digital Ocean to host my project. I hit
a couple of speed bumps during the deployment of the app, but I think it
was a skill issue on my part. I’m still learning the Cloudways platform
so I’m sure it will get more intuitive as time goes on. In retrospect
this will likely be the way that I host apps in the future. Especially
after hearing about terrifying stories like
[<u>this</u>](https://old.reddit.com/r/webdev/comments/1b14bty/netlify_just_sent_me_a_104k_bill_for_a_simple/)
on Serverless platforms. The site may go down because my server isn’t
that powerful, but at least I won’t wake up to a rough bill.
