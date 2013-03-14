AirSegue
========
1. Clone AirSegue
2. Create new application.
3. Drag AirSegue.xcodeproj into your project
4. Add into Target Dependencies
  AirSegue
5. Add linked frameworks and libraries into Target/Summary:
	GLKit.framework
	OpenGLES.framework
	libAirSegue.a
	libc++.dlyb
6. add header search path into Project settings/Build Settings/Header Search Path
	${path_to_AirSegue}/AirSegue/Headers
7. Coding

7.1 Setup for storyboard:
7.1.1. Add UINavigationController into storyboard
7.1.2. Move startup point to navigation controller
7.1.3. Change UINavigationController class -> ASNavigationController
7.2. Build and run.

xxx. Enjoy.
