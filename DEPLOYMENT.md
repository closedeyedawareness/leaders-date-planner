# Deployment Guide - Leaders in Benefits Quarterly Planner

## Quick Start (5 minutes)

### Step 1: Set Up Supabase

1. Go to [supabase.com](https://supabase.com/dashboard) and sign up/log in
2. Click **New Project**
3. Choose organization (create one if needed)
4. Fill in:
   - **Project name**: `leaders-benefits-planner`
   - **Password**: Generate a secure one
   - **Region**: Choose closest to your Leaders (e.g., US-East, EU-West)
5. Click **Create new project** (takes ~2 minutes)

### Step 2: Create Database Schema

1. Once project loads, go to **SQL Editor** (left sidebar)
2. Click **New query**
3. Copy entire contents of `001_init_schema.sql`
4. Paste into the editor
5. Click **Run** (green play button)
6. Verify: Go to **Tables** and confirm you see `q1_votes`, `q2_votes`, `q3_votes`, `q4_votes`

### Step 3: Get Your API Keys

1. Go to **Settings** (bottom left gear icon)
2. Click **API**
3. Copy:
   - **Project URL** (looks like: `https://xxxx.supabase.co`)
   - **Publishable Keys** section → Copy the **sb_publishable_xxxx** key
4. Keep these safe - you'll need them next

### Step 4: Configure the HTML File

1. Open `leaders-date-planner.html` in a text editor (VS Code, Sublime, Notepad++)
2. Find line ~130:
   ```javascript
   const SUPABASE_URL = "YOUR_SUPABASE_URL_HERE";
   const SUPABASE_PUBLISHABLE_KEY = "YOUR_PUBLISHABLE_KEY_HERE";
   ```
3. Replace with your actual values:
   ```javascript
   const SUPABASE_URL = "https://abcdefghijklmn.supabase.co";
   const SUPABASE_PUBLISHABLE_KEY = "sb_publishable_abc123def456ghi789jkl";
   ```
4. **Save the file**

### Step 5: Test Locally

1. Open `leaders-date-planner.html` in your browser (just double-click the file)
2. You should see the three voting sections
3. Try entering a name and selecting a date
4. Check if the vote appears in the results
5. If it works locally, you're ready to deploy!

## Deploy to Netlify (Recommended)

### Option A: Automatic (5 minutes)

1. Create GitHub account if you don't have one
2. Create new repo: https://github.com/new
   - Name: `leaders-date-planner`
   - Description: "Quarterly governance voting platform"
   - Public (so you can share easily)
   - Add .gitignore: Select **None**
   - Click **Create repository**

3. Upload files to GitHub:
   ```bash
   # In folder with the files:
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/leaders-date-planner.git
   git push -u origin main
   ```

4. Deploy to Netlify:
   - Go to [netlify.com](https://netlify.com)
   - Click **Add new site** → **Import an existing project**
   - Select **GitHub**
   - Find your `leaders-date-planner` repo
   - Click **Deploy site**
   - Netlify builds and deploys automatically (takes ~1-2 minutes)

5. Your site is live! Netlify gives you a URL like:
   ```
   https://leaders-date-planner-abc123.netlify.app
   ```

### Option B: Manual Upload to Netlify

1. Go to [netlify.com](https://netlify.com)
2. Sign up/log in
3. Drag and drop this entire folder onto the deploy area
4. Netlify uploads and gives you a live URL

### Option C: Self-Hosted (Any Web Server)

Simply upload `leaders-date-planner.html` to your web server.

```bash
# Via SFTP, FTP, or hosting control panel:
# Upload: leaders-date-planner.html
# Access: https://your-domain.com/leaders-date-planner.html
```

## Post-Deployment

### Share the Link

Send the live URL to your Leaders in Benefits network:
```
📅 Quarterly Meeting Planner
Please vote on dates, suggest agenda topics, and nominate new members:
[Live URL]
Voting closes: [Date]
```

### Monitor Responses

1. Go back to your Supabase dashboard
2. Click **Table Editor** (left sidebar)
3. Select `q1_votes` to see all responses in real-time
4. Export data if needed (click **...** menu → Export)

### Troubleshooting Deployment

**White page / Nothing loads**
- Check browser console (F12 → Console tab) for errors
- Verify Supabase URL and key are correct in HTML
- Check that Supabase project is active (not paused)

**"Could not load votes" error**
- Check Supabase status at https://status.supabase.com
- Verify RLS policies are set correctly (see `001_init_schema.sql`)
- Try opening Supabase dashboard to confirm project is accessible

**Real-time updates not working**
- Go to Supabase Settings → Realtime → Enable if off
- Refresh page

**Votes not saving**
- Check browser console for CORS errors
- Verify you're using the publishable key (not secret key)
- Confirm `q1_votes` table exists in Supabase

## Customization

### Change Quarter Dates

To adapt for Q2 (January), Q3 (May), or Q4 (September):

1. Open `leaders-date-planner.html`
2. Find the `getOctDates()` function (around line 165)
3. Create similar function for your month:
   ```javascript
   function getJanDates() {
     const dates = [];
     for (let d = 12; d <= 23; d++) {
       const date = new Date(2026, 0, d); // January is month 0
       if (date.getDay() !== 0 && date.getDay() !== 6) {
         dates.push({
           id: `2026-01-${String(d).padStart(2,'0')}`,
           label: date.toLocaleDateString('en-US', {weekday:'short', month:'short', day:'numeric'})
         });
       }
     }
     return dates;
   }
   ```
4. Update references from `q1_votes` to `q2_votes`
5. Redeploy

### Change Branding

Edit CSS variables at the top (lines 8-27) to match your organization colors.

### Change Table Name

If you want a single table for all quarters instead of separate ones:
1. Modify `001_init_schema.sql` to use one table with a `quarter` column
2. Update HTML references accordingly

## Security Notes

✅ **This setup is secure because:**
- Uses Supabase publishable keys (client-safe)
- RLS policies restrict who can read/write
- Anonymous nominations have no identifying info
- No sensitive data in client code

⚠️ **Best practices:**
- Never commit your secret Supabase key to Git
- Use different Supabase projects for dev/production
- Monitor data access in Supabase dashboard
- Export and archive data after each quarter

## Files Included

```
leaders-date-planner/
├── leaders-date-planner.html     # Main app (all-in-one)
├── 001_init_schema.sql            # Database setup
├── README.md                       # Feature guide
├── DEPLOYMENT.md                  # This file
├── netlify.toml                    # Netlify config
├── .gitignore                      # Git ignore rules
└── .env.example                    # Environment template
```

## Next Steps

1. ✅ Follow **Quick Start** above
2. ✅ Deploy to Netlify or your server
3. ✅ Send URL to Leaders
4. ✅ Monitor responses in Supabase
5. ✅ Schedule the meeting based on voting results
6. ✅ Archive data and prepare next quarter's planner

---

**Need help?** Check Supabase docs at https://supabase.com/docs or Netlify help at https://docs.netlify.com
