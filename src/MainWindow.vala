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

namespace Fulo {

    class MainWindow : Gtk.Window {

        //  Properties
        private const string WINDOW_TITLE = "Fulo";
        private Gtk.Settings gtk_settings = Gtk.Settings.get_default ();
        // TODO Instantiate Glib.Settings
        
        //  UI
        private Gtk.HeaderBar header_bar;
        private Granite.ModeSwitch theme_switch;

        //  Instantiation
        public MainWindow (Gtk.Application app) {
            this.application = app;
            //  this.resizable = false;
            this.window_position = Gtk.WindowPosition.CENTER;
            this.icon_name = Application.instance.application_id;
        }
        
        static construct {
            // TODO Initialize settings for application states
        }
        
        construct {
            //  Theme Switch
            theme_switch = new Granite.ModeSwitch.from_icon_name (
                "display-brightness-symbolic",
                "weather-clear-night-symbolic"
            );
            theme_switch.primary_icon_tooltip_text = _("Light theme");
            theme_switch.secondary_icon_tooltip_text = _("Dark theme");
            theme_switch.valign = Gtk.Align.CENTER;
            theme_switch.bind_property ("active", gtk_settings, "gtk_application_prefer_dark_theme");
            
            //  Custom Header Bar
            header_bar = new Gtk.HeaderBar ();
            header_bar.show_close_button = true;
            header_bar.title = WINDOW_TITLE;
            header_bar.has_subtitle = false;
            header_bar.pack_end(theme_switch);
            header_bar.pack_end(new Gtk.Separator (Gtk.Orientation.HORIZONTAL));

            this.set_titlebar (header_bar);
        }

    }

}
