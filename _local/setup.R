#─────────────────────────────────────────────────────────────────────────
# Title: setup.r
#
# Description: Set up environment for cfb analysis
#
# Author: JY
#
# Origination date: 2026-10-06
#─────────────────────────────────────────────────────────────────────────

# Initiate targets ──────────
if (file.exists('/_targets')) {
    if (!requireNamespace("targets", quietly = TRUE)) {
        install.packages("targets")
    }

    targets::use_targets()
}

# Initiate renv
if (!requireNamespace("renv", quietly = TRUE)) {
    install.packages("renv")
}

renv::init()
