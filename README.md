# Leaders in Benefits - Quarterly Governance Planner

A collaborative tool for coordinating quarterly meetings with three voting sections:
- 📅 **Date Selection** – Leaders select available dates (2-week window, 09:00–17:00 working hours)
- 📋 **Agenda Topics** – Propose and vote on discussion topics
- 🤝 **Network Nominations** – Anonymously nominate new members to join the network

## Features

✅ Real-time collaborative voting via Supabase  
✅ Multiple selection (vote on multiple dates)  
✅ Topic suggestions with vote aggregation  
✅ Anonymous nominations  
✅ Live vote counts and results  
✅ Responsive luxury design (gold/dark theme)  
✅ No registration required – just add your name and vote  

## Setup

### 1. Create Supabase Project

1. Go to [supabase.com](https://supabase.com) and create a new project
2. Note your **Project URL** and create API keys:
   - Get your **publishable key** (replace the legacy anon key)
   - Store it securely

### 2. Create Database Schema

1. In Supabase, go to **SQL Editor**
2. Copy the entire contents of `001_init_schema.sql`
3. Paste and execute to create tables for all four quarters

### 3. Configure the HTML File

1. Open `leaders-date-planner.html` in a text editor
2. Find these lines (around line 130):
   ```javascript
   const SUPABASE_URL = "YOUR_SUPABASE_URL_HERE";
   const SUPABASE_PUBLISHABLE_KEY = "YOUR_PUBLISHABLE_KEY_HERE";
   ```
3. Replace with your actual Supabase URL and publishable key:
   ```javascript
   const SUPABASE_URL = "https://your-project.supabase.co";
   const SUPABASE_PUBLISHABLE_KEY = "sb_publishable_xxxxx...";
   ```

### 4. Deploy

**Option A: Deploy to Netlify**
1. Create a Git repo: `git init`
2. Add files: `git add .`
3. Commit: `git commit -m "Initial commit"`
4. Push to GitHub
5. Connect to Netlify and deploy
6. Share the live URL with Leaders in Benefits

**Option B: Self-host**
1. Upload `leaders-date-planner.html` to any web server
2. Share the URL

## Quarterly Configuration

The tool creates 4 tables: `q1_votes`, `q2_votes`, `q3_votes`, `q4_votes`

| Quarter | Month | Typical Date Window |
|---------|-------|---------------------|
| Q1 | October | Oct 12–23 (first meeting) |
| Q2 | January | Jan 12–23 (2026) |
| Q3 | May | May 12–23 (2026) |
| Q4 | September | Sept 12–23 (2026) |

**To change dates for a quarter:**
1. Edit the HTML file (look for `getOctDates()` function)
2. Modify the date range and month number
3. Change the table name from `q1_votes` to the appropriate quarter
4. Redeploy

## Data Structure

### q1_votes (and q2/q3/q4)

| Field | Type | Purpose |
|-------|------|---------|
| `id` | bigserial | Unique ID |
| `created_at` | timestamp | When the vote was cast |
| `name` | text | Voter name (for dates & topics) |
| `name_key` | text | Normalized name (unique per voter for dates) |
| `selected_dates` | text[] | Array of selected date IDs |
| `topic` | text | Suggested agenda topic |
| `nominee` | text | Anonymous nomination text |
| `category` | text | 'dates' \| 'topics' \| 'nominations' |

## Security

✅ Row Level Security (RLS) enabled  
✅ Public read access to all votes (transparency)  
✅ Public insert access (no auth required)  
✅ Date votes use `name_key` for idempotent updates (replace previous response)  
✅ Nominations are anonymous (no name stored)  
✅ Uses Supabase publishable keys (not secret keys in client code)  

## Troubleshooting

**"Could not load votes" error**
- Check that your Supabase URL and key are correct
- Verify RLS policies are enabled on all tables
- Check Supabase dashboard for any SQL errors

**Votes not updating in real-time**
- Ensure Realtime is enabled in Supabase project settings
- Check browser console for JS errors

**Name replacement not working for dates**
- Make sure the `name_key` column has the `unique` constraint
- Check that `category` is set to 'dates'

## Customization

### Change dates for a quarter
Edit the `getOctDates()` function or create similar functions for other months.

### Change branding/colors
Edit the CSS `:root` variables at the top of the HTML file.

### Add more voting sections
Duplicate one of the three sections and modify the category filter.

## Files

- `leaders-date-planner.html` – Main application (all-in-one file)
- `001_init_schema.sql` – Database schema (run in Supabase SQL Editor)
- `README.md` – This file

## Deployment Checklist

- [ ] Supabase project created
- [ ] Database schema applied
- [ ] HTML file configured with real Supabase credentials
- [ ] Tested locally (open HTML in browser)
- [ ] Deployed to Netlify or web server
- [ ] Invited Leaders to the live URL
- [ ] Confirmed real-time updates work

## Support

For issues or questions, check the Supabase dashboard logs and browser console for error messages.

---

Built with ❤️ for Leaders in Benefits Governance
