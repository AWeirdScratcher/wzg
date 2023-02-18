from wzg import Wzg
from $components.App import App

app = Wzg(project=True)

app.render(
  (
    <App>
      Good Morning! Very Good!
    </App>
  ),
  root="#root"
)
