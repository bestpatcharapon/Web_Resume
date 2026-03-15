# frozen_string_literal: true

module IconHelper
  DEFAULT_SIZE = 24
  DEFAULT_STROKE_WIDTH = 2

  def icon(name, options = {})
    size = options.fetch(:size, DEFAULT_SIZE)
    css_class = options.fetch(:class, "")
    color = options.fetch(:color, "currentColor")
    stroke_width = options.fetch(:stroke_width, DEFAULT_STROKE_WIDTH)

    svg_options = {
      xmlns: "http://www.w3.org/2000/svg",
      width: size,
      height: size,
      viewBox: "0 0 24 24",
      fill: "none",
      stroke: color,
      "stroke-width": stroke_width,
      "stroke-linecap": "round",
      "stroke-linejoin": "round",
      class: css_class
    }

    content_tag(:svg, svg_options) do
      icon_path(name)
    end
  end

  def icon_filled(name, options = {})
    size = options.fetch(:size, DEFAULT_SIZE)
    css_class = options.fetch(:class, "")
    color = options.fetch(:color, "currentColor")

    svg_options = {
      width: size,
      height: size,
      fill: color,
      viewBox: "0 0 24 24",
      class: css_class
    }

    content_tag(:svg, svg_options) do
      icon_filled_path(name)
    end
  end

  private

  def icon_path(name)
    paths = case name.to_sym
    when :user
      [
        tag.path(d: "M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"),
        tag.circle(cx: "12", cy: "7", r: "4")
      ]
    when :code
      [
        tag.path(d: "m18 16 4-4-4-4"),
        tag.path(d: "m6 8-4 4 4 4"),
        tag.path(d: "m14.5 4-5 16")
      ]
    when :briefcase
      [
        tag.path(d: "M16 20V4a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"),
        tag.rect(width: "20", height: "14", x: "2", y: "6", rx: "2")
      ]
    when :location
      [
        tag.path(d: "M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0"),
        tag.circle(cx: "12", cy: "10", r: "3")
      ]
    when :email
      [
        tag.rect(width: "20", height: "16", x: "2", y: "4", rx: "2"),
        tag.path(d: "m22 7-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 7")
      ]
    when :cake
      [
        tag.path(d: "M20 21v-8a2 2 0 0 0-2-2H6a2 2 0 0 0-2 2v8"),
        tag.path(d: "M4 16s.5-1 2-1 2.5 2 4 2 2.5-2 4-2 2.5 2 4 2 2-1 2-1"),
        tag.path(d: "M2 21h20"),
        tag.path(d: "M7 8v3"),
        tag.path(d: "M12 8v3"),
        tag.path(d: "M17 8v3")
      ]
    when :graduation
      [
        tag.path(d: "M22 10v6M2 10l10-5 10 5-10 5z"),
        tag.path(d: "M6 12v5c3 3 9 3 12 0v-5")
      ]
    when :sparkle
      [
        tag.path(d: "M9.937 15.5A2 2 0 0 0 8.5 14.063l-6.135-1.582a.5.5 0 0 1 0-.962L8.5 9.936A2 2 0 0 0 9.937 8.5l1.582-6.135a.5.5 0 0 1 .963 0L14.063 8.5A2 2 0 0 0 15.5 9.937l6.135 1.581a.5.5 0 0 1 0 .964L15.5 14.063a2 2 0 0 0-1.437 1.437l-1.582 6.135a.5.5 0 0 1-.963 0z")
      ]
    when :heart
      [
        tag.path(d: "M19 14c1.49-1.46 3-3.21 3-5.5A5.5 5.5 0 0 0 16.5 3c-1.76 0-3 .5-4.5 2-1.5-1.5-2.74-2-4.5-2A5.5 5.5 0 0 0 2 8.5c0 2.3 1.5 4.05 3 5.5l7 7Z")
      ]
    when :download
      [
        tag.path(d: "M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"),
        tag.polyline(points: "7 10 12 15 17 10"),
        tag.line(x1: "12", x2: "12", y1: "15", y2: "3")
      ]
    when :search
      [
        tag.circle(cx: "11", cy: "11", r: "8"),
        tag.path(d: "m21 21-4.3-4.3")
      ]
    when :terminal
      [
        tag.polyline(points: "4 17 10 11 4 5"),
        tag.line(x1: "12", x2: "20", y1: "19", y2: "19")
      ]
    when :database
      [
        tag.ellipse(cx: "12", cy: "5", rx: "9", ry: "3"),
        tag.path(d: "M3 5V19A9 3 0 0 0 21 19V5"),
        tag.path(d: "M3 12A9 3 0 0 0 21 12")
      ]
    when :server
      [
        tag.rect(width: "20", height: "8", x: "2", y: "2", rx: "2", ry: "2"),
        tag.rect(width: "20", height: "8", x: "2", y: "14", rx: "2", ry: "2"),
        tag.line(x1: "6", x2: "6.01", y1: "6", y2: "6"),
        tag.line(x1: "6", x2: "6.01", y1: "18", y2: "18")
      ]
    when :check_circle
      [
        tag.path(d: "M22 11.08V12a10 10 0 1 1-5.93-9.14"),
        tag.polyline(points: "22 4 12 14.01 9 11.01")
      ]
    when :folder
      [
        tag.path(d: "M20 20a2 2 0 0 0 2-2V8a2 2 0 0 0-2-2h-7.9a2 2 0 0 1-1.69-.9L9.6 3.9A2 2 0 0 0 7.93 3H4a2 2 0 0 0-2 2v13a2 2 0 0 0 2 2Z")
      ]
    when :external_link
      [
        tag.path(d: "M15 3h6v6"),
        tag.path(d: "M10 14 21 3"),
        tag.path(d: "M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6")
      ]
    else
      []
    end

    safe_join(paths)
  end

  def icon_filled_path(name)
    case name.to_sym
    when :github
      tag.path(d: "M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z")
    when :linkedin
      tag.path(d: "M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z")
    else
      ""
    end
  end
end
