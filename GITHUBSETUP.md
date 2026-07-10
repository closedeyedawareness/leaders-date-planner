# Push to GitHub - 3 Steps

Your **Leaders in Benefits Quarterly Governance Planner** is ready to deploy! Follow these steps to push to GitHub:

## Step 1: Create GitHub Repository

1. Go to **[github.com/new](https://github.com/new)**
2. Fill in:
   - **Repository name**: `leaders-date-planner`
   - **Description**: "Quarterly governance tool: date voting, agenda topics, network nominations"
   - **Visibility**: Public
3. **DO NOT** initialize with README (we already have one)
4. Click **Create repository**

You'll see a page with commands. Copy the HTTPS URL, it will look like:
```
https://github.com/closedeyedawareness/leaders-date-planner.git
```

## Step 2: Add Remote and Push (Choose One)

### Option A: If you cloned this repo locally

```bash
cd /path/to/leaders-date-planner
git remote add origin https://github.com/closedeyedawareness/leaders-date-planner.git
git branch -M main
git push -u origin main
```

### Option B: From a fresh clone
```bash
git clone https://github.com/closedeyedawareness/leaders-date-planner.git
cd leaders-date-planner
# Files are already here
git push -u origin main
```

## Step 3: Create Feature Branch

Push to the designated development branch:

```bash
git checkout -b claude/researchagent-jwt-secrets-dgoa4h
git push -u origin claude/researchagent-jwt-secrets-dgoa4h
```

## Step 4: Set Up Supabase Database

Now that code is on GitHub, set up your Supabase schema:

1. Go to your **Supabase dashboard** → **SQL Editor**
2. Click **New query**
3. Copy the entire contents of `001_init_schema.sql` from the repo
4. Paste and click **Run**
5. Verify tables were created (check **Tables** in left sidebar)

## Step 5: Deploy to Netlify

### Option A: Automatic (Recommended)
1. Go to **[netlify.com](https://netlify.com)**
2. Click **Add new site** → **Import an existing project**
3. Select **GitHub**
4. Find your `leaders-date-planner` repo
5. Click **Deploy site**
6. Netlify builds automatically (takes 1-2 minutes)
7. You'll get a live URL like: `https://leaders-date-planner-abc123.netlify.app`

### Option B: Drag & Drop
1. Go to **[netlify.com](https://netlify.com)**
2. Drag the entire `leaders-date-planner` folder onto the deploy area
3. Done! You have a live URL

## Step 6: Share & Celebrate 🎉

Your tool is live! Send this URL to your Leaders in Benefits network:

```
📅 Quarterly Meeting Planner
Please vote on October meeting dates, suggest agenda topics, 
and nominate new network members:

[Your Netlify URL]

Voting closes: [Date]
```

---

## Troubleshooting GitHub Push

**"Authentication failed"**
```bash
# Generate a Personal Access Token instead:
# 1. Go to github.com → Settings → Developer settings → Personal access tokens
# 2. Generate new token (check 'repo' scope)
# 3. Use token as password when pushing
```

**"Branch already exists"**
```bash
git push -u origin main
# If main exists, just push
```

**Files not showing on GitHub**
```bash
git status  # Check what's committed
git log     # See commit history
git push    # Make sure push succeeded
```

---

## Credentials Configured

✅ **Supabase URL**: `https://nzcguncvknmiocporvqo.supabase.co`  
✅ **Publishable Key**: Configured in `leaders-date-planner.html`  
✅ **Database Schema**: Run `001_init_schema.sql` in Supabase SQL Editor  

Everything is ready to go live! 🚀
