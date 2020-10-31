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

    class Application : Gtk.Application {
        
        //  Properties
        // TODO Instantiate Glib.Settings
        private const string APP_ID = "com.github.arviantodwi.fulo";
        private static Application _instance = null;
        public static Application instance {
            get {
                if (_instance == null) {
                    _instance = new Application ();
                }
                return _instance;
            }
        }
        
        //  UI
        weak Gtk.IconTheme theme;
        private MainWindow main_window;
        private Gtk.CssProvider provider;
        
        //  Instantiation
        public Application () {
            this.application_id = APP_ID;
            this.flags = ApplicationFlags.FLAGS_NONE;
        }
        
        static construct {
            // TODO Initialize settings for application states
        }

        protected override void activate () {
            // Set default Icon Theme
            theme = Gtk.IconTheme.get_default ();
            theme.add_resource_path ("/com/github/arviantodwi/fulo");
            
            //  Load custom CSS
            provider = new Gtk.CssProvider ();
            provider.load_from_resource ("/com/github/arviantodwi/fulo/css/main.css");
            Gtk.StyleContext.add_provider_for_screen (
                Gdk.Screen.get_default (),
                provider,
                Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
            );
            
            //  Show app in main window
            main_window = new MainWindow (this);
            main_window.add (new ColorPickerView ());
            main_window.show_all ();
        }

        public static int main (string[] args) {
            return new Application ().run (args);
        }

    }

}
