# fish-plugin-template
> A fish plugin to make template directories and project files for fish plugin development

You can start developing a fish plugin quickly with this plugin.

## Installation

Using [fisher](https://github.com/jorgebucaran/fisher):

```console
fisher install yo-goto/fish-plugin-template
```

Update

```console
fisher update yo-goto/fish-plugin-template
```

## Usage

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

As a alias, 'fpt' is also available.

```shell
❯ fpt -pa
-->created: ./README.md
-->added template: ./README.md
-->created: ./CHANGELOG.md
-->created: ./LICENSE.md
-->added template: ./LICENSE.md
```

You can write a template file for yourself.
Modify files such as `__fish-plugin-template_write_template_functions.fish` in the config directory (normally `~/.config/fish`) for the function template.

## Change log
- [CHANGELOG.md](/CHANGELOG.md)

