defmodule Bingogen.CLI do
  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  @doc """
  `argv` can be -h or --help which returns :help.

  Otherwise it is an input file name and an output file name. 
  Additionally a description has to be set which will be displayed
  above the table in a h1 tag. 
  to avoid a bingo joker in the middle -n or --nojoker (parser 
  supports no underscores) can be used. 
       
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv,  switches: [ help: :boolean, 
                                                  nojoker: :boolean],
                                      aliases:  [ h:    :help, 
                                                  n: :nojoker])
    case parse do
      { [help: true], _, _ }
        -> :help
      { [nojoker: true], [input_file, output_file, description], _ }
        -> {input_file, output_file, description, true}
      { _, [input_file, output_file, description], _ }
        -> {input_file, output_file, description, false}
        _       -> :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: bingogen <input_file> <output_file> <description> [--nojoker]
    """
    System.halt(0)
  end

  def process({input_file, output_file, description, no_joker}) do
    Generator.build(input_file, output_file, description, no_joker)
  end
end