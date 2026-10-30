# Youssef Sadquy

Software engineer based in London. BSc Software Engineering, University of Leicester (First-Class, 79.72%).

I build web applications, desktop tools and games, and I have run my own e-commerce business. I like projects that connect software to real things: a career fair, a TV, a bus stop, a voting system.

## Featured projects

### GlobeFair: a virtual career fair (final-year project)

My longest and most complex project: a 3D career fair built in Unity where job seekers and employers sign up, then walk through a large exhibition hall in a third-person view.

- **Two account types:** job seekers and businesses each get their own sign-up, login and dashboard, backed by Firebase Authentication and Cloud Firestore.
- **CV upload:** job seekers upload a PDF CV from their dashboard, stored in Firebase Storage.
- **The fair:** one click on "Start fair" shows a loading screen and enters a large 3D exhibition scene (around 19,000 scene objects) with exhibitor stands and a third-person character controller.
- **Scale:** about 1,000 lines of C# for login, sign-up, dashboards, loading and navigation, plus the exhibition scenes, built on Unity 2021 LTS.
- **Outcome:** it attracted interest from the University of Leicester's Career & Employability team.
- **Stack:** Unity, C#, Firebase (Auth, Firestore, Storage).

### [Dock TV](https://github.com/youssefsadquy/dock-tv)

A Windows app (Electron) that replaces the ad-filled home screen on Samsung smart TVs with a clean, customisable Dock, and walks you through switching off the TV's tracking.

![Dock TV](https://raw.githubusercontent.com/youssefsadquy/dock-tv/main/docs/design.png)

- **Finds and backs up the TV** on the local network, and shows honestly whether the model has been tested.
- **Privacy clean-up with an undo log:** every setting's old value is recorded first, so one click restores it.
- **Live designer:** apps, HDMI inputs, weather, London bus times (TfL), prayer times, Spotify, night mode and photo backgrounds, with a preview of the real launcher.
- **Installs over the network:** builds and signs the app, creating the signing certificate automatically on 2018 to 2022 TVs.
- **Engineering:** 18 automated tests against a fake TV and a fake SDK, settings validation, and a design that keeps personal data out of the app and the repository.
- **Stack:** JavaScript, Electron, Tizen web apps, REST APIs. Tested end to end on a Samsung UE55NU7021.

Companion repo: [dock-tv-player](https://github.com/youssefsadquy/dock-tv-player), the small HTTPS page that lets the Dock act as a Spotify device.

## Other projects

| Project | What it is | Stack |
|---|---|---|
| [GEVS Online Voting App](https://github.com/youssefsadquy/GEVS-Online-Voting-App) | A general election voting system: voter registration, one vote per voter, an election commission dashboard and a public REST API. | JavaScript, HTML, CSS |
| [RefugEAP website](https://github.com/youssefsadquy/RefugEAP-website) | A Java web application with a MySQL database for events and blog pages, with a user manual and setup guide. | Java, MySQL |
| [Study Scheduler](https://github.com/youssefsadquy/Study-Scheduler) | Software engineering coursework: functional requirements, use cases, class diagrams and a weekly log. | UML, documentation |

## Skills

| | |
|---|---|
| **Languages** | JavaScript, Java, Python, C++, C#, SQL, HTML, CSS |
| **Web and apps** | Node.js, Electron, Spring (MVC), REST APIs, Firebase (Auth, Firestore, Storage), Android |
| **Games and 3D** | Unity: C# scripting, large 3D scenes, UI and scene management, asset integration |
| **Data** | Python notebooks, data analytics and big data coursework |
| **E-commerce** | Shopify, WooCommerce, WordPress |
| **Tools** | Git and GitHub, IntelliJ, PyCharm, MySQL Workbench |

## Experience

**Founder and director, Nero Label Limited.** Ran all aspects of the business alongside my degree: team leadership, planning and delivery.

**Freelance web developer.** Built custom websites and e-commerce stores for clients, from business portfolios to online shops.

## Get in touch

I am open to opportunities in software engineering, web development and Unity game development.

- Email: [youssefsadquy@gmail.com](mailto:youssefsadquy@gmail.com)
- LinkedIn: [Youssef Sadquy](https://uk.linkedin.com/in/youssef-sadquy)
