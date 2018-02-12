<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%--<%@ taglib uri="http://www.springframework.org/tags/form" prefix="from" %>--%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>


<html>
  <head>
      <style type="text/css">

          .container {
              height: 260px;
          }
          #prodReportTable
          {
              overflow-y:scroll;
              position:absolute;
              height: 240px;
          }
          #myInput {
              /*background-image: url('/css/searchicon.png'); !* Add a search icon to input *!*/
              /*background-position: 10px 12px; !* Position the search icon *!*/
              /*background-repeat: no-repeat; !* Do not repeat the icon image *!*/
              /*width: 100%; !* Full-width *!*/
              font-size: 14px; /* Increase font-size */
              padding: 12px 20px 12px 40px; /* Add some padding */
              border: 1px solid #ddd; /* Add a grey border */
              margin-bottom: 12px; /* Add some space below the input */
          }
          #myInput1 {
              /*background-image: url('/css/searchicon.png'); !* Add a search icon to input *!*/
              /*background-position: 10px 12px; !* Position the search icon *!*/
              /*background-repeat: no-repeat; !* Do not repeat the icon image *!*/
              /*width: 100%; !* Full-width *!*/
              font-size: 14px; /* Increase font-size */
              padding: 12px 20px 12px 40px; /* Add some padding */
              border: 1px solid #ddd; /* Add a grey border */
              margin-bottom: 12px; /* Add some space below the input */
          }
          #myInput2 {
              /*background-image: url('/css/searchicon.png'); !* Add a search icon to input *!*/
              /*background-position: 10px 12px; !* Position the search icon *!*/
              /*background-repeat: no-repeat; !* Do not repeat the icon image *!*/
              /*width: 100%; !* Full-width *!*/
              font-size: 14px; /* Increase font-size */
              padding: 12px 20px 12px 40px; /* Add some padding */
              border: 1px solid #ddd; /* Add a grey border */
              margin-bottom: 12px; /* Add some space below the input */
          }

          #myTable {
              border-collapse: collapse; /* Collapse borders */
              /*width: 100%; !* Full-width *!*/
              border: 1px solid #ddd; /* Add a grey border */
              font-size: 14px; /* Increase font-size */
          }

          #myTable th, #myTable td {
              text-align: left; /* Left-align text */
              padding: 3px; /* Add padding */
          }

          #myTable tr {
              /* Add a bottom border to all table rows */
              border-bottom: 1px solid #ddd;
          }

          #myTable tr.header, #myTable tr:hover {
              /* Add a grey background color to the table header and on hover */
              background-color: #f1f1f1;
          }

      </style>

      <script>
          function myFunction() {
              // Declare variables
              var filter, filter1, filter2, table, tr, td1, td3, td5, i;
              filter = document.getElementById("myInput").value.toUpperCase();
              filter1 = document.getElementById("myInput1").value.toUpperCase();
              filter2 = document.getElementById("myInput2").value.toUpperCase();
              table = document.getElementById("myTable");
              tr = table.getElementsByTagName("tr");

              // Loop through all table rows, and hide those who don't match the search query
              for (i = 0; i < tr.length; i++) {
                  td1 = tr[i].getElementsByTagName("td")[1];
                  td3 = tr[i].getElementsByTagName("td")[3];
                  td5 = tr[i].getElementsByTagName("td")[5];
                  if (td1 || td3 || td5) {
                      if ((td1.innerHTML.toUpperCase().indexOf(filter) > -1) && (td3.innerHTML.toUpperCase().indexOf(filter1) > -1) && (td5.innerHTML.toUpperCase().indexOf(filter2) > -1)) {
                          tr[i].style.display = "";
                      } else {
                          tr[i].style.display = "none";
                      }
                  }
              }
          }
      </script>

    <title>Заголовок: ${title}</title>
  </head>
  <body>
  <a href="/">Back to main menu</a>

  <br/>
  <br/>

  <h1>BookList</h1>
  <input type="text" id="myInput" onkeyup="myFunction()" placeholder="поиск по Названию...">
  <input type="text" id="myInput1" onkeyup="myFunction()" placeholder="поиск по Автору...">
  <input type="text" id="myInput2" onkeyup="myFunction()" placeholder="поиск по Дате Публикации...">

  <c:if test="${!empty bookList}">
      <div class="container">
    <table id="myTable">
        <thead>
            <tr class="header">
                <th width="20">id</th>
                <th width="150">Название</th>
                <th width="200">Описание</th>
                <th width="100">Автор</th>
                <th width="150">ISBN</th>
                <th width="150">Дата публикации</th>
                <th width="100">Прочитана</th>
                <th width="200" colspan="2">Действия</th>
            </tr>
        </thead>

        <tbody id="prodReportTable">

            <c:forEach items="${bookList}" var="book" >
            <tr>
                <td width="20">${book.id}</td>
                <td width="150"><a href="/bookInfo/${book.id}" target="_blank">${book.title}</a></td>
                <td width="200">${book.description}</td>
                <td width="100">${book.author}</td>
                <td width="150">${book.isbn}</td>
                <td width="150">${book.printYear}</td>
                <td width="100">${book.readAlready}</td>
                <td width="100"><a href="<c:url value='/edit/${book.id}'/>">Редактировать</a></td>
                <td width="100"><a href="<c:url value='/remove/${book.id}'/>">Удалить</a></td>
            </tr>
            </c:forEach>
        </tbody>

    </table>
      </div>
  </c:if>

  <h1>AddBook</h1>

  <c:url var="addAction" value="/books/add"/>

  <form:form action="${addAction}" commandName="newBook">
      <table>
          <c:if test="${!empty newBook.title}">
              <tr>
                  <td>
                      <form:label path="id">
                          <spring:message text="ID"/>
                      </form:label>
                  </td>
                  <td>
                      <form:input path="id" readonly="true" size="8" disabled="true"/>
                      <form:hidden path="id"/>
                  </td>
              </tr>
          </c:if>
              <tr>
                  <td>
                      <form:label path="title">
                          <spring:message text="Название"/>
                      </form:label>
                  </td>
                  <td>
                      <form:input path="title"/>
                  </td>
              </tr>
          <tr>
              <td>
                  <form:label path="description">
                      <spring:message text="Описание"/>
                  </form:label>
              </td>
              <td>
                  <form:input path="description"/>
              </td>
          </tr>

              <tr>
                  <td>
                      <form:label path="author">
                          <spring:message text="Автор"/>
                      </form:label>
                  </td>
                  <td>
                      <c:if test="${!empty newBook.author}">
                      <form:input path="author" disabled="true"/>
                      </c:if>
                      <c:if test="${empty newBook.author}">
                          <form:input path="author"/>
                      </c:if>
                  </td>
              </tr>

              <tr>
                  <td>
                      <form:label path="isbn">
                          <spring:message text="ISBN"/>
                      </form:label>
                  </td>
                  <td>
                      <form:input path="isbn"/>
                  </td>
              </tr>
              <tr>
                  <td>
                      <form:label path="printYear">
                          <spring:message text="Дата публикации"/>
                      </form:label>
                  </td>
                  <td>
                      <form:input path="printYear"/>
                  </td>
              </tr>
          <tr>
              <td colspan="2">
                  <c:if test="${!empty newBook.title}">
                      <input type="submit"
                             value="<spring:message text="Редактировать книгу"/>"/>
                  </c:if>
                  <c:if test="${empty newBook.title}">
                      <input type="submit"
                             value="<spring:message text="Добавить книгу"/>"/>
                  </c:if>
              </td>
          </tr>
      </table>
  </form:form>
  </body>
</html>
