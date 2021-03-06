function fish-plugin-template -d "Make fish plugin templates"
    argparse \
        -x 'v,h,d' \
        -x 'p,m' \
        'v/version' 'h/help' 'd/debug' \
        'n/no_template' \
        'p/project' 'm/minimal' \
        -- $argv
    or return 1
    
    set --local version_fish_plugin_template "v0.4.0"

    # color
    set --local cn (set_color $__fish_plugin_templete_color_normal)
    set --local ce (set_color $__fish_plugin_templete_color_error)

    # template directories & files for the project 
    set --local list_create_dir "functions" "completions" "conf.d" 
    set --local list_create_dir_test "tests"
    set --local list_create_files "README" "CHANGELOG" "LICENSE"
    set --local list_all $list_create_dir $list_create_dir_test $list_create_files

    # set target name for a plugin name or directory name
    set --local target_first $argv[1]
    set --local target_second_file_name $argv[2]

    set --local _flag_add_template "--add_template"
    if set -q _flag_no_template
        set _flag_add_template ""
    end

    if set -q _flag_version
        echo "fish-plugin-template:" $version_fish_plugin_template
    else if set -q _flag_help
        __fish-plugin-template_help
    else if set -q _flag_project
        # create README CHANGELOG LICENSE
        for i in (seq 1 (count $list_create_files))
            __fish-plugin-template_make_template 'root' "$list_create_files[$i]" '.md' --create_file $_flag_add_template $_flag_debug
        end
    else if test -n "$target_first"
        # make a minimal template set (function, completion, CHANGELOG)
        if set -q _flag_minimal
            set --local plugin_name (string replace --all -r "\.fish\$" "" $target_first)
            __fish-plugin-template_make_template "functions" "$plugin_name" '.fish' --create_file $_flag_add_template $_flag_debug
            __fish-plugin-template_make_template "completions" "$plugin_name" '.fish' --create_file $_flag_add_template $_flag_debug
            __fish-plugin-template_make_template 'root' "CHANGELOG" '.md' --create_file $_flag_add_template $_flag_debug
            return
        end

        # create target dir & files
        if contains $target_first $list_all
            # for list_create_files
            if contains $target_first $list_create_files
                # --argument-names 'directory' 'base_name' 'extension' '_flag_create_file' '_flag_add_template' '_flag_debug'
                __fish-plugin-template_make_template "root" "$target_first" ".md" --create_file $_flag_add_template $_flag_debug
                return
            end

            if test -n "$target_second_file_name"
                # for list_create_dir
                if contains $target_first $list_create_dir
                    # --argument-names 'directory' 'base_name' 'extension' '_flag_create_file' '_flag_add_template' '_flag_debug'
                    __fish-plugin-template_make_template "$target_first" "$target_second_file_name" ".fish" --create_file $_flag_add_template $_flag_debug
                    return
                end

                # for list_create_dir_test
                if contains $target_first $list_create_dir_test
                    # --argument-names 'directory' 'base_name' 'extension' '_flag_create_file' '_flag_add_template' '_flag_debug'
                    __fish-plugin-template_make_template "$target_first" "$target_second_file_name" ".fish" --create_file $_flag_add_template $_flag_debug
                    return
                end
            else
                echo $ce"Please pass a file name to the second argument"$cn
                return 1
            end
        else
            echo $ce"Target not found"$cn
        end
    else
        __fish-plugin-template_interactive $_flag_debug
    end
end


# helper functions
function __fish-plugin-template_help
    set_color $__fish_plugin_templete_color_color
    printf '%s\n' \
        'ALIAS:' \
        '      fpt' \
        'USAGE: ' \
        '      fish-plugin-template' \
        '      fish-plugin-template [-v | -h]' \
        '      fish-plugin-template DIRECTORY PLUGINNAME [-n]' \
        '      fish-plugin-template PROJECTFILE [-n]' \
        '      fish-plugin-template -m [-n] PLUGINNAME' \
        '      fish-plugin-template -p [-n] PLUGINNAME' \
        'OPTIONS: ' \
        '      -v, --version         Show version info' \
        '      -h, --help            Show help' \
        '      -d, --debug           Debug' \
        '      -n, --no_template     Disable adding templates' \
        '      -m, --minimal         Make a minimal template set (function completion CHANGELOG)' \
        '      -p, --project         Make project files (README LICENSE CHANGELOG)'
    set_color normal
end

