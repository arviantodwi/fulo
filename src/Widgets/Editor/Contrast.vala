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

    public class Contrast : Gtk.Box {

        //  Properties
        private static double r;
        private static double g;
        private static double b;
        private static double a;
        private const uint8 BOX_WIDTH = 47;
        private Gtk.DrawingArea blackbox;
        private Gtk.DrawingArea whitebox;

        public Contrast (Gdk.RGBA active_color) {
            r = active_color.red;
            g = active_color.green;
            b = active_color.blue;
            a = active_color.alpha;
        }

        construct {
            //  Initialize parent's properties
            this.orientation = Gtk.Orientation.HORIZONTAL;
            this.spacing = 6;
            this.valign = Gtk.Align.CENTER;

            blackbox = new Gtk.DrawingArea ();
            blackbox.set_size_request (BOX_WIDTH, BOX_WIDTH);
            blackbox.draw.connect ((context) => {
                draw_contrast_box (context, "dark");
            });
            
            whitebox = new Gtk.DrawingArea ();
            whitebox.set_size_request (BOX_WIDTH, BOX_WIDTH);            
            whitebox.draw.connect ((context) => {
                draw_contrast_box (context, "light");
            });
            
            this.pack_start (blackbox, false);
            this.pack_end (whitebox, false);
        }

        private static bool draw_contrast_box (Cairo.Context context, string contrast_type) {
            char c = (contrast_type == "dark") ? 0 : 1;

            context.set_source_rgb (c, c, c);
            context.paint ();

            context.set_source_rgba (r, g, b, a);
            context.paint ();

            context.rectangle (33, 33, 10, 10);
            context.set_source_rgb (c, c, c);
            context.fill ();

            return false;
        }

        public void set_foreground (Gdk.RGBA active_color) {
            r = active_color.red;
            g = active_color.green;
            b = active_color.blue;
            a = active_color.alpha;

            blackbox.queue_draw ();
            whitebox.queue_draw ();
        }

        public void set_foreground_alpha (double alpha) {
            a = alpha;
            blackbox.queue_draw ();
            whitebox.queue_draw ();
        }

    }

}
