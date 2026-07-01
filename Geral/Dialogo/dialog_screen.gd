extends CanvasLayer

var _step: float = 0.05
var _id: int = 0
var data: Dictionary = {}

@export_category("Objects")
@export var _name: Label = null
@export var _dialog: RichTextLabel = null
@export var _faceset: TextureRect = null
@onready var choices_container = $Background/HContainer/vContainer/ChoicesContainer

func _ready() -> void:
	hide()
	#_initialize_dialog()
	pass

func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_accept") and _dialog.visible_ratio < 1:
		_step = 0.01
		return

	_step = 0.05
	if Input.is_action_just_pressed("ui_accept"):
		if not data.has(_id):
			hide()
			return
			
		# Trava das escolhas
		if data[_id].has("choices"):
			return
			
		# NOVA TRAVA: Se a fala estiver marcada com "end", esconde e encerra.
		if data[_id].has("end") and data[_id]["end"] == true:
			hide()
			return
			
		# Avança normalmente
		_id += 1
		
		if not data.has(_id):
			hide()
			return
			
		_initialize_dialog()
		

func _initialize_dialog() -> void:
	_name.text = data[_id]["title"]
	_dialog.text = data[_id]["dialog"]
	# 1. Define o texto na caixa
	$Background/HContainer/vContainer/Dialog.text = data[_id]["dialog"]
	
	# 2. ESCONDE todas as letras imediatamente antes de qualquer coisa
	$Background/HContainer/vContainer/Dialog.visible_characters = 0
	
	# 3. Cria a animação (Tween) para mostrar letra por letra
	var tween = create_tween()
	var velocidade_da_letra = 0.03 # Quanto menor o número, mais rápido digita
	var quantidade_de_letras = $Background/HContainer/vContainer/Dialog.text.length()
	var tempo_total = velocidade_da_letra * quantidade_de_letras
	
	# Faz a propriedade "visible_characters" ir de 0 até o total de letras
	tween.tween_property($Background/HContainer/vContainer/Dialog, "visible_characters", quantidade_de_letras, tempo_total)
	_faceset.texture = load(data[_id]["faceset"])
	


	# 1. Limpa os botões de escolhas anteriores
	for child in choices_container.get_children():
		child.queue_free()

	# 2. Verifica se a fala atual tem "choices" (escolhas) e cria os botões
	if data[_id].has("choices"):
		for choice in data[_id]["choices"]:
			print("Criando um botão de escolha!")
			var btn = Button.new()
			btn.text = choice["text"]
	# Conecta o clique do botão à função que avança o diálogo
			btn.add_theme_font_size_override("font_size", 10)
			btn.pressed.connect(_on_choice_selected.bind(choice["next_id"]))
			choices_container.add_child(btn)

		_dialog.visible_characters = 0
		while _dialog.visible_ratio < 1:
			await get_tree().create_timer(_step).timeout
			_dialog.visible_characters += 1
			
func _on_choice_selected(next_id: int) -> void:
	_id = next_id
	_initialize_dialog()	
