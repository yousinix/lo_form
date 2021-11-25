customElements.define(
  "flutter-app",
  class FlutterApp extends HTMLElement {
    constructor() {
      super();
      const width = this.getAttribute("width") || "100%";
      const height = this.getAttribute("height") || "100%";

      this.innerHTML = `
      <style>
        #app-container {
          height: ${height};
          width: ${width};
          border: none;
        }
      </style>
      <iframe id="app-container" src="flutter-app.html"></iframe>
    `;
    }
  }
);
