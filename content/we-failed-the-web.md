# We Failed the Web

As web developers we failed the web. This may seem like a bold statement to
make, but I think it is undeniably true. I think the erosion has happened over
a long time. It is not too late to fix. But firstly we need to understand the
damage that we've caused, and are still causing. The web by large is not
accessible. I don't just mean A11Y accessible. The web is no longer resilient.
Finally the web is wrapped in artificially controlled bubbles. I'll do my best
to dive into each of these topics and explain how to come back as a community
of engineers looking to move the web platform forward.

## The Web is Not Accessible

When the word accessibility is thrown around most people think immediately of
the A11y standards or WCAG. These standards largely exist to ensure that people
with disabilities have access to the web. Let's talk about 1993 when the Hyper
Text Markup Language _(HTML)_ was released to the world. HTML was a
revolutionary hypermedia document format that allowed for documents to link to
each other openly and freely. It was black text on white backgrounds which made
it the most friendly on the users eyes when consuming. Work began almost
immediately to make the web accessible. Tim Berners-Lee gave an accessibility
keynote in 1994 to the International World Wide Web conference. In 1995 Unified
Web Site Accessibility Guidelines were created. 1999 WCAG was released.

So as you can see clearly from these early web events the internet has always
been designed to be an accessible public location. A11Y and WCAG are important
guiding documents to make websites accessible to people with all sorts of
disabilities. They're great standards however, they're not the only
accessibility concerns we should have.

### JavaScript Accessibility Issues

JavaScript is probably one of the easy targets that you expected to see here in
this blog post about accessibility issues. JavaScript has been around since
1995 and it was an early part of the web as well. It was created to add client
side interactivity to the web. Today it is used everywhere. It has even
expanded to problem spaces outside of the web.

The trouble with JavaScript though is that we are over using it. Today we use
JavaScript for everything on the web. In effect JavaScript has largely become
the only tool of the web in many ways. Component based frameworks that perform
client side rendering of web content has become normal. Loads of modern
websites just won't do anything without JavaScript.

The initial reaction to this is "If someone turns off JavaScript that is on
them." Early in my career I had similar feelings. I felt that people that
turned off JavaScript were paranoid people. But there are lots of reasons to
turn off JavaScript. If you live in a location with poor internet connection
speeds turning off JavaScript and avoiding downloading huge JavaScript files is
a great way to be able to participate in the web. That person isn't paranoid.
Another great reason is that JavaScript can drain your battery quite quickly if
you're running a ton of it. Imagine you don't have access to stable power or
you've got to pay for not only the data but just to charge your low end smart
phone. JavaScript won't likely run well on that device either causing a less
than ideal experience. On older devices new APIs may break the entire
experience because when JavaScript fails sometimes it won't do anything.

Another way that JavaScript negatively impacts accessibility is the time it
takes for content to be displayed. Some screen reader software struggles to
provide meaningful feedback while the website is fetching the content to be
displayed.

Ok. So I'm not advocating for you to not use JavaScript. I'm also not 
advocating for you to not use component based technology. I am advocating that
the most critical paths of your web application **should** work without
JavaScript. That way if someone is using an old device or browser, a bad
connection, or a screen reader they can still perform the main actions on your
site.

HTML5 released a ton of native elements we were missing from the web. In
many cases these elements replaced problems that we were previously solving
with JavaScript with native controls. This is one great way to lower your
JavaScript burden. Lots of these new components already come progressively
enhanced as well. The details element for instance works like an accordion if
the browser supports it, but if not then it just shows the content. That is
an effective alternative!

Custom Elements using Light DOM is another great way to provide a sleek
interactive experience to users without breaking the main experience. Custom
Elements is the most underrated feature on the web platform today that isn't
taken advantage of.

### CSS Accessibility Issues

CSS can be an accessibility problem as well. We've all worked on CSS where it
works fine in one browser but not fine in another. The experience can be
completely broken. It is even worst for older browsers. But you have to use
some form of styling today.

So the best thing that you can do to make sure that your website would work for
users is to disable the CSS and see what your site looks like. If the website
loads and is readable in some fashion you've got a pretty good chance of the
website working if some CSS fails in some way.

If you're using traditional CSS an easy way to accomplish this is to filter out
the CSS network results using you're browsers developer tools. This will show
the page with no styles applied.

Another thing that can go wrong with styling your page in general is making
sure that you use it in a way that makes it accessible to those with vision
impairments. The colors might look fine to you, but there are all kinds of
color blindness or partial blindness that can make things really hard for some
of your users. Lighthouse, which is built into Chrome's Developer tools, is a
great starting point to get some guidance on how to improve your accessibility.

Finally we are making poor design choices. I've seen buttons that look like
hyperlinks, hyperlinks that look like buttons. These are just two examples
where we break down the contract of the native web. Your designs should not go
against 30 years of internet history. Do not break the web. Do not confuse
people.

### Semantic Problems

Another area that we've failed the web is not using the appropriate elements
everywhere. Countless times I've worked in React projects with components that
use divs for everything. HTML elements have specific roles that make
indications to users with Assistive Technology how the element is going to
respond. When you use a div tag as a button, or a link as a button, you
fundamentally break the trust of your user.

In addition each form control, and interactive element has different keys, and
behavior that is unique to that element. An example of this is a tags only work
with enter, while buttons work with space bar or enter.

