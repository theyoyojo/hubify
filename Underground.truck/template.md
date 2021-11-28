# Main title as H1 heading
### Subtitle as H2 heading

Paragraphs written in in plaintext

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec fermentum ultrices lectus scelerisque vulputate. Nam id purus ligula. Proin finibus ipsum elit, ut facilisis neque consectetur maximus. Cras sit amet ipsum turpis. Nam luctus tempus enim ut rhoncus. Cras sed urna eros. Curabitur vitae dignissim mauris, semper mattis tortor. Duis sit amet metus neque.

![For a demonstration of broken images, this image is not displaying correctly, because it's looking for img.jpg, which is not in this repo](img.jpg)

Source code can be found [here](https://github.com/underground-software/template.underground.software)

Directions for use of the template:

1. Download [this](template.tar.gz), which is a clean tarball built with `make dist` from the repository root.

2. Uncompress it in a clean directory.

3. Remove the contents of `src/index.md` and nav.md replace it with your markdown or html content.

4. Create your own `*.md` files in `src/` as you see fit.

5. Optionally, add your Google Analytics tracking ID to `header` in the tracking template markup.

6. Run `make` in the repository root to create a complete `*.html` page in the `docs` directory for every `*.md` page in the `src` directory.

7. Check out how these pages look in your browsers.

8. Host this tree somewhere and direct visitors to `docs/index.md`. Underground Software reccommends [GitHub Pages](https://pages.github.com/).
