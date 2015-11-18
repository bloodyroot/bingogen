defmodule Bingogen.CLI do
  @default_count 4
  @module """
  Handle the command line parsing and the dispatch to
  the varios functions that end up generating a
  table of the last _n_ issues in a github project
  """
  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  @doc """
  `argv` can be -h or --help which returns :help.
  Otherwise it is an input file name and an output file name.
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv,  switches: [ help: :boolean],
                                      aliases:  [ h:    :help])
    case parse do
      { [help: true], _, _ }
        -> :help
      { _, [input_file, output_file], _ }
        -> {input_file, output_file}
        _       -> :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: bingogen <input_file> <output_file>
    """
    System.halt(0)
  end

  def process({input_file, output_file}) do
    Generator.build(input_file, output_file)
  end
end