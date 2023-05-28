function __fpt_write_template_LICENSE
    # --argument-names 'plugin' '_flag_debug'
    argparse 'd/debug' -- $argv
    or return 1

    set --local plugin $argv[1]
    set --local filepath "./LICENSE.md"

    if not test -n "$plugin"
        echo "code failed: [__fpt_write_template_LICENSE]"
        return 1
    end

    # color
    set --local cc (set_color $__fpt_color_color)
    set --local cn (set_color $__fpt_color_normal)
    set --local ca (set_color $__fpt_color_accent)
    set --local ce (set_color $__fpt_color_error)

    set -q _flag_debug; and echo $ce"Debug point: [__fpt_write_template_LICENSE]"$cn

    set --local user_name '{YOUR_NAME}'
    set --local time_now (command date +%Y)

builtin printf '%s\n' \
"The MIT License (MIT)

Copyright (c) $time_now $user_name

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the \"Software\"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

">> $filepath

    if test "$status" = "0"
        echo $ca"-->added template:"$cc "$filepath" $cn
    else
        echo $ce"-->failed to write:"$cc "$filepath" $cn
    end
end

