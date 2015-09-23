module ApplicationHelper
  def pluralize_no_digits(number, term)
    pluralized = pluralize number.to_i, term
    pluralized.gsub /^\d+\s?/, ''
  end
end
