# frozen_string_literal: true

require "erb"

def render_prompts(prompts)
  template = ERB.new(File.read("templates/black.html.erb"))

  prompts.each_slice(20).each_with_index do |batch_of_prompts, index|
    puts "Rendering prompts batch ##{index + 1} to HTML"
    rendered = template.result_with_hash({ cards: batch_of_prompts })
    batch_number = format('%02d', index + 1)
    File.write("rendered/prompts_#{batch_number}.html", rendered)
  end
end

def render_responses(responses)
  template = ERB.new(File.read("templates/white.html.erb"))

  responses.each_slice(20).each_with_index do |batch_of_responses, index|
    puts "Rendering responses batch ##{index + 1} to HTML"
    rendered = template.result_with_hash({ cards: batch_of_responses })
    batch_number = format('%02d', index + 1)
    File.write("rendered/responses_#{batch_number}.html", rendered)
  end
end