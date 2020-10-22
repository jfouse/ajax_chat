Ajax Chat
---------

An overly simplified AJAX chat app using Rails 4


### Why
Most of my work over the past several years has been rooted in the backend (Rails 3, DevOps, data work, etc).  This is just a little something to explore what's different in Rails 4 as well as dust off the cobwebs on front-end work (jQuery etc) and check out Bootstrap.  N.B. this code is basic.  Little to no thought has been given yet to production-level things like security and performance.

### Current Status
Well, it's not much to look at, that's for sure.  I threw in some Bootstrap divs to make the basic page layout, but there's no contained scrolling window for the message view and I haven't touched any CSS yet.

* On first load, the app will auto-assign a user name
* Current active users are shown
* Non-admins see all new messages from the time of initial page load
* Admins (currently simply denoted by ?admin=true on initial page load) are shown all historical messages as well
* N.B. Current refresh rate on the ajax calls is 5 seconds, mostly so any errors don't fly past too quickly on the server console while I'm watching.  As such, it may take a couple seconds for any action to be reflected on the page.


### To do
* Allow user to change name
* Allow admin to become user mid-session
* Fix message display bug: sometimes a message shows up twice
* Make the pretty (or at least the passably usable)

Don't mind me, just here to break stuff...
