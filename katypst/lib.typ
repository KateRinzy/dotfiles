#import "source/clues.typ"
#import "source/meth.typ"
#import "source/config.typ"
#import "source/theorems.typ"

#let em = $dash.em$

#let fonts = (
  serif: ("Noto Serif", "Noto Serif CJK JP"),
  sans: ("Noto Sans", "Noto Sans CJK JP"),
  mono: "Courier Prime Code",
  computer: "New Computer Modern",
  zenmaru: "Zen Maru Gothic",
  raleway: "Raleway",
)

#let present(
  top_content,
  middle_content,
  bottom_content,
  show_outline: true,
  do_pagebreak: true,
  makeconf: true,
) = {
  align(center, {
    align(top, top_content)
    align(horizon, middle_content)
    align(bottom, bottom_content)
  })
  if show_outline {
    pagebreak()
    outline()
  }
  if do_pagebreak {
    pagebreak()
  }
}



#let tens(value, exponent) = {
  $
    value times 10^(exponent)
  $
}
