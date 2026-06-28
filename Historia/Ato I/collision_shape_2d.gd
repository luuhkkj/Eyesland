extends Area2D

# Variável para saber se o Flint está perto do diário
var pode_interagir: bool = false

# Função disparada quando algo entra na área
func _on_body_entered(body: Node2D) -> void:
	# Verifica se quem entrou foi o Flint
	# Dica: Certifique-se de que o nó do jogador se chama "Flint" 
	# ou use body.is_in_group("player") se você usar grupos!
	if body.name == "Flint":
		pode_interagir = true
		# Opcional: Aqui você pode fazer aparecer um ícone "Aperte E" na tela

# Função disparada quando algo sai da área
func _on_body_exited(body: Node2D) -> void:
	if body.name == "Flint":
		pode_interagir = false
		# Opcional: Esconda o ícone "Aperte E"

# Fica escutando os botões que o jogador aperta
func _unhandled_input(event: InputEvent) -> void:
	# Se o Flint estiver na área E o jogador apertar a tecla configurada
	if pode_interagir and event.is_action_pressed("interagir"):
		ler_diario()

# A função que realmente faz a história andar
func ler_diario() -> void:
	print("Flint abriu o diário! A história avança agora.")
	# Aqui você vai chamar a sua tela de texto, atualizar a missão do Flint, etc.

func _on_diariointerativo_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
