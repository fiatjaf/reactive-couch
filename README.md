# Reactive Couch

_Crawlable, component and events based, easy to mantain CouchApps using Facebook's React.js to render the same HTML inside CouchDB's \_list and \_show and then easily update or re-render them at client side using the same libraries, the same components._

Attention: this is an old project, so it uses an old React version, but since it is only an example of how to structure your Couchapp with React, then it still has value as that. The source code is commented everywhere and there are various README.md pages explaining how and why things work.

---

Reactive Couch is a bunch of patterns for declaring [React](http://facebook.github.io/react/) components, rendering them inside \_list and \_show functions and binding the components with javascript them to the rendered HTML elements at the rendered app/website.

To achieve this we need:

* A __single page__ HTML template -- all elements which will be targets of components must be present at the same page;
* Various __components__, each with different concerns -- with \_list and \_show we can render only one kind of data at once, each data must be tied to a component, and each component to a different HTML element;
* An __event emitter__ for communication between components -- this is not the only way of communication, but we found it to be a good, simple and clean way of achieving this.
* A [history](https://github.com/fiatjaf/reactive-couch/blob/master/lib/history.coffee) plug (you can call it a router, but it is not exactly) to change the URL, while the visitor navigates using only client-side javascript and ajax, to a path with which the server can render the same page at a later visit.

For reasons of preference, in this project we also use:

* [Coffeescript](http://coffeescript.org/) -- with the known [_lispy_ syntax](http://blog.vjeux.com/2013/javascript/react-coffeescript.html) for declaring React tags;
* [Erica](https://github.com/benoitc/erica) for pushing the directory files to CouchDB as a design document; and
* [curljs](https://github.com/cujojs/curl) for requering in the browser the same modules we require with CommonJS syntax at the server.
* a [Makefile](https://github.com/fiatjaf/reactive-couch/blob/master/Makefile) for compiling Coffeescript, syncing directories and pushing the design doc to CouchDB (a system that can be replaced by other tools, but very simple and in which anyone can plug in easily things like a [JSX](http://facebook.github.io/react/jsx-compiler.html) or a [Less](http://lesscss.org/) compilers, or a minifier)

Everything is included in this package, but you can probably remove and change everything easily.

## How to structure a Reactive Couch project

### I
If you're working with CouchDB, you probably already thinks in terms of documents and rows of \_views, so the data for your page/app is probably structured in a way that you can clearly see that

1. some kinds of data can be represented as a list of docs or rows of emitted data from one or more docs;
2. some kinds of data can be represented as a single doc, and then it is all inside a doc.

So, this is the first step of structuring a Reactive Couch project: thinking about your data.

### II
After you acknowledge these points and identify the data you will display, your next step is to proceed to the `views` folder of the reactive couch project. There you you edit and create the view functions you'll need for displaying the data of kind __1__.

### III
Then you move to the `lists` [folder](https://github.com/fiatjaf/reactive-couch/tree/master/lists). There you'll find an [example](https://github.com/fiatjaf/reactive-couch/blob/master/lists/standardListOfSomeKindOfThing.coffee) of a list function that just fetches the rows emitted from some passed view and `provides` then as `'html'` and as `'json'`. You can edit the behavior of the `fetch()` function, but the crucial part is that both the HTML and the JSON providers must have the same data. The `tpl = require 'app/template'` and `tpl @app.app, data` parts of the HTML provider are meant to render the data to the same HTML template, which is defined at https://github.com/fiatjaf/reactive-couch/blob/master/app/template.coffee.

### IV
Repeat the last step for data of kind __2__, only that now you'll work with functions receiving single docs inside the `shows` [folder](https://github.com/fiatjaf/reactive-couch/tree/master/shows).

### V
Inside the `shows` folder there's also an [index.coffee](https://github.com/fiatjaf/reactive-couch/blob/master/shows/index.coffee). This is a not necessary, but recommended, form of redirecting the user from the top level path of your website to a more meaninful URL pointing to the actual data at the home page -- and it is also useful for passing parameters the ever-needed parameters such as `include_docs=true` to CouchDB.

### VI
Now, the React moment: move to the `components` [folder](https://github.com/fiatjaf/reactive-couch/tree/master/components). There you'll find some components, each one in its file, no one of these are required, there are some (like `RangeField` or `RadioField` written by me that are included only as examples). Just pay attention to `ListComponent` and `Thing`, because these implement the logic for rendering the same thing server-side and client side, each assuming that will receive data as props -- if they're being rendered server-side --, or no data -- if not. In the second case they probably should be rendered with a `style="display: none"` or some other pattern for showing/hiding elements in single pages or some fallback for inexistence of data, such as a "loading" message. There are comments inside these files explaining its important parts, `ListComponent` is a components meant to be populated with list data, and `Thing` with a single doc.

It is important to maintain the [UMD](https://github.com/umdjs/umd)-inspired syntax of the components, with the dependencies defined at `deps` at the top, the component itself being returned by a `factory`:
```coffeescript
deps = ['lib/react']
factory = (React) ->
  # component definition
```
and the last 4 lines:
```coffeescript
if typeof define == 'function' and define.amd
  define deps, factory
else if typeof exports == 'object'
  module.exports = factory.apply @, deps.map require
```

### VII
The components defined at the previous step will now be binded to HMTL elements. At [app/template](https://github.com/fiatjaf/reactive-couch/blob/master/app/template.coffee) there is, as a string, the full base template of the page your website will have. For each of your top-level components (the ones meant to be populated with \_list or \_show data), instantiate a `div` (or similar) and call `React.renderComponentToString` inside it, with `data` as argument (`data` will be populated inside each \_list/\_show function with the correct data). `browsercode` is the other element of the mixture, it is the browser-only code, defined at [app/app](https://github.com/fiatjaf/reactive-couch/blob/master/app/app.coffee) as plain javascript. It is mainly the __curljs__ config, instantiation of the global `window.ee`, the event emitter and binding of the React components to the same divs into which we called `React.renderComponentToString` (they must be properly identified by ids to facilitate this process).

### VIII
[rewrites.json](https://github.com/fiatjaf/reactive-couch/blob/master/rewrites.json) is used to give prettier and easy URL syntax for CouchDB. Edit the first two lines, add more lines as you add more components, read about it at [the wiki](https://wiki.apache.org/couchdb/Rewriting_urls), but there is nothing much to do here.

### IX
Everything is ready. just run `make`.

## Important information

* When you run `make` the contents of the `lib` folder and `components` folder will be copied to the homonymous folders inside `\_attachments`, so you don't need to modify these directly, everything will be copied and everything will be available at the server and at the browser.
* Modules at the `lib` should have to be AMD and CommonJS compatible. If they are not, you have to modify then and trick CouchDB and curljs into thinking they are. Read about it at https://github.com/umdjs/umd and https://github.com/cujojs/curl/wiki/js#wiki-the-js-plugin.

#### Now you're good to go. If you found a bug, have some idea to be included here or developed a totally different approach to building reactive couchapp, please open an issue, make a pull request or email me, respectively (or not). Thanks a lot.
