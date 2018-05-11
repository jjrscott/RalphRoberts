<img src='RalphRoberts/Assets.xcassets/Shield.imageset/Shield.pdf' width='100'>

# Ralph Roberts

RalphRoberts is a small demo app for iOS that displays characters using [Marvel Developer Portal](https://developer.marvel.com) APIs.

## Approach

The general approach taken to this project was to follow [The Rule of Three](https://blog.codinghorror.com/rule-of-three/) as summarised by [Jeff Atwood](https://en.wikipedia.org/wiki/Jeff_Atwood) (although he's describing a relatively old concept). Combined with [Kanban](https://en.wikipedia.org/wiki/Kanban) I have found this to be an extremely effective mechanism for practically improving products while maintaining timely releases.



## Requirements

- Public and private key to the Marvel Developer Portal.
- Xcode 9.3

## Notes

- I downloaded the model schema for `MarvelConnector` manually, but in a full product release, this step must be automated as human's *always* get copy-n-paste + manual fiddling wrong. Also, any data used to generate compiled code MUST still be versioned.
- It appears that using CommonCrypto in Swift is generally considered a pain. However, I found a pretty simple way to solve the issue in a very Xcode friendly way. You can see that solution in the StackOverflow entitled [Importing CommonCrypto in a Swift framework](https://stackoverflow.com/a/50256958/542244).
- Who is Ralph Roberts? [Ralph Roberts](https://en.wikipedia.org/wiki/Cobalt_Man) is a character from the Marvel universe (of course he is). 


## Acknowledgements

- [Importing CommonCrypto in a Swift framework](https://stackoverflow.com/a/42852743/542244) (SO). I posted an improved answer to this question here: [https://stackoverflow.com/a/50256958/542244](https://stackoverflow.com/a/50256958/542244).
- [How to convert Data to hex string in swift](https://stackoverflow.com/a/40089462/542244) (SO).
- [How to get MD5 hash from string in SWIFT and make bridge-header](https://stackoverflow.com/a/40089462/542244) (SO). I posted a solution for Swift 4.1 here: [https://stackoverflow.com/a/50257157/542244].
- The icon is available at [S.H.I.E.L.D. Logo Vector](https://seeklogo.com/vector-logo/257821/s-h-i-e-l-d).

