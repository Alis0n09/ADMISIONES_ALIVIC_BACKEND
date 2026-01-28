-- ============================================
-- CONSULTAS SQL PARA DIAGNÓSTICO Y ELIMINACIÓN
-- Tabla: postulaciones
-- ============================================

-- 1. Ver todas las postulaciones con sus IDs
SELECT 
    id_postulacion,
    id_cliente,
    id_carrera,
    periodo_academico,
    fecha_postulacion,
    estado_postulacion
FROM postulaciones
ORDER BY fecha_postulacion DESC;

-- 2. Buscar una postulación específica por ID
-- Reemplaza 'TU_ID_AQUI' con el ID que quieres buscar
SELECT 
    id_postulacion,
    id_cliente,
    id_carrera,
    periodo_academico,
    fecha_postulacion,
    estado_postulacion,
    observaciones
FROM postulaciones
WHERE id_postulacion = '4e5f8b71-82ab-4c7b-acb9-d6b1bd7fe27b';

-- 3. Verificar el formato del UUID (comparar con el ID del frontend)
SELECT 
    id_postulacion,
    id_postulacion::text as id_texto,
    length(id_postulacion::text) as longitud,
    pg_typeof(id_postulacion) as tipo_dato
FROM postulaciones
WHERE id_postulacion::text LIKE '%4e5f8b71%'
LIMIT 5;

-- 4. Ver la estructura de la tabla (columnas y tipos)
SELECT 
    column_name,
    data_type,
    character_maximum_length,
    is_nullable
FROM information_schema.columns
WHERE table_name = 'postulaciones'
ORDER BY ordinal_position;

-- 5. Verificar si existe la postulación con el ID exacto
SELECT 
    CASE 
        WHEN EXISTS (
            SELECT 1 FROM postulaciones 
            WHERE id_postulacion = '4e5f8b71-82ab-4c7b-acb9-d6b1bd7fe27b'
        ) 
        THEN 'EXISTE' 
        ELSE 'NO EXISTE' 
    END as existe_postulacion;

-- 6. Ver todas las postulaciones con formato de UUID legible
SELECT 
    id_postulacion::text,
    id_cliente::text,
    id_carrera::text,
    periodo_academico,
    fecha_postulacion,
    estado_postulacion
FROM postulaciones
ORDER BY fecha_postulacion DESC
LIMIT 10;

-- 7. ELIMINAR una postulación específica (CUIDADO: Esta consulta elimina permanentemente)
-- Reemplaza 'TU_ID_AQUI' con el ID que quieres eliminar
DELETE FROM postulaciones
WHERE id_postulacion = '4e5f8b71-82ab-4c7b-acb9-d6b1bd7fe27b';

-- 8. Verificar relaciones (cliente y carrera) antes de eliminar
SELECT 
    p.id_postulacion,
    p.id_cliente,
    c.nombres || ' ' || c.apellidos as nombre_cliente,
    p.id_carrera,
    ca.nombre as nombre_carrera,
    p.estado_postulacion
FROM postulaciones p
LEFT JOIN clientes c ON p.id_cliente = c.id_cliente
LEFT JOIN carreras ca ON p.id_carrera = ca.id_carrera
WHERE p.id_postulacion = '4e5f8b71-82ab-4c7b-acb9-d6b1bd7fe27b';

-- 9. Contar total de postulaciones
SELECT COUNT(*) as total_postulaciones FROM postulaciones;

-- 10. Ver postulaciones recientes (últimas 5)
SELECT 
    id_postulacion::text,
    periodo_academico,
    fecha_postulacion,
    estado_postulacion
FROM postulaciones
ORDER BY fecha_postulacion DESC
LIMIT 5;
