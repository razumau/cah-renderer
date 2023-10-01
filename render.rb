# frozen_string_literal: true

require "erb"

def pick_font_size(text)
  case text.size
  when 1..60 then 18
  when 61..80 then 16
  when 81..100 then 16
  when 100..120 then 14
  else 12
  end
end

def pick_line_height(text)
  if text.scan('<br>').count >= 2
    1.2
  else
    1.4
  end
end

def render_prompts(prompts)
  template = ERB.new(File.read("templates/black.html.erb"))

  prompts.each_slice(20).each_with_index do |batch_of_prompts, index|
    puts "Rendering prompts batch ##{index + 1} to HTML"
    cards = batch_of_prompts.map do |prompt|
      font_size = pick_font_size(prompt)
      card_line_height = pick_line_height(prompt)
      [prompt, font_size, card_line_height]
    end
    rendered = template.result_with_hash({ cards: })
    batch_number = format('%02d', index + 1)
    File.write("rendered/prompts_#{batch_number}.html", rendered)
  end
end

def render_responses(responses)
  template = ERB.new(File.read("templates/white.html.erb"))

  responses.each_slice(20).each_with_index do |batch_of_responses, index|
    puts "Rendering responses batch ##{index + 1} to HTML"
    cards = batch_of_responses.map do |response|
      font_size = pick_font_size(response)
      card_line_height = pick_line_height(response)
      [response, font_size, card_line_height]
    end
    rendered = template.result_with_hash({ cards: })
    batch_number = format('%02d', index + 1)
    File.write("rendered/responses_#{batch_number}.html", rendered)
  end
end