If you do need to deviate from the semantics of the native elements for some
reason, please ensure that you use aria attributes to label the purpose of the
element. This will help users with assistive technology. My other piece of
advice is to prefer the platform solutions. Your users don't care that you're
not using the default options in a select box. That is your ego, or the ego of
someone in design. These custom solutions aren't as fault tolerant as native
elements. If the JavaScript fails for some reason, they might not be able to do
what they need.

## Resilient Web

Websites used to run forever. The Space Jam website is a testament to this. It
was published in 1996 when the movie came out. It still runs today.

Conversely, every site I've built over the last 10 years has required constant
maintenance. Security patches for JavaScript libraries I didn't know existed,
library updates,or rewrites due to changing thought patterns in the community.
These are all real reasons that are hurting our velocity.

In addition what happens with your fancy client side rendered framework fails
to execute JavaScript. Hopefully some of the site loads, but lots of the time
you get nothing. No experience at all. At least
when we didn't require JavaScript to do anything on the front end we got an
error page, or sometimes a page that didn't look quite right. What a terrible


## Where Did We Go Wrong? Corporate Control.

In the late 2000s and early 2010s we had a really big problem with the web.
Code reuse was difficult to do in the front end. We began competing with native
phone applications with snappy experiences. At the time lots of sites were not
mobile phone accessible.

A few companies came along and began to make a promise. Build once ship
everywhere. AngularJS, React, and Knockout.js are a few examples of these early
implementations that were available at the time. Up until that point jQuery was
the only kid on the block and while we loved jQuery we knew that we needed
something more. At the time we had been moving more and more logic to the
client side with jQuery plugins, but they weren't easy to reason about. Our
apps needed to act like phone apps right? They needed soft navigation so that
the user never left the experience. It was the future! We were going to have
re-usable custom web elements.

So we made our pact with our new corporate overlords. And we implemented
AngularJS only to have google pull the rug out from under us a few years later.
Then we dusted ourselves off to jump into other frameworks. What about React?
Sure! These classes make sense! And it has a cool in browser Dev tool to run
JSX! That is awesome. Oh that tooling died? We have to learn bundling. Ok sure
we'll learn webpack so that we can keep using the latest features. Oh! A new
version of React? With functional hooks. Oh and everything is moving that
direction now. So I have to rewrite my components to use the latest third party
libraries. Hmm. I didn't quite have a chance to re-use any of these components,
but I have to rewrite them now? Oh state management! Yes I need that! These
components are far too complicated to house the state themselves. Maybe we
should use native web components for this feature? Oh my framework is not
compatible, and they don't want to support this native feature. They want us to
do everything, and I mean everything in the framework using the frameworks way
of doing it.

It happened over time. We slowly sold our time and attention to these component
libraries and frameworks. We never achieved the initial promise of re-usability.
Well. Maybe at the most simple level for form controls that we were forced to
wrap in JavaScript. But we had that out of the gate with our native platform.
Oh but we had styles applied! Just as native CSS could do. And we had our
single page applications with soft navigation at the expense of having to
rewrite it ourselves with a huge amount of JavaScript accompanied with it. And
the new features like Custom Elements that could come and save us conveniently
weren't compatible with the libraries. After all our the company with which we
made the pact knows the best way to solve a problem. The tool that a social
media company wrote, or a search engine monolith clearly solves all our
collective problems too right? I mean after all, they work in Big Tech!

## We Were Wrong

Ultimately no we were wrong. The promises we bought into never panned out. It
took me personally 10 years of chasing shiny new objects and every framework
under the sun to realize that maybe we got it wrong. And everything on the web
has suffered because of it.

New engineers coming into the market have to learn exceptionally large
technology stacks in order to get an entry level job. Our websites became slow
with bloated JavaScript bundles. Sometimes the websites stopped working because
we shipped bad builds. In this way the web was no longer resilient. We forced
an endless cycle of security patching and library updates to maintain your
current position let alone moving forward.

We re-invented everything the web already did well, some of which had been
there since day one so that we could compete poorly with native phone apps. We
now have a class of engineers that don't know how to work outside of
a specific framework they learned. They don't know about the native
functionality of the web. They only know the way that a corporation tells them
to write code.

We sold 10+ years of our life to building web apps in an unsustainable way. We
pushed a corporations framework rather than the web platform forward.

## What Now?

This problem did not happen overnight. It will not be fixed overnight. We've
spent 10 years advocating for technology that just doesn't work. This is coming
from a person who has become an expert in these technologies and had lots of
hype towards them. I'm not speaking from a lack of experience. The call is
coming from inside the house.

Our employers have been convinced that we need to be working with framework of
the day or we're not going to compete. We've structured educational platforms
like boot camps to think they need to teach the students these technologies or
they won't get hired. In that way we incentivized them to learn frameworks and
not the web platform.

We propagated an entire ecosystem and structure around the platform and despite
all of our efforts, the native platform provided a superior experience not only
to our new way of working, but our arch enemy Native Phone apps as well. In my
opinion the web has largely won outside of a few niche markets for mobile
users. Imagine if instead we had invested our time pushing the platform
forward.

It is our responsibility to begin to fix the narrative. We need to start
showing the real cost of our mistakes. We have a group of engineers we have to
deprogram in order to help them have healthy and sustainable careers. We have
to return to resilient website construction so that everyone can enjoy the
internet. This is my new goal is to help drive us back from the brink of
insanity that we're at now. I see the road we're going down and I don't like
where we're headed. We still have time to fix this though if we band together
and fix our mistakes.
