# Kujira

CSS doesn't need a full rewrite, but some actions are way too tedious. I wrote Kujira to add some shortcuts to those tedious actions like writing `h1, h2, h3, h4, h5, h6`, while still allowing CSS to fall through so you don't have to learn an entire new language.

Kujira will fill in missing semicolons for you, but it is not indentation based like `.sass`.

Below I'll name a Kujira feature, it's usage, and the equivalent CSS.

Center looks like this: `center #stockholm`. Under the hood, it generates: 

```css
#stockholm {
    display: flex;
    align-items: center;
    justify-content: center;
}   
```

Right now, center only accepts an id, but that is the main application of centering things in my experience.

`text` is an alias for the following tags:

* h1
* h2
* h3
* h4
* h5
* h6
* p
* a
* label
* textarea
* button
* span

When you write:

```
text {
  font-family: -apple-system, BlinkMacSystemFont, sans-serif;
}
```

It generates:

```css
h1, h2, h3, h4, h5, h6, p, a, label, textarea, button, span {
  font-family: -apple-system, BlinkMacSystemFont, sans-serif;
}
```

Similar to this is `header` or `heading`. You can write:

```
header {
  color: red
}
```

and Kujira will generate

```css
h1, h2, h3, h4, h5, h6 {
  color: red;
}
```

Finally, checkbox. This is an alias for `input[type="checkbox"]`. 

It looks like:

```
checkbox {
  scale: 1.25;
  margin: 8px;
}
```

And transpiles into:

```css
input[type="checkbox"] {
  scale: 1.25;
  margin: 8px;
}
```

And since Kujira lets you write normal CSS, you can write something like:

```
center #some_thing

text {
  font-family: -apple-system, BlinkMacSystemFont, sans-serif
}

checkbox {
  scale: 1.25;
  margin: 8px;
}

/* Normal CSS */
label,
textarea,
button {
  font-family: -apple-system, BlinkMacSystemFont, sans-serif;
}
```

And get:

```css
#some_thing {
    display: flex;
    align-items: center;
    justify-content: center;
}   
        

h1, h2, h3, h4, h5, h6, p, a, label, textarea, button, span {
  font-family: -apple-system, BlinkMacSystemFont, sans-serif;
}

input[type="checkbox"] {
  scale: 1.25;
  margin: 8px;
}

/* Normal CSS */
label,
textarea,
button {
  font-family: -apple-system, BlinkMacSystemFont, sans-serif;
}
```

It's important to remember that Kujira isn't in the same field as Sass or Stylus. Kujira just adds some shortcuts to commonly used things.

# Use Kujira

First, get Kujira on your machine through any means necessary.

Then, run:

```
lua kujira.lua <command> <file_in> <file_out>
```

To transpile a file, use:

```
lua kujira.lua digest <file> <new_file_name>
```

To generate a .sass file, use:

```
lua kujira.lua scaffold <file_name>
```

Or, you could do the extra work to make it executable and put it on your path so it is globally available.

Cheers!
