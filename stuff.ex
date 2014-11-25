
defmodule Mix.Tasks.Stuff do
  use Mix.Task

 @shortdoc "It's Stuff!"
 def run(_) do
   Mix.shell.info "stuff"
 end
end
