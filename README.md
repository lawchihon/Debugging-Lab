## Debugging Game for iOS Lab

![Imgur](http://i.imgur.com/oQbQLf9.png)

# Solution:

- [X] Level 1: The dreaded key-value coding compliant error

  - Rename 'finishLevelButton2' to 'finishLevelButton'

- [X] Level 2: Terminating app due to uncaught exception?!?

  - Since NSMakeRange is out of range, make 'NSMakeRange(17, 8)' to 'NSMakeRange(17, 7)'

- [X] Level 3: The Button doesn't work

  - Moving the 'View' before 'Click me to pass!'

- [X] Level 4: Dude, where's my tableView?

  - Add 'self.tableView.reloadData()' in 'loadJSON()'

- [X] Level 5: Why are the descriptions wrong?

  - Add else statement to declare the overview text

- [X] Level 6: AutoLayout

  - Remove the width attribute
