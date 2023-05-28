function __fpt_make_template
    # --argument-names 'directory' 'base_name' 'extension' '_flag_create_file' '_flag_add_template' '_flag_debug'
    argparse 'c/create_file' 'a/add_template' 'd/debug' -- $argv
    or return 1

    # name arguemnts
    set --local directory $argv[1]
    set --local base_name $argv[2]
    set --local extension $argv[3]

    if not test -n "$directory" || not test -n "$base_name"
        # for debugging
        if set -q _flag_debug
            echo "directory: " $directory
            echo "base_name: " $base_name
            echo "extension: " $extension
            echo "_flag_add_template: " $_flag_add_template
            echo "_flag_create_file: " $_flag_create_file
            echo "_flag_debug: " $_flag_debug
        end
        echo "code failed: [1]"
        return 1
    end

    if test "$extension" = ".fish"
        set --local name_prep (string replace --all -r "\.fish\$" "" $base_name)
        set base_name $name_prep
    end

    set --local filename (string join "" "$base_name" "$extension")
    set --local filepath
    set --local template
    # color
    set --local cc (set_color $__fpt_color_color)
    set --local cn (set_color $__fpt_color_normal)
    set --local ca (set_color $__fpt_color_accent)
    set --local ce (set_color $__fpt_color_error)

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
        set filepath "./$filename"
        set template $base_name
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

        set filepath "./$directory/$filename"
        set template $directory
        set -q _flag_debug; and echo $ce"Debug point: [B]"$cn
    end

    # write template to the file created
    if set -q _flag_add_template && test -e "$filepath"
        set -q _flag_debug; and echo $ce"Debug point: [C-1]"$cn
        if functions --query __fpt_write_template_override_$template
            __fpt_write_template_override_$template $base_name $_flag_debug
        else if functions --query __fpt_write_template_$template
            set -q _flag_debug; and echo $ce"Debug point: [C-2]"$cn
            __fpt_write_template_$template $base_name $_flag_debug
        end
    end
end

