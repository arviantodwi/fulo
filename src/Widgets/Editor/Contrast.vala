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

namespace Fulo.Widgets.Editor {

    public class Contrast : Gtk.Box {

        private Gdk.RGBA _color;

        public Contrast () {
            this.margin_start = 10;
        }

        construct {
            this.orientation = Gtk.Orientation.HORIZONTAL;
            this.spacing = 6;
            this.valign = Gtk.Align.CENTER;
            
            _color.parse ("#F00");

            Gtk.DrawingArea contrast_dark = new Gtk.DrawingArea ();
            contrast_dark.set_size_request (47, 47);
            Cairo.ImageSurface contrast_dark_surface = new Cairo.ImageSurface (
                Cairo.Format.ARGB32, 47, 47
            );
            Cairo.Context contrast_dark_context = new Cairo.Context (contrast_dark_surface);
            contrast_dark.draw.connect ((contrast_dark_context) => {
                draw_contrast (contrast_dark_context, "dark");
            });

            Gtk.DrawingArea contrast_light = new Gtk.DrawingArea ();
            contrast_light.set_size_request (47, 47);
            Cairo.ImageSurface contrast_light_surface = new Cairo.ImageSurface (
                Cairo.Format.ARGB32, 47, 47
            );
            Cairo.Context contrast_light_context = new Cairo.Context (contrast_light_surface);
            contrast_light.draw.connect ((contrast_light_context) => {
                draw_contrast (contrast_light_context, "light");
            });

            this.pack_start (contrast_dark, false);
            this.pack_end (contrast_light, false);
        }

        public void set_color (Gdk.RGBA color) {
            _color = color;
        }

        private bool draw_contrast (Cairo.Context context, string contrast_type) {
            Cairo.Pattern p1 = (contrast_type == "dark")
                ? new Cairo.Pattern.rgb (0, 0, 0)
                : new Cairo.Pattern.rgb (1, 1, 1);
            context.rectangle (0, 0, 47, 47);
            context.set_source (p1);
            context.fill ();

            Cairo.Pattern p2 = new Cairo.Pattern.rgba (_color.red, _color.green, _color.blue, _color.alpha);
            context.rectangle (0, 0, 47, 47);
            context.set_source (p2);
            context.fill ();

            context.rectangle (33, 33, 10, 10);
            context.set_source (p1);
            context.fill ();

            return true;
        }

    }

}
