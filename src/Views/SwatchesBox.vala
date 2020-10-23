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

using Fulo.Enums;
using Fulo.Widgets;

namespace Fulo.Views {

    public class SwatchesBox : Gtk.Box {

        Gtk.Grid preset_colors_grid = new Gtk.Grid () {
            row_spacing = 10,
            column_spacing = 10,
            orientation = Gtk.Orientation.HORIZONTAL
        };
        Gtk.Grid custom_colors_grid = new Gtk.Grid () {
            row_spacing = 10,
            column_spacing = 10,
            orientation = Gtk.Orientation.HORIZONTAL,
            margin_bottom = 20
        };
        //  string[] preset_colors = {
        //      "#000000", "#5F5F5F", "#9A9A9A", "#CBCBCB", "#E1E1E1", "#F8F8F8",
        //      "#FF0D0D", "#FF8A1D", "#2AA677", "#006EF8", "#7F26FF", "#F8209C",
        //      "#FF5F5F", "#FFB46E", "#50D29F", "#4B9BFF", "#AF78FF", "#F470BB",
        //      "#FFB1B1", "#FFDEC0", "#91E2C3", "#9DC8FF", "#DFCAFF", "#F7BEDF",
        //      "#FFD9D9", "#FFF3E8", "#B1EBD5", "#C4DFFF", "#F8F2FF", "#FCEAF3"
        //  };

        public SwatchesBox () {
            Object (
                orientation: Gtk.Orientation.VERTICAL,
                spacing: 0
            );
        }

        construct {
            Gtk.Box preset_colors_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0) {
                margin_start = 20,
                margin_end = 20,
                margin_top = 10
            };
            Gtk.Box custom_colors_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0) {
                margin_start = 20,
                margin_end = 20,
                margin_bottom = 10
            };
            Gtk.Label preset_colors_label = new Gtk.Label ("Preset Colors") {
                margin_bottom = 13,
                xalign = 0.0f
            };
            Gtk.Label custom_colors_label = new Gtk.Label ("Custom Colors") {
                margin_bottom = 13,
                xalign = 0.0f
            };
            Gtk.Button custom_button = new Gtk.Button.with_label ("Add custom color");

            get_style_context ().add_class ("swatches-box");
            preset_colors_label.get_style_context ().add_class ("swatches-section-label");
            custom_colors_label.get_style_context ().add_class ("swatches-section-label");

            init_swatches (preset_colors_grid, PresetColor.all ());
            init_swatches (custom_colors_grid);

            preset_colors_box.pack_start (preset_colors_label, false, true, 0);
            preset_colors_box.pack_end (preset_colors_grid, false, false, 0);
            pack_start (preset_colors_box, false, true, 10);

            custom_colors_box.pack_start (custom_colors_label, false, true, 0);
            custom_colors_box.pack_start (custom_colors_grid, false, false, 0);
            custom_colors_box.pack_end (custom_button, false, true, 0);
            pack_start (custom_colors_box, false, true, 10);
        }

        private void init_swatches (Gtk.Grid grid, PresetColor[]? colors = null) {
            int col = 0;
            int row = 0;
            int max_rows = colors != null ? 5 : 2;
            ColorSwatch swatch;

            while (row >= 0 && col >= 0) {
                if (col % 6 == 0 && col > 6 - 1) {
                    row += 1;
                    if (row > max_rows - 1) {
                        break;
                    }
                    col = 0;
                }
                if (colors != null) {
                    int color_index = col + (row * 6);
                    swatch = new ColorSwatch (colors[color_index].to_hex_color ());
                } else {
                    swatch = new ColorSwatch ();
                }
                grid.attach (swatch, col, row, 1, 1);
                col += 1;
            }
        }

    }

}
