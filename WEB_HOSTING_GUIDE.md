# Web Hosting Guide for Advent Calendar

## Build Output
After running `flutter build web --release`, your web app will be in the `build/web` folder.

## Hosting Options

### Option 1: Firebase Hosting (Recommended)
1. Install Firebase CLI: `npm install -g firebase-tools`
2. Login: `firebase login`
3. Initialize: `firebase init hosting`
   - Select your project or create new one
   - Set public directory to: `build/web`
   - Configure as single-page app: Yes
   - Set up automatic builds: No
4. Deploy: `firebase deploy --only hosting`

### Option 2: GitHub Pages
1. Copy contents of `build/web` to your GitHub repository
2. Go to repository Settings → Pages
3. Select branch and folder
4. Your site will be at: `https://yourusername.github.io/advent`

### Option 3: Netlify
1. Go to https://app.netlify.com
2. Drag and drop the `build/web` folder
3. Your site will be live immediately

### Option 4: Vercel
1. Install Vercel CLI: `npm install -g vercel`
2. Run: `vercel --prod`
3. Point to the `build/web` folder

### Option 5: Simple HTTP Server (for testing)
```bash
cd build/web
python -m http.server 8000
```
Then open http://localhost:8000

## Important Notes

### Base URL
If hosting in a subdirectory (not root), update `web/index.html`:
```html
<base href="/your-subdirectory/">
```

### CORS Issues
If you encounter CORS issues with SharedPreferences on web, you may need to:
- Use a proper hosting service (not file:// protocol)
- Configure CORS headers on your server

### Asset Loading
Make sure all assets in the `assets` folder are properly loaded. The build process should handle this automatically.

### Browser Compatibility
The app works on modern browsers:
- Chrome/Edge (recommended)
- Firefox
- Safari

## Testing the Build
Before deploying, test locally:
```bash
flutter run -d chrome --release
# or
cd build/web
python -m http.server 8000
```

## Rebuild for Deployment
Whenever you make changes:
```bash
flutter build web --release
```
Then redeploy to your hosting service.
