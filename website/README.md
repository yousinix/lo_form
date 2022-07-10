# LoForm Website

This is a static website (using [Eleventy](https://www.11ty.dev/)) that have a Flutter widget rendered inside a [web component](https://developer.mozilla.org/en-US/docs/Web/Web_Components).

## Development

```bash
# Build the static files into app/web
yarn build

# Run the Flutter app using the generated index file
cd flutter
flutter run -d chrome 
```
