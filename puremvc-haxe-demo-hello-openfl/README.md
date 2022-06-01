# PureMVC Haxe Hello OpenFL

This example app demonstrates how to use [PureMVC](http://puremvc.org/) within an [OpenFL](https://openfl.org/) project. A lonely little blue box appears, moving in a grey room. Interact with it.

Based on [PureMVC ActionScript 3 Demo: HelloFlash (Flash)](https://github.com/PureMVC/puremvc-as3-demo-flash-helloflash)

## Interaction

A lonely little blue box appears, moving in a grey room. Interact with it.

- When it hits a wall it changes direction and shrinks.
- If you grab it and drag it around, diffrently colored boxes trail out going the opposite of the direction you drag.
- The colors are from a short palette of about 5 colors and they cycle.
- If you roll your mouse-wheel all the boxes scale up or down in size depending on the direction you scroll it. (Mac users use the two-finger downswipe to scale up and two-finger upswipe to scale down)
- When the boxes are all tiny, its hard to grab them, so you might scale them all up.
- Catch one and hold on to it. Allow the others to decay in size a bit by bouncing off the walls. Then drag around to emit some, let them decay, etc.
- Scale them up until they all look like a jigging mass of Jello™. Then scroll farther, most wrap around and become small, but some stay large. Let them decay.

## Techniques Illustrated

- Starting the application via the ApplicationFacade
- Sending a Notification to trigger a Startup Command
- Initializing the Model and View from a Command
- Dynamically created View Components and Mediators with unique instance names
- View components communicating with their Mediators
- Mediators communicating with a Proxy
- Use of a Proxy to hold Model data
- Mediators communicating with other Mediators via Notification

## Live demo

A build of the [_puremvc-haxe-demo-hello-openfl_ sample](https://feathersui.com/samples/haxe-openfl/puremvc/puremvc-haxe-demo-hello-openfl/) is hosted on the Feathers UI website, and it may be viewed in any modern web browser.

## Run locally

This project includes an [_project.xml_](https://lime.software/docs/project-files/xml-format/) file that configures all options for [OpenFL](https://openfl.org/). This file makes it easy to build from the command line, and many IDEs can parse this file to configure a Haxe project to use OpenFL.

### Prerequisites

- [Install Haxe 4.0.0 or newer](https://haxe.org/download/)
- Install OpenFL from Haxelib
  ```sh
  haxelib install openfl
  haxelib run openfl setup
  ```

### Command Line

Run the [**openfl**](https://www.openfl.org/learn/haxelib/docs/tools/) tool in your terminal:

```sh
haxelib run openfl test html5
```

In addition to `html5`, other supported targets include `windows`, `mac`, `linux`, `android`, and `ios`. See [Lime Command Line Tools: Basic Commands](https://lime.software/docs/command-line-tools/basic-commands/) for complete details about the available commands.
