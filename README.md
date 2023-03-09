# Container for Trac 1.5

This is a simple container for Trac 1.5. It also includes the IniAdminPlugin.

## Usage

The following commands assume that your Trac environment it at `/my/trac/env`
on your local machine.

This examples use host networking but other options are possible.

Variables:

- TRAC_PORT: the port that trac will listen on (defaults to 80)
- PROJ_DIR: project directory inside the container (defaults to /trac-env)

### Launch/Setup

If the project directory is already initialized, the `-it` option is not
necessary. If not, launch an interactive session to set up the environment:

T set up, launch the container with

```sh
podman run -it -v /my/trac/env:/trac-env --name trac-test --network host -e TRAC_PORT=8080 trac:1.5
```

It will prompt you for options: project name, and admin password. You can leave
it running or exit with CTRL-C.

If it is already set-up, use

```sh
# podman run -init -v /my/trac/env:/trac-env --name trac-test --network host -e TRAC_PORT=8080 trac:1.5
```

### Add a user

```sh
podman exec -it trac:1.5 adduser <user-name>
```
