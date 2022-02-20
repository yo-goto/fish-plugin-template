function __fish-proejct-template_make_template --argument-names 'directory' 'basename' 'extension' 'template' 'bool_create_file' 'bool_debug'
    if not test -n "$directory" || not test -n "$basename"
        # for debugging
        begin 
            echo "directory: " $directory
            echo "basename: " $basename
            echo "extension: " $extension
            echo "template: " $template
            echo "bool_create_file: " $bool_create_file
        end
        echo "code failed: [1]"
        return 1
    end
    set --local filename (string join "" "$basename" "$extension")
    # color
    set --local cc (set_color $__fish_project_templete_color_color)
    set --local cn (set_color $__fish_project_templete_color_normal)
    set --local ca (set_color $__fish_project_templete_color_accent)
    set --local ce (set_color $__fish_project_templete_color_error)

    test "$bool_debug" = "true"
    and set -l _flag_debug "true"

    if test "$directory" = "root"
        # make a directory root file
        if not test -e "./$filename"
            command touch "./$filename"
            if test "$status" = "0"
                echo $ca"-->created:"$cc "./$filename" $cn
            else
                echo $ce"-->failed:"$cc "./$filename" $cn
            end
        end

        set -q _flag_debug; and echo $ce"Debug point: [A]"$cn
    else
        if not test -d $directory
            # make a directory
            command mkdir -p $directory
            if test "$status" = "0"
                echo $ca"-->created:"$cc "./$directory" $cn
            else
                echo $ce"-->failed:"$cc "./$directory" $cn
            end
        end

        # make a file
        if not test "$bool_create_file" = "false" && not test -e "./$directory/$filename"
            command touch "./$directory/$filename"
            if test "$status" = "0"
                echo $ca"-->created:"$cc "./$directory/$filename" $cn
            else
                echo $ce"-->failed:"$cc "./$directory/$filename" $cn
            end
        end

        set -q _flag_debug; and echo $ce"Debug point: [B]"$cn
    end

    # write template to the file created
    if not test "$bool_create_file" = "false" && set -q template
        set -q _flag_debug; and echo $ce"Debug point: [C-1]"$cn
        if functions --query __fish-project-template_write_template_$directory
            set -q _flag_debug; and echo $ce"Debug point: [C-2]"$cn
            __fish-project-template_write_template_$directory $basename $_flag_debug
        end
    end
end

