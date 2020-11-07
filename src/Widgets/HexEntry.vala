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

    public class HexEntry : Gtk.Entry {

        construct {
            this.max_length = 7;
            this.editable = true;
            this.secondary_icon_name = "edit-copy";
            this.width_chars = 12;
            this.get_style_context ().add_class ("hex");
            //  this.add_events (Gdk.EventMask.ENTER_NOTIFY_MASK);
        }

        public HexEntry (string hex) {
            this.text = hex;
        }

        public void set_value (string hex) {
            this.text = hex;
        }
        
        //  public override bool enter_notify_event (Gdk.EventCrossing e) {
        //      e.window.set_cursor (new Gdk.Cursor.for_display (
        //          Gdk.Display.get_default (),
        //          Gdk.CursorType.HAND2
        //      ));

        //      return true;
        //  }
        
    }

}
