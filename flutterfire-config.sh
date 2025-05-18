# Script to generate Firebase configuration files for different environments/flavors
# Feel free to reuse and adapt this script for your own projects
# Run  './flutterfire-config.sh <environment>'  from the root of your project
if [[ $# -eq 0 ]]; then
  echo "Error: No environment specified. Use 'dev', 'stg', or 'prod'."
  exit 1
fi

case $1 in
#   dev)
#     flutterfire config \
#       --project=flutter-ship-dev \
#       --out=lib/firebase_options_dev.dart \
#       --ios-bundle-id=com.codewithandrea.flutterShipApp.dev \
#       --ios-out=ios/flavors/dev/GoogleService-Info.plist \
#       --android-package-name=com.codewithandrea.flutter_ship_app.dev \
#       --android-out=android/app/src/dev/google-services.json
#     ;;
  stg)
    flutterfire config \
      --project=health-mn-staging \
      --out=lib/firebase/firebase_options_stg.dart \
      --android-package-name=com.example.health_management.stg \
      --android-out=android/app/src/staging/google-services.json
    ;;
  prod)
    flutterfire config \
      --project=health-mn-prod \
      --out=lib/firebase/firebase_options_prod.dart \
      --android-package-name=com.example.health_management.prod \
      --android-out=android/app/src/production/google-services.json
    ;;
  *)
    echo "Error: Invalid environment specified. Use 'dev', 'stg', or 'prod'."
    exit 1
    ;;
esac