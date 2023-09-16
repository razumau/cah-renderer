# frozen_string_literal: true

require_relative "card"
require_relative "fetch_spreadsheet"
require_relative "render"

prompts = fetch_prompts
responses = fetch_responses
puts "Fetched #{prompts.size} prompts and #{responses.size} responses"

render_prompts(prompts + responses)
