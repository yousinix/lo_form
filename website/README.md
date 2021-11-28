# LoForm Website

This is a static website (using [Jekyll](https://jekyllrb.com/)) that have a Flutter widget rendered inside a [web component](https://developer.mozilla.org/en-US/docs/Web/Web_Components).

## Development

```bash
# Build the static pages into website/web
cd src
bundle exec jekyll serve -lo

# Run the Flutter app using the generated index file
cd ..
flutter run -d chrome 
```
