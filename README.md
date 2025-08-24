# 📦 Object-to-Camera

**Object-to-Camera** is a lightweight Roblox module that lets developers place 3D objects (Models, Parts, Unions, MeshParts) directly in front of the client’s camera — **without using ViewportFrames or UI objects**.  

---

## ✨ Features
- 🎯 Renders objects in **full resolution** (no viewport compression).  
- ⚡ **Lightweight** and easy to integrate.  
- 🛠️ Supports **Models, Parts, Unions, and MeshParts**.  
- 🎬 Compatible with **Tweens** for smooth animations.  
- 🔄 Simple **activate/deactivate** API for full control.  

---

## 📖 API Reference

### `CameraObject.Init(Object: Instance) → CameraObject?`  
Initializes a new camera object.  
- Accepts: `Model`, `BasePart`, `UnionOperation`, `MeshPart`.  
- Creates an internal **CFrame offset** (defaults to `CFrame.new(0, 0, -5)`, which places the object 5 studs in front of the camera).  
- Returns a `CameraObject` instance or `nil` if the object type is invalid.  

---

### `CameraObject:Activate()`  
Starts updating the object’s position **every frame** (`RenderStepped`).  
- Continuously sets the object’s `CFrame` (or `PrimaryPartCFrame` for models) so it stays in front of the camera at the defined offset.  
- Prevents multiple activations (warns if already active).  

---

### `CameraObject:Deactivate()`  
Stops updating the object’s position.  
- Disconnects the active `RenderStepped` connection.  
- Safe to call multiple times.  

---

⚠️ **Important Usage Note**  
All parts used with **Object-to-Camera** must be:  
- **Anchored** (so they don’t fall due to physics)  
- **CanCollide = false** (so they don’t block or interfere with the player or environment)  

This ensures the module works as intended and keeps objects rendering smoothly in front of the camera.

---

## 📘 Examples

### Place a Part in Front of the Camera
```lua
local CameraObject = require(WhereYouPlacedIt) -- make sure it's a module too!

local part = Instance.new("Part")
part.Size = Vector3.new(2, 2, 2)
part.Anchored = true
part.Parent = workspace

local camObj = CameraObject.Init(part)
-- You can change the position of the part by adding offset using camObj.__Offset.Value
camObj:Activate()

task.wait(5)
camObj:Deactivate()
