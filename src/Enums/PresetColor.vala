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

namespace Fulo.Enums {

    public enum PresetColor {
        BLACK,
        GRANITE_GRAY,
        QUICK_SILVER,
        SILVER,
        MERCURY,
        ALABASTER,
        RED,
        WEST_SIDE,
        JUNGLE_GREEN,
        BLUE_RIBBON,
        ELECTRIC_VIOLET,
        PERSIAN_ROSE,
        BITTERSWEET,
        MACARONI_AND_CHEESE,
        SHAMROCK,
        BLUEBERRY,
        HELIOTROPE,
        PERSIAN_PINK,
        SUNDOWN,
        NEGRONI,
        ALGAE_GREEN,
        ANAKIWA,
        FOG,
        CHANTILLY,
        COSMOS,
        SERENADE,
        CRUISE,
        FRENCH_PASS,
        MAGNOLIA,
        CAROUSEL_PINK;
    
        public static int min () {
            EnumClass enumc = (EnumClass) typeof (PresetColor).class_ref ();
            return enumc.minimum;
        }

        public static int max () {
            EnumClass enumc = (EnumClass) typeof (PresetColor).class_ref ();
            return enumc.maximum;
        }

        public string to_hex_color () {
            string[] hex = {
                "#000000", "#5F5F5F", "#9A9A9A", "#CBCBCB", "#E1E1E1", "#F8F8F8",
                "#FF0D0D", "#FF8A1D", "#2AA677", "#006EF8", "#7F26FF", "#F8209C",
                "#FF5F5F", "#FFB46E", "#50D29F", "#4B9BFF", "#AF78FF", "#F470BB",
                "#FFB1B1", "#FFDEC0", "#91E2C3", "#9DC8FF", "#DFCAFF", "#F7BEDF",
                "#FFD9D9", "#FFF3E8", "#B1EBD5", "#C4DFFF", "#F8F2FF", "#FCEAF3"
            };
            EnumClass enumc = (EnumClass) typeof (PresetColor).class_ref ();
            unowned EnumValue? eval = enumc.get_value (this);

            //  print ("%s\n", eval.value_nick);

            return hex[eval.value];
        }

        public static PresetColor[] all () {
            return {
                BLACK,
                GRANITE_GRAY,
                QUICK_SILVER,
                SILVER,
                MERCURY,
                ALABASTER,
                RED,
                WEST_SIDE,
                JUNGLE_GREEN,
                BLUE_RIBBON,
                ELECTRIC_VIOLET,
                PERSIAN_ROSE,
                BITTERSWEET,
                MACARONI_AND_CHEESE,
                SHAMROCK,
                BLUEBERRY,
                HELIOTROPE,
                PERSIAN_PINK,
                SUNDOWN,
                NEGRONI,
                ALGAE_GREEN,
                ANAKIWA,
                FOG,
                CHANTILLY,
                COSMOS,
                SERENADE,
                CRUISE,
                FRENCH_PASS,
                MAGNOLIA,
                CAROUSEL_PINK
            };
        }
    }

}
