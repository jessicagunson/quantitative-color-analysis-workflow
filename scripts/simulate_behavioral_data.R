library(tidyverse)
library(here)

set.seed(456)

dir.create(here("data"), recursive = TRUE, showWarnings = FALSE)

ids <- paste0("id", stringr::str_pad(1:15, width = 2, pad = "0"))

behavior_data <- expand_grid(
  id = ids,
  period = as.character(1:5)
) %>%
  group_by(period) %>%
  mutate(
    ranking = rank(as.numeric(str_extract(id, "\\d+")), ties.method = "first"),
    group = if_else(as.numeric(str_extract(id, "\\d+")) <= 8, "A", "B"),
    time_observed = round(runif(n(), min = 8, max = 25), 2),
    rank_prop = (max(ranking) - ranking) / (max(ranking) - 1)
  ) %>%
  ungroup() %>%
  mutate(
    dominance_rank_z = as.numeric(scale(rank_prop)),
    period_num = as.numeric(period),
    
    # Simulated behavioral outcomes with rank and period structure.
    aggression_count = rpois(
      n(),
      lambda = exp(0.4 + 0.7 * dominance_rank_z + 0.05 * period_num)
    ),
    submission_count = rpois(
      n(),
      lambda = exp(0.5 - 0.7 * dominance_rank_z + 0.03 * period_num)
    ),
    affiliation_count = rpois(
      n(),
      lambda = exp(0.6 + 0.2 * dominance_rank_z)
    ),
    reproductive_behavior_count = rpois(
      n(),
      lambda = exp(0.3 + 0.8 * dominance_rank_z + 0.05 * period_num)
    )
  ) %>%
  select(
    id, period, group, time_observed, ranking, rank_prop,
    dominance_rank_z,
    aggression_count, submission_count,
    affiliation_count,
    reproductive_behavior_count
  )

write_csv(
  behavior_data,
  here("data", "behavior_data.csv")
)

behavior_data