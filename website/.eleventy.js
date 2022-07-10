module.exports = function (eleventyConfig) {
  // Builds the web dir inside flutter app
  const outputDir = "app/web";

  // Watch CSS files for changes
  eleventyConfig.setBrowserSyncConfig({
    files: `${outputDir}/assets/css/**/*.css`,
  });

  eleventyConfig.addPassthroughCopy("src/assets");
  eleventyConfig.addPassthroughCopy("src/flutter-app");

  return {
    pathPrefix: "/lo_form/",
    dir: {
      input: "src",
      output: outputDir,
    },
  };
};
