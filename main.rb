# frozen_string_literal: true

require_relative "fetch_spreadsheet"

prompts = fetch_prompts
responses = fetch_responses
puts "Fetched #{prompts.size} prompts and #{responses.size} responses"
