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

    public class Chooser : Gtk.DrawingArea {

        //  Properties
        private const uint16 WIDTH = 306;
        private const uint16 HEIGHT = 200;
        private static double r;
        private static double g;
        private static double b;
        private static double xpos = 306;
        private static double ypos = 0;
        private static unowned Chooser instance;
        private static Cairo.Surface surface;
        private static Gtk.GestureDrag gesture;

        //  Signals
        public signal void on_sv_move (double s, double v);

        public Chooser (Gdk.RGBA active_color) {
            double h, s, v;
            r = active_color.red;
            g = active_color.green;
            b = active_color.blue;

            Gtk.rgb_to_hsv (r, g, b, out h, out s, out v);
            sv_to_xy (s, v, out xpos, out ypos);
            create_surface ();
        }

        construct {
            instance = this;
            instance.set_size_request (WIDTH, HEIGHT);

            gesture = new Gtk.GestureDrag (this);
            GLib.Signal.connect (gesture, "drag-begin", (GLib.Callback) gesture_drag_begin, null);
            GLib.Signal.connect (gesture, "drag-update", (GLib.Callback) gesture_drag_update, null);
            GLib.Signal.connect (gesture, "drag-end", (GLib.Callback) gesture_drag_end, null);

            surface = new Cairo.ImageSurface (Cairo.Format.ARGB32, WIDTH, HEIGHT);
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

        public void update_surface_color (double r_arg, double g_arg, double b_arg) {
            r = r_arg;
            g = g_arg;
            b = b_arg;
            create_surface ();
            this.queue_draw ();
        }

        public void pos_to_sv (out double s, out double v) {
            xy_to_sv (xpos, ypos, out s, out v);
        }

        private static void xy_to_sv (double x, double y, out double s, out double v) {
            s = x / WIDTH;
            v = 1 - (y / HEIGHT);
        }

        private static void sv_to_xy (double s, double v, out double x, out double y) {
            x = s * WIDTH;
            y = HEIGHT - (v * HEIGHT);
        }

        private static void create_surface () {
            Cairo.Context context = new Cairo.Context (surface);
            context.set_source_rgb (r, g, b);
            context.paint ();

            Cairo.Pattern p1 = new Cairo.Pattern.linear (0, 0, WIDTH, 0);
            p1.add_color_stop_rgba (0, 1, 1, 1, 1);
            p1.add_color_stop_rgba (1, 1, 1, 1, 0);
            context.set_source (p1);
            context.paint ();

            Cairo.Pattern p2 = new Cairo.Pattern.linear (0, 0, 0, HEIGHT);
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
            xpos = start_x;
            ypos = start_y;

            set_crosshair_cursor (true);

            double new_s, new_v;
            xy_to_sv (xpos, ypos, out new_s, out new_v);
            instance.on_sv_move (new_s, new_v);
            instance.queue_draw ();
        }

        private static void gesture_drag_update (double offset_x, double offset_y) {
            double _xpos, _ypos;
            gesture.get_start_point (out _xpos, out _ypos);

            if (_xpos + offset_x > WIDTH) {
                xpos = WIDTH;
            } else if (_xpos + offset_x < 0) {
                xpos = 0;
            } else {
                xpos = _xpos + offset_x;
            }

            if (_ypos + offset_y > HEIGHT) {
                ypos = HEIGHT;
            } else if (_ypos + offset_y < 0) {
                ypos = 0;
            } else {
                ypos = _ypos + offset_y;
            }

            double new_s, new_v;
            xy_to_sv (xpos, ypos, out new_s, out new_v);
            instance.on_sv_move (new_s, new_v);
            instance.queue_draw ();
        }

        private static void gesture_drag_end (double offset_x, double offset_y) {
            set_crosshair_cursor (false);
        }

    }

}
