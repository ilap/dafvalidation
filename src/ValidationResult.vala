/**
 * Copyright (c) 2012 Pal Dorogi <pal.dorogi@gmail.com>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 *
 **/

using Gee;

namespace Daf.Validation {

    public class ValidationResult : Object {

        public bool valid { get { return severity == Severity.OK; }}
        private Severity severity = Severity.OK;

        public Gee.Map<string, IValidationFailure> failures = new HashMap<string, IValidationFailure> ();

        public ValidationResult (Severity severity, Gee.Map<string, IValidationFailure> failures) {
            this.failures = failures;
            this.severity = severity;
        }

        public Severity is_valid (string? property_name = null) {

            if (property_name == null) {
                return severity;
                //failures[property_name].size == 0;
            } else {
                if (failures.contains (property_name)) {
                    return failures[property_name].severity;
                } else {
                    return Severity.OK;
                }
            }
        }
    }
}
