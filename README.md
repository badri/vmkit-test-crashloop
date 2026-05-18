# vmkit-test-crashloop

A **VMKit test fixture** that builds successfully but **exits immediately
on start**. Used by VMKit's end-to-end test suite to verify that:

1. `docker build` succeeds — the Dockerfile is syntactically valid and
   the image pushes to the registry without error.
2. `kamal deploy` starts the container, the process exits with status 1
   on the first run.
3. Kamal-proxy reports the web container as unhealthy (the /health
   endpoint never comes up because the process is dead), Kamal rolls
   back the deploy, and the dashboard surfaces a clear "container
   crashed on start" status — NOT a generic "deploy failed."

If a future change to the deploy gate doesn't distinguish "build failed"
from "container crashed on start," this fixture's behaviour will look the
same as a real bug — the test catches that ambiguity.

## What the "app" does

`python -c "import sys; sys.exit(1)"`. That's the entire workload. Image
builds, container starts, exits with code 1, repeat.
