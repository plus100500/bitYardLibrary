<%--
  Created by IntelliJ IDEA.
  User: root
  Date: 11.02.18
  Time: 18:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Заголовок: ${title}</title>
</head>
<body>
<a href="/">Back to main menu</a>

<br/>
<br/>

<h1>BookList</h1>

    <table>
        <thead>
        <tr>
            <th>id</th>
            <th>Название</th>
            <th>Описание</th>
            <th>Автор</th>
            <th>ISBN</th>
            <th>Дата публикации</th>
            <th>Прочитана</th>
        </tr>
        </thead>
        <tbody>

            <tr>
                <td>${book.id}</td>
                <td>${book.title}</td>
                <td>${book.description}</td>
                <td>${book.author}</td>
                <td>${book.isbn}</td>
                <td>${book.printYear}</td>
                <%--<td>${book.readAlready}</td>--%>
            </tr>

        </tbody>
    </table>

</body>
</html>
