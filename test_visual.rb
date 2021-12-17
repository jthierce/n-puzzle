require 'mittsu'
require 'pry'
require_relative 'piece.rb'

SCREEN_WIDTH = 1920
SCREEN_HEIGHT = 1080
ASPECT = SCREEN_WIDTH.to_f / SCREEN_HEIGHT.to_f
X_AXIS = Mittsu::Vector3.new(1.0, 0.0, 0.0)
Y_AXIS = Mittsu::Vector3.new(0.0, 1.0, 0.0)

mouse_delta = Mittsu::Vector2.new
last_mouse_position = Mittsu::Vector2.new

renderer = Mittsu::OpenGLRenderer.new width: SCREEN_WIDTH, height: SCREEN_HEIGHT, title: 'Hello, World!', antialias: true
renderer.shadow_map_enabled = true
#renderer.set_clear_color(0xf4f, 0.9);

scene = Mittsu::Scene.new

camera = Mittsu::PerspectiveCamera.new(75.0, ASPECT, 0.1, 1000.0)
camera.position = Mittsu::Vector3.new(-20, 20, 30)
camera.look_at(scene.position)

camera_container = Mittsu::Object3D.new
camera_container.add(camera)

#orbit_control = Mittsu::OrbitControls.new()

box_form = Mittsu::BoxGeometry.new(3, 3, 3)
box_material = Mittsu::MeshBasicMaterial.new(color: 0x0ff)
box = Mittsu::Mesh.new(box_form, box_material)

light = Mittsu::AmbientLight.new(0xffffff)

# Create all piece and adding in the scene

pieces = Piece.create_piece

pieces.each do |key, piece|
  scene.add(piece)
end

face_up = Mittsu::Object3D.new
face_down = Mittsu::Object3D.new
face_right = Mittsu::Object3D.new
face_left = Mittsu::Object3D.new
face_front = Mittsu::Object3D.new
face_back = Mittsu::Object3D.new

face_up.add(pieces[:corner_wgr])
face_up.add(pieces[:corner_wog])
face_up.add(pieces[:corner_wbo])
face_up.add(pieces[:corner_wrb])

scene.add(face_up)
scene.add(light)
scene.add(camera_container)

i = 0

renderer.window.on_scroll do |offset|
  scroll_factor = (1.5 ** (offset.y * 0.1))
  camera.zoom *= scroll_factor
  camera.update_projection_matrix
end

renderer.window.on_mouse_button_pressed do |button, position|
  if button == GLFW_MOUSE_BUTTON_LEFT
    last_mouse_position.copy(position)
  else button == GLFW_MOUSE_BUTTON_RIGHT
    face_up.position.x += 3
  end
end

renderer.window.on_mouse_move do |position|
  if renderer.window.mouse_button_down?(GLFW_MOUSE_BUTTON_LEFT)
    mouse_delta.copy(last_mouse_position).sub(position)
    last_mouse_position.copy(position)

    camera_container.rotate_on_axis(Y_AXIS, mouse_delta.x * 0.01)
    camera_container.rotate_on_axis(X_AXIS, mouse_delta.y * 0.01)
  end
end

renderer.window.on_resize do |width, height|
  renderer.set_viewport(0, 0, width, height)
  camera.aspect = width.to_f / height.to_f
  camera.update_projection_matrix
end

renderer.window.run do
    renderer.render(scene, camera)
    # if i == 0
    #     i = 1
    #     box.position.z += 2
    # else
    #     i = 0
    #     box.position.z -= 2
    # end
    # box.rotation.z += 0.01
    # box.rotation.y += 0.01
    # sleep 1
end