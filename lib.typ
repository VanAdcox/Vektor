// vektor.typ
// Free-Body Diagram (FBD) Drawing Utilities for Typst
//
// # Functions
// - force(label, direction, offset): Defines a force vector with a label, direction, and optional offset.
// - axis(label, direction, offset): Defines an axis with a label, direction, and optional offset.
// - fbd(system, forces, axes, axes_offset): Draws a free-body diagram for a given system, list of forces, and axes.
//
// # Directions
// Supported directions: north, northeast, east, southeast, south, southwest, west, northwest, out, into.
#import "@preview/cetz:0.4.2"

#let _directions = (
  north: (0,1),
  northeast: (1,1),
  east: (1,0),
  southeast: (1,-1),
  south: (0,-1),
  southwest: (-1,-1),
  west: (-1,0),
  northwest: (-1,1),
  out: (0,0),
  into: (0,0),
)

#let _anchor_for_direction = (direction) => if direction == "north" or direction == "south" {"west"} else {"north"}

#let force = (label, direction, offset: (0,0)) => (
  label: label,
  direction: direction,
  offset: offset,
)

#let axis = (label, direction, offset: (0,0)) => (
  label: label,
  direction: direction,
)

    
#let fbd(system: "?", forces: (), axes: (axis("X","east"),axis("Y","north"),), axes_offset: (3,0)) = {
  block[
    #cetz.canvas({
      import cetz.draw: *
      set-style(mark: (end: ">"))

      // System Label
      content((-1,1.5), [System = #system])

      // Point Mass
      circle((0,0),radius:0.1, fill:black)

      for force in forces {
        let dir = _directions.at(force.direction)
        line((0,0),(force.offset.at(0) + dir.at(0), force.offset.at(1) + dir.at(1)), name:"X")
        content(
          ("X.start", 70%, "X.end"),
          padding: 0.1,
          anchor: _anchor_for_direction(force.direction),
          [#force.label]
        )
      }
 
      for axis in axes {
        let dir = _directions.at(axis.direction)
        if axis.direction == "out" {
          circle((axes_offset.at(0), axes_offset.at(1)), radius: 0.15, fill: white)
          circle((axes_offset.at(0), axes_offset.at(1)), radius: 0.05, fill: black)
          content(
            ((axes_offset.at(0), axes_offset.at(1) + 0.2)),
            anchor: "south",
            [#axis.label]
          )
        } else if axis.direction == "into" {
          circle((axes_offset.at(0), axes_offset.at(1)), radius: 0.15,fill:white)
          line((axes_offset.at(0) - 0.07, axes_offset.at(1) - 0.07), (axes_offset.at(0) + 0.07, axes_offset.at(1) + 0.07), mark:(end:false))
          line((axes_offset.at(0) - 0.07, axes_offset.at(1) + 0.07), (axes_offset.at(0) + 0.07, axes_offset.at(1) - 0.07), mark:(end:false))
          content(
            ((axes_offset.at(0) + 0.2, axes_offset.at(1) + 0.2)),
            anchor: "south",
            [#axis.label]
          )
        } else {
          line(axes_offset,(axes_offset.at(0) + dir.at(0),axes_offset.at(1) + dir.at(1)), name:"X")
          content(
            ("X.start", 70%, "X.end"),
            padding: 0.15,
            anchor: _anchor_for_direction(axis.direction),
            [#axis.label]
          )
        }
      }
    })
  ]
}
