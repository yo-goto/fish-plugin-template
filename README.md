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
ALIAS:
      fpt
USAGE:
      fish-plugin-template
      fish-plugin-template [-v | -h]
      fish-plugin-template DIRECTORY PLUGINNAME [-n]
      fish-plugin-template PROJECTFILE [-n]
      fish-plugin-template -m [-n] PLUGINNAME
      fish-plugin-template -p [-n] PLUGINNAME
OPTIONS:
      -v, --version         Show version info
      -h, --help            Show help
      -d, --debug           Debug
      -n, --no_template     Disable adding templates
      -m, --minimal         Make a minimal template set (function completion CHANGELOG)
      -p, --project         Make project files (README LICENSE CHANGELOG)
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
❯ fpt functions my-plugin
-->created: ./functions
-->created: ./functions/my-plugin.fish
-->added template: ./functions/my-plugin.fish
```

If you need only project markdown files (`README.md`, `LICENSE.md`, `CHANGELOG.md`), just type `fish-plugin-template -p`. You can get template files. To disable adding a template, use `-n, --no_template` option.

```console
❯ fpt -p
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

