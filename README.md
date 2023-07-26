# ¡Hola! Esto es un pequeño README para aclarar ciertos puntos de la prueba técnica.

### En primer lugar, especificar que:
- He hecho la prueba en ANDROID.
- He dedicado algo más de 12 horas, pues se me iban ocurriendo ideas y no podía parar de experimentar. He preferido forzar un poco los engranajes para crear algo mejor.
- La API Key de OpenAI debe ir a lib/src/config/globals.dart
- La gestión del estado la he hecho con provider, ya que no requería de grandes estructuras de estado más alla de un par o tres de grupos de datos.

Me gustaría dar un pequeño disclaimer por posibles partes con código sucio: he estado experimentando con muchas cosas hechas a mano y pese a que he revisado todo, puede haber quedado algun rastro de suciedad y de cosas mal optimizadas.

### Cosas que quiero comentar:

· A partir de según que momento he pasado a tomarme la prueba más como un experimento y admito que puedo haber dejado ligeramente de lado las buenas prácticas de programación limpia y el afan de mantener la estrucutra impecable. No obstante, soy consciente de la importáncia que tiene. Simplemente, dadas las circumstáncias, he decidido decantar la balanza por dedicar el tiempo a crear sin límites y no obsesionarme con la estructura y los principios de programacion.

· A parte de eso, debido a lo sumergido que he estado en la prueba, no he gastado tiempo en poner demasiados comentarios.

· Las peticiones a la API tardan mucho en responderse. Es como consecuencia del tiempo que le lleva la generación del texto a GPT-4. Sí, he usado éste modelo porque GPT-3 daba respuestas muy erráticas.

· La funcionalidad de escojer entre los dos exploradores no sirve de nada. La idea era que, como GPT-4 tardaba mucho, poner una función que permitiese user GPT-3 con menos espera, pero GPT-3 casi nunca devolvia texto utilizable, así que he optado por que los dos usen GPT-4.
