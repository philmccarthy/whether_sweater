<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Thanks again! Now go create something AMAZING! :D
***
***
***
*** To avoid retyping too much info. Do a search and replace for the following:
*** philmccarthy, whether_sweater, @philmccccarthy, hi@philmccarthy.dev, Whether Sweater?, _Whether Sweater is a Rails API built to JSON:API specifications. The API serves up...endpoints! (placeholder)
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
  <h3 align="center">Whether Sweater?</h3>

  <p align="center">
    Whether Sweater? is a Rails API built to JSON:API specifications. The API serves up endpoints that consume and aggregate informaton from MapQuest, OpenWeather and Pexels Image Search APIs.
    <br />
    <a href="https://documenter.getpostman.com/view/14287104/Tz5ndz16" target="_blank"><strong>Explore the API Docs »</strong></a>
    <br />
    <br />
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
        <li><a href="#usage">Usage</a></li>
      </ul>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

_Whether Sweater?_ was my final solo project for Turing School's Mod 3 program for backend software engineering.

### Things I practiced in this project

- How to expose an API that aggregates data from multiple external APIs
- How to expose an API that requires an authentication token
- How to expose an API for CRUD functionality
- Determined completion criteria based on the needs of other developers from specs
- Researched & selected an API based on your needs as a developer

### Built With

* [Rails API](https://guides.rubyonrails.org/api_app.html)
* [RSpec](https://github.com/rspec/rspec-rails)
* [Postman](https://postman.com)

<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites

- Ruby 2.5.3
- Rails 5.2.4.4

### Installation

1. Clone the repo
  
  ```sh
   git clone https://github.com/philmccarthy/whether_sweater.git
   ```
   
2. Run bundle
  
  ```sh
   bundle
   ```
   
3. Setup the database

  ```sh
  rails db:{drop,create,migrate}
  ```
   
4. Start your local server
   
  ```sh
  rails server
  ```
   
5. In Postman, hit the documented endpoints at `http://localhost:3000/api/v1/<endpoint>`

<!-- USAGE EXAMPLES -->
### Usage

Get started quickly with the [Postman Documentation](https://documenter.getpostman.com/view/14287104/Tz5ndz16) for _Whether Sweater?_

<!-- CONTACT -->
## Contact

Your Name - [@philmccccarthy](https://twitter.com/@philmccccarthy) - [hi@philmccarthy.dev](mailto:hi@philmccarthy.dev)

Project Link: [https://github.com/philmccarthy/whether_sweater](https://github.com/philmccarthy/whether_sweater)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/philmccarthy
