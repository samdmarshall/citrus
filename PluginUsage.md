# Using the Citrus Plugin

This plugin works in both `Xcode.app` and command line invocation of via `xcodebuild`. 

---

## Build and Install 
To use the Citrus plugin for Xcode, you must first open the `CitrusPlugin.xcodeproj` file in Xcode and build the target `CitrusPlugin`. This will run a build of `lemon` (in this directory) and copy it into the plugin that is built. This plugin will be automatically installed into `~/Library/Application Support/Developer/Shared/Xcode/Plug-ins/`. Now for this plugin to take effect you must relaunch Xcode. 

---

## Integration
This plugin is forcing Xcode to load additional build rules and file specifications, these will not appear as part of the default set of build rules for a target. However, since they are registered with the system you only have to add a new build rule to the target and select "Lemon source files" from the source type dropdown and "Lemon" from the rule dropdown. Once you have done that this rule gets installed onto the project file, so it is becomes portable.

The citrus plugin expects lemon files to be using the extension `.citrus`. Only files matching this extension will be caught for using this.

### Creating the Build Rule

Step 1: Open project file in Xcode. Select the project file in the file navigator. Select the target that will have lemon file(s) to compile. Select Build Rules. Add a new build rule.

![Step1](/plugin-readme-assets/Step1.png)

Step 2: Now you have created a new custom build rule, you will have to select the types of files it will process and rule to execute on those files

![Step2](/plugin-readme-assets/Step2.png)

Step 3: From the "Processing" dropdown, select "Lemon source files"

![Step3](/plugin-readme-assets/Step3.png)

Step 4: From the "Using" dropdown, select "Lemon"

![Step4](/plugin-readme-assets/Step4.png)

Step 5: You have finished creating the build rule.

![Step5](/plugin-readme-assets/Step5.png)

---

## Troubleshooting



### Loading the plugin with Xcode

##### Unexpected code bundle

This plugin is designed to work with both the `Xcode.app` GUI and being loaded by `xcodebuild` for building from the command line. The first time Xcode loads the plugin you will see this message:

![Unexpected](/plugin-readme-assets/Unexpected.png)

Please press `Load Bundle` to approve it to be used.


##### Plugin Not Loading

To check if the plugin is being loaded or not, look at the console log when you open `Xcode.app` or at the output from when invoking `xcodebuild build` on a target. If you don't see `Loaded CitrusPlugin` followed by a version number, then the plugin is most likely not being loaded by Xcode. Please check the `DVTPlugInCompatibilityUUID` key in Xcode's Info.plist file. You can read the key by using the following command:

	defaults read /Applications/Xcode.app/Contents/Info DVTPlugInCompatibilityUUID

Check the output of this against the array listed under `DVTPlugInCompatibilityUUIDs` in the Info.plist file of the Citrus plugin. If the value from Xcode is not in this array then Xcode will not load the plugin. Append the new value into Citrus' Info.plist file and relaunch Xcode for it to take affect.

### No rule to process file

##### sourcecode.lemon

	Dependency Analysis Warning
	warning: no rule to process file '/Users/Samantha/Desktop/lemon-test/lemon-test/test.citrus' of type sourcecode.lemon for architecture x86_64

This warning message will trigger there is no build rule setup for lemon files. Please see the Integration section for instructions on how to create a new build rule.


##### Any other file type

	Dependency Analysis Warning
	warning: no rule to process file '/Users/Samantha/Desktop/lemon-test/lemon-test/test.citrus' of type text for architecture x86_64

This warning message will trigger if the Citrus plugin isn't installed. To install it please see the "Build and Install" section for instructions.

If the plugin is installed and you still get this error message or the .citrus file is being processed by another rule; you will need to remove the existing file type defintion for the file reference in the project file. To do this, follow these steps:

* quit Xcode.
* open the `project.pbxproj` file that is within the `.xcodeproj` bundle in a text editor
* Find where it says `/* Begin PBXFileReference section */` and then locate the file in question. It should look something like this:

```
	1541C1961BD3F3540060CECC /* test.citrus */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = ...; path = test.citrus; sourceTree = "<group>"; };	
```

* remove the part that says `lastKnownFileType = ...;`
* save the file
* close text editor
* re-open Xcode, perform a clean then build again. If you have the plugin installed the file should now be corrected detected as a lemon source file.
