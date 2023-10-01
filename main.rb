# frozen_string_literal: true

require_relative "fetch_spreadsheet"
require_relative "render"

def format_prompt(prompt)
  prompt.gsub!('\\', '<br>')
  prompt.gsub!(/_+/, '__________')
  prompt.chomp!(' ')
  prompt << '.' unless %w[. ! ?].include?(prompt.chars.last)

  prompt
end

prompts = fetch_prompts.map { |prompt| format_prompt(prompt) }
responses = fetch_responses
puts "Fetched #{prompts.size} prompts and #{responses.size} responses"

render_prompts(prompts)
render_responses(responses)
