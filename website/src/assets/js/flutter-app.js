customElements.define(
  "flutter-app",
  class FlutterApp extends HTMLElement {
    constructor() {
      super();
      this.innerHTML = `
        <iframe id="app" src="index-flutter.html"></iframe>
      `;
    }
  }
);
