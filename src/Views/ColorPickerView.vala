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

using Fulo.Widgets;

namespace Fulo.Views {

    class ColorPickerView : Gtk.Box {

        //  Properties
        public Gdk.RGBA current_color { get; private set; }

        //  UI
        private PresetSwatches preset;
        private CustomSwatches custom;
        private HexEntry hex_entry;
        private ColorName color_name;
        private PickerButton picker_button;
        private HueRange hue_range;
        private OpacityRange opacity_range;
        private Contrast contrast;
        private ColorRegion color_region;
        private Format format;

        //  Instantiation
        public ColorPickerView () {
            this.spacing = 0;
            this.orientation = Gtk.Orientation.HORIZONTAL;
        }

        construct {
            //  Initialize current color
            string hex = "#FF0000";
            current_color.parse (hex);
            
            //  Set all widgets
            preset = new PresetSwatches ();
            custom = new CustomSwatches ();
            hex_entry = new HexEntry (hex);
            color_name = new ColorName ("Red");
            picker_button = new PickerButton ();
            color_region = new ColorRegion ();
            hue_range = new HueRange ();
            opacity_range = new OpacityRange ();
            contrast = new Contrast ();
            format = new Format ();

            Gtk.Label color_name_heading = new Gtk.Label ("<small>Known as</small>");
            color_name_heading.get_style_context ().add_class ("dim-label");
            color_name_heading.use_markup = true;
            color_name_heading.valign = Gtk.Align.END;

            //  Configuring widgets containers
            Gtk.Box left_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            left_box.get_style_context ().add_class ("swatches-box");
            left_box.pack_start (preset, false, true, 10);
            left_box.pack_end (custom, false, true, 10);

            Gtk.Grid entry_grid = new Gtk.Grid ();
            entry_grid.column_spacing = 10;
            entry_grid.attach (hex_entry, 0, 0, 1, 2);
            entry_grid.attach_next_to (color_name_heading, hex_entry, Gtk.PositionType.RIGHT);
            entry_grid.attach_next_to (color_name, color_name_heading, Gtk.PositionType.BOTTOM);
            
            Gtk.Box right_first_row = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            right_first_row.margin_start = 20;
            right_first_row.margin_end = 20;
            right_first_row.margin_top = 20;
            right_first_row.margin_bottom = 10;
            right_first_row.pack_start (entry_grid, false);
            right_first_row.pack_end (picker_button, false);
            
            Gtk.Box scales_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            scales_box.pack_start (hue_range, true);
            scales_box.pack_end (opacity_range, true);
            
            Gtk.Box right_third_row = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            right_third_row.margin_start = 20;
            right_third_row.margin_end = 20;
            right_third_row.margin_top = 5;
            right_third_row.pack_start (scales_box, true);
            right_third_row.pack_end (contrast, false);
            
            Gtk.Box right_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            right_box.pack_start (right_first_row, false);
            right_box.pack_start (color_region, false);
            right_box.pack_start (right_third_row, false);
            right_box.pack_end (format, false);
            
            this.pack_start (left_box, false);
            this.pack_end (right_box, true);

            preset.preset_color_clicked.connect ((color) => {
                double hue = Helpers.get_hue (color);
                color_region.set_region (Helpers.hsv_to_rgb (hue, 1, 1));
                color_region.queue_draw ();
            });
            
            //  custom.color_clicked.connect (() => {});
        }

    }

}
