# AuthAuth

Gives you some structure to allow you to authenticate your users and decide whether they are authorized to access specified resources.

---

## Q&A

### Cool stuff. So, in which database is the data stored?

Nothing is stored. State should be handled elsewhere.

### Oh, that seems rather limiting?

Or you could say it would be more limiting to bundle a database. Now you are free to choose whatever storage you'd like. It also keeps the library pure. Well, I guess you could say it keeps the library a library. Teehee! What we want is to stay focused on...

### Okay, yeah, hey, I've looked at the source files and there is not much going on. The feature set is almost zero. Aren't you supposed to provide something more than just some simple structure via basically two functions?

Isn't a low feature set a good thing?

### I thought I was the one asking the questions?

...

### That's right. Now, you're not even encrypting the password! That's absolutely awful! Is this some kind of joke?

...no.

### What is the point then?

I...don't know! I'm...

### Ha! Any last words?

The user of the library is in charge of how user, resources and roles are defined. The only requirements are some Eq instances. The instances can be automatically derived or, if the library user wants both roles and role groups, manually implemented outside of the library. Please see the example in Spec.hs.

