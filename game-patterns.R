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

require(targets)

tar_visnetwork(script = "_targets-get-data.R")
tar_manifest(script = "_targets-get-data.R")

tar_make(script = "_targets-get-data.R")
