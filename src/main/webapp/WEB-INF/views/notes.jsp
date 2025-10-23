<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Notes App</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
        }
        h1 {
            color: #333;
        }
        #noteForm {
            display: flex;
            margin-bottom: 20px;
        }
        #noteInput {
            padding: 10px;
            width: 300px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        #addNoteBtn {
            padding: 10px 20px;
            margin-left: 10px;
            border: none;
            background-color: #28a745;
            color: white;
            border-radius: 4px;
            cursor: pointer;
        }
        #addNoteBtn:hover {
            background-color: #218838;
        }
        #notesList {
            list-style: none;
            padding: 0;
            width: 350px;
        }
        .noteItem {
            background-color: white;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 4px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .deleteBtn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 4px;
            cursor: pointer;
        }
        .deleteBtn:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>

<h1>My Notes</h1>

<form id="noteForm">
    <input type="text" id="noteInput" placeholder="Enter a note..." required />
    <button type="submit" id="addNoteBtn">Add Note</button>
</form>

<ul id="notesList"></ul>

<script>
    const noteForm = document.getElementById('noteForm');
    const noteInput = document.getElementById('noteInput');
    const notesList = document.getElementById('notesList');

    // Load saved notes from localStorage
    let notes = JSON.parse(localStorage.getItem('notes')) || [];
    renderNotes();

    // Add new note
    noteForm.addEventListener('submit', function(e) {
        e.preventDefault();
        const noteText = noteInput.value.trim();
        if(noteText) {
            notes.push(noteText);
            localStorage.setItem('notes', JSON.stringify(notes));
            noteInput.value = '';
            renderNotes();
        }
    });

    // Render notes in list
    function renderNotes() {
        notesList.innerHTML = '';
        notes.forEach((note, index) => {
            const li = document.createElement('li');
            li.className = 'noteItem';

            const span = document.createElement('span');
            span.textContent = note; // safer than innerHTML

            const btn = document.createElement('button');
            btn.textContent = 'Delete';
            btn.className = 'deleteBtn';
            btn.addEventListener('click', () => deleteNote(index));

            li.appendChild(span);
            li.appendChild(btn);
            notesList.appendChild(li);
        });
    }

    // Delete a note
    function deleteNote(index) {
        notes.splice(index, 1);
        localStorage.setItem('notes', JSON.stringify(notes));
        renderNotes();
    }
</script>

</body>
</html>
