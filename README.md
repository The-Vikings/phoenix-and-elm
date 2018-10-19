# Phoenix And Elm: a real use case

This is a [Phoenix 1.3][] port over of the
[Phoenix 1.2/Elm Address Book application][], created by
[Ricardo García Vega][] over a series of posts over at
[his blog][codeloveandboards] ([original app codebase][]).

See the [`original` branch][] for the as-close-to-the-original-as-I-could-get-it
version of the codebase. Other branches will likely have personal tweaks to the
codebase in it.

## Installation

### Repository

```sh
git clone git@github.com:paulfioravanti/phoenix-and-elm.git
cd phoenix-and-elm
mix do deps.get, ecto.create, ecto.migrate, run priv/repo/seeds.exs
```

### Dependencies

### Global

```sh
npm install --global elm
```

### npm

To install npm dependencies in `package.json`:

```sh
cd assets
npm install
```

### Elm

To install Elm dependencies in `elm-package.json`:

```sh
cd elm
elm-package install
```

## Run code

From the project root directory:

```sh
mix phx.server
```

Open <http://localhost:4000> in a browser.

## Changes from the original application

- The introduction of [Contexts][] into Phoenix 1.3 required some re-structuring
  of the application to get it working as expected. I made the decision to put
  `Contact` behind an `AddressBook` context.
- I used [Create Elm App][] to generate the Elm app under the assets directory,
  so its structure is slightly different to what is in the original.

## Notes

### Using Create Elm App

If you want to use [Create Elm App][] to have it generate an Elm app in your
Phoenix 1.3 project's `assets/` directory, you can follow these steps:

```sh
npm install create-elm-app --global
cd assets
create-elm-app elm
```

## Code Branches

### REST version

The [`rest` branch][] of this repository (which also the base branch) contains
code covering the first five sections of the tutorial. In other words, up to and
including [Implementing Elm routing][], so the communication between back
and front ends is done with REST requests via controllers.

Code from the `rest` branch is deployed at
<https://phoenix-and-elm-rest.herokuapp.com/>.

### Websockets version

The [`websockets` branch][] of this repository contains code covering all
sections of the tutorial. In other words, up to and including
[Phoenix and Elm WebSockets support][], so the communication between back and
front ends is done with Websockets requests via channels.

Code from the `websockets` branch is deployed at
<https://phoenix-and-elm-websockets.herokuapp.com/>.

### GraphQL version

The [`graphql` branch][] of this repository used the REST version of the app as
a base, but added [GraphQL][]. So the communication between back and front ends
is done with GraphQL requests via resolvers.

Code from the `graphql` branch is deployed at
<https://phoenix-and-elm-graphql.herokuapp.com/>.

### REST version (refactored)

The [`rest-refactor` branch][] of this repository contains the same contents
as the `rest` branch, but was refactored to reduce coupling between parent and
child modules based on information gleaned about the project using
[elm-module-graph][].

Code from the `rest-refactor` branch is not currently deployed.

## Deployment Notes

[Heroku][] is used to deploy each branch to it's own app. The git remotes look
like this:

```sh
$ git remote -v
heroku-graphql  https://git.heroku.com/phoenix-and-elm-graphql.git (fetch)
heroku-graphql  https://git.heroku.com/phoenix-and-elm-graphql.git (push)
heroku-rest     https://git.heroku.com/phoenix-and-elm-rest.git (fetch)
heroku-rest     https://git.heroku.com/phoenix-and-elm-rest.git (push)
heroku-websockets https://git.heroku.com/phoenix-and-elm-websockets.git (fetch)
heroku-websockets https://git.heroku.com/phoenix-and-elm-websockets.git (push)
origin  git@github.com:paulfioravanti/phoenix-and-elm.git (fetch)
origin  git@github.com:paulfioravanti/phoenix-and-elm.git (push)
```

So, deploying each version of the app out to Heroku meant deploying its branch
out as the master branch:

```sh
git push heroku-rest rest:master
git push heroku-websockets websockets:master
git push heroku-graphql graphql:master
```

## Blog Posts

I wrote a couple of blog posts that use this application as an illustrative
example:

- [Migrating a Phoenix and Elm app from REST to GraphQL][]: This blog post
  covers migrating the application API from using REST, to using GraphQL, and
  shows the steps needed to get the application from the code base in the `rest`
  branch, to the codebase in the `graphql` branch.
- [Graph-driven Refactoring in Elm][]: This blog post covers decoupling parent
  and child modules and refactoring Elm applications, and shows the steps needed
  to get the application from the code base in the `rest` branch, to the
  codebase in the `rest-refactor` branch.

## Social

[![Contact][twitter-badge]][twitter-url]

[![Stack Overflow][stackoverflow-badge]][stackoverflow-url]

[codeloveandboards]: http://codeloveandboards.com/
[Contexts]: https://hexdocs.pm/phoenix/contexts.html
[Create Elm App]: https://github.com/halfzebra/create-elm-app
[elm-module-graph]: https://github.com/justinmimbs/elm-module-graph
[Graph-driven Refactoring in Elm]: https://paulfioravanti.com/blog/2018/03/17/graph-driven-refactoring-in-elm/
[GraphQL]: http://graphql.org/
[`graphql` branch]: https://github.com/paulfioravanti/phoenix-and-elm/tree/graphql
[Heroku]: https://www.heroku.com/
[Implementing Elm routing]: http://codeloveandboards.com/blog/2017/03/07/phoenix-and-elm-a-real-use-case-pt-5/
[Migrating a Phoenix and Elm app from REST to GraphQL]: https://paulfioravanti.com/blog/2018/03/06/migrating-a-phoenix-and-elm-app-from-rest-to-graphql/
[`original` branch]: https://github.com/paulfioravanti/phoenix-and-elm/tree/original
[original app codebase]: https://github.com/bigardone/phoenix-and-elm
[Phoenix 1.2/Elm Address Book application]: http://codeloveandboards.com/blog/2017/02/02/phoenix-and-elm-a-real-use-case-pt-1/
[Phoenix 1.3]: http://phoenixframework.org/blog/phoenix-1-3-0-released
[Phoenix and Elm WebSockets support]: http://codeloveandboards.com/blog/2017/03/19/phoenix-and-elm-a-real-use-case-pt-6/
[Ricardo García Vega]: https://twitter.com/bigardone
[`rest` branch]: https://github.com/paulfioravanti/phoenix-and-elm/tree/rest
[`rest-refactor` branch]: https://github.com/paulfioravanti/phoenix-and-elm/tree/rest-refactor
[stackoverflow-badge]: http://stackoverflow.com/users/flair/567863.png
[stackoverflow-url]: http://stackoverflow.com/users/567863/paul-fioravanti
[twitter-badge]: https://img.shields.io/badge/contact-%40paulfioravanti-blue.svg
[twitter-url]: https://twitter.com/paulfioravanti
[`websockets` branch]: https://github.com/paulfioravanti/phoenix-and-elm/tree/websockets
