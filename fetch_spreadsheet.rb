# frozen_string_literal: true

require "dotenv/load"
require "google/apis/sheets_v4"
require "googleauth"
require_relative "card"

SPREADSHEET_KEY = ENV["SPREADSHEET_KEY"]
GOOGLE_API_KEY = ENV["GOOGLE_API_KEY"]

def fetch_prompts
  fetch_data("prompts", "D").values.map { |text| Card[:prompt, text] }
end

def fetch_responses
  fetch_data("responses", "D").values.map { |text| Card[:response, text] }
end

def fetch_data(sheet_name, column)
  sheets = Google::Apis::SheetsV4::SheetsService.new
  sheets.key = GOOGLE_API_KEY
  sheets.get_spreadsheet_values(SPREADSHEET_KEY, "#{sheet_name}!#{column}2:#{column}")
end
