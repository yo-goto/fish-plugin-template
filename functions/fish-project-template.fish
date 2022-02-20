function fish-project-template -d "Make a fisher template project"
    argparse \
        -x 'v,h,d' \
        'v/version' 'h/help' 'd/debug' \
        'p/project' \
        -- $argv
    or return 1
    
    set --local version_fish_project_template "v0.0.1"

    # color
    set --local cc (set_color $__fish_project_templete_color_color)
    set --local cn (set_color $__fish_project_templete_color_normal)
    set --local ca (set_color $__fish_project_templete_color_accent)
    set --local ce (set_color $__fish_project_templete_color_error)
    set --local tb (set_color -o)

    # template directories & files for the proejct 
    set --local list_create_dir "functions" "completions" "conf.d" 
    set --local list_create_dir_test "tests"
    set --local list_create_files "README" "CHANGELOG" "LICENSE"

    set --local plugin_name
    # set target name for plugin name or direcotry name
    set --local target_name $argv[1]

    if set -q _flag_version
        echo "fish-project-template:" $version_fish_project_template
        return
    else if set -q _flag_help
        __fish-project-template_help
        return
    else
        __fish-project-template_interactive $target_name $_flag_debug
    end
end


# helper functions
function __fish-project-template_help
    set_color $__fish_project_templete_color_color
    echo 'Usage: '
    echo '      fish-project-template [OPTION]'
    echo 'Options: '
    echo '      -v, --version   Show version info'
    echo '      -h, --help      Show help'
    echo '      -d, --debug     Show debug tests'
    set_color normal
end

