defmodule Generator do
	def build(input_file, output_file, description, no_joker) do
		# initialize random seed
		init_random()

		# read bingo file content
		list = read_bingo_candidates(input_file)

		# write header
		write_bingo_header(output_file, description)

		# TODO: switch between take(24) and take(25) incl List.insert_at(12, "BINGO") byswitch

		# generate lines
#		list
#		|> Enum.shuffle
#		|> Enum.take(24)
#		|> List.insert_at(12, "BINGO")
#		|> Enum.chunk(5, 5)
#		|> Enum.each(fn([a, b, c, d ,e]) -> write_bingo_line(output_file, a, b, c, d, e) end)

		list
		|> Enum.shuffle
		|> build_list(no_joker)
		|> Enum.chunk(5, 5)
		|> Enum.each(fn([a, b, c, d ,e]) -> write_bingo_line(output_file, a, b, c, d, e) end)



		# write footer
		write_bingo_footer(output_file)
	end

	defp init_random() do
		:random.seed(:os.timestamp)
	end

	defp build_list(entries, false) do
		entries
		|> Enum.take(24)
		|> List.insert_at(12, "BINGO")
	end

	defp build_list(entries, true) do
		entries
		|> Enum.take(25)
	end

	defp write_bingo_line(file, a, b, c, d, e) do
		content = """
							<tr>
								<td style="padding:20px">#{a}</td>
								<td style="padding:20px">#{b}</td>
								<td style="padding:20px">#{c}</td>
								<td style="padding:20px">#{d}</td>
								<td style="padding:20px">#{e}</td>
							</tr>
				"""
		File.write(file, content, [:append])
	end

	defp write_bingo_header(file, description) do
		header = """
				<html>
					<body>
						<h1>#{description}</h1>
						<table border='1'>
				"""
		File.write(file, header)
	end

	defp write_bingo_footer(file) do
		footer = """
						</table>
					</body>
				</html>
				"""
		File.write(file, footer, [:append])
	end

	defp read_bingo_candidates(file) do
		binary = File.read!(file)

		binary 
		|> String.split("\n")
		|> Enum.filter(fn(str) -> String.length(str) > 0 end)
	end
end