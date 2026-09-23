# Kujira

CSS doesn't need a full rewrite, but some actions are way too tedious. That's why Kujira adds some shortcuts to those actions while allowing CSS to fall through.

Kujira has three features: `center`, `text`, and `checkbox`.

Center looks like this: `center #stockholm`. Under the hood, it generates: 

```css
#stockholm {
    display: flex;
    flex-direction: column;
    align-items: center;
}   
```

Right now, center only accepts an id, but that is the main application of centering things.

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

Finally, checkbox. This is the smallest feature so far as it is just an alias for `input[type="checkbox"]`. 

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
  font-family: -apple-system, BlinkMacSystemFont, sans-serif;
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
    flex-direction: column;
    align-items: center;
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
