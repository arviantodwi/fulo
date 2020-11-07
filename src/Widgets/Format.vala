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

        public Format () {
            this.margin_start = 20;
            this.margin_end = 20;
            this.margin_bottom = 20;
        }

        construct {
            this.orientation = Gtk.Orientation.HORIZONTAL;
            this.spacing = 0;

            Gtk.Entry entry = new Gtk.Entry () {
                editable = false,
                secondary_icon_name = "edit-copy"
            };
            Gtk.ComboBoxText combo = new Gtk.ComboBoxText () {
                margin_start = 10
            };
            foreach (unowned Enums.Format format in Enums.Format.all ()) {
                combo.append_text (
                    Enums.Format.get_real_format_name (format.to_string ())
                );
            }
            combo.set_active (0);

            this.pack_start (entry, true, true, 0);
            this.pack_end (combo, true, true, 0);
        }

    }

}
