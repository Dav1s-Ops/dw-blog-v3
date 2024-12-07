puts "—————— Clearing existing data..."

Post.destroy_all
User.destroy_all
Category.destroy_all
Tag.destroy_all

puts "—————— Data cleared."
puts "Creating user..."

admin = User.create!(
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password'
)

puts "—————— User created: #{admin.email}"
puts "Creating categories..."

categories = [ 'Frontend', 'Backend', 'Fullstack', 'DevOps', 'News', 'Personal' ].map do |category_name|
  Category.create!(name: category_name)
end

puts "—————— Categories created: #{categories.map(&:name).join(', ')}"
puts "Creating tags..."

tags = [ 'JavaScript', 'Python', 'Ruby', 'Java', 'C++', 'C#', 'HTML', 'CSS', 'SQL', 'React', 'Angular', 'Vue', 'Node.js', 'Django', 'Flask', 'Rails', 'Spring Boot', 'Git', 'Docker', 'Kubernetes', 'AWS', 'Azure', 'GCP', 'REST', 'GraphQL', 'TypeScript', 'Swift', 'Objective-C', 'Kotlin', 'Go', 'Rust', 'PHP', 'Bash', 'Perl', 'Linux', 'Windows', 'macOS', 'Agile', 'Scrum', 'TDD', 'DevOps', 'Machine Learning', 'AI', 'Data Science', 'Cybersecurity', 'Blockchain', 'Web Development', 'Mobile Development', 'Frontend', 'Backend', 'Fullstack' ].map do |tag_name|
  Tag.create!(name: tag_name)
end

puts "—————— Tags created: #{tags.map(&:name).join(', ')}"
puts "Creating posts..."

post_content = <<~MD
# h1 Heading
## h2 Heading
### h3 Heading
#### h4 Heading
##### h5 Heading
###### h6 Heading

# Emphasis!

Emphasis, aka italics, with *asterisks* or _underscores_.

Strong emphasis, aka bold, with **asterisks** or __underscores__.

Combined emphasis with **asterisks and _underscores_**.

Strikethrough uses two tildes. ~~Scratch this.~~

**This is bold text**

__This is bold text__

*This is italic text*

_This is italic text_

~~Strikethrough~~

Programming is the process of designing and building software to solve problems, automate tasks, and create interactive experiences that drive the modern world. It involves writing instructions, called code, that computers interpret to perform specific functions. 

Programming languages like Python, JavaScript, Ruby, and Java provide developers with the tools to express logic, manipulate data, and interact with hardware. Through frameworks and libraries, programmers accelerate development, enabling the creation of everything from responsive web applications to powerful machine learning algorithms. 

It’s a field that blends creativity with logic, requiring attention to detail, problem-solving skills, and an understanding of complex systems. Whether it's crafting a simple script to automate repetitive tasks, building an immersive video game, or engineering scalable cloud services, programming empowers individuals to innovate and bring ideas to life. 

Collaboration is key, as programmers often work in teams, leveraging tools like Git for version control and methodologies like Agile to ensure projects are delivered efficiently. 

As technology evolves, so do programming paradigms, pushing the boundaries of what's possible in artificial intelligence, cybersecurity, and digital transformation. Ultimately, programming isn't just about writing code—it's about building solutions that shape the future.

# Tables

| Header 1      | Header 2      | Header 3      |
|---------------|---------------|---------------|
| Row 1 Column 1| Row 1 Column 2| Row 1 Column 3|
| Row 2 Column 1| Row 2 Column 2| Row 2 Column 3|
| Row 3 Column 1| Row 3 Column 2| Row 3 Column 3|


# Lists

* Unordered list can use asterisks
- Or minuses
+ Or pluses

1. Make my changes
    1. Fix bug
    2. Improve formatting
        - Make the headings bigger
2. Push my commits to GitHub
3. Open a pull request
    * Describe my changes
    * Mention all the members of my team
        * Ask for feedback

