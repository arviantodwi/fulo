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

    public class CustomSwatches : Gtk.Box {

        public CustomSwatches () {
            Object (
                orientation: Gtk.Orientation.VERTICAL,
                spacing: 0,
                margin_start: 20,
                margin_end: 20,
                margin_bottom: 10
            );
        }

        construct {
            this.get_style_context ().add_class ("swatches-box");

            Gtk.Label label = new Gtk.Label ("Preset Colors") {
                margin_bottom = 13,
                xalign = 0.0f
            };
            label.get_style_context ().add_class ("swatches-section-label");

            Gtk.Grid grid = new Gtk.Grid () {
                row_spacing = 10,
                column_spacing = 10,
                orientation = Gtk.Orientation.HORIZONTAL,
                margin_bottom = 20
            };

            Gtk.Button button = new Gtk.Button.with_label (_("Add custom color"));

            int col = 0;
            int row = 0;
            const int MAX_ROWS = 2;
            while (row >= 0 && col >= 0) {
                if (col % 6 == 0 && col > 6 - 1) {
                    row += 1;
                    if (row > MAX_ROWS - 1) {
                        break;
                    }
                    col = 0;
                }

                int index = col + (row * 6);
                ColorSwatch swatch = new ColorSwatch ();
                grid.attach (swatch, col, row, 1, 1);
                col += 1;
            }

            this.pack_start (label, false, true, 0);
            this.pack_start (grid, false, true, 0);
            this.pack_end (button, false, true, 0);
        }

    }

}
