library(tidyverse)
library(here)

set.seed(123)

dir_in <- here("data", "pixelvalues")
dir.create(dir_in, recursive = TRUE, showWarnings = FALSE)

# Optional: clear old toy files before regenerating
old_files <- list.files(dir_in, pattern = "\\.csv$", full.names = TRUE)
file.remove(old_files)

ids <- paste0("id", stringr::str_pad(1:15, width = 2, pad = "0"))

period_lookup <- tibble(
  period = as.character(1:5),
  date = c("20230115", "20230302", "20230510", "20230718", "20230925")
)

simulate_roi_files <- function(name, period, date, img_id, region = "rump1",
                               n_x = 20, n_y = 20) {
  
  coords <- expand_grid(
    X = 1:n_x,
    Y = 1:n_y
  )
  
  # Individual-level variation makes the later plots look more realistic.
  id_num <- as.numeric(str_extract(name, "\\d+"))
  period_num <- as.numeric(period)
  
  individual_effect <- rnorm(1, mean = 0, sd = 0.004)
  
    period_effect <- c(
      -0.004,
      -0.001,
      0.002,
      0.001,
      0.005
    )[period_num]
    
    rg_shift <- individual_effect + period_effect +
      rnorm(1, 0, 0.0015)
  
    by_shift <- rnorm(1, mean = 0, sd = 0.003) +
      sin(period_num) * 0.001 +
      rnorm(1, 0, 0.001)
  
  channels <- tibble(
    channel = c("lw", "mw", "sw"),
    mean_value = c(
      0.040 + rg_shift,
      0.034 - rg_shift,
      0.026 + by_shift
    )
  )
  
  for (i in seq_len(nrow(channels))) {
    
    df <- coords %>%
      mutate(
        Value = pmax(
          rnorm(n(), mean = channels$mean_value[i], sd = 0.004),
          0.010
        )
      )
    
    file_name <- paste0(
      name, date, "_IMG_", img_id, "_", channels$channel[i], "_", region, ".csv"
    )
    
    write_csv(df, here("data", "pixelvalues", file_name))
  }
}

toy_metadata <- expand_grid(
  name = ids,
  period = period_lookup$period,
  img_id = c("0001", "0002")
) %>%
  left_join(period_lookup, by = "period")

pwalk(toy_metadata, simulate_roi_files)
