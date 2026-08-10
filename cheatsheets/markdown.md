# Markdown Cheatsheet

## 1. Encabezados (Headings)

**Codigo:**

```text
# Heading 1
## Heading 2
### Heading 3
#### Heading 4
##### Heading 5
###### Heading 6
```

**Visualización:**

# Heading 1

## Heading 2

### Heading 3

#### Heading 4

##### Heading 5

###### Heading 6

## 2. Formato de texto

**Código:**

```text
**Bold**

_Italic_

*Italic 2*

~~Strikethrough~~
```

**Visualización:**

**Bold**

_Italic_

_Italic 2_

~~Strikethrough~~

## 3. Listas

### 3.1 Listas con viñetas (Bullets)

**Código:**

```text
- Bullet Item 1
- Bullet Item 2
    - Nested Item
- Bullet Item 3
```

**Visualización:**

- Bullet Item 1
- Bullet Item 2
    - Nested Item
- Bullet Item 3

### 3.2 Listas numeradas (Ordered)

**Código:**

```text
1. Number one
2. Number two
3. Number three
```

**Visualización:**

1. Number one
2. Number two
3. Number three

## 4. Enlaces

#### 4.1 Enlace externo

**Código:**

```text
[Link Text](https://google.com)
```

**Visualización:**

[Link Text](https://google.com)

#### 4.2 Enlace externo con tooltip personalizado

**Código:**

```text
[Link Text](https://google.com "Tooltip :D")
```

**Visualización:**

[Link Text](https://google.com "Tooltip :D")

## 5. Código

### 5.1 Código en línea

**Código:**

```text
`Inline code`
```

**Visualización:**

`Inline code`

### 5.2 Bloques de código

En GitHub, puedes usar cualquier lenguaje que Rouge/Linguist

**Código python:**

````text
```python
    print('Hola Mundo')
```
````

**Visualización:**

```python
print('Hola Mundo')
```

---

**Código javascript:**

````text
```javascript
    console.log("Hola Mundo");
```
````

**Visualización:**

```javascript
console.log("Hola Mundo");
```

---

**Código java:**

````text
```java
    System.out.println("Hola Mundo");
```
````

**Visualización:**

```java
System.out.println("Hola Mundo");
```

## 6. Citas

**Código:**

```text
> This is a quote
```

**Visualización:**

> This is a quote

## 7. Tablas

**Código:**

```text
| Column 1 | Column 2 |
| -------- | -------- |
| Item A   | Item B   |
| Item C   | Item D   |
```

**Visualización:**

| Column 1 | Column 2 |
| -------- | -------- |
| Item A   | Item B   |
| Item C   | Item D   |

## 8. Separadores

**Código:**

```text
---
```

**Visualización:**

---

## 9. Imágenes

La imagen debe estar en la misma carpeta o usar una URL.

**Código:**

```text
![Alt text](image.jpg)
```

**Visualización:**

![Alt text](image.jpg)

## 10. Errores comunes

- Olvidar el espacio después de #
- No dejar línea en blanco antes/después de listas
- Mezclar tabs y espacios en listas anidadas
