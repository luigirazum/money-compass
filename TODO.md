 # `03-add-authentication` branch
 ## Implement the authentication and authorization
- [ ] You should use devise for authentication.
- [ ] Create Sign up and log in pages
  - [ ] The user should be able to register in the app with full name, email and password (all mandatory).
  - [ ] The user can log into the app using email and password.
  - [ ] If the user is not logged in, they can't access pages that require the user to be logged in (Home, transactions, add category and add transaction pages).
----
- [ ] Create unit and integration tests for all the most important components of your RoR application.
- [ ] You should follow the provided [design guidelines](https://www.behance.net/gallery/19759151/Snapscan-iOs-design-and-branding?tracking_source=), including:
  * Colors.
  * Typography: font face, size and weight.
  * Layout: composition and space between elements.
  > NOTE: In these design guidelines there are several UIs that you won't need for this exercise; also, some pages are not given a design and you will create them following the design guidelines of the other pages.
- [ ] You should validate all user input to make sure that anyone with bad intentions cannot compromise your app.
- [ ] You can use a view template engine of your choice (.erb, .slim, .haml).
- [ ] The project should be deployed and accessible online.

<div align="center">
  <img width="250px" src="https://ik.imagekit.io/dqd3uh1at/budget-app/design-guides/register.png?updatedAt=1708939267302&tr=w-1080%2Ch-1920%2Cfo-auto" alt="sign up page">
  <img width="250px" src="https://ik.imagekit.io/dqd3uh1at/budget-app/design-guides/login.png?updatedAt=1708939267116&tr=w-1080%2Ch-1920%2Cfo-auto" alt="login page">
</div>