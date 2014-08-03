/* -*- Mode: vala; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
/*
 * request-handler.vala
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
	
	/**
	 * A request handler for Tumblr authentication
	 * and requests
	 */
	public class RequestHandler : GLib.Object {
		protected string consumer { get; set; }
		protected string token { get; set; }
		protected string signatureMethod { get; set; }
		protected string baseUrl { get; set; }


		/**
		 * Instantiate a new RequestHandler
		 */
			public RequestHandler () {

		}

		/**
		 * Set the consumer for this request handler
		 *
		 * @param string $key    the consumer key
		 * @param string $secret the consumer secret
		 */
		public void setConsumer (string key, string secret) {
			// TODO: Add implementation here.
		}

		/**
		 * Set the token for this request handler
		 *
		 * @param string $token  the oauth token
		 * @param string $secret the oauth secret
		 */
		public void setToken (string token, string secret) {
			// TODO: Add implementation here.
		}

		/**
		 * Set the base url for this request handler.
		 *
		 * @param string $url The base url (e.g. http://api.tumblr.com)
		 */
		public void setBaseUrl (string url) {
			// TODO: Add implementation here.
		}

		/**
		 * Make a request with this request handler
		 *
		 * @param string $method  one of GET, POST
		 * @param string $path    the path to hit
		 * @param array  $options the array of params
		 *
		 * @return GLib.Object response object
		 */
		public GLib.Object request (string method, string path, Array options) {
			// TODO: Add implementation here.
			return new GLib.Object();
		}
	}
}
