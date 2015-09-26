module ApplicationHelper
  def pluralize_no_digits(number, term)
    pluralized = pluralize number.to_i, term
    pluralized.gsub /^\d+\s?/, ''
  end

  def color_scheme(color)
    {"minustwo" => "rgb(243, 247, 253)",
     "minusone" => "rgb(218, 230, 246)",
     "median" => "rgb(172, 195, 225)",
     "plusone" => "rgb(123, 154, 194)",
     "plustwo" => "rgb(92, 124, 166)"}[color]
  end
end
