# achar numeros primos no intervalo 
# selecionado pelo usuário
.data 
	message:
	.asciiz 
	"Informe um numero: "
	
	breakl:
	.asciiz 
	"\n"

.text 
	# interação com o usuário
	li $v0, 4
	la $a0, message 
	syscall 
	
	li $v0, 5 
	syscall
	move $t5, $v0   # move o valor do registrador v0 para t5
	
	li $v0, 4
	la $a0, breakl 
	syscall 
	
	
	# segunda interação com o usuário
	li $v0, 4
	la $a0, message 
	syscall 
	
	li $v0, 5 
	syscall
	move $t2, $v0  # move o valor do registrador v0 para t2
	
	li $t3, 1      # contador t3 recebe 1 (verifica numero de divisores)
	li $t4, 0      # variavel que receberá a soma de contadores
	li $t6, 0      # contabiliza os primos,somados
	while:
		div $t1, $t5, $t3     # divide t1 por t3
		mfhi $t1              # move o resto do registrador HI para t5
		beq $t1, $zero, count # se o resto for zero, vai para o contador
		j pass 
		count:
		    addi $t4, $t4, 1  # soma 1 ao registrador t4
		pass:
		    # ignora
		addi $t3, $t3, 1      # soma 1 ao registrador t3 para correr o loop
		ble $t3, $t5, while   # se t3 for menor ou igual a t5, volta para o loop
		li $t3, 1             # reseta o registrador
				
		ble $t4, 2, sum       # se o contador for menor ou igual a 2, vai para a soma
		j passto
		sum: 
		    add $t6, $t6, $t5 # soma ao registrador t6, o numero primo
		passto:
		# se nao, ignora a condição
		li $t4, 0             # reseta o registrador t4
		addi $t5, $t5, 1      # soma mais 1 ao registrador inicial
		ble $t5, $t2, while   # se t5 for menor que t2, volta ao loop
	
	# exibe a soma
	li $v0, 1
	move $a0, $t6
	syscall
	