This is a wrapper aroung RestKit that enables easy creation requests and handling of responses from the Tumblr v2 API.
The main aim is to make the manager's interface as transparent as possible, so that knowing how the Tumblr's API works
would be sufficient to use the manager.

It requires RestKit 0.10.0.

It currently supports authentication and the following API calls (see the manager's header file for details):
- /user/info
- /user/dashboard
- /blog/{base-hostname}/post (creating posts with type="text" only, for now)
- /blog/{base-hostname}/post/edit (editing posts with type="text" only, for now)
- /blog/{base-hostname}/delete
- /blog/{base-hostname}/info
- /blog/{base-hostname}/followers
- /blog/{base-hostname}/posts
- /blog/{base-hostname}/avatar
