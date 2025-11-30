# Windows App Icon Setup

To set your custom icon for the Windows application, you need to convert `icon.png` to `app_icon.ico` format.

## Option 1: Online Converter (Easiest)
1. Go to https://convertio.co/png-ico/ or https://www.icoconverter.com/
2. Upload `assets/icon.png`
3. Select sizes: 16x16, 32x32, 48x48, 256x256
4. Download the generated `.ico` file
5. Replace `windows/runner/resources/app_icon.ico` with the downloaded file
6. Rebuild the Windows app: `flutter build windows --release`

## Option 2: Using ImageMagick (Command Line)
1. Install ImageMagick: `winget install ImageMagick.ImageMagick`
2. Run this command:
   ```powershell
   magick convert assets/icon.png -define icon:auto-resize=256,128,96,64,48,32,16 windows/runner/resources/app_icon.ico
   ```
3. Rebuild: `flutter build windows --release`

## Option 3: Using GIMP (Free Software)
1. Download GIMP: https://www.gimp.org/downloads/
2. Open `assets/icon.png` in GIMP
3. Go to File → Export As
4. Save as `app_icon.ico`
5. Check all size options (16x16, 32x32, 48x48, 256x256)
6. Replace `windows/runner/resources/app_icon.ico`
7. Rebuild the app

## After Replacing the Icon
Run a clean rebuild:
```powershell
flutter clean
flutter build windows --release
```

The executable will be in: `build/windows/x64/runner/Release/advent.exe`
