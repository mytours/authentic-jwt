# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "authentic-jwt"

require "awesome_print"
require "pry"
require "byebug"

ENV["AUTHENTIC_AUTH_ACCOUNT_ID"] = "1"
ENV["AUTHENTIC_AUTH_PUBLIC_KEY"] = "-----BEGIN PUBLIC KEY-----\nMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAxGKidTdDHDPmw42At3TW\ntwZ4mf134uX0W+E2Ck4AJR2BlRhbGBOyZ1+cWO66LJEX0q6qwERiGvSBN/k3owkQ\nyeFaz4zaS9diwKr24qJKVMFOxM4Y7/kj05NjVuCkbiIB8VM5R3ielXcVJI9Fmjdf\nNGEBk3e6jFcqGAUv4fOGDJbdvyXIw9V+ETSNBKtz2w2orqbXyfp3X/rfbK2x3wok\nsuOXy1v1ZVCqRfFyooArwGWtiLzVTKsWG50WNnbs9U26YdI6t37OUdUFWs4N/3Qb\n73TQ1qrTDUcbERTnrTslbHO9NHEA8hjsLBtKvhPoHmZfQ5zZcr4qbNG9tJDh1m3i\n+55ZPyOGXw6FtPYxX+Mr4Jinmk/yYqQhuzIvpA5vfzqZlVOV6ZUEUwJuCQ/mXlfF\njhcGT16WxDB7EV/7bFAiWNqHd5Q8Jp0/wvvsb966qTgDZgB3YyBRgGr/wH14QEcF\nysiyVIT0GrRPxlQPGYYVhKLrCguWgul3k/WnbKnLgOvVEUQrRvM1dUXU0lmDUe8E\nxB8LS9EvtVjlTymCl1UTgnmJ6mykzNwbYevRh2uTOaaeVD7L2IFY1HsxE2KD1e/M\n5uyDSWAaEWC1vTRQUBPrilM6rB73DPzUjf3abLG/kYg/7VdI31k9cCi3EFP1LytT\nGCz/fJKBLkKzny3FedHQxukCAwEAAQ==\n-----END PUBLIC KEY-----"
