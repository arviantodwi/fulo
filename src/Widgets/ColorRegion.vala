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

    public class ColorRegion : Gtk.DrawingArea {

        //  Properties
        protected static double xpos = 306;
        protected static double ypos = 0;
        protected static uint16 width = 306;
        protected static uint16 height = 200;
        private static ColorRegion instance;
        private static Cairo.Surface surface;
        private static Gtk.GestureDrag gesture;

        construct {
            this.set_size_request (width, height);
            this.margin_start = 20;
            this.margin_end = 20;

            instance = this;

            gesture = new Gtk.GestureDrag (this);
            GLib.Signal.connect (gesture, "drag-begin", (GLib.Callback) gesture_drag_begin, null);
            GLib.Signal.connect (gesture, "drag-update", (GLib.Callback) gesture_drag_update, null);
            GLib.Signal.connect (gesture, "drag-end", (GLib.Callback) gesture_drag_end, null);

            surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, width, height);

            create_surface ();
        }

        public override bool draw (Cairo.Context context) {
            double xc = 7;
            double yc = 7;
            double stroke_width = 3;
            double radius = xc - stroke_width / 2;
            double angle1 = 0;
            double angle2 = 2 * GLib.Math.PI;
            
            context.set_source_surface (surface, 0, 0);
            context.paint ();
            context.translate (xpos - 7, ypos - 7);
            context.arc (xc, yc, radius, angle1, angle2);
            context.set_line_width (stroke_width);
            context.set_source_rgb (1, 1, 1);
            context.stroke_preserve ();
            context.set_line_width (1);
            context.set_source_rgba (0, 0, 0, 0.6);
            context.stroke ();

            return false;
        }

        private static void create_surface () {
            Cairo.Context context = new Cairo.Context (surface);
            context.set_source_rgb (1, 0, 0);
            context.paint ();

            Cairo.Pattern p1 = new Cairo.Pattern.linear (0, 0, width, 0);
            p1.add_color_stop_rgba (0, 1, 1, 1, 1);
            p1.add_color_stop_rgba (1, 1, 1, 1, 0);
            context.set_source (p1);
            context.paint ();

            Cairo.Pattern p2 = new Cairo.Pattern.linear (0, 0, 0, height);
            p2.add_color_stop_rgba (0, 0, 0, 0, 0);
            p2.add_color_stop_rgba (1, 0, 0, 0, 1);
            context.set_source (p2);
            context.paint ();
        }

        private static void set_crosshair_cursor (bool enabled) {
            Gdk.Cursor cursor = null;
            unowned Gdk.Window window = instance.get_window ();
            unowned Gdk.Device device = gesture.get_device ();

            if (!(bool)window || !(bool)device) {
                return;
            }

            if (enabled) {
                cursor = new Gdk.Cursor.from_name (((Gtk.Widget)instance).get_display (), "crosshair");
            }

            window.set_device_cursor (device, cursor);
        }

        private static void gesture_drag_begin (double start_x, double start_y) {
            print ("========= DRAG_BEGIN:\n");
            print ("start_x: %1.4f, start_y: %1.4f\n", start_x, start_y);
            xpos = start_x;
            ypos = start_y;

            set_crosshair_cursor (true);

            instance.queue_draw ();
        }

        private static void gesture_drag_update (double offset_x, double offset_y) {
            print ("========= DRAG_UPDATE:\n");
            print ("offset_x: %1.4f, offset_y: %1.4f\n", offset_x, offset_y);
            double _xpos, _ypos;
            gesture.get_start_point (out _xpos, out _ypos);
            print ("_xpos: %1.4f, _ypos: %1.4f\n", _xpos, _ypos);
            if (_xpos + offset_x > width) {
                xpos = width;
            } else if (_xpos + offset_x < 0) {
                xpos = 0;
            } else {
                xpos = _xpos + offset_x;
            }
            if (_ypos + offset_y > height) {
                ypos = height;
            } else if (_ypos + offset_y < 0) {
                ypos = 0;
            } else {
                ypos = _ypos + offset_y;
            }

            instance.queue_draw ();
        }

        private static void gesture_drag_end (double offset_x, double offset_y) {
            print ("========= DRAG_END:\n");
            print ("offset_x: %1.4f, offset_y: %1.4f\n", offset_x, offset_y);
            set_crosshair_cursor (false);
            print ("xpos: %1.4f, ypos: %1.4f\n", xpos, ypos);
        }

    }

}
