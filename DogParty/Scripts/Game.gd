extends Node


func _ready():
	
	get_tree().connect('network_peer_disconnected', self, '_on_player_disconnected')
	get_tree().connect('server_disconnected', self, '_on_server_disconnected')
	get_tree().connect('connection_failed', self, '_on_connected_failed');
	
	var new_player = preload('res://Prefab/Player.tscn').instance();
	new_player.name = str(get_tree().get_network_unique_id());
	new_player.set_network_master(get_tree().get_network_unique_id());
	get_tree().get_root().add_child(new_player);
	var mat = new_player.get_node("AnimatedSprite").get_material().duplicate(true)
	new_player.get_node("AnimatedSprite").set_material(mat)
	var info = Network.self_data;
	new_player.init(info.name, info.position, false);
	
func _process(delta):
	for peer_id in Network.players:
		#print(Network.players[peer_id].name);
		pass
		
func _on_player_disconnected(id):
	#get_node(str(id)).queue_free()
	pass

func _on_server_disconnected():
	get_tree().disconnect_network_peer(get_tree().get_network_unique_id());
	get_tree().change_scene("res://Scenes/StartMenu.tscn");
	
func _on_connected_failed():
	get_tree().change_scene("res://Scenes/StartMenu.tscn");