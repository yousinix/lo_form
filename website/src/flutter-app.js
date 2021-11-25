customElements.define(
  "flutter-app",
  class FlutterApp extends HTMLElement {
    constructor() {
      super();
      this.innerHTML = `
      <iframe id="app-container" src="flutter-app.html" style="border: none;"></iframe>
    `;
    }
  }
);
