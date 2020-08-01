# HackneyBugDemo

Try to demonstrate [this issue](https://github.com/benoitc/hackney/issues/643).

The app starts up `:ranch` to accept incoming requests, and a number of fetchers that fetch from it.
I've tried various timeout and other kinds of responses from `:ranch` and haven't yet nailed down what
actually causes the pool to fill up.

To run the app:

```
$ mix deps.get
$ mix run --no-halt
```
