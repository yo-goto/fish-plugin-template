function __fish-plugin-template_write_template_completions 
    # --argument-names 'plugin' '_flag_debug'
    argparse 'd/debug' -- $argv
    or return 1

    set --local plugin $argv[1]
    set --local filepath "./completions/$plugin.fish"

    if not test -n "$plugin"
        echo "code failed: [__fish-plugin-template_write_template_completions ]"
        return 1
    end

    # color
    set --local cc (set_color $__fish_plugin_templete_color_color)
    set --local cn (set_color $__fish_plugin_templete_color_normal)
    set --local ca (set_color $__fish_plugin_templete_color_accent)
    set --local ce (set_color $__fish_plugin_templete_color_error)

    set -q _flag_debug; and echo $ce"Debug point: [__fish-plugin-template_write_template_completions ]"$cn

builtin printf -- '%s\n' \
"# completion template generated from 'fish-plugin-template'
complete -c $plugin -s v -l version -f -d \"Show version info\"
complete -c $plugin -s h -l help -f -d \"Show help\"
   " >> "$filepath"

    if test "$status" = "0"
        echo $ca"-->added template:"$cc "$filepath" $cn
    else
        echo $ce"-->failed to write:"$cc "$filepath" $cn
    end
end

