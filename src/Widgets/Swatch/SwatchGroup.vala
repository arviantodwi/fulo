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

    class SwatchGroup : Gtk.Box {

        //  Properties
        private uint8 row_size;

        //  Signals
        public signal void color_clicked (Gdk.RGBA color);

        //  UI
        private Gtk.Label label;
        private Gtk.Grid grid;
        private SwatchItem[] swatches;

        construct {
            this.orientation = Gtk.Orientation.VERTICAL;
            this.spacing = 0;
            this.margin_start = 20;
            this.margin_end = 20;
            this.margin_top = 10;

            label = new Gtk.Label (null);
            label.margin_bottom = 13;
            label.xalign = 0.0f;
            label.get_style_context ().add_class ("swatch-group-label");

            grid = new Gtk.Grid ();
            grid.row_spacing = 10;
            grid.column_spacing = 10;
            grid.orientation = Gtk.Orientation.HORIZONTAL;
        }

        public SwatchGroup (string group_label, uint8 row_size_arg = 2) {
            row_size = row_size_arg;
            label.label = group_label;
            
            init_swatch_items ();

            this.pack_start (label, false);
            this.pack_end (grid, false);
        }

        public SwatchGroup.make_preset (Gdk.RGBA[] colors, string group_label, uint8 row_size_arg) {
            this (group_label, row_size_arg);
            assign_preset_colors (colors);
        }

        private void init_swatch_items () {
            uint8 col = 0;
            uint8 row = 0;
            while (row >= 0 && col >= 0) {
                if (col == 6) {
                    if (row + 1 == row_size) {
                        break;
                    }
                    col = 0;
                    row += 1;
                }

                uint8 i = col + (row * 6);
                swatches += new SwatchItem ();
                swatches[i].color_clicked.connect ((color) => {
                    color_clicked (color);
                });

                grid.attach (swatches[i], col, row, 1, 1);
                col += 1;
            }
        }

        private void assign_preset_colors (Gdk.RGBA[] colors) {
            uint8 i = 0;
            foreach (var c in colors) {
                swatches[i].set_color (c);
                i += 1;
            }
        }

    }

}
