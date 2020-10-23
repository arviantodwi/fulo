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

    public class ColorSwatch : Gtk.Button {

        public string color { get; construct; }

        private const string CSS_SWATCH = """
            .swatch {
                background-color: %s;
                border-radius: 3px;
                box-shadow: inset 0 0 0 1px %s;
            }
            .swatch.custom-swatch {
                border: dashed 1px #CDCDCD;
                box-shadow: none;
            }
            .swatch.custom-swatch.custom-has-color {}
        """;

        private Gtk.StyleContext swatch_item_style_context;

        public ColorSwatch (string? color = null) {
            Object (
                color: color,
                width_request: 24,
                height_request: 24
            );
        }

        construct {
            swatch_item_style_context = get_style_context ();
            swatch_item_style_context.add_class (Gtk.STYLE_CLASS_FLAT);
            swatch_item_style_context.add_class ("swatch");
            if (color == null) {
                swatch_item_style_context.add_class ("custom-swatch");
                color = "#FCFCFC";
            }

            Gdk.RGBA color_rgba = Gdk.RGBA ();
            color_rgba.parse ((string)color);

            Color contrast_rgba = new Color.from_rgba (
                Granite.contrasting_foreground_color (color_rgba)
            );
            contrast_rgba.set_alpha(0.08);
            
            string css = CSS_SWATCH.printf (
                color_rgba.to_string (),
                contrast_rgba.to_string()
            );
            
            Gtk.CssProvider provider = new Gtk.CssProvider ();
            try {
                provider.load_from_data (css, css.length);
                swatch_item_style_context.add_provider (
                    provider,
                    Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
                );
            } catch (GLib.Error e) {
                critical (e.message);
                return;
            }

            //  TODO get color for color picker use
            clicked.connect (() => {
                print("%s clicked!\n", new Color.from_string ((string)color).to_string ());
            });
        }
    }

}
