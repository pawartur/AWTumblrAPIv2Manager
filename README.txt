This is a wrapper aroung RestKit that enables easy creation requests and handling of responses from the Tumblr v2 API.
The main aim is to make the manager's interface as transparent as possible, so that knowing how the Tumblr's API works
would be sufficient to use the manager.

It requires RestKit 0.10.0.

It currently supports (see the manager's header file for details):
- authentication via XAuth!
- /user/info
- /user/dashboard
- /user/likes
- /user/following
- /user/follow
- /user/unfollow
- /user/like
- /user/unlike
- /blog/{base-hostname}/post (creating posts with type "text", "quote", "link" or "photo" only, for now)
- /blog/{base-hostname}/post/reblog
- /blog/{base-hostname}/post/edit (editing posts with type "text", "quote", "link" or "photo" only, for now)
- /blog/{base-hostname}/delete
- /blog/{base-hostname}/info
- /blog/{base-hostname}/followers
- /blog/{base-hostname}/posts
- /blog/{base-hostname}/avatar
