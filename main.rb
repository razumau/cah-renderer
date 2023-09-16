# frozen_string_literal: true

require_relative "card"
require_relative "fetch_spreadsheet"
require_relative "render"

# prompts = fetch_prompts
# responses = fetch_responses
# puts "Fetched #{prompts.size} prompts and #{responses.size} responses"
prompts = (1..55).map { |index| Card[:prompt, "Text for a prompt ##{index}: ___________"] }

render_prompts(prompts)
