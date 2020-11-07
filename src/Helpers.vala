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

namespace Fulo {

    public class Helpers : Object {

        public static Gdk.RGBA[] get_preset_colors () {
            string[] preset_colors = {
                "#000000", "#5F5F5F", "#9A9A9A", "#CBCBCB", "#E1E1E1", "#F8F8F8",
                "#FF0D0D", "#FF8A1D", "#2AA677", "#006EF8", "#7F26FF", "#F8209C",
                "#FF5F5F", "#FFB46E", "#50D29F", "#4B9BFF", "#AF78FF", "#F470BB",
                "#FFB1B1", "#FFDEC0", "#91E2C3", "#9DC8FF", "#DFCAFF", "#F7BEDF",
                "#FFD9D9", "#FFF3E8", "#B1EBD5", "#C4DFFF", "#F8F2FF", "#FCEAF3"
            };

            Gdk.RGBA[] colors = new Gdk.RGBA[preset_colors.length];
            for (var i = 0; i < preset_colors.length; i += 1) {
                colors[i].parse (preset_colors[i]);
            }

            return colors;
        }

        public static double get_hue (Gdk.RGBA color) {
            double r = color.red;
            double g = color.green;
            double b = color.blue;
            double x_max = GLib.Math.fmax (r, GLib.Math.fmax (g, b));
            double x_min = GLib.Math.fmin (r, GLib.Math.fmin (g, b));
            double chroma = x_max - x_min;
            double hue = 0;

            if (chroma == 0) {
                hue = 0;
            } else if (x_max == r) {
                hue = 60 * (0 + ((g - b) / chroma));
            } else if (x_max == g) {
                hue = 60 * (2 + ((b - r) / chroma));
            } else if (x_max == b) {
                hue = 60 * (4 + ((r - g) / chroma));
            }
            if (hue < 0) {
                hue = 360 + hue;
            }

            return hue;
        }

        public static string rgb_to_hex (double red, double green, double blue) {
            string r_hex = "%02x".printf ((uint) (red * 255));
            string g_hex = "%02x".printf ((uint) (green * 255));
            string b_hex = "%02x".printf ((uint) (blue * 255));

            return @"#$r_hex$g_hex$b_hex".up ();
        }

        public static Gdk.RGBA hsv_to_rgb (double h, double s, double v) {
            double chroma = v * s;
            double hue = h / 60;
            double intermediate_x = chroma * (1 - GLib.Math.fabs(hue % 2 - 1));
            Gdk.RGBA rgb = Gdk.RGBA ();
            //  print ("Hue RGB: %1.4f, Intermediate X: %1.4f, Chroma RGB: %1.4f\n", hue, intermediate_x, chroma);

            double m = v - chroma;
            //  print ("M: %1.4f\n", m);
            double new_r = 0;
            double new_g = 0;
            double new_b = 0;
            if (0 <= hue && hue <= 1) {
                new_r = chroma + m;
                new_g = intermediate_x + m;
                new_b = m;
            } else if (1 < hue && hue <= 2) {
                new_r = intermediate_x + m;
                new_g = chroma + m;
                new_b = m;
            } else if (2 < hue && hue <= 3) {
                new_r = m;
                new_g = chroma + m;
                new_b = intermediate_x + m;
            } else if (3 < hue && hue <= 4) {
                new_r = m;
                new_g = intermediate_x + m;
                new_b = chroma + m;
            } else if (4 < hue && hue <= 5) {
                new_r = intermediate_x + m;
                new_g = m;
                new_b = chroma + m;
            } else if (5 < hue && hue <= 6) {
                new_r = chroma + m;
                new_g = m;
                new_b = intermediate_x + m;
            }

            rgb.parse (@"rgb($(new_r * 255), $(new_g * 255), $(new_b * 255))");
            //  print ("R: %1.4f, G: %1.4f, B: %1.4f\n", new_r, new_g, new_b);

            return rgb;
        }

    }

}
