/**
 * Copyright (c) 2020 Arvianto Dwi Wicaksono (https://github.com/arviantodwi)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public
 * License along with this program; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA
 *
 * Authored by: Arvianto Dwi Wicaksono <arvianto.dwi@gmail.com>
 */

using Granite.Drawing;

namespace Fulo.Widgets {

    public class ColorSwatch : Gtk.Button {

        public string color { get; construct; }

        public signal void color_clicked (Gdk.RGBA color);

        private const string CSS_SWATCH = """
            .swatch {
                background-color: %s;
                border-radius: 3px;
                box-shadow: inset 0 0 0 1px %s;
            }
            .swatch.custom-swatch {
                border: dashed 1px #CDCDCD;
                box-shadow: none;
            }
            .swatch.custom-swatch.custom-has-color {}
        """;

        private Gtk.StyleContext swatch_item_style_context;

        public ColorSwatch (string? color = null) {
            Object (
                color: color,
                width_request: 24,
                height_request: 24
            );
        }

        construct {
            swatch_item_style_context = get_style_context ();
            swatch_item_style_context.add_class (Gtk.STYLE_CLASS_FLAT);
            swatch_item_style_context.add_class ("swatch");
            if (color == null) {
                swatch_item_style_context.add_class ("custom-swatch");
                color = "#FCFCFC";
            }

            Gdk.RGBA color_rgba = Gdk.RGBA ();
            color_rgba.parse ((string)color);

            Color contrast_rgba = new Color.from_rgba (
                Granite.contrasting_foreground_color (color_rgba)
            );
            contrast_rgba.set_alpha(0.08);
            
            string css = CSS_SWATCH.printf (
                color_rgba.to_string (),
                contrast_rgba.to_string()
            );
            
            Gtk.CssProvider provider = new Gtk.CssProvider ();
            try {
                provider.load_from_data (css, css.length);
                swatch_item_style_context.add_provider (
                    provider,
                    Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
                );
            } catch (GLib.Error e) {
                critical (e.message);
                return;
            }

            clicked.connect (() => {
                color_clicked (color_rgba);

                //  TODO: Remove commented logic below before production release
                //  print("======================");
                //  print("%s clicked!\n", new Color.from_string ((string)color).to_string ());
                //  print("R: %1.4f\n", color_rgba.red);
                //  print("G: %1.4f\n", color_rgba.green);
                //  print("B: %1.4f\n", color_rgba.blue);
                //  unowned double r = color_rgba.red;
                //  unowned double g = color_rgba.green;
                //  unowned double b = color_rgba.blue;

                //  //  rgb to hsv
                //  double x_max = GLib.Math.fmax (r, GLib.Math.fmax (g, b));
                //  double x_min = GLib.Math.fmin (r, GLib.Math.fmin (g, b));
                //  double chroma = x_max - x_min;
                //  double lightness = (x_max + x_min) / 2;
                //  print ("Max: %1.4f, Min: %1.4f, Chroma: %1.4f, Lightness: %1.4f\n", x_max, x_min, chroma, lightness);
                
                //  double hue;
                //  if (chroma == 0) {
                //      hue = 0;
                //  } else if (x_max == r) {
                //      hue = 60 * (0 + ((g - b) / chroma));
                //  } else if (x_max == g) {
                //      hue = 60 * (2 + ((b - r) / chroma));
                //  } else if (x_max == b) {
                //      hue = 60 * (4 + ((r - g) / chroma));
                //  }
                //  if (hue < 0) {
                //      hue = 360 + hue;
                //  }

                //  double sv = 0;
                //  if (x_max != 0) {
                //      sv = chroma / x_max;
                //  }
                //  print ("H: %1.4f, Sv: %1.4f\n", hue, sv);

                //  //  hsv to rgb
                //  double chroma_rgb = x_max * sv;
                //  double hue_rgb = hue / 60;
                //  double intermediate_x = chroma_rgb * (1 - GLib.Math.fabs(hue_rgb % 2 - 1));
                //  //  if (intermediate_x < 0) {
                //  //      intermediate_x *= -1;
                //  //  }
                //  string rgb = "";
                //  print ("Hue RGB: %1.4f, Intermediate X: %1.4f, Chroma RGB: %1.4f\n", hue_rgb, intermediate_x, chroma_rgb);

                //  double m = x_max - chroma_rgb;
                //  print ("M: %1.4f\n", m);
                //  double new_r = 0;
                //  double new_g = 0;
                //  double new_b = 0;
                //  if (0 <= hue_rgb && hue_rgb <= 1) {
                //      new_r = chroma_rgb + m;
                //      new_g = intermediate_x + m;
                //      new_b = m;
                //  } else if (1 < hue_rgb && hue_rgb <= 2) {
                //      new_r = intermediate_x + m;
                //      new_g = chroma_rgb + m;
                //      new_b = m;
                //  } else if (2 < hue_rgb && hue_rgb <= 3) {
                //      new_r = m;
                //      new_g = chroma_rgb + m;
                //      new_b = intermediate_x + m;
                //  } else if (3 < hue_rgb && hue_rgb <= 4) {
                //      new_r = m;
                //      new_g = intermediate_x + m;
                //      new_b = chroma_rgb + m;
                //  } else if (4 < hue_rgb && hue_rgb <= 5) {
                //      new_r = intermediate_x + m;
                //      new_g = m;
                //      new_b = chroma_rgb + m;
                //  } else if (5 < hue_rgb && hue_rgb <= 6) {
                //      new_r = chroma_rgb + m;
                //      new_g = m;
                //      new_b = intermediate_x + m;
                //  }
                //  print ("New R: %1.4f, New G: %1.4f, New B: %1.4f\n\n", new_r, new_g, new_b);
            });
        }
    }

}
