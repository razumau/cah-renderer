# frozen_string_literal: true

require "erb"

def render_prompts(prompts)
  template = ERB.new(File.read("templates/prompt.html.erb"))

  prompts.each_slice(20).each_with_index do |batch_of_prompts, index|
    rendered = template.result_with_hash({ prompts: batch_of_prompts})
    File.write("rendered/prompts_#{index + 1}.html", rendered)
  end
end

