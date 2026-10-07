library(cfbfastR)
library(tidyverse)

# setting git user name, etc
# git config --global user.name "Your Name"
# git config --global user.email "your.email@example.com"

#  2013--2025 ──────────
# pbp <- load_ncaa_mfb_pbp_cfbfastr(2025)

# 2004--2026 ──────────
# https://cfbfastr.sportsdataverse.org/reference/load_espn_cfb_pbp.html

# Settings ──────────
# season of interest
soi <- 2026

pbp <- load_espn_cfb_pbp(soi)

teamid <- espn_cfb_teams()
teamid |> filter(grepl("Kentucky", display_name))

# must have team_id...
coachid <- espn_cfb_team_coaches(year = soi, team_id = 96)

# Division, conference ──────────
teaminfo <- espn_cfb_groups(year = soi, season_type = 2)
teaminfo

# UK team id
teamoi <- 96

# overUnder,homeTeamSpread
# USE homeTeamSpread -- gameSpread is relative to home team margin

#scoring_opp?
score_types <- pbp |>
    select(scoringType.name, scoringType.displayName, end.pos_team.id) |>
    na.omit() |>
    distinct()

playerid <- pbp |> select(ends_with("player_id"))

# start.team.id == pos_team, end.team.id != poss_team if turnover
pbp |> select(pos_team, pos_team_id, week, homeTeamId, )


pbp |> dplyr::filter(def_pos_team == "Kentucky")
