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

    public class PickerButton : Gtk.Button {

        public PickerButton () {
            Object ();
        }

        construct {
            Gtk.Image *dropper_icon = new Gtk.Image ();
            dropper_icon->pixel_size = 22;
            dropper_icon->gicon = new ThemedIcon ("dropper");

            //  unowned Gtk.Widget dropper_icon_pointer = dropper_icon;

            this.always_show_image = true;
            this.label = null;
            this.set_image (dropper_icon);
            this.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
        }

    }

}
