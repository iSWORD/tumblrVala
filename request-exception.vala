/* -*- Mode: vala; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
/*
 * request-exception.vala
 * Copyright (C) 2014 iSWORD <isword@isword.me>
 *
 * TumblrSDK is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * TumblrSDK is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License along
 * with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

namespace TumblrAPI {
	
	public class RequestException : GLib.Object {

		/**
		 * @param GLib.Object $response
		 */
			public RequestException (GLib.Object response) {

		}

		public string __toString () {
			// TODO: Add implementation here.
			return "";
		}
	}

}