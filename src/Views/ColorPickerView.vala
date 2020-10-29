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

    public class ColorPickerView : Gtk.Box {

        private Gdk.RGBA current_color;

        public ColorPickerView () {
            Object (
                orientation: Gtk.Orientation.HORIZONTAL,
                spacing: 0
            );
        }

        construct {
            PresetSwatches preset = new PresetSwatches ();
            CustomSwatches custom = new CustomSwatches ();
            Gtk.Box left_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            left_box.get_style_context ().add_class ("swatches-box");
            left_box.pack_start (preset, false, true, 10);
            left_box.pack_end (custom, false, true, 10);
            
            Gtk.Box info_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0) {
                margin_start = 20,
                margin_end = 20,
                margin_top = 20,
                margin_bottom = 10
            };
            HexEntry hex_entry = new HexEntry ();
            ColorName color_name = new ColorName ();
            color_name.set_color_name ("Red");
            PickerButton picker_button = new PickerButton ();
            info_box.pack_start (hex_entry, false, true, 0);
            info_box.pack_start (color_name, false, true, 0);
            info_box.pack_end (picker_button, false, true, 0);

            Gtk.Box tool_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0) {
                margin_start = 20,
                margin_end = 20,
                margin_top = 3
            };
            HueRange hue_range = new HueRange ();
            OpacityRange opacity_range = new OpacityRange ();
            Gtk.Box scales_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            scales_box.pack_start (hue_range, false, true, 0);
            scales_box.pack_end (opacity_range, false, true, 0);
            tool_box.pack_start (scales_box, false, true, 0);

            ColorRegion color_region = new ColorRegion ();
            Gtk.Box right_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            right_box.pack_start (info_box, false, true, 0);
            right_box.pack_start (color_region, false, true, 0);
            right_box.pack_start (tool_box, false, true, 0);
            
            pack_start (left_box, false, true, 0);
            pack_end (right_box, false, true, 0);

            preset.preset_color_clicked.connect ((color) => {
                double hue = Helpers.get_hue (color);
                color_region.set_region (Helpers.hsv_to_rgb (hue, 1, 1));
                color_region.queue_draw ();
            });
            
            //  custom.color_clicked.connect (() => {});
        }

    }

}
