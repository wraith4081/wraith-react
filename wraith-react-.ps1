function print_progress($1, $2, $3, $4, $5) {
    $percentage = (100 * $1 / $2)
    $loader_bar = ("#" * $3).PadRight($3, $4)
    Write-Host ("{0}`r {1}%  [{2}] {3}" -f $5, $percentage, $loader_bar.Replace("#", "-"), $4)
}

function download($1, $2, $3) {
    $file = $1
    $destination = $2
    $description = $3
    $url = "$DOWNLOAD_PREFIX$file"
    print_progress $CURRENT_STEP $TOTAL_STEPS 20 "=" $description
    Invoke-WebRequest -Uri $url -OutFile $destination
    $CURRENT_STEP++
}

$TOTAL_STEPS = 22
$CURRENT_STEP = 0
$DOWNLOAD_PREFIX = "https://raw.githubusercontent.com/wraith4081/wraith-react/main/assets/"

if ($args.Length -ne 1) {
    Write-Host "Kullanım: ./wraith-react.ps1 <name>"
    exit 1
}

$NAME = $args[0]

print_progress $CURRENT_STEP $TOTAL_STEPS 20 "=" "Creating React app..."
npx create-react-app $NAME --template typescript
$CURRENT_STEP++

cd $NAME

print_progress $CURRENT_STEP $TOTAL_STEPS 20 "=" "Removing unnecessary files..."
Remove-Item src\App.css
Remove-Item src\App.test.tsx
Remove-Item src\logo.svg
Remove-Item src\reportWebVitals.ts
Remove-Item src\setupTests.ts
$CURRENT_STEP++

print_progress $CURRENT_STEP $TOTAL_STEPS 20 "=" "Installing dependencies..."
pnpm add react-hot-toast react-router-dom@6
pnpm add -D tailwindcss
$CURRENT_STEP++

download "tsconfig.json" "tsconfig.json" "Downloading tsconfig.json..."
download "tailwind.config.js" "tailwind.config.js" "Downloading tailwind.config.js..."

cd src

download "routes.tsx" "routes.tsx" "Downloading routes.tsx..."
download "index.tsx" "index.tsx" "Downloading index.tsx..."
download "index.css" "index.css" "Downloading index.css..."
download "App.tsx" "App.tsx" "Downloading App.tsx..."

print_progress $CURRENT_STEP $TOTAL_STEPS 20 "=" "Creating directories..."
New-Item -ItemType Directory -Path components
New-Item -ItemType Directory -Path context
New-Item -ItemType Directory -Path pages
New-Item -ItemType Directory -Path utils
New-Item -ItemType Directory -Path views/layouts
$CURRENT_STEP++

download "components/PrivateRoute.tsx" "components/PrivateRoute.tsx" "Downloading PrivateRoute.tsx..."
download "context/Main.tsx" "context/Main.tsx" "Downloading Main.tsx..."
download "pages/Home.tsx" "pages/Home.tsx" "Downloading Home.tsx..."
download "utils/url.ts" "utils/url.ts" "Downloading url.ts..."
download "views/Header.tsx" "views/Header.tsx" "Downloading Header.tsx..."
download "views/Footer.tsx" "views/Footer.tsx" "Downloading Footer.tsx..."
download "views/layouts/HomeLayout.tsx" "views/layouts/HomeLayout.tsx" "Downloading HomeLayout.tsx..."

Write-Host "`nReact uygulaması başarıyla oluşturuldu ve yapılandırıldı."
