# fish-plugin-template 🍤
> *A fish plugin to make template directories and project files for fish plugin development*

With typing `fish-plugin-template` in your command-line, you can start developing a fish plugin instantly.

## Installation 🎣

Using [fisher](https://github.com/jorgebucaran/fisher):

```console
fisher install yo-goto/fish-plugin-template
```

Update

```console
fisher update yo-goto/fish-plugin-template
```

## Usage 🔦

```console
Usage:
      fish-plugin-template
      fish-plugin-template [-v | -h] [-p [-a]]
      fish-plugin-template DIRECTORY PLUGINNAME [-a]
      fish-plugin-template PROJECTFILE [-a]
Options:
      -v, --version         Show version info
      -h, --help            Show help
      -d, --debug           Debug
      -p, --project         Make project files (README LICENSE CHANGELOG)
      -a, --add_template    Add template to specified files
```

As a alias, `fpt` is also available. This alias is defined in `~/.config/conf.d/fish-plugin-template.fish`.

For basic usage, you should type only `fish-plugin-template` or `fpt` with no options in your command-line.  
`fish-plugin-template` starts questions for your fish plugin.

```console
❯ fish-plugin-template
Please type base name which will be used as a file name
Base name: my-new-plugin
--> File name "my-new-plugin.fish" is set
Is this OK? [Y/n]: y
Make a full template in this directory? [Y/n]: y
-->created: ./functions/my-new-plugin.fish
-->added template: ./functions/my-new-plugin.fish
-->created: ./completions
-->created: ./completions/my-new-plugin.fish
-->added template: ./completions/my-new-plugin.fish
-->created: ./conf.d
-->created: ./conf.d/my-new-plugin.fish
-->created: ./tests
-->created: ./tests/my-new-plugin-test.fish
-->added template: ./README.md
-->added template: ./LICENSE.md
```

If you want to make `my-plugin.fish` in `functions` direcotry, type this.

```console
❯ fpt functions my-plugin -a
-->created: ./functions
-->created: ./functions/my-plugin.fish
-->added template: ./functions/my-plugin.fish
```

If you need only project markdown files (`README.md`, `LICENSE.md`, `CHANGELOG.md`), just type `fish-plugin-template -p`.
With `-a` or `--add_template` option flag, you can get template files.

```console
❯ fpt -pa
-->created: ./README.md
-->added template: ./README.md
-->created: ./CHANGELOG.md
-->created: ./LICENSE.md
-->added template: ./LICENSE.md
```

You can write a template file for yourself.
For example, if you want to make your own function template, make a file named `__fish-plugin-template_write_template_override_functions.fish` in the config directory (normally `~/.config/fish`). `fish-plugin-template` tries to read override files instead of default templates if exist.


## Change log 🔖
- [CHANGELOG.md](/CHANGELOG.md)

