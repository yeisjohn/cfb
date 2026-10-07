#─────────────────────────────────────────────────────────────────────────
# Title:
#
# Description: Modeling college football game patterns using play-by-play
# data and XXXXX modeling.
#
# Author: J. Yeiser
#
# Origination date: 2026-10-06
#─────────────────────────────────────────────────────────────────────────
renv::status()

# Update data pipeline ──────────
require(targets)
require(tidyverse)

tar_visnetwork(script = "_targets-get-data.R")
tar_manifest(script = "_targets-get-data.R")

tar_make(script = "_targets-get-data.R")
tar_prune(script = "_targets-get-data.R")

# Load play by play data ──────────
tar_load_everything()

str(pbprecent)

colnames(pbprecent)[grepl('season', colnames(pbprecent))]

# get game patterns ──────────

#─── metadata ──────────
# season
# seasonType            2 = regular season, 3 = postseason
# gameid
# pos_team_id:          espn id of team with ball
# def_pos_team_id:      espn id of team without ball
# drive.id:             unique id of each drive (goes across games I think)
# new_series:           boolean - is it a new drive?

#─── context ──────────
# half
# period
# down
# distance

#─── play types ──────────
# orig_play_type:       play description (with result, e.g., Pass Reception)
# type.text             same as orig_play_type?
# rush
# pass_attempt          pass attempts, includes sacks

#─── play result ──────────
# offense_score_play    boolean
# defense_score_play    boolean
# pass_direction        boolean
unique(pbprecent$type.text)
# ...others...
# offense_score_play
# defense_score_play
# change_of_poss
# end.pos_team.id:      pos. team at end of play
# end.def_pos_team.id:  def pos team at end of play

# !!! do not use ──────────
# type.abbreviation  RUSH,PASS, etc. No kickoffs, eg.
# change_of_pos_team?
# rush_direction (too many NAs)
# pass_depth (too many NAs)
# rush_direction (too many NAs)

pattern_data <- pbprecent |>
    select(
        # metadata
        season,
        seasonType,
        game_id,
        pos_team_id,
        def_pos_team_id,
        drive.id,
        new_series,
        # context
        half,
        period,
        down,
        distance,
        # play types
        orig_play_type,
        type.text,
        rush,
        pass_attempt,
        # play result
        end.pos_team.id,
        end.def_pos_team.id,
        offense_score_play,
        defense_score_play,
        change_of_poss
    )

pattern_data |> select(rush, season, seasonType, type.text)
# Notes ──────────

#─── pass attempts more comprehensive than pass b/c it denote sacks as well ──────────
# all(pattern_data$pass == pattern_data$pass_attempt)
# pattern_data |> filter(pass != pass_attempt) |> select(pass,pass_attempt, type.text)

#─── lot of NAs in pass_depth, pass_direction ──────────
# # only non-NA when turnover? No...but obviously not complete info...
# tmp <- pattern_data |> filter(!is.na(pass_depth) & type.text == 'Pass Completion') |> select(pass_attempt,pass_direction,pass_depth,type.text)
# tmp
# unique(tmp$type.text)

# tmp <- pattern_data |> filter(!is.na(pass_direction)) |> select(pass_attempt,pass_direction,pass_depth,type.text)
# tmp
