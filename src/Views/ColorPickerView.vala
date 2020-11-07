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
using Granite.Widgets;

namespace Fulo.Views {

    class ColorPickerView : Gtk.Overlay {

        //  Properties
        public Gdk.RGBA current_color { get; private set; }

        //  UI
        private SwatchGroup preset;
        private SwatchGroup custom;
        private HexEntry hex_entry;
        private ColorName color_name;
        private PickerButton picker_button;
        private Editor.Chooser color_region;
        private Editor.HueSlider hue_range;
        private Editor.AlphaSlider opacity_range;
        private Editor.Contrast contrast;
        private Format format;
        private Toast toast;

        //  Instantiation
        public ColorPickerView () {
            //  
        }

        construct {
            //  Initialize current color
            string hex = "#FF0000";
            current_color.parse (hex);
            
            //  Set all widgets
            preset = new SwatchGroup.make_preset (Helpers.get_preset_colors (), _("Preset Colors"), 5);
            custom = new SwatchGroup (_("Custom Colors"));
            hex_entry = new HexEntry (hex);
            color_name = new ColorName ("Red");
            picker_button = new PickerButton ();
            color_region = new Editor.Chooser ();
            hue_range = new Editor.HueSlider ();
            opacity_range = new Editor.AlphaSlider ();
            contrast = new Editor.Contrast ();
            format = new Format ();
            
            toast = new Toast (_("Color was pressed!"));
            toast.set_default_action (_("Do Things"));

            Gtk.Button add_custom_color_button = new Gtk.Button.with_label (_("Add custom color"));
            add_custom_color_button.margin_start = 20;
            add_custom_color_button.margin_end = 20;
            add_custom_color_button.margin_top = 15;
            add_custom_color_button.margin_bottom = 20;

            Gtk.Label color_name_heading = new Gtk.Label ("<small>" + _("Known as") + "</small>");
            color_name_heading.get_style_context ().add_class ("dim-label");
            color_name_heading.use_markup = true;
            color_name_heading.valign = Gtk.Align.END;

            //  Configuring widgets containers
            Gtk.Box left_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            left_box.get_style_context ().add_class ("swatches-box");
            left_box.pack_start (preset, false, true, 10);
            left_box.pack_start (custom, false);
            left_box.pack_start (add_custom_color_button, false);

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
            
            //  Gtk.ColorChooserWidget chooser = new Gtk.ColorChooserWidget ();
            //  chooser.show_editor = true;
            Gtk.Box right_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            right_box.pack_start (right_first_row, false);
            right_box.pack_start (color_region, false);
            right_box.pack_start (right_third_row, false);
            right_box.pack_end (format, false);
            
            Gtk.Box root_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            root_box.pack_start (left_box, false);
            root_box.pack_end (right_box, true);

            this.add (root_box);
            this.add_overlay (toast);

            preset.color_clicked.connect ((color) => {
                toast.send_notification ();
                weak double hue = Helpers.get_hue (color);
                //  color_region.update (Helpers.hsv_to_rgb (hue, 1, 1));

                weak double r = color.red;
                weak double g = color.green;
                weak double b = color.blue;
                hex_entry.set_value (Helpers.rgb_to_hex (r, g, b));
            });
            
            custom.color_clicked.connect (() => {});
        }

    }

}
