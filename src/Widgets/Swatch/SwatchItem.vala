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

namespace Fulo.Widgets {

    public class SwatchItem : Gtk.Button {

        //  Properties
        //  TODO: Remove if unused
        //  public bool has_registered_color { get; private set; default = false; }
        public Gdk.RGBA? color;

        //  Signals
        public signal void color_clicked (Gdk.RGBA color);

        //  UI
        private weak Gtk.StyleContext style_ctx;
        private Gtk.CssProvider provider;

        construct {
            this.width_request = 24;
            this.height_request = 24;
            this.sensitive = false;

            style_ctx = this.get_style_context ();
            style_ctx.add_class (Gtk.STYLE_CLASS_FLAT);
            style_ctx.add_class ("swatch");
            style_ctx.add_class ("custom");
            style_ctx.add_class ("empty");

            provider = new Gtk.CssProvider ();

            this.clicked.connect (() => {
                if (color == null) {
                    return;
                }

                color_clicked (color);
            });
        }
        
        public SwatchItem () {
            //  
        }

        public void set_color (Gdk.RGBA color_arg) {
            color = color_arg;
            
            weak Gdk.RGBA inverted_color = Granite.contrasting_foreground_color (color);
            inverted_color.alpha = 0.08;
            
            string css = ".swatch { background-color: %s; box-shadow: inset 0 0 0 1px %s; }".printf (
                color.to_string (), inverted_color.to_string()
            );
            try {
                provider.load_from_data (css, css.length);
                style_ctx.add_provider (provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
            } catch (GLib.Error e) {
                critical (e.message);
                return;
            }

            this.sensitive = true;
            style_ctx.remove_class ("custom");
            style_ctx.remove_class ("empty");
        }

    }

}

//  TODO: Remove commented logic below before production release
//  print("======================");
//  print("%s clicked!\n", color_rgba.to_string ());
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
