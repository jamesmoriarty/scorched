module Scorched
  class Terrian < Array
    def initialize(width, height, cycles)
      super(width) do |index|
        Math.sin(index.to_f / width.to_f * cycles.to_f) * height / 4 + (height / 4).to_i
      end
    end

    def render(win, height)
      win.draw sprite(height)
    end

    def sprite(height)
      @cache ||= begin
        image = Ray::Image.new [size, height]

        Ray::ImageTarget.new(image) do |target|
          each_with_index do |y, x|
            target.draw Ray::Polygon.line([x, height], [x, height - y], 1, Ray::Color.new(204, 204, 153))
          end

          target.update
        end

        Ray::Sprite.new(image, at: [0, 0])
      end
    end

    def deform(x, radius)
      x1 = x - radius
      x2 = x + radius

      Range.new(x1.to_i, x2.to_i).to_a.each do |x_offset|
        cycle = (x_offset - x).to_f / (radius * 2).to_f + 0.5
        delta = Math.sin(Math::PI * cycle) * radius
        if x_offset >= 0 && x_offset < size
          self[x_offset] = [self[x_offset] - delta.to_i, 0].max
        end
      end

      @cache = nil
    end
  end
end