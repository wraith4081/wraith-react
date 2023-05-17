#!/bin/bash

print_progress() {
    percentage=$((100 * $1 / $2))
    loader_bar=$(printf "%-${3}s" "#")
    loader_bar=${loader_bar//#/$4}
    printf "\r %3d%%  [%s] %s" $percentage "${loader_bar// /-}" "$5"
}

download() {
    file=$1
    destination=$2
    description=$3
    url="${DOWNLOAD_PREFIX}${file}"
    print_progress $CURRENT_STEP $TOTAL_STEPS 20 "=" "$description"
    wget -q -O "$destination" "$url"
    CURRENT_STEP=$((CURRENT_STEP + 1))
}

TOTAL_STEPS=22
CURRENT_STEP=0
DOWNLOAD_PREFIX="https://raw.githubusercontent.com/wraith4081/wraith-react/main/assets/"

if [ "$#" -ne 1 ]; then
    echo "Kullanım: ./wraith-react.sh <name>"
    exit 1
fi

NAME=$1

print_progress $CURRENT_STEP $TOTAL_STEPS 20 "=" "Creating React app..."
npx create-react-app $NAME --template typescript
CURRENT_STEP=$((CURRENT_STEP + 1))

cd $NAME

print_progress $CURRENT_STEP $TOTAL_STEPS 20 "=" "Removing unnecessary files..."
rm src/App.css
rm src/App.test.tsx
rm src/logo.svg
rm src/reportWebVitals.ts
rm src/setupTests.ts
CURRENT_STEP=$((CURRENT_STEP + 1))

print_progress $CURRENT_STEP $TOTAL_STEPS 20 "=" "Installing dependencies..."
npm install react-hot-toast react-router-dom@6
npm install -D tailwindcss
CURRENT_STEP=$((CURRENT_STEP + 1))

download "tsconfig.json" "tsconfig.json" "Downloading tsconfig.json..."
download "tailwind.config.js" "tailwind.config.js" "Downloading tailwind.config.js..."

cd src

download "routes.tsx" "routes.tsx" "Downloading routes.tsx..."
download "index.tsx" "index.tsx" "Downloading index.tsx..."
download "index.css" "index.css" "Downloading index.css..."
download "App.tsx" "App.tsx" "Downloading App.tsx..."

print_progress $CURRENT_STEP $TOTAL_STEPS 20 "=" "Creating directories..."
mkdir -p components
mkdir -p context
mkdir -p pages
mkdir -p utils
mkdir -p views/layouts
CURRENT_STEP=$((CURRENT_STEP + 1))

download "components/PrivateRoute.tsx" "components/PrivateRoute.tsx" "Downloading PrivateRoute.tsx..."
download "context/Main.tsx" "context/Main.tsx" "Downloading Main.tsx..."
download "pages/Home.tsx" "pages/Home.tsx" "Downloading Home.tsx..."
download "utils/url.ts" "utils/url.ts" "Downloading url.ts..."
download "views/Header.tsx" "views/Header.tsx" "Downloading Header.tsx..."
download "views/Footer.tsx" "views/Footer.tsx" "Downloading Footer.tsx..."
download "views/layouts/HomeLayout.tsx" "views/layouts/HomeLayout.tsx" "Downloading HomeLayout.tsx..."

printf "\nReact uygulaması başarıyla oluşturuldu ve yapılandırıldı.\n"
