#─────────────────────────────────────────────────────────────────────────
# Title: get-data.r
#
# Description: Gets college football play by play data
#
# Author: J. Yeiser
#
# Origination date: 2026-10-06
#─────────────────────────────────────────────────────────────────────────

require(targets)
tar_option_set(
  packages = c("cfbfastR", "tidyverse")
)
tar_source()

list(
  # Settings ──────────
  tar_target(rundate, as.Date("2026-10-06")),
  tar_target(seasonoi, 2026),
  tar_target(weekoi, 6),
  tar_target(past_seasons, 2004:2025),

  # Historical play-by-play data ──────────
  tar_target(pbp, load_espn_cfb_pbp(seasons = past_seasons))
)
