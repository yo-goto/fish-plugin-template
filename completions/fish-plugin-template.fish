complete -c fish-plugin-template -s v -l version -f -d "Show version info"
complete -c fish-plugin-template -s h -l help -f -d "Show help"
complete -c fish-plugin-template -s d -l debug -f -d "Debug"
complete -c fish-plugin-template -s n -l no_template -f -d "Disable adding templates"
complete -c fish-plugin-template -s m -l minimal -f -d "Make a minimal template set (function completion CHANGELOG)"
complete -c fish-plugin-template -s p -l project -f -d "Make project files"
complete -c fish-plugin-template -n __fish_use_subcommand -xa 'functions completions conf.d README LICENSE CHANGELOG'