+ Create a list by starting a line with `+`, `-`, or `*`
+ Sub-lists are made by indenting 2 spaces:
  - Marker character change forces new list start:
    * Ac tristique libero volutpat at
    + Facilisis in pretium nisl aliquet
    - Nulla volutpat aliquam velit
+ Very easy!

# Links

[I'm an inline-style link](https://www.google.com)

[I'm an inline-style link with title](https://www.google.com "Google's Homepage")

[You can use numbers for reference-style link definitions][1]

Or leave it empty and use the [link text itself].

# Code Block / Syntax Highlighting

Inline `code` has `back-ticks around` it.

```c#
using System.IO.Compression;

#pragma warning disable 414, 3021

namespace MyApplication
{
    [Obsolete("...")]
    class Program : IInterface
    {
        public static List<int> JustDoIt(int count)
        {
            Console.WriteLine($"Hello {Name}!");
            return new List<int>(new int[] { 1, 2, 3 })
        }
    }
}
```

```css
@font-face {
  font-family: Chunkfive; src: url('Chunkfive.otf');
}

body, .usertext {
  color: #F0F0F0; background: #600;
  font-family: Chunkfive, sans;
}

@import url(print.css);
@media print {
  a[href^=http]::after {
    content: attr(href)
  }
}
```

```javascript
function $initHighlight(block, cls) {
  try {
    if (cls.search(/\bno\-highlight\b/) != -1)
      return process(block, true, 0x0F) +
             ` class="${cls}"`;
  } catch (e) {
    /* handle exception */
  }
  for (var i = 0 / 2; i < classes.length; i++) {
    if (checkCondition(classes[i]) === undefined)
      console.log('undefined');
  }
}

export  $initHighlight;
```

```php
require_once 'Zend/Uri/Http.php';

namespace Location\Web;

interface Factory
{
    static function _factory();
}

abstract class URI extends BaseURI implements Factory
{
    abstract function test();

    public static $st1 = 1;
    const ME = "Yo";
    var $list = NULL;
    private $var;

    /**
     * Returns a URI
     *
     * @return URI
     */
    static public function _factory($stats = array(), $uri = 'http')
    {
        echo __METHOD__;
        $uri = explode(':', $uri, 0b10);
        $schemeSpecific = isset($uri[1]) ? $uri[1] : '';
        $desc = 'Multi
line description';

        // Security check
        if (!ctype_alnum($scheme)) {
            throw new Zend_Uri_Exception('Illegal scheme');
        }

        $this->var = 0 - self::$st;
        $this->list = list(Array("1"=> 2, 2=>self::ME, 3 => URI::class));

        return [
            'uri'   => $uri,
            'value' => null,
        ];
    }
}

echo URI::ME . URI::$st1;

__halt_compiler () ; datahere
datahere
datahere */
datahere
```
# Blockquotes

> Blockquotes are very handy in email to emulate reply text.
> This line is part of the same quote.

Quote break.

> This is a very long line that will still be quoted properly when it wraps. Oh boy let's keep writing to make sure this is long enough to actually wrap for everyone. Oh, you can *put* **Markdown** into a blockquote.

> Blockquotes can also be nested...
>> ...by using additional greater-than signs right next to each other...
> > > ...or with spaces between arrows.

# Horizontal Rules

Three or more...

---

Hyphens

***

Asterisks

___

Underscores

------
MD

50.times do |i|
  post = Post.create!(
    title: "Sample Post #{i + 1}",
    content: post_content,
    status: Post.statuses.keys.sample,
    user: admin,
    categories: categories.sample(rand(1..(categories.length - 1))),
    tags: tags.sample(rand(1..(tags.length - 1)))
  )

  # Associate random categories and tags
  # post.categories << categories.sample(rand(0..4))
  # post.tags << tags.sample(rand(0..5))

  # Generate slug using FriendlyId
  post.save!

  puts "Created post: #{post.title}"
end

puts "Data added, happy blogging!"
