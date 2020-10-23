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

    public class MainWindow : Gtk.Window {

        // TODO Instantiate Glib.Settings

        private const string WINDOW_TITLE = "Fulo";

        public MainWindow (Gtk.Application app) {
            Object (
                application: app,
                icon_name: Application.instance.application_id,
                title: WINDOW_TITLE,
                window_position: Gtk.WindowPosition.CENTER
            );
        }

        static construct {
            // TODO Initialize settings for application states
        }

        construct {
            Gtk.Settings gtk_settings = Gtk.Settings.get_default ();
            //  Granite.Settings granite_settings = Granite.Settings.get_default();

            default_width = 580;
            //  default_height = 426;

            Granite.ModeSwitch theme_switch = new Granite.ModeSwitch.from_icon_name (
                "display-brightness-symbolic",
                "weather-clear-night-symbolic"
            ) {
                primary_icon_tooltip_text = _("Light theme"),
                secondary_icon_tooltip_text = _("Dark theme"),
                valign = Gtk.Align.CENTER
            };
            theme_switch.bind_property ("active", gtk_settings, "gtk_application_prefer_dark_theme");
            
            Gtk.HeaderBar header_bar = new Gtk.HeaderBar () {
                show_close_button = true,
                has_subtitle = false
            };
            header_bar.pack_end(theme_switch);
            header_bar.pack_end(new Gtk.Separator (Gtk.Orientation.HORIZONTAL));

            this.set_titlebar (header_bar);
            this.show_all ();
        }

    }

}
