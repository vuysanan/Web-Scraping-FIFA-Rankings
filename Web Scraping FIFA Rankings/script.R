library(rvest)
library(ggplot2)

wiki_url <- "https://en.wikipedia.org/wiki/FIFA_Men%27s_World_Ranking"

webpage <- read_html(wiki_url)

fifa_rankings <- webpage %>% 
  html_node(".wikitable") %>% 
  html_table()

rankings_df <- fifa_rankings[4:23, c(1, 3, 4)]

names(rankings_df) <- c("Rank", "Team", "Points")

rankings_df

rankings_df$Rank <- as.numeric(rankings_df$Rank)
rankings_df$Points <- as.numeric(rankings_df$Points)

ggplot(rankings_df, aes(x = reorder(Team, Points), y = Points, fill = Rank)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "FIFA Men's World Rankings",
    x = "Team",
    y = "Points"
  ) +
  theme_minimal()

write.csv(rankings_df, "fifa_rankings.csv", row.names = FALSE)
