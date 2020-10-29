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

    public class ColorName : Gtk.Box {

        private Gtk.Label _color_name;

        public ColorName () {
            Object (
                orientation: Gtk.Orientation.VERTICAL,
                spacing: 0,
                margin_start: 10
            );
        }

        construct {
            Gtk.Label title = new Gtk.Label ("Color name:");
            title.get_style_context ().add_class ("color-name-title");

            _color_name = new Gtk.Label (null) {
                xalign = 0.0f
            };

            this.pack_start (title, false, true, 0);
            this.pack_end (_color_name, false, true, 0);
        }

        public void set_color_name (string name) {
            _color_name.label = name;
        }

    }

}