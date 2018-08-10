# UIRemoteControllerPresentationBug

A sample project showing a bug related to custom UIPresentationControllers and system-provided UIRemoteViewControllers.

Steps to run:
  1. Run the project, which immediately performs a custom presentation of a green controller with custom bounds and rounded corners.
  2. Tap 'Present Over Full Screen', which demonstrates the desired behavior - by setting modalPresentationStyle = .overFullScreen, we can preserve the frame and corners of this green controller.
  3. Dismiss back to the green controller.
  4. Tap 'Present UIActivityViewController' and then select an option like 'Save to Files' which presents a system controller (a _UIRemoteViewController) full screen.
  5. Dismiss the system controller (e.g. hit 'Cancel' from the Save to Files screen). Observe that the green controller has momentarily lost its custom bounds and rounded corners. After a brief pause, it "pops" jarringly back to the correct presentation.

