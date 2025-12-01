# Secure Key Management Guide

## Overview
This app uses encrypted SharedPreferences to store sensitive data. The encryption key is passed at compile-time using `--dart-define`.

## Generating Secure Encryption Keys

### Method 1: Using OpenSSL (Recommended)
```bash
openssl rand -base64 32
```

### Method 2: Using Dart
```dart
import 'dart:math';
import 'dart:convert';

String generateKey() {
  final random = Random.secure();
  final values = List<int>.generate(32, (i) => random.nextInt(256));
  return base64Encode(values);
}
```

### Method 3: Using Python
```bash
python3 -c "import secrets; print(secrets.token_urlsafe(32))"
```

## Environment-Specific Keys

### Development
- Key: `dev_encryption_key_12345678901234`
- ⚠️ Only for local development
- Can be shared in launch.json

### Staging
- Key: Generate using: `openssl rand -base64 32`
- Store in: `.env` file (NOT committed to git)
- Share securely with team via password manager

### Production
- Key: Generate using: `openssl rand -base64 32`
- Store in: CI/CD secrets (GitHub Secrets, GitLab CI/CD Variables, etc.)
- **NEVER** commit to git
- Rotate periodically (every 6 months)

## Usage

### In VS Code (Debug Mode)
Keys are already configured in `.vscode/launch.json`:
- Select flavor (dev/staging/prod)
- Run with F5 or debug button

### Command Line
```bash
# Development
fvm flutter run --flavor dev --dart-define=STORAGE_ENCRYPTION_KEY=dev_encryption_key_12345678901234

# Staging
fvm flutter run --flavor staging --dart-define=STORAGE_ENCRYPTION_KEY=YOUR_STAGING_KEY

# Production
fvm flutter build apk --flavor production --dart-define=STORAGE_ENCRYPTION_KEY=YOUR_PRODUCTION_KEY --release
```

### In CI/CD (GitHub Actions example)
```yaml
- name: Build APK
  run: |
    flutter build apk \
      --flavor production \
      --dart-define=STORAGE_ENCRYPTION_KEY=${{ secrets.STORAGE_ENCRYPTION_KEY }} \
      --release
```

## Security Best Practices

1. **Never hardcode keys in source code**
2. **Use different keys for each environment**
3. **Store production keys in secure secret management systems**
4. **Rotate keys periodically**
5. **Add .env to .gitignore**
6. **Use CI/CD secrets for automated builds**

## Key Rotation Strategy

When rotating keys:
1. Generate new key
2. Read old data with old key
3. Re-encrypt data with new key
4. Update all deployment configurations
5. Invalidate old key

## Troubleshooting

### Warning: "Using default encryption key"
- You forgot to pass `--dart-define=STORAGE_ENCRYPTION_KEY`
- The key is empty or invalid
- Solution: Add the key to your launch configuration or build command

### Data can't be decrypted
- Key mismatch between encryption and decryption
- Solution: Ensure you're using the same key that was used to encrypt the data
