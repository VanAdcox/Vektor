#import "@local/Vektor:0.1.0":*

#fbd(
  system: "Block",
  forces: (
    force($W_(E b)$, "south", offset:(.1,0)),
    force($W_(E b)$, "south", offset:(-.1,0), offset:"east"),
    force($N_(E b)$, "north"),
  ),
)
