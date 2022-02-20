function fish-project-template -d "Make a fisher template project"
    argparse \
        -x 'v,h,d' \
        'v/version' 'h/help' 'd/debug' \
        'p/project' \
        -- $argv
    or return 1
    
    set --local version_fisher_project "v0.0.1"

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
        echo "fisher-project: " $version_fisher_project
        return
    else if set -q _flag_help
        __fish-project-template_help
        return
    else
        __fish-project-template_interactive $target_name $_flag_debug
    end
end


# helper functions
function __fish-project-template_interactive
    argparse 'd/debug' -- $argv
    or return 1

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

    set --local plugin_name $argv[1]

    # first question to decide plugin name
    if not test -n "$plugin_name"
        echo $tb$ca"Please type base name which will be a file name"$cn
        while true
            set --local loop_exit_flag
            read -l -P "Base name: " plugin_name_prep
            # strip ".fish"
            and set plugin_name (string replace --all -r "\.fish\$" "" $plugin_name_prep)
            while true
                echo $cc"--> File name \"$plugin_name.fish\" is set"$cn
                read -l -P "Is this OK? [Y/n]: " yes_or_no
                switch "$yes_or_no"
                    case Y y yes
                        set loop_exit_flag "true"
                        break
                    case N n no
                        break
                end
            end
            test "$loop_exit_flag" = "true"; and break
        end
    else
        set --local plugin_name_prep $plugin_name
        set plugin_name (string replace --all -r "\.fish\$" "" $plugin_name_prep)
        echo $cc"--> File name \"$plugin_name.fish\" is set"$cn
    end

    # second quesiton to create a full template
    while true
        read -l -P "Make a full template in this directory? [Y/n]: " question
        switch "$question"
            case Y y yes
                # prototype
                for i in (seq 1 (count $list_create_dir))
                    set -q _flag_debug; and \
                    echo $ce"Debug pattern(dir): "$cn "$list_create_dir[$i]" "$plugin_name" '.fish' "$list_create_dir[$i]" --create_file $_flag_debug
                    __fish-proejct-template_make_template "$list_create_dir[$i]" "$plugin_name" '.fish' "$list_create_dir[$i]" --create_file $_flag_debug
                end

                for i in (seq 1 (count $list_create_dir_test))
                    set -q _flag_debug; and \
                    echo $ce"Debug pattern(dir): "$cn "$list_create_dir_test[$i]" "$plugin_name" '.fish' "$list_create_dir_test[$i]" --create_file $_flag_debug
                    __fish-proejct-template_make_template "$list_create_dir_test[$i]" "$plugin_name-test" '.fish' "$list_create_dir_test[$i]" --create_file $_flag_debug
                end

                ## project files
                for i in (seq 1 (count $list_create_files))
                    set -q _flag_debug; and \
                    echo $ce"Debug pattern(file): "$cn 'root' "$list_create_files[$i]" '.md' "$list_create_files[$i]" --create_file $_flag_debug
                    __fish-proejct-template_make_template 'root' "$list_create_files[$i]" '.md' "$list_create_files[$i]" --create_file $_flag_debug
                end
                return
            case N n no
                break
        end
    end

    # third question to create template dir
    for i in (seq (count $list_create_dir))
        while true
            set --local loop_exit_flag
            read -l -P "Make \"$list_create_dir[$i]\" directory? [Y/n]: " question
            switch "$question"
                case Y y yes
                    __fish-proejct-template_make_template "$list_create_dir[$i]" "$plugin_name" '.fish' "$list_create_dir[$i]" $_flag_debug
                    while true
                        read -l -P "Make \"$plugin_name.fish\" in \"./$list_create_dir[$i]\"? [Y/n]: " choice
                        switch "$choice"
                            case Y y yes
                                __fish-proejct-template_make_template "$list_create_dir[$i]" "$plugin_name" '.fish' "$list_create_dir[$i]" --create_file $_flag_debug
                                set loop_exit_flag "true"
                                break
                            case N n no
                                set loop_exit_flag "true"
                                break
                        end
                    end
                    test "$loop_exit_flag" = "true"; and break
                case N n no
                    break
            end
        end
    end

    # create test files
    for i in (seq 1 (count $list_create_dir_test))
        while true
            set --local loop_exit_flag
            read -l -P "Make \"$list_create_dir_test[$i]\"? [Y/n]: " question
            switch "$question"
                case Y y yes
                    set --local loop_exit_flag
                    ## project files
                    for i in (seq 1 (count $list_create_dir_test))
                        while true
                            read -l -P "Type testing file name: " testing_file
                            __fish-proejct-template_make_template "$list_create_dir_test[$i]" "$testing_file" '.fish' "$list_create_dir_test[$i]" --create_file $_flag_debug
                        end
                    end
                    break
                case N n no
                    break
            end
            test "$loop_exit_flag" = "true"; and break
        end
    end

    # create project files
    for i in (seq 1 (count $list_create_files))
        while true
            read -l -P "Make \"$list_create_files[$i]\"? [Y/n]: " question
            switch "$question"
                case Y y yes
                    ## project files
                    for i in (seq 1 (count $list_create_files))
                        __fish-proejct-template_make_template 'root' "$list_create_files[$i]" '.md' "$list_create_files[$i]" --create_file $_flag_debug
                    end
                    break
                case N n no
                    break
            end
        end
    end
end


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

