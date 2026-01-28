# Configuración de Correo para Recuperación de Contraseña

## Requisitos

Para que el sistema pueda enviar correos de recuperación de contraseña, necesitas configurar las siguientes variables de entorno en tu archivo `.env`:

```env
MAIL_USER=tu_correo@gmail.com
MAIL_PASS=tu_contraseña_de_aplicacion
FRONTEND_URL=http://localhost:5173
```

## Configuración para Gmail

### Paso 1: Habilitar Verificación en 2 Pasos

1. Ve a tu [Cuenta de Google](https://myaccount.google.com/)
2. Selecciona **Seguridad**
3. En "Iniciar sesión en Google", activa **Verificación en 2 pasos** (si no está activada)

### Paso 2: Crear una Contraseña de Aplicación

1. En la misma página de Seguridad, busca **Contraseñas de aplicaciones**
2. O ve directamente a: https://myaccount.google.com/apppasswords
3. Selecciona la aplicación: **Correo**
4. Selecciona el dispositivo: **Otro (nombre personalizado)**
5. Escribe: "CRM Admisiones UTE"
6. Haz clic en **Generar**
7. **Copia la contraseña de 16 caracteres** que aparece (sin espacios)

### Paso 3: Configurar en el .env

```env
MAIL_USER=tu_correo@gmail.com
MAIL_PASS=abcd efgh ijkl mnop  # La contraseña de aplicación de 16 caracteres (sin espacios)
FRONTEND_URL=http://localhost:5173  # Ajusta según tu frontend
```

**⚠️ IMPORTANTE:**
- NO uses tu contraseña normal de Gmail
- Usa SOLO la contraseña de aplicación generada
- La contraseña de aplicación no tiene espacios (si aparece con espacios, quítalos)

## Verificación

Una vez configurado, cuando solicites recuperación de contraseña:

1. El servidor verificará la conexión con Gmail
2. Si hay errores, verás mensajes específicos en la consola del servidor
3. Si todo está bien, recibirás el correo en la bandeja de entrada (o spam)

## Solución de Problemas

### Error: "Error de autenticación"
- Verifica que `MAIL_PASS` sea una contraseña de aplicación, no tu contraseña normal
- Asegúrate de que la verificación en 2 pasos esté activada

### Error: "No se pudo enviar el correo"
- Verifica tu conexión a internet
- Revisa los logs del servidor para más detalles
- Asegúrate de que `MAIL_USER` y `MAIL_PASS` estén correctamente configurados

### El correo no llega
- Revisa la carpeta de spam
- Verifica que el correo de destino sea válido
- Revisa los logs del servidor para confirmar que se envió

## Logs de Depuración

El sistema ahora incluye logs detallados:
- ✅ Mensajes de éxito cuando el correo se envía
- ❌ Mensajes de error con detalles específicos
- ⚠️ Advertencias cuando la configuración está incompleta

Revisa la consola del servidor para ver estos mensajes.
