class Nave{
	var property velocidad //kms*seg
	var direccion //-10,0,10
	var combustible // lts

        method initialize(){
               if (not direccion.between(-10,10){
                   self.error("error de inicializacion")
               }
	method acelerar(cuanto){velocidad = 0.max(velocidad+cuanto).min(100000)}
	method desacelerar(cuanto){velocidad -= 0.max(velocidad-cuanto).min(100000)}
	method irHaciaElSol(){direccion = 10}
	method escaparDelSol(){direccion = -10}
	method ponerseParaleloAlSol(){direccion = 0}
	method acercarseUnPocoAlSol(){direccion = 10.min(direccion+1)}
	method alejarseUnPocoAlSol(){direccion = (-10).max(direccion-1)}
	method prepararViaje(){
		self.cargarCombustible(30000)
		self.acelerar(5000)
	}
	method cargarCombustible(carga){combustible=combustible+carga}
	method descargarCombustible(carga){combustible=combustible-carga}
	method estaTranquila(){return combustible>=4000&&velocidad<=12000}
	method recibirAmenaza(){
		self.escapar()
		self.avisar()
	}
	method escapar()
	method avisar()
	method estaDeRelajo(){
		return self.estaTranquila()
	}
}

class NaveBaliza inherits Nave{
	var color
	var cambioDeColor = false
	
	method cambiarColorDeBaliza(colorNuevo){
		color = colorNuevo
		cambioDeColor=true
	}
	override method prepararViaje(){
		super()
		self.cambiarColorDeBaliza("verde") 
		self.ponerseParaleloAlSol()
	}
	override method estaTranquila(){
		return super()&&color!="rojo"
	}
	override method escapar(){self.irHaciaElSol()}
	override method avisar(){self.cambiarColorDeBaliza("rojo")}
	override method estaDeRelajo(){
		return super()&&!cambioDeColor
	}
}

class NavePasajeros inherits Nave{
	const pasajeros
	var comida
	var bebida
	var racionesServidas=0
	method cargarComida(raciones){comida=comida+raciones}
	method descargarComida(raciones){
		comida-=raciones
		racionesServidas+=raciones
	}
	method cargarBebida(raciones){bebida+=raciones}
	method descargarBebida(raciones){bebida+=raciones}
	override method prepararViaje(){
		super()
		self.cargarComida(4)
		self.cargarBebida(6)
		self.acercarseUnPocoAlSol()
	}
	override method escapar(){self.acelerar(self.velocidad())}
	override method avisar(){
		self.descargarComida(pasajeros)
		self.descargarBebida(pasajeros*2)
	}
	override method estaDeRelajo(){
		return super()&&racionesServidas<50
	}
}	
	
class NaveCombate inherits Nave{	
	var estaInvisible
	var misilesDesplegados
	const mensajes=[]
	
	method ponerseVisible(){estaInvisible = false}
	method ponerseInvisible(){estaInvisible = true}
	method estaInvisible(){return estaInvisible}
	method desplegarMisiles(){misilesDesplegados=true}
	method replegarMisiles(){misilesDesplegados=false}
	method misilesDesplegados(){return misilesDesplegados}
	method emitirMensaje(mensaje){mensajes.add(mensaje)}
	method mensajesEmitidos(){return mensajes}
	method primerMensajeEmitido(){return mensajes.first()}
	method ultimoMensajeEmitido(){return mensajes.last()}
	method esEscueta(){return mensajes.any({m=>m.length()>30})}
	method emitioMensaje(mensaje){mensajes.contains(mensaje)}
	override method prepararViaje(){
		super()
		self.ponerseVisible()
		self.replegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("Saliendo en mision")
	}
	override method estaTranquila(){
		return super()&&!self.misilesDesplegados()
	}
	override method escapar(){
		self.acercarseUnPocoAlSol()
		self.acercarseUnPocoAlSol()
	}
	override method avisar(){self.emitirMensaje("Amenaza recibida")}
	override method estaDeRelajo(){
		return super()&&self.esEscueta()
	}
}

class NaveHopital inherits NavePasajeros{
	var property tienePreparadosQuirofanos
	override method estaTranquila(){
		return super()&&!self.tienePreparadosQuirofanos()
	}
	override method recibirAmenaza(){
		super()
		self.tienePreparadosQuirofanos(true)
	}
}

class NaveSigilosa inherits NaveCombate{
	override method estaTranquila(){
		return super()&&!self.estaInvisible()
	}
	override method recibirAmenaza(){
		super()
		self.desplegarMisiles()
		self.ponerseInvisible()
	}
}
