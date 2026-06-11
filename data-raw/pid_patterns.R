pid_patterns <- tibble::tribble(
  ~type, ~pattern, ~description,

  #  Email
  "email", "(?i)\\b[a-z0-9._%+\\-]+@[a-z0-9.\\-]+\\.[a-z]{2,}\\b", "Standard email address including plus-addressing and subdomains",

  #  Phone: UK
  "phone", "(?:(?:\\+44|0044|0)[\\s.\\-]?(?:1[0-9]{3}|2[0-9]|3[0-9]{2}|7[0-9]{3}|8[0-9]{2}|9[0-9]{2})[\\s.\\-]?[0-9]{3}[\\s.\\-]?[0-9]{3,4})", "UK landline and mobile numbers with +44, 0044, or trunk 0 prefix",
  "phone", "(?:(?:\\+44|0044|0)[\\s.\\-]?(?:800|845|870|871|872|873)[\\s.\\-]?[0-9]{3}[\\s.\\-]?[0-9]{4})", "UK freephone and special rate numbers",

  # Phone: International
  "phone", "(?<![0-9])\\+(?:[1-9][0-9]{0,2})[\\s.\\-]?(?:[0-9][\\s.\\-]?){6,14}[0-9]", "International E.164 numbers with country code prefix",

  #  IP: IPv4
  "ip", "\\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\b", "IPv4 address with per-octet 0-255 validation",

  #  IP: IPv6
  "ip", "(?:[0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}", "IPv6 full form (8 groups of 4 hex digits)",
  "ip", "(?:[0-9a-fA-F]{1,4}:){1,7}:", "IPv6 with trailing double-colon compression",
  "ip", ":(?::[0-9a-fA-F]{1,4}){1,7}", "IPv6 with leading double-colon compression",
  "ip", "(?:[0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}", "IPv6 with mid-string double-colon compression",
  "ip", "::(?:[fF]{4}(?::0{1,4})?:)?(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)", "IPv4-mapped IPv6 address (::ffff:192.168.1.1)",

  #  Date of Birth: Numeric
  "date", "\\b(?:0?[1-9]|[12][0-9]|3[01])[/\\-.](0?[1-9]|1[0-2])[/\\-.](?:19|20)[0-9]{2}\\b", "DMY numeric date: DD/MM/YYYY, DD-MM-YYYY, DD.MM.YYYY",
  "date", "\\b(?:19|20)[0-9]{2}[/\\-.](0?[1-9]|1[0-2])[/\\-.](?:0?[1-9]|[12][0-9]|3[01])\\b", "ISO / YMD numeric date: YYYY-MM-DD",

  #  Date of Birth: Written month
  "date", "(?i)\\b(?:0?[1-9]|[12][0-9]|3[01])(?:st|nd|rd|th)?\\s+(?:Jan(?:uary)?|Feb(?:ruary)?|Mar(?:ch)?|Apr(?:il)?|May|Jun(?:e)?|Jul(?:y)?|Aug(?:ust)?|Sep(?:tember)?|Oct(?:ober)?|Nov(?:ember)?|Dec(?:ember)?)\\s+(?:19|20)[0-9]{2}\\b", "Long-form DMY: 12th March 1985, 12 March 1985",
  "date", "(?i)\\b(?:Jan(?:uary)?|Feb(?:ruary)?|Mar(?:ch)?|Apr(?:il)?|May|Jun(?:e)?|Jul(?:y)?|Aug(?:ust)?|Sep(?:tember)?|Oct(?:ober)?|Nov(?:ember)?|Dec(?:ember)?)\\s+(?:0?[1-9]|[12][0-9]|3[01])(?:st|nd|rd|th)?,?\\s+(?:19|20)[0-9]{2}\\b", "Long-form MDY: January 12, 1985, Jan 12th 1985",

  #  UK Postcode
  "postcode", "(?i)\\b[A-Z]{1,2}[0-9][0-9A-Z]?\\s?[0-9][ABD-HJLNP-UW-Z]{2}\\b", "UK postcode following Royal Mail format (AN/ANN/AAN/AANN/ANA/AANA NAA)",

  #  US ZIP Code
  "postcode", "\\b[0-9]{5}(?:-[0-9]{4})?\\b", "US ZIP code, 5-digit or ZIP+4",

  #  Credit / Debit Card: Amex
  "card", "(?:3[47][0-9]{2})[\\s\\-]?[0-9]{6}[\\s\\-]?[0-9]{5}", "American Express: 4-6-5 digit grouping, starting 34 or 37",

  #  Credit / Debit Card: Visa
  "card", "(?<![0-9])4[0-9]{3}(?:[\\s\\-]?[0-9]{4}){3}(?![0-9])", "Visa: 16 digits starting with 4",

  #  Credit / Debit Card: Mastercard
  "card", "(?<![0-9])(?:5[1-5][0-9]{2}|2(?:2[2-9][1-9]|[3-6][0-9]{2}|7[01][0-9]|720))[\\s\\-]?(?:[0-9]{4}[\\s\\-]?){3}(?![0-9])", "Mastercard: 16 digits starting 51-55 or 2221-2720",

  #  Credit / Debit Card: Discover
  "card", "(?<![0-9])(?:6011|65[0-9]{2}|64[4-9][0-9])[\\s\\-]?(?:[0-9]{4}[\\s\\-]?){3}(?![0-9])", "Discover: 16 digits starting 6011, 644-649, or 65"
)


usethis::use_data(pid_patterns, overwrite = T)
