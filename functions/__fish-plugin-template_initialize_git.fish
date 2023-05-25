# initialize current directory as git repositry
function __fish-plugin-template_initialize_git
  if command git rev-parse --is-inside-work-tree 2>/dev/null
    return
  else
    echo (command git init)
  end
end

