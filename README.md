# Obuoba Homes

Marketing website for Obuoba Homes, a real-estate company based in Pokuase ACP, Accra, Ghana. It is a static multi-page site for people looking to buy property: services, listings, agents, a short blog, and contact details. The published copy describes a company that brings original ideas and model specifications to its clients, with the aim of becoming a leading real-estate company in Africa. The home page opens with "The Simplest Path to Owning Property."

The site in this repository is published with GitHub Pages at [https://simiel.github.io/obuobahomes.com/](https://simiel.github.io/obuobahomes.com/). The repository is maintained by Samuel Mensah ([@simiel](https://github.com/simiel)).

## Key features

- Nine pages share one navbar and footer: [Home](index.html), [About](about.html), [Agents](agent.html), [Services](services.html), [Properties](properties.html), a [property detail](properties-single.html) page, [Blog](blog.html), a [blog post](blog-single.html), and [Contact](contact.html).
- The home page presents four service areas — Real Estate, Land Sale, Construction, and Surveys — and a four-step path: evaluate a property, meet an agent, close the deal, and take possession.
- Property cards list homes at Franko Estate, ACP Estate, and Nsawam Government Hospital Road, with a price, bed and bath counts, and a photo. Cards on the properties page link to the detail page.
- The agent page names the team and roles: Kennedy Gyamfi (CEO), Winifred Agyapomaah (Director), Godwin Owusu (Director), Henry Tackie (Agent), Stephanie Crabbe (Agent), and Nicholas Tetteh (Agent).
- About copy, a testimonial carousel, and animated counters sit alongside the listings.
- The contact page shows the Pokuase ACP address, Ghana phone numbers, and obuobahomes@gmail.com, plus a message form and a map container. The footer links to [Instagram](http://www.instagram.com/obuoba_homes).
- The layout is responsive: a collapsing navbar, a parallax hero, scroll-triggered motion, and image lightboxes.

## Tech stack

- Static HTML, CSS, and JavaScript. The repository has no package manifest, application server, or database.
- [Bootstrap](https://getbootstrap.com/) 4.2.1, vendored as SCSS under `scss/bootstrap/` and compiled into `css/style.css`, with Bootstrap's JavaScript, Popper, and jQuery 3.2.1 (plus jQuery Migrate 3.0.1).
- Sass theme in `scss/style.scss`: Nunito Sans, a red primary (`rgb(163, 20, 20)`), a gold secondary (`#f7b71d`), and the Bootstrap import.
- Page libraries: AOS, Animate.css, Owl Carousel, Magnific Popup, Stellar.js, Waypoints, animateNumber, Scrollax, Bootstrap Datepicker, jQuery Timepicker, Open Iconic, Ionicons, Icomoon, and Flaticon.
- Google Fonts (Nunito Sans) and the Google Maps JavaScript API, both loaded from their CDNs in each page.
- A [Prepros](https://prepros.io/) 6 project file (`prepros-6.config`, project name "OBUOBA HOMES") for compiling the Sass. The compiled stylesheet is already in the repo.
- GitHub Actions for GitHub Pages, and an Nginx Alpine image defined in `dockerfile`.

## Architecture

Each page is a standalone HTML document. Shared behavior lives in `js/main.js`: a navbar that changes on scroll, viewport-height helpers, Waypoint counters, fade-in on scroll, the testimonial carousel, Magnific Popup galleries, date and time pickers, and smooth scroll from the hero arrow. `js/google-map.js` initializes a map when an element with id `map` is on the page. The contact page is the one that includes that element.

```
index.html  about.html  agent.html  services.html
properties.html  properties-single.html
blog.html  blog-single.html  contact.html
css/                  compiled theme and vendor stylesheets
scss/style.scss       site theme
scss/bootstrap/       vendored Bootstrap 4.2.1 source
js/main.js            page behavior
js/google-map.js      map setup
images/               logo, property photos, agent portraits
fonts/                Flaticon, Icomoon, Ionicons, Open Iconic
.github/workflows/static.yml
dockerfile            Nginx Alpine image
prepros-6.config
```

The markup follows a Bootstrap real-estate template (the shared `ftco-*` class names) and has been rebranded for Obuoba: logo, palette, photography, Ghana locations, and the agent roster.

The same static tree can be published two ways.

- **GitHub Pages.** `.github/workflows/static.yml` (`Deploy static content to Pages`) runs on every push to `master` and on manual `workflow_dispatch`. It checks out the repository, configures Pages, uploads the repository root, and deploys that artifact. The Pages settings for this repository record the workflow build and the URL above, with no custom domain attached.
- **Nginx.** `dockerfile` starts from `nginx:alpine`, copies the repository into `/usr/share/nginx/html/`, and exposes port 80. The file is named `dockerfile` in lowercase.

## Getting started

A current browser is enough to view the site. Docker is needed only for the container image. Prepros 6 can recompile `scss/style.scss`; the committed `css/style.css` is what the pages load, so a Sass compiler is optional. Nothing in the repository reads environment variables. There is no install step and no test suite.

Serve the repository root so relative asset paths resolve:

```bash
python3 -m http.server 8080
```

Open `http://localhost:8080`. Fonts and the Maps script load from the network.

Build and run the Nginx image. `-f dockerfile` is required because the definition is not named `Dockerfile`:

```bash
docker build -f dockerfile -t obuobahomes .
docker run --rm -p 8080:80 obuobahomes
```

Open `http://localhost:8080`.

A push to `master` publishes the site through the Pages workflow. The same workflow can be started from the Actions tab with `workflow_dispatch`. There is no separate build command.

## Project status

This is Obuoba Homes' static marketing site. The first commit is from April 2022, the Pages workflow was added in January 2025, and the Nginx image was added in June 2025. The Pages deployment is live.

Some sections still carry the template's placeholder content. Listing titles on the property cards are unfinished (`--`), the detail page still describes "The Blue Sky Home," blog entries repeat template copy, and several service descriptions are filler text. The contact form and the blog comment form use `action="#"`, so they do not submit anywhere. Counter figures are hardcoded in the HTML and differ between the home and about pages. `js/google-map.js` still centers the map on the template's New York sample coordinates.

## What this demonstrates

- A complete multi-page marketing site for a Ghanaian property company: branded navigation, local listings (Franko Estate, ACP Estate, Nsawam), a named leadership and agent team, and published Accra contact details.
- Adapting a Bootstrap 4 and jQuery template into that site, with the visual system owned in one Sass theme file beside the vendored Bootstrap source.
- Front-end interaction gathered in `js/main.js`: scroll-aware navigation, parallax, animated counters, a testimonial carousel, and lightbox galleries.
- Two ways to ship the same static files: a GitHub Actions workflow that publishes the repository root to GitHub Pages, and a small Nginx Alpine image that serves them as a container.
