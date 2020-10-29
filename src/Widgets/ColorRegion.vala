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

    public class ColorRegion : Gtk.DrawingArea {

        private Gdk.RGBA region;

        public ColorRegion () {
            Object (
                margin_start: 20,
                margin_end: 20,
                width_request: 306,
                height_request: 200
            );
        }

        construct {
            region.parse ("#F00");
        }

        public override bool draw (Cairo.Context context) {
            Cairo.Pattern p1 = new Cairo.Pattern.rgb (region.red, region.green, region.blue);
            context.rectangle (0, 0, 306, 200);
            context.set_source (p1);
            context.fill ();
            
            Cairo.Pattern p2 = new Cairo.Pattern.linear (0.0, 0.0, 306.0, 0.0);
            p2.add_color_stop_rgba (1, 1, 1, 1, 0);
            p2.add_color_stop_rgba (0, 1, 1, 1, 1);
            context.rectangle (0, 0, 306, 200);
            context.set_source (p2);
            context.fill ();

            Cairo.Pattern p3 = new Cairo.Pattern.linear (0.0, 0.0, 0.0, 200.0);
            p3.add_color_stop_rgba (0, 0, 0, 0, 0);
            p3.add_color_stop_rgba (1, 0, 0, 0, 1);
            context.rectangle (0, 0, 306, 200);
            context.set_source (p3);
            context.fill ();

            return true;
        }

        public void set_region (Gdk.RGBA color) {
            region = color;
        }

    }

}
