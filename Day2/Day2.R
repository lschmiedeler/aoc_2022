library(tidyverse)

rounds <- read.csv("Day2Input.txt", header = F, sep = " ")
names(rounds) <- c("opponent", "result")

score <- function(opponent, you) {
  sum(data.frame(opponent = opponent, you = you) %>% 
    mutate(score_1 = case_when(you == "X" ~ 1, you == "Y" ~ 2, you == "Z" ~ 3)) %>%
    mutate(score_2 = case_when(
      (opponent == "A" & you == "Z") | (opponent == "B" & you == "X") | (opponent == "C" & you == "Y") ~ 0,
      (opponent == "A" & you == "X") | (opponent == "B" & you == "Y") | (opponent == "C" & you == "Z") ~ 3,
      TRUE ~ 6)) %>%
    mutate(score = score_1 + score_2) %>% select(score))
}

rounds <- rounds %>%
  mutate(you = case_when(result == "X" & opponent == "A" ~ "Z", result == "X" & opponent == "B" ~ "X",
                         result == "X" & opponent == "C" ~ "Y", result == "Y" & opponent == "A" ~ "X",
                         result == "Y" & opponent == "B" ~ "Y", result == "Y" & opponent == "C" ~ "Z",
                         result == "Z" & opponent == "A" ~ "Y", result == "Z" & opponent == "B" ~ "Z",
                         result == "Z" & opponent == "C" ~ "X"))

# puzzle answers
print(paste0("puzzle 1 answer = ", score(rounds$opponent, rounds$result)))
print(paste0("puzzle 2 answer = ", score(rounds$opponent, rounds$you)))
