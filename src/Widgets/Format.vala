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

    public class Format : Gtk.Box {

        private Gtk.Entry entry;
        private Gtk.ComboBoxText combo;

        public Format.as_rgb (string color_string) {
            entry.set_text (color_string);
            combo.set_active_id ("rgb");
        }

        public Format.as_rgba (string color_string) {
            entry.set_text (color_string);
            combo.set_active_id ("rgba");
        }

        public Format.as_hsv (string color_string) {
            entry.set_text (color_string);
            combo.set_active_id ("hsv");
        }
        
        construct {
            this.margin_start = 20;
            this.margin_end = 20;
            this.margin_top = 16;
            this.margin_bottom = 20;
            this.orientation = Gtk.Orientation.HORIZONTAL;
            this.spacing = 10;

            entry = new Gtk.Entry ();
            entry.editable = false;
            entry.secondary_icon_name = "edit-copy";

            combo = new Gtk.ComboBoxText ();
            foreach (unowned Enums.Format format in Enums.Format.all ()) {
                combo.append (
                    format.to_nick (),
                    Enums.Format.get_real_format_name (format.to_string ())
                );
            }

            this.pack_start (entry, true);
            this.pack_end (combo, true);

            combo.changed.connect (() => {
                print ("Active ID: %s\n", combo.get_active_id ().to_string ());
            });
        }

        public void reformat (Gdk.RGBA active_color, double active_hue) {
            if (combo.active_id != "rgba" && active_color.alpha < 1) {
                combo.set_active_id ("rgba");
            }

            if (combo.active_id == "rgba") {
                if (active_color.alpha < 1) {
                    entry.set_text (active_color.to_string ().up ());
                } else {
                    int r = (int) GLib.Math.round (active_color.red * 255);
                    int g = (int) GLib.Math.round (active_color.green * 255);
                    int b = (int) GLib.Math.round (active_color.blue * 255);
                    entry.set_text (@"RGBA($r,$g,$b,$(active_color.alpha))");
                }
            } else if (combo.active_id == "rgb") {
                entry.set_text (active_color.to_string ().up ());
            } else if (combo.active_id == "hsv") {
                int rh, rs, rv;
                double h, s, v;
                Gtk.rgb_to_hsv (active_color.red, active_color.green, active_color.blue, out h, out s, out v);
                if (h == 0) {
                    h = active_hue;
                }

                rh = (int) (h * 360);
                rs = (int) (s * 100);
                rv = (int) (v * 100);
                entry.set_text (@"HSV($rh,$rs%,$rv%)");
            }
        }

    }

}
