require 'mittsu'
require 'pry'

SCREEN_WIDTH = 1920
SCREEN_HEIGHT = 1080
ASPECT = SCREEN_WIDTH.to_f / SCREEN_HEIGHT.to_f

renderer = Mittsu::OpenGLRenderer.new width: SCREEN_WIDTH, height: SCREEN_HEIGHT, title: 'Hello, World!', antialias: true
renderer.shadow_map_enabled = true
#renderer.set_clear_color(0xf4f, 0.9);

scene = Mittsu::Scene.new

camera = Mittsu::PerspectiveCamera.new(75.0, ASPECT, 0.1, 1000.0)
camera.position = Mittsu::Vector3.new(-20, 20, 30)
camera.look_at(scene.position);

#orbit_control = Mittsu::OrbitControls.new()

box_form = Mittsu::BoxGeometry.new(3, 3, 3, 1, 1, 1)
box_material = Mittsu::MeshBasicMaterial.new(color: 0x0ff)
box = Mittsu::Mesh.new(box_form, box_material)
box.position.z = -10

light = Mittsu::AmbientLight.new(0xffffff)

scene.add(box)
scene.add(light)

i = 0

renderer.window.on_mouse_move do |position|
    box.position.x = ((position.x/SCREEN_WIDTH)*2.0-1.0) * 5.0
    box.position.y = ((position.y/SCREEN_HEIGHT)*-2.0+1.0) * 5.0
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