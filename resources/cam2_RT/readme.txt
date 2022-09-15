Resource: Camera2RenderTarget v0.2.4
Author: Ren712
Contact: knoblauch700@o2.pl

This resource adds a possibility to render world from different perspective.
The world textures are drawn in a separate render pass - unlike some earlier
experiments - in the same frame.

I've decided to provide classes instead of exported functions.

Effects:
cam2RTMirror - this class creates a mirror provided it's matrix and mirror size. 
         It reminds of gtasa mirrors, but is drawn in native resolution.
cam2RTScreen - this class creates a screen similar to what is seen in 8-track stadium 
         interior. Required variables are camera matrix, screen matrix and size. 
         Projection is set based on main camera projection parameters. An additional 
         setProjection method is available.
cam2RTImage - same as above, but doesn't create in-world screen. Required
         variables are camera matrix and render target alpha enable.	 

Requirements:
The effects require MRT in shader (works with GFX cards with full dx9 support)

Known issues:
The resource draws only what is seen by camera, doesn't stream in anything outside the 
main viewport. So expect many things to be culled - Mainly small objects or peds outside 
the field of view. It is advised to create this effect only in smaller interiors.
Fog is disabled, most of the shadow textures, stencil shadows, smoke and particles.

Camera2RenderTarget is very experimental - if you see any other issues - please notice me. 
Message me at official mta forums (Ren_712) or send me an e-mail