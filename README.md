# Bingogen

This simple tool can help you to generate a bingo map from a list of possibles entries. The source list is expected to be a text file in which every line holds a value. 
Bingogen will take 25 entries of these and build a random map which will be stored in a HTML file you define in the command call.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add bingogen to your list of dependencies in `mix.exs`:

        def deps do
          [{:bingogen, "~> 0.0.1"}]
        end

  2. Ensure bingogen is started before your application:

        def application do
          [applications: [:bingogen]]
        end
