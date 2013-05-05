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

namespace Daf.Validation {

    public class ValidationRule : Object, IValidationFailure {

        public string property_name {
            get { return failure.property_name; } set {}
        }

        public string message {
            get { return failure.message; }
            set { failure.message = value; }
        }

        public Severity severity {
            get { return failure.severity; }
            set { failure.severity = value; }
        }

        public IValidationFailure failure { get; private set; }
        public DelegateRule rule { get; owned set; }

        public ValidationRule (owned DelegateRule rule, IValidationFailure failure) {
            this.failure = failure;
            this.rule = (owned) rule;
        }
    }
}
