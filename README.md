<a name="readme-top"></a>

<div align="center">

  <img src="https://ik.imagekit.io/dqd3uh1at/budget-app/design-guides/app_icon_circled.svg?updatedAt=1708991848772" alt="logo" width="120" height="auto" />
  <br/>

### About
**MoneyCompass** is a mobile _Budget Application_ where you can manage your budget. [See more...](#about-project)

</div>

<div align="center"><hr width="250px"/></div>

# 📗 Table of Contents

- [💬 About the project](#about-project)
  - [🛠 Built With](#built-with)
    - [Tech Stack](#tech-stack)
  - [Key Features](#key-features)
  - [🚀 Live Demo](#live-demo)
- [💻 Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Setup](#setup)
  - [Usage](#usage)
  - [Run](#run)
  - [Open](#open)
- [👥 Author](#author)
- [🔭 Future Features](#future-features)
- [🤝 Contributing](#contributing)
- [⭐️ Show your support](#support)
- [🙏 Acknowledgements](#acknowledgements)
- [📝 License](#license)

<div align="center"><hr width="250px"/></div>

# 💰**MoneyCompass** <a name="about-project"></a>

  🤷‍♂️ **MoneyCompass** is a mobile _Budget Application_ where you can manage your budget.\
  📃 You have a list of **Payments** associated with a **Category**, so that you can see how much money you spent and on what.\
  👤 It allows you to register and log in to _keep_ the _data private_, introduce _**new categories**_ and _**new payments**_ and see the money spent on each category.\
  🧑‍💻 It's a fully functional _web app_ created with [Rails](https://rubyonrails.org/).\
  💾 All the data is preserved using a [PostgreSQL](https://www.postgresql.org/) _Database_.

- ### Building the **MoneyCompass** App <a name="howto-build"></a>

  It follows the next **ERD** data model:

  <p align="center">
    <img src="https://ik.imagekit.io/dqd3uh1at/budget-app/erd/erd_diagram.png?updatedAt=1707740376788" alt="Data model" width="500px"  />
  </p>

    
  This project keep the following _Design Guidelines_:

  <p align="center">
    <img src="https://ik.imagekit.io/dqd3uh1at/budget-app/design-guides/splash.png?updatedAt=1708939267622" alt="splash screen" width="200px" />
    <img src="https://ik.imagekit.io/dqd3uh1at/budget-app/design-guides/transactions.png?updatedAt=1708939268233" alt="payments"  width="200px"  />
  </p>

  <p align="center">
    <img src="https://ik.imagekit.io/dqd3uh1at/budget-app/design-guides/register.png?updatedAt=1708939267302" alt="registration"  width="200px"  />
    <img src="https://ik.imagekit.io/dqd3uh1at/budget-app/design-guides/login.png?updatedAt=1708939267116" alt="login"  width="200px"  />
  </p>

  **Original design** idea by [**Gregoire Vella**](#gregoire-vella) on [**Behance**](https://www.behance.net/gallery/19759151/Snapscan-iOs-design-and-branding).

  This project is made to prove our knowledge and learn more about [**Ruby on Rails**](https://rubyonrails.org/) concepts - starting from the _**Views**_ and finishing the _**database connection**_. We will also **implement** ideas like _**authentication**_, _**authorization**_, and _**testing**_.

## 🛠 Built With <a name="built-with"></a>

- ### Tech Stack <a name="tech-stack"></a>

  <ul>
     <li>
      <a href="https://www.ruby-lang.org/en/">
      <img align="center" width="19" height="auto" src="https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Ruby_logo.svg/198px-Ruby_logo.svg.png?20101129171534" alt="ruby logo" />
      Ruby
      </a>
    </li>
    <li>
      <a href="https://rubyonrails.org/">
      <img align="center" width="19" height="auto" src="https://ik.imagekit.io/dqd3uh1at/logos/rails-red-logo.svg?updatedAt=1704962146563" alt="ruby logo" />
      Rails
      </a>
    </li>
    <li>
      <a href="https://www.postgresql.org/">
      <img align="center" width="19" height="auto" src="https://wiki.postgresql.org/images/3/30/PostgreSQL_logo.3colors.120x120.png" alt="postgreSQL logo" />
      PostgreSQL
      </a>
    </li>
  </ul>

<!-- Features -->

- ### Key Features <a name="key-features"></a>

  **MoneyCompass** users will be able to:
    - **Create** _Categories_ to group their payments.
    - **Create** _Payments_ for a given _Category_.
    - **List** their _Categories_ and _Payments_.
    - **Register** in the app with an email and password.
    - **Log in** the app so only the user can see their categories and payments.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## 🚀 Live Demo <a name="live-demo"></a>

- [MoneyCompass Live Demo](https://lit-forest-67612-7ce27a105121.herokuapp.com/)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->

## 💻 Getting Started <a name="getting-started"></a>

To get a local copy of this project up and running, follow these steps.

- ### Prerequisites

  - `git` installed. Please got to [Getting Started - Installing Git guide](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and follow the steps described for your system to install `git`.
  - `Ruby` installed, you can go to the [Installing Ruby](https://www.ruby-lang.org/en/documentation/installation/) documentation and follow the steps for your computer OS.
  - `Rails` installed, you can follow the [GoRails Tutorial](https://gorails.com/setup/) and follow the steps for your computer OS.
  - `PostgreSQL` installed, you can follow the [PostgreSQL Tutorial](https://www.postgresqltutorial.com/) and follow the steps for your computer OS.

- ### Setup
  Clone this repository to your `local-folder`:
  ```sh
  cd local-folder
  git clone git@github.com:luigirazum/money-compass.git
  ```
- ### Usage
  In the `local-folder` where you cloned the project, go into the project folder
  ```sh
  cd money-compass
  ```
- ### Prepare
  In the `money-compass` folder, use the following code to install the app dependencies
  ```rb
  bundle install
  ```
- ### Run
  In the `money-compass` folder, use the following code to run the app
  ```rb
  rails server
  ```
- ### Open
  Open your favorite `browser` and type in the address bar
  ```sh
  http://localhost:3000
  ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>
<!-- AUTHORS -->

## 👥 Author <a name="author"></a>

👨‍💻 **Luis Zubia**

<ul>
  <li>
    <a href="https://github.com/luigirazum">
    <img align="center" width="18px" src="https://upload.wikimedia.org/wikipedia/commons/2/24/Github_logo_svg.svg" alt="github logo" />
    <b>@luigirazum</b>
    </a>
  </li>
  <li>
    <a href="https://twitter.com/LuigiRazum">
    <img align="center" width="18px" src="https://ik.imagekit.io/dqd3uh1at/logos/x-new-logo.svg?updatedAt=1704962156902" alt="twitter logo" />
    <b>@LuigiRazum</b>
    </a>
  </li>
  <li>
    <a href="https://linkedin.com/in/luiszubia">
    <img align="center" width="18px" src="https://upload.wikimedia.org/wikipedia/commons/c/ca/LinkedIn_logo_initials.png" alt="linkedin logo" />
    <b>/luiszubia</b>
    </a>
  </li>
</ul>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- FUTURE FEATURES -->

## 🔭 Future Features <a name="future-features"></a>

- **Delete** a _Category_ or _Payment_ previously created.
- **Download** all the _Payments_ and _Categories_.
- **Edit** a _Payment_ so it can be associated with another _Category_.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTRIBUTING -->

## 🤝 Contributing <a name="contributing"></a>

Contributions, issues, typos, and feature requests or suggestions are welcome!

Feel free to check the [issues page](../../issues/).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- SUPPORT -->

## ⭐️ Show your support <a name="support"></a>

If you like this project, I will really appreciate your support, and don't forget to give a ⭐ to this repository.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ACKNOWLEDGEMENTS -->

## 🙏 Acknowledgments <a name="acknowledgements"></a>

- I would like to thank [Yukihiro “Matz” Matsumoto](http://www.rubyist.net/~matz/) for creating the [Ruby Programming Language](https://www.ruby-lang.org/en/).
- Thanks [David Heinemeier Hansson](https://en.wikipedia.org/wiki/David_Heinemeier_Hansson) for sharing [Rails](https://rubyonrails.org/) to the world.\
_**Wikipedia:** [Ruby on Rails - History](https://en.wikipedia.org/wiki/Ruby_on_Rails)_
<a name="gregoire-vella"></a>
- Also thanks to [Gregoire Vella on Behance](https://www.behance.net/gregoirevella) for his original idea on the [Design Guidelines](https://www.behance.net/gallery/19759151/Snapscan-iOs-design-and-branding) used in this project under the [**CreativeCommons**](https://creativecommons.org) [**CC BY-NC 4.0 Deed**](https://creativecommons.org/licenses/by-nc/4.0/deed.en) License.
- Last but not least, thanks to the amazing [**Microverse**](https://www.microverse.org/) community.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- FAQ (optional)

## ❓ FAQ <a name="faq"></a>

> Add at least 2 questions new developers would ask when they decide to use your project.

- **[Question_1]**

  - [Answer_1]

- **[Question_2]**

  - [Answer_2]

<p align="right">(<a href="#readme-top">back to top</a>)</p>
-->
<!-- LICENSE -->

## 📝 License <a name="license"></a>

This project is [MIT](./LICENSE) licensed.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
