# Dragons vs Monsters

HTML5 dragon defense auto-battler inspired by Plants vs. Zombies and Teamfight Tactics.

## Play locally

Open `Dragons vs Monsters.html` in a browser, or run the LAN server:

```bat
server.bat
```

The server prints a LAN link like:

```text
http://YOUR_IPV4:8001/Dragons%20vs%20Monsters.html
```

Share that link with computers on the same network.

## GitHub Pages

This project is a static HTML5 prototype with no build step. GitHub Pages can serve it directly from the `main` branch root.

Public URL format:

```text
https://qa-vibejam.github.io/Dragons-vs-Monsters/
```

## Main files

- `Dragons vs Monsters.html` - playable game file.
- `server.bat` - starts the LAN server for local network testing.
- `lan-server.ps1` - small static file server used by `server.bat`.
- `GDD/` - game design document.
- `Asset DML/`, `Asset Pack/`, `Resource Asset/` - game assets.
