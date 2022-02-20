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

    set --local plugin_name

    # first question to decide plugin name
    echo $tb$ca"Please type base name which will be used as a file name"$cn
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


    # second quesiton to create a full template
    while true
        read -l -P "Make a full template in this directory? [Y/n]: " question
        switch "$question"
            case Y y yes
                # prototype
                for i in (seq 1 (count $list_create_dir))
                    set -q _flag_debug; and \
                    echo $ce"Debug pattern(dir): "$cn "$list_create_dir[$i]" "$plugin_name" '.fish' --create_file --add_template $_flag_debug
                    __fish-proejct-template_make_template "$list_create_dir[$i]" "$plugin_name" '.fish' --create_file --add_template $_flag_debug
                end

                for i in (seq 1 (count $list_create_dir_test))
                    set -q _flag_debug; and \
                    echo $ce"Debug pattern(dir): "$cn "$list_create_dir_test[$i]" "$plugin_name" '.fish' --create_file --add_template $_flag_debug
                    __fish-proejct-template_make_template "$list_create_dir_test[$i]" "$plugin_name-test" '.fish' --create_file --add_template $_flag_debug
                end

                ## project files
                for i in (seq 1 (count $list_create_files))
                    set -q _flag_debug; and \
                    echo $ce"Debug pattern(file): "$cn 'root' "$list_create_files[$i]" '.md' --create_file --add_template $_flag_debug
                    __fish-proejct-template_make_template 'root' "$list_create_files[$i]" '.md' --create_file --add_template $_flag_debug
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
                    __fish-proejct-template_make_template "$list_create_dir[$i]" "$plugin_name" '.fish' $_flag_debug
                    while true
                        read -l -P "Make \"$plugin_name.fish\" in \"./$list_create_dir[$i]\"? [Y/n]: " choice_create_file
                        switch "$choice_create_file"
                            case Y y yes
                                __fish-proejct-template_make_template "$list_create_dir[$i]" "$plugin_name" '.fish' --create_file $_flag_debug
                                set loop_exit_flag "true"
                                break
                            case N n no
                                set loop_exit_flag "true"
                                break
                        end
                    end

                    if functions --query __fish-project-template_write_template_$list_create_dir[$i]
                        while true
                            read -l -P "Add template to \"$plugin_name.fish\"? [Y/n]: " choice_add_templete
                            switch "$choice_add_templete"
                                case Y y yes
                                    __fish-proejct-template_make_template "$list_create_dir[$i]" "$plugin_name" '.fish' --add_template $_flag_debug
                                    break
                                case N n no
                                    break
                            end
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
            read -l -P "Make \"$list_create_dir_test[$i]\" directory? [Y/n]: " question
            switch "$question"
                case Y y yes
                    set --local loop_exit_flag
                    ## project files
                    for i in (seq 1 (count $list_create_dir_test))
                        while true
                            read -l -P "Type testing file name: " testing_file
                            __fish-proejct-template_make_template "$list_create_dir_test[$i]" "$testing_file" '.fish' --create_file $_flag_debug
                            
                            if functions --query __fish-project-template_write_template_$list_create_dir_test[$i]
                                while true
                                    read -l -P "Add template to \"$testing_file.fish\"? [Y/n]: " choice_add_templete
                                    switch "$choice_add_templete"
                                        case Y y yes
                                            __fish-proejct-template_make_template "$list_create_dir_test[$i]" "$testing_file" '.fish' --add_template $_flag_debug
                                            break
                                        case N n no
                                            break
                                    end
                                end
                            end

                            read -l -P "Make another file or Go next? [m:make | g:go]: " quesiton_exit
                            switch "$quesiton_exit"
                                case G g go
                                    break
                                case M m make
                            end
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
                    __fish-proejct-template_make_template 'root' "$list_create_files[$i]" '.md' --create_file $_flag_debug
                    break
                case N n no
                    break
            end
        end

        if functions --query __fish-project-template_write_template_$list_create_files[$i]
            while true
                read -l -P "Add template to \"$list_create_files[$i].md\"? [Y/n]: " choice_add_templete
                switch "$choice_add_templete"
                    case Y y yes
                        __fish-proejct-template_make_template 'root' "$list_create_files[$i]" '.md' --add_template $_flag_debug
                        break
                    case N n no
                        break
                end
            end
        end

    end
end

