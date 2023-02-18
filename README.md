# wzg
Simple tool for creating simple applications.

## Simple Routing
To create a light application, we recommend you use our **`Wzg.FileTreeRouting`**, designed for route mapping by file tree.

```py
# Files
.
└── 🏠 src/
    ├── 📂 routes/
    │   ├── 🚀 index.html
    │   └── 🚀 test.html
    └── 📦 main.py
```

```py
from wzg import Wzg

app = Wzg.FileTreeRouting(
  tree="routes" # *optional*, "routes" in default
)

app() # start the application
```

<details>
  <summary><b>Renaming Routes</b></summary>
  <p>

By default, **`FileTreeRouting`** automatically sets the route to the HTML file name. (Though for `index.html`, it's set to the base route `/`)

We can simply rename the routes by specifying them in `rename`:

```py
app = Wzg.FileTreeRouting(
  tree="routes",
  rename={
    "test": "hello/1"
  }
)
```

<sub><i>This is an example of renaming the "/test" path to "/hello/1". </i></sub>

Generally, this replaces the original route (`/test`) from the file name (`test.html`) to a user-defined route (`/hello/1`).

In addition, you could also modify the routes using decorators:

```py
app = Wzg.FileTreeRouting(
  tree="routes",
  rename="custom" # Use the "custom" keyword
)

@app.route('/hello/1')
def hello_route(req):
  return app['test'] # return the "test.html" file
```
<sub><i>This is an advanced example of modifying the routes using decorators</i></sub>

  </p>
</details>

## Parsed
If you prefer React + Python, here it is! 

Note that the file extension is NOT for Cython, this generally indicates "**Py**thon E**x**tension".

```py
# Files
.
└── 🏠 src/
    ├── 📂 components/
    │   └── ✨ App.pyx
    ├── 🚀 index.html
    └── 📦 main.py
```

Let's give it a shot by editing **`components/App.pyx**`:
```pyx
# App.pyx

$use strict

from uuid import uuid4

# create the component
def App(children):
  return (
    <div id={str(uuid4())}>
      {children}
    </div>
  )

# export the component as default
$export default App
```

<details>
  <summary><b>How does it look like after parsing?</b></summary>
  <p>

After parsing the `pyx` (Python Extension) file, it should output a file exactly named `App.py` (without the 'x').

Here's how it looks like:

```py
from wzg import component as _0e80d2c35a33
from wzg import html as _e13b9bb4b6f3

# _USER_IMPORT
from uuid import uuid4

@_0e80d2c35a33
def App(ctx):
  return ( #BEGIN-COMPONENT
    _e13b9bb4b6f3("div", **{"id":str(uuid4())}) << ctx.children,
  ) #END-OF-COMPONENT

EXPORTS = {"default": App}

# mappingResult::{"result": {"foundErrors":0,"userImports":1,"ellasped":"300ms"}}
# mappingKeyIsValid::true
# mappingKey::MWE5ODM4NzctZDg4NS00NTA2LTllZjgtMThhOWFlYjg0NGQ0MjQ2ZDE4YWEtOGU0MS00YzdmLTljMTUtZjNlMzFkZTJiYjYw
```

...along with another file named "__init__.py":

```py
from .App import EXPORTS as _App_EXPORTS

EXPORTS = {"App": _App_EXPORTS}
```

  </p>
</details>

Nice, now we have a working component.

Next up, let's jump right back to the **`main.pyx`** file:

```py
from wzg import Wzg

# with dollar sign as prefix,
# it's treated as a file instead of a package.
from $components.App import App

app = Wzg(project=True) # project mode

app.render(
  (
    <App>
      Good Morning!
    </App>
  ),
  root="#the-root"
)
```

<details>
  <summary><b>How does it look like after parsing?</b></summary>
  <p>

Here's the output file content (main.py):

```py
from components import EXPORTS
# CONST::EXPORTS
App = EXPORTS['App']['default']

# _USER_IMPORT
from wzg import Wzg

app = Wzg(project=True) # project mode

app.render(
  ( #BEGIN-COMPONENT
    App() << "Good Morning!"
  ), #END-OF-COMPONENT
  root="#the-root"
)
# mappingResult::{"result": {"foundErrors":0,"userImports":2,"ellasped":"300ms"}}
# mappingKeyIsValid::true
# mappingKey::ZTNiNGYwNzAtMmU5NC00Yzk4LTliOTktY2VlY2E1NzFkNWE5NGQ4NzUxYmUtMTZhNy00MDljLThkZjMtMTIwZjMyNTBhZWVk
```

  </p>
</details>
