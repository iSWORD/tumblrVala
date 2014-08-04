/* -*- Mode: vala; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
/*
 * client.vala
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

using Gee;

namespace TumblrAPI {

	/**
	 * A client to access the Tumblr API
	 */
	public class Client : GLib.Object {
		protected string apiKey { get; set; }
		private RequestHandler requestHandler;


		/**
		 * Create a new Client
		 *
		 * @param string $consumerKey    the consumer key
		 * @param string $consumerSecret the consumer secret
		 * @param string $token          oauth token
		 * @param string $secret         oauth token secret
		 */
			public Client (string consumerKey, string consumerSecret = "", string token = "", string secret = "") {
				this.requestHandler = new RequestHandler();
				this.setConsumer(consumerKey, consumerSecret);

				if (token != "" && secret != "") {
					this.setToken(token,secret);
				}
		}

		/**
		 * Set the consumer for this client
		 *
		 * @param string $consumerKey    the consumer key
		 * @param string $consumerSecret the consumer secret
		 */
		public void setConsumer (string consumerKey, string consumerSecret) {
			this.apiKey = consumerKey;
			this.requestHandler.setConsumer(consumerKey, consumerSecret);
		}
		
		/**
		 * Set the token for this client
		 *
		 * @param string $token  the oauth token
		 * @param string $secret the oauth secret
		 */
		public void setToken (string token, string secret) {
			this.requestHandler.setToken(token, secret);
		}

		/**
		 * Retrieve RequestHandler instance
		 *
		 * @return RequestHandler
		 */
		public RequestHandler getRequestHandler () {
			return this.requestHandler;
		}

		/**
		 * Get info on the authenticating user
		 *
		 * @return array the response array
		 */
		public HashMap<string, string> getUserInfo () {
			return this.getRequest("v2/user/info", new HashMap<string, string>(), false);
		}

		/**
		 * Get user dashboard for the authenticating user
		 *
		 * @param  array $options the options for the call
		 * @return array the response array
		 */
		public HashMap<string, string> getDashboardPosts (HashMap<string, string> options = new HashMap<string, string>()) {
			return this.getRequest("v2/user/dashboard", options, false);
		}

		/**
		 * Get followings for the authenticating user
		 *
		 * @param  array $options the options for the call
		 * @return array the response array
		 */
		public HashMap<string, string> getFollowedBlogs (HashMap<string, string> options = new HashMap<string, string>()) {
			return this.getRequest("v2/user/following", options, false);
		}

		/**
		 * Get likes for the authenticating user
		 *
		 * @param  array $options the options for the call
		 * @return array the response array
		 */
		public HashMap<string, string> getLikedPosts (HashMap<string, string> options = new HashMap<string, string>()) {
			return this.getRequest("v2/user/likes", options, false);
		}

		/**
		 * Follow a blog
		 *
		 * @param  string $blogName the name of the blog to follow
		 * @return array  the response array
		 */
		public HashMap<string, string> follow (string blogName) {
			HashMap<string, string> options = new HashMap<string, string>();
			options["url"] = this.blogUrl(blogName);
			
			return this.postRequest("v2/user/follow", options, false);
		}

		/**
		 * Unfollow a blog
		 *
		 * @param  string $blogName the name of the blog to follow
		 * @return array  the response array
		 */
		public HashMap<string, string> unfollow (string blogName) {
			HashMap<string, string> options = new HashMap<string, string>();
			options["url"] = this.blogUrl(blogName);
			
			return this.postRequest("v2/user/unfollow", options, false);
		}

		/**
		 * Like a post
		 *
		 * @param int    $postId    the id of the post
		 * @param string $reblogKey the reblog_key of the post
		 *
		 * @return array the response array
		 */
		public HashMap<string, string> like (int postId, string reblogKey) {
			HashMap<string, string> options = new HashMap<string, string>();
			options["id"] = postId.to_string();
			options["reblogKey"] = reblogKey;

			return this.postRequest("v2/user/like", options, false);
		}

		/**
		 * Unlike a post
		 *
		 * @param int    $postId    the id of the post
		 * @param string $reblogKey the reblog_key of the post
		 *
		 * @return array the response array
		 */
		public HashMap<string, string> unlike (int postId, string reblogKey) {
			HashMap<string, string> options = new HashMap<string, string>();
			options["id"] = postId.to_string();
			options["reblogKey"] = reblogKey;

			return this.postRequest("v2/user/unlike", options, false);
		}

		/**
		 * Delete a post
		 *
		 * @param string $blogName  the name of the blog the post is on
		 * @param int    $postId    the id of the post
		 * @param string $reblogKey the reblog_key of the post
		 *
		 * @return array the response array
		 */
		public HashMap<string, string> deletePost (string blogName, int postId, string reblogKey) {
			HashMap<string, string> options = new HashMap<string, string>();
			options["id"] = postId.to_string();
			options["reblogKey"] = reblogKey;

			string path = this.blogPath(blogName, "/post/delete");

			return this.postRequest(path, options, false);
		}

		/**
		 * Reblog a post
		 *
		 * @param string $blogName  the name of the blog
		 * @param int    $postId    the id of the post
		 * @param string $reblogKey the reblog key of the post
		 * @param array  $options   the options for the call
		 *
		 * @return array the response array
		 */
		public HashMap<string, string> reblogPost (string blogName, int postId, string reblogKey, HashMap<string, string> options = new HashMap<string, string>()) {
			HashMap<string, string> params = options;
			params["id"] = postId.to_string();
			params["reblogKey"] = reblogKey;
			
			string path = this.blogPath(blogName, "/post/reblog");
			
			return this.postRequest(path, params, false);
		}

		/**
		 * Edit a post
		 *
		 * @param string $blogName the name of the blog
		 * @param int    $postId   the id of the post to edit
		 * @param array  $data     the data to save
		 *
		 * @return array the response array
		 */
		public HashMap<string, string> editPost (string blogName, int postId, HashMap<string, string> data) {
			data["id"] = postId.to_string();
			string path = this.blogPath(blogName, "/post/edit");
			
			return this.postRequest(path, data, false);
		}

		/**
		 * Create a post
		 *
		 * @param string $blogName the name of the blog
		 * @param array  $data     the data to save
		 *
		 * @return array the response array
		 */
		public HashMap<string, string> createPost (string blogName, HashMap<string, string> data) {
			string path = this.blogPath(blogName, "/post");
			
			return this.postRequest(path, data, false);
		}

		/**
		 * Get tagged posts
		 *
		 * @param string $tag     the tag to look up
		 * @param array  $options the options for the call
		 *
		 * @return array the response array
		 */
		public HashMap<string, string> getTaggedPosts (string tag, HashMap<string, string> options = new HashMap<string, string>()) {
			options["tag"] = tag;
			
			return this.getRequest("v2/tagged", options, true);
		}

		/**
		 * Get information about a given blog
		 *
		 * @param  string $blogName the name of the blog to look up
		 * @return array  the response array
		 */
		public HashMap<string, string> getBlogInfo (string blogName) {
			string path = this.blogPath(blogName, "/info");
			
			return this.getRequest(path, new HashMap<string, string>(), true);
		}

		/**
		 * Get blog avatar URL
		 *
		 * @param string $blogName the nae of the blog to look up
		 * @param int    $size     the size to retrieve
		 *
		 * @return string the avatar url
		 */
		public string getBlogAvatar (string blogName, int size = 0) {
			string path = this.blogPath(blogName, "/avatar");
			if (size != 0) {
				path += "/" + size.to_string();
			}
			
			return this.getRedirect(path, new HashMap<string, string>(), true);
		}

		/**
		 * Get blog likes for a given blog
		 *
		 * @param string $blogName the name of the blog to look up
		 * @param array  $options  the options for the call
		 *
		 * @return array the response array
		 */
		public HashMap<string, string> getBlogLikes (string blogName, HashMap<string, string> options = new HashMap<string, string>()) {
			string path = this.blogPath(blogName, "/likes");
			return this.getRequest(path, options, true);
		}

		/**
		 * Get blog followers for a given blog
		 *
		 * @param string $blogName the name of the blog to look up
		 * @param array  $options  the options for the call
		 *
		 * @return array the response array
		 */
		public HashMap<string, string> getBlogFollowers (string blogName, HashMap<string, string> options = new HashMap<string, string>()) {
			string path = this.blogPath(blogName, "/followers");
			
			return this.getRequest(path, options, false);
		}

		/**
		 * Get posts for a given blog
		 *
		 * @param string $blogName the name of the blog
		 * @param array  $options  the options for the call
		 *
		 * @return array the response array
		 */
		public HashMap<string, string> getBlogPosts (string blogName, HashMap<string, string> options = new HashMap<string, string>()) {
			string path = this.blogPath(blogName, "/posts");
			if (options.has_key("type")) {
				path += "/" + options["type"];
				options.unset("type");
			}
			
			return this.getRequest(path, options, true);
		}

		/**
		 * Get queue posts for a given blog
		 *
		 * @param string $blogName the name of the blog
		 * @param array  $options  the options for the call
		 *
		 * @return array the response array
		 */
		public HashMap<string, string> getQueuedPosts (string blogName, HashMap<string, string> options = new HashMap<string, string>()) {
			string path = this.blogPath(blogName, "/posts/queue");
			
			return this.getRequest(path, options, false);
		}

		/**
		 * Get draft posts for a given blog
		 *
		 * @param string $blogName the name of the blog
		 * @param array  $options  the options for the call
		 *
		 * @return array the response array
		 */
		public HashMap<string, string> getDraftPosts (string blogName, HashMap<string, string> options = new HashMap<string, string>()) {
			string path = this.blogPath(blogName, "/posts/draft");
			
			return this.getRequest(path, options, false);
		}

		/**
		 * Get submission posts for a given blog
		 *
		 * @param string $blogName the name of the blog
		 * @param array  $options  the options for the call
		 *
		 * @return array the response array
		 */
		public HashMap<string, string> getSubmissionPosts (string blogName, HashMap<string, string> options = new HashMap<string, string>()) {
			string path = this.blogPath(blogName, "/posts/submission");
			
			return this.getRequest(path, options, false);
		}

		/**
		 * Make a GET request to the given endpoint and return the response
		 *
		 * @param string $path      the path to call on
		 * @param array  $options   the options to call with
		 * @param bool   $addApiKey whether or not to add the api key
		 *
		 * @return array the response object (parsed)
		 */
		private HashMap<string, string> getRequest (string path, HashMap<string, string> options = new HashMap<string, string>(), bool addApiKey) {
			var response = this.makeRequest("GET", path, options, addApiKey);
      
			return this.parseResponse(response);
		}

		/**
		 * Make a POST request to the given endpoint and return the response
		 *
		 * @param string $path      the path to call on
		 * @param array  $options   the options to call with
		 * @param bool   $addApiKey whether or not to add the api key
		 *
		 * @return array the response object (parsed)
		 */
		private HashMap<string, string> postRequest (string path, HashMap<string, string> options = new HashMap<string, string>(), bool addApiKey) {
			// TODO: Add implementation here.
			return new HashMap<string, string>();
		}

		/**
		 * Parse a response and return an appropriate result
		 *
		 * @param  GLib.Object $response the response from the server
		 *
		 * @throws RequestException
		 * @return array  the response data
		 */
		private HashMap<string, string> parseResponse (GLib.Object response) {
			// TODO: Add implementation here.
			return new HashMap<string, string>();
		}

		/**
		 * Make a GET request to the given endpoint and return the response
		 *
		 * @param string $path      the path to call on
		 * @param array  $options   the options to call with
		 * @param bool   $addApiKey whether or not to add the api key
		 *
		 * @return string url redirected to (or null)
		 */
		private string getRedirect (string path, HashMap<string, string> options = new HashMap<string, string>(), bool addApiKey) {
			// TODO: Add implementation here.
			return "";
		}

		/**
		 * Make a request to the given endpoint and return the response
		 *
		 * @param string $method    the method to call: GET, POST
		 * @param string $path      the path to call on
		 * @param array  $options   the options to call with
		 * @param bool   $addApiKey whether or not to add the api key
		 *
		 * @return GLib.Object the response object (not parsed)
		 */
		private GLib.Object makeRequest (string method, string path, HashMap<string, string> options = new HashMap<string, string>(), bool addApiKey) {
			// TODO: Add implementation here.
			return new GLib.Object();
		}

		/**
		 * Expand the given blogName into a base path for the blog
		 *
		 * @param string $blogName the name of the blog
		 * @param string $ext      the url extension
		 *
		 * @return string the blog base path
		 */
		private string blogPath (string blogName, string ext) {
			string blogUrl = this.blogUrl(blogName);
			
			return "v2/blog/" + blogUrl + ext;
		}

		/**
		 * Get the URL of a blog by name or URL
		 *
		 * @param  string $blogName the name of the blog
		 * @return string the blog URL
		 */
		private string blogUrl (string blogName) {
			if (!blogName.contains(".")) {
				return blogName + ".tumblr.com";
			}
			
			return blogName;
		}
	}
}
