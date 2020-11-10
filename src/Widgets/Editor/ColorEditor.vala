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

namespace Fulo.Widgets.Editor {

    class ColorEditor : Gtk.Grid {

        //  Properties
        public Gdk.RGBA active_color;
        private Chooser chooser;
        private HueSlider hue_slider;
        private AlphaSlider alpha_slider;
        private Contrast contrast;

        //  Signals
        public signal void on_active_color_change (Gdk.RGBA new_color, double current_hue);

        construct {
            //  Initialize parent's properties
            this.margin_start = 20;
            this.margin_end = 20;
            this.column_spacing = 10;
            this.row_spacing = 7;
            
            //  Set active color
            active_color.parse ("#FF0000");
            
            //  initialize UI instances
            chooser = new Chooser (active_color);
            hue_slider = new HueSlider (360);
            alpha_slider = new AlphaSlider ();
            contrast = new Contrast (active_color);

            this.attach (chooser, 0, 0, 2, 1);
            this.attach_next_to (hue_slider, chooser, Gtk.PositionType.BOTTOM, 1, 1);
            this.attach_next_to (alpha_slider, hue_slider, Gtk.PositionType.BOTTOM, 1, 1);
            this.attach_next_to (contrast, hue_slider, Gtk.PositionType.RIGHT, 1, 2);

            chooser.on_sv_move.connect ((s, v) => {
                double hue = hue_slider.get_value () / 360;
                Gtk.HSV.to_rgb (hue, s, v, out active_color.red, out active_color.green, out active_color.blue);
                contrast.set_foreground (active_color);
                on_active_color_change (active_color, hue);
            });

            alpha_slider.on_value_changed.connect ((alpha) => {
                double hue = hue_slider.get_value () / 360;
                string formatted_alpha = "%1.2f".printf (alpha);
                active_color.alpha = double.parse (formatted_alpha);
                contrast.set_foreground_alpha (alpha);
                on_active_color_change (active_color, hue);
            });

            hue_slider.on_value_changed.connect ((hue) => {
                double s, v;
                double sr, sg, sb;
                double r, g, b;
                chooser.pos_to_sv (out s, out v);
                Gtk.HSV.to_rgb (hue, 1, 1, out sr, out sg, out sb);
                Gtk.HSV.to_rgb (hue, s, v, out r, out g, out b);

                active_color.red = r;
                active_color.green = g;
                active_color.blue = b;
                chooser.update_surface_color (sr, sg, sb);
                contrast.set_foreground (active_color);
                on_active_color_change (active_color, hue);
            });
        }

    }

}
