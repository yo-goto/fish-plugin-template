# initialize current directory as git repositry
function __fish-plugin-template_initialize_git
  if command test -d .git
    return
  else
    command git init >/dev/null
    echo "-->initalized git repositry"
  end
end

