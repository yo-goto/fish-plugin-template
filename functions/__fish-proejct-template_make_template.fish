function __fish-proejct-template_make_template 
    # --argument-names 'directory' 'base_name' 'extension' 'template' '_flag_create_file' '_flag_debug'
    argparse 'd/debug' 'c/create_file' -- $argv
    or return 1

    set --local directory $argv[1]
    set --local base_name $argv[2]
    set --local extension $argv[3]
    set --local template $argv[4]

    if not test -n "$directory" || not test -n "$base_name"
        # for debugging
        begin 
            echo "directory: " $directory
            echo "base_name: " $base_name
            echo "extension: " $extension
            echo "template: " $template
            echo "_flag_create_file: " $_flag_create_file
            echo "_flag_debug: " $_flag_debug
        end
        echo "code failed: [1]"
        return 1
    end

    set --local filename (string join "" "$base_name" "$extension")
    # color
    set --local cc (set_color $__fish_project_templete_color_color)
    set --local cn (set_color $__fish_project_templete_color_normal)
    set --local ca (set_color $__fish_project_templete_color_accent)
    set --local ce (set_color $__fish_project_templete_color_error)


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
        if set -q _flag_create_file && not test -e "./$directory/$filename"
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
    if set -q _flag_create_file && set -q template
        set -q _flag_debug; and echo $ce"Debug point: [C-1]"$cn
        if functions --query __fish-project-template_write_template_$directory
            set -q _flag_debug; and echo $ce"Debug point: [C-2]"$cn
            __fish-project-template_write_template_$directory $base_name $_flag_debug
        end
    end
end

