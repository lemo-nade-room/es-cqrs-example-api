package import EXEvent
package import EXReadModel

package func projectTodoCreatedToTodoList(
    previous: TodoList?,
    event: TodoEvent.Created
) -> TodoList {
    var todoList: TodoList = previous ?? .init(items: [])

    let newTodo = TodoList.Item(
        id: event.aid.uuid,
        title: event.title,
        description: event.description
    )

    todoList.items.append(newTodo)

    return todoList
}
