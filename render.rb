# frozen_string_literal: true

require "erb"

def render_prompts(prompts)
  template = ERB.new(File.read("templates/prompt.html.erb"))

  prompts.each_slice(20).each_with_index do |batch_of_prompts, index|
    rendered = template.result_with_hash({ prompts: batch_of_prompts })
    batch_number = format('%02d', index + 1)
    File.write("rendered/prompts_#{batch_number}.html", rendered)
  end
end

