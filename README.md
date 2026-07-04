# CRM Pro

Single-file HTML/CSS/JS CRM (Hebrew, RTL) with optional Supabase cloud sync.

Works fully offline out of the box (localStorage). Cloud sync is opt-in — nothing
breaks if you skip the setup below.

## Local use

Just open `index.html` in a browser. Data is stored in `localStorage`.

## Enabling cloud sync (optional)

1. Create a new project at [supabase.com](https://supabase.com).
2. In the Supabase SQL editor, run `supabase/migrations/0001_init.sql` — this creates
   the `contacts`, `deals`, `tasks` tables with row-level security scoped to
   `auth.uid()`.
3. In your Supabase project settings, grab the **Project URL** and **anon public key**.
4. In this GitHub repo: Settings → Secrets and variables → Actions → New repository secret.
   Add:
   - `SUPABASE_URL`
   - `SUPABASE_ANON_KEY`
5. In this GitHub repo: Settings → Pages → Source → set to "GitHub Actions".
6. Push to `main`. The included workflow (`.github/workflows/deploy.yml`) injects
   the secrets into `index.html` at deploy time and publishes to GitHub Pages —
   the anon key never touches the committed source.
7. Open the deployed site → sidebar (bottom-left) → user tile → Settings →
   "סנכרון ענן" → sign up with an email/password. Your local data is pushed
   to Supabase on first sign-in and syncs automatically after every change.

Running `index.html` directly (e.g. via `file://` or local dev) without replacing
the `__SUPABASE_URL__` / `__SUPABASE_ANON__` placeholders keeps cloud sync disabled
and the app behaves exactly like local-only mode.
