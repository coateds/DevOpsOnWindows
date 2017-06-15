# Using Markdown
The Markdown syntax (put in .md files) attempts to make a fast way of creating human readable text files that can be rendered into HTML. These files are not consumed by web browsers by default. They are rendered on the server side. In the case I am interested right now is GitHub. When a .md file is selected in the GtiHub Web interface the file is rendered into HTML and then displayed in side the web page. Unfortunately, different services may render these files differently.

When creating/editing a Markdown file, it is best to use an editor that shows the interpreted HTML alongside the text in a split screen. There are a number of web sites that will do this. I like using Visual Studio Code for this.

To set this up, open a .md file in the main editor pane then click the 'Open Preview to the Side' icon in the upper right of that pane.

The following is a 'Cheat Sheet' for GitHub flavored Markdown interpretation.

## Rule 1: Never use a single Carriage Return and/or Line Feed
I assume this has its roots in trying to handle both *NIX and Windows files. If you type two lines with a single CrLf (Yes, I am Windows centric) between them, the two lines will appear as if one paragraph. It is possible to get around this restriction in GitHub Flavored Markdown (GFM) by putting two spaces at the end of the first line. Because this is so hard to see in the text form of a .md file, I recommend against it.

***Always separate lines with a header, bullet tag, number tag or two line feeds***

Formatting tags don't count! In practice this means your layout and formating options are very limited!! So I recommend you use as few of these options as possible.

Perhaps the best way to interpret this document is to view it in a side-by-side editor as I described above.

## Layout tags
Using these options will allow for single line feeds
* '#', '##', '###'  --  Headers
* '* [Text]'  --  bulleted list, note there must be a space after the *
* '1. [Text]'  --  numbered list, note the period after the number

Effectively, a bullet or number list must have a heading, even if the heading does not have a Header (#) tag. Two consecuctive bullet/number lists will not render properly without a header at the beginning of each list. I recommend using bullets and numbers a lot, with or with out a header tag

Indented bulleted lists work well
* Bullet 1
* Bullet 2
  * Bullet 3
  * Bullet 4
* Bullet 5

Indented number lists do not
1. test
2. text
  a. list
  b. list
3. Hext

## Format Tags
* '*' on both ends of a word/phrase  --  *Italics*
* '**' on both ends of a word/phrase  --  **Bold**
* '***' on both ends of a word/phrase  --  ***Bold Italics***
* There may be more, but I have not found them yet

## Code Blocks
Since markdown is often used to share and documment code, the backtick (usually between the Esc and Tab keys on a PC keyboard) can be used to highlight code...

Either a single inline line with just a couple of words.
`Single Backtick on both ends of a phrase`  --  /end

Or the Triple Backtick can used in a number of ways to display a group of code lines
```
Triple Backtick
  on the line before and on the line after a series of lines of text
  will create a multi line 'Code Block'
This is the best way to display code in a markdown file.
  Note that
  Tabs are preserved
  and indenting are preserved
This seems to be the exception to the single line feed rule

A single paragraph of text, too long for the rendered page, will create a horizontal scroll bar. This is problematic because it is hard to copy code from such a block.
```

```diff
Triple Backtick with a 'diff' after the ticks can be used to create a colorized font. This is normally used to display the differences between two files, but it can be used. Perhaps as a way to hightlight things to be done and completed.
+ lines that start with '+' will be green
- lines that start with '-' will be red
```

## Block quotes
The implementation here is a little rocky. As I understand it, one of the roots of markdown is to display email in a web page. Some email programs used '>>>' to denote earlier messages in the thread. This can be used here, but I suspect it more trouble that it's worth in most cases.

>'>' Single greater than sign

>> '>>' Double greater than sign

Use double space after line to preserve line feeds
> Line 1
>
> Line 2

> * Line 1
> * Line 2
> * Line 3

## HTML Tags
HTML tags are preserved intact. It rather defeats the purpose to use this a lot since the text version of the file will get hard to use. Hyper links are a good example of the trade off. It is possible to simply insert a hyperlink as text and it will be displayed in full and be clickable. However, very long URLs can be a problem so using the '\<a>' tag can make the rendered HTML more readable.
* http://www.yahoo.com
* <a href="http://www.yahoo.com">Yahoo</a>

## Tables
It is possible to create a a default style table with out using any HTML tags. For small amouts of content, you can type out a full text table like the following:

|Title1          |Title2         |
|----------------|---------------|
|Content 1       |Content 2      |
|Content again   |Content 2 again|
|Content again   |Content 2 again|

However, not all of this is necessary or even desirable in a much larger table with long lines of content. The following is a table of the Lorem Ipsum lines. Note that only the second line and the pipe character (|) separating the columns are actually necessary

Sentance | Sentance Content
|-|-
Sentance1 | Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
Sentance2 | At vero eos et accusam et justo duo dolores et ea rebum.
Sentance3 | Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
Sentance4 | Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.

This is not very readable in text form, but it takes far less time to type. Obviously a trade off.