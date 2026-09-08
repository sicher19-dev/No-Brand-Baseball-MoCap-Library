# No Brand Baseball — Motion Capture Library

Static web build of the No Brand MoCap assessment library (Air Force, and future teams).
Open `index.html` locally, or deploy via GitHub Pages (workflow included).

- `index.html` — the app (Team -> pitcher nav, pitch video with camera angles, report card, A/B compare, notes)
- `data.js` — baked metrics + roster (mean +/- SD per session, kinematic sequence, team averages)
- `videos/<reportId>/` — pitch clips (cameras 1, 3, 6)

## Deploy (GitHub Pages)
1. Push this folder to the repo's `main` branch.
2. Repo Settings -> Pages -> Build and deployment -> Source: **GitHub Actions**.
3. The included workflow publishes on every push to `main`.
