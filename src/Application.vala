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

using Fulo.Views; 

namespace Fulo {

    public class Application : Gtk.Application {

        // TODO Instantiate Glib.Settings

        private const string APP_ID = "com.github.arviantodwi.fulo";
        private MainWindow main_window;

        public Application () {
            Object (
                application_id: APP_ID,
                flags: ApplicationFlags.FLAGS_NONE
            );
        }

        private static Application _instance = null;
        public static Application instance {
            get {
                if (_instance == null) {
                    _instance = new Application ();
                }
                return _instance;
            }
        }

        static construct {
            // TODO Initialize settings for application states
        }

        protected override void activate () {
            load_css ();
            
            Gtk.Box root_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            SwatchesBox swatches = new SwatchesBox ();

            root_box.pack_start (swatches, false, true, 0);
            
            main_window = new MainWindow (this);
            main_window.add (root_box);
            main_window.show_all ();
        }

        public static int main (string[] args) {
            return new Application ().run (args);
        }

        private static void load_css () {
            Gtk.CssProvider provider = new Gtk.CssProvider ();
            provider.load_from_resource ("/com/github/arviantodwi/fulo/css/main.css");
            Gtk.StyleContext.add_provider_for_screen (
                Gdk.Screen.get_default (),
                provider,
                Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
            );
        }

    }

}
