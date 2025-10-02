# Actividad-CRUD-de-Usuarios-Prueba-controlada-de-fuerza-bruta-contra-tu-propia-API

Contenido del repositorio
app_sqlite.py
attack.sh

Requisitos
Python 3.8
Git Bash
Paquetes: fastapi, uvicorn[standard].sqlmodel,request

Comandos 
cd (dirrecion de la carpeta del proyecto)
python -m venv venv
.\venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install fastapi "uvicorn[standard]" sqlmodel requests

python -m uvicorn app_sqlite:app --reload

cd "/c/Users/yomar/OneDrive/Documentos/First _term_exam"
sed -i 's/\r$//' attack.sh
chmod +x attack.sh
./attack.sh

Objetivo del experimento
Realizar pruebas de ataques de fuerza bruta para encontrar contraseñas en un ambiente controlado como en este caso el entorno virtual
Comprender los comandos para usar API

Pruebas
<img width="601" height="366" alt="image" src="https://github.com/user-attachments/assets/9b805708-03ec-4842-baa3-debb88912dcb" />

<img width="579" height="369" alt="image" src="https://github.com/user-attachments/assets/95757ee4-1126-426a-a980-0c968e59146f" />

<img width="570" height="367" alt="image" src="https://github.com/user-attachments/assets/1f57cf24-fe5a-4660-9809-948ae1971bd9" />



