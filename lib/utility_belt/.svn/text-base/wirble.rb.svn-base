require 'wirble'
Wirble.init
Wirble.colorize

module UtilityBelt
  module Themes
    def self.background(bkg)
      case bkg
      when :dark
        Wirble::Colorize.colors = UtilityBelt::Themes::WIRBLE_DEFAULT_THEME
      when :light
        Wirble::Colorize.colors = UtilityBelt::Themes::THEME_FOR_WHITE_BKG
      end
    end
    WIRBLE_DEFAULT_THEME = {
      # delimiter colors
      :comma              => :blue,
      :refers             => :blue,

      # container colors (hash and array)
      :open_hash          => :green,
      :close_hash         => :green,
      :open_array         => :green,
      :close_array        => :green,

      # object colors
      :open_object        => :light_red,
      :object_class       => :white,
      :object_addr_prefix => :blue,
      :object_line_prefix => :blue,
      :close_object       => :light_red,

      # symbol colors
      :symbol             => :yellow,
      :symbol_prefix      => :yellow,

      # string colors
      :open_string        => :red,
      :string             => :cyan,
      :close_string       => :red,

      # misc colors
      :number             => :cyan,
      :keyword            => :green,
      :class              => :light_green,
      :range              => :red,
    }
    THEME_FOR_WHITE_BKG = {
      # delimiter colors
      :comma              => :purple,
      :refers             => :blue,

      # container colors (hash and array)
      :open_hash          => :red,
      :close_hash         => :red,
      :open_array         => :red,
      :close_array        => :red,

      # object colors
      :open_object        => :dark_gray,
      :object_class       => :purple,
      :object_addr_prefix => :blue,
      :object_line_prefix => :blue,
      :close_object       => :dark_gray,

      # symbol colors
      :symbol             => :black,
      :symbol_prefix      => :light_gray,

      # string colors
      :open_string        => :blue,
      :string             => :dark_gray,
      :close_string       => :blue,

      # misc colors
      :number             => :black,
      :keyword            => :brown,
      :class              => :red,
      :range              => :blue,
    }
    COLORS = WIRBLE_DEFAULT_THEME
  end
end
