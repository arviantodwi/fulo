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

    public class OpacityRange : Gtk.Scale {

        public OpacityRange () {
            Object ();
        }

        construct {
            this.orientation = Gtk.Orientation.HORIZONTAL;
            this.adjustment = new Gtk.Adjustment (1, 0, 1, 0.01, 100, 0);
            this.width_request = 193;
            this.draw_value = false;
            this.digits = 2;
            this.has_origin = false;

            this.get_style_context ().add_class ("opacity");
        }

    }

}
