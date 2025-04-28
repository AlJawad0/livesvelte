<script>
    // Define props and state
    let {initialTodos = []} = $props()

    // State for todos and new todo input
    let todos = $state(
        initialTodos.length
            ? [...initialTodos]
            : [
                  {id: 1, text: "Learn Phoenix", completed: true},
                  {id: 2, text: "Learn Svelte", completed: false},
                  {id: 3, text: "Build something awesome", completed: false},
              ]
    )
    let newTodoText = $state("")
    let filter = $state("all") // 'all', 'active', or 'completed'

    // Functions for manipulating todos
    function addTodo() {
        if (newTodoText.trim() === "") return

        const newId = todos.length ? Math.max(...todos.map(t => t.id)) + 1 : 1
        todos = [...todos, {id: newId, text: newTodoText, completed: false}]
        newTodoText = ""
    }

    function toggleTodo(id) {
        todos = todos.map(todo => (todo.id === id ? {...todo, completed: !todo.completed} : todo))
    }

    function deleteTodo(id) {
        todos = todos.filter(todo => todo.id !== id)
    }

    function clearCompleted() {
        todos = todos.filter(todo => !todo.completed)
    }

    function getCompletedCount() {
        return todos.filter(todo => todo.completed).length
    }

    function getRemainingCount() {
        return todos.length - getCompletedCount()
    }

    // Filtered todos based on current filter
    $effect(() => {
        console.log(`Filter changed to: ${filter}`)
    })

    function getFilteredTodos() {
        switch (filter) {
            case "active":
                return todos.filter(todo => !todo.completed)
            case "completed":
                return todos.filter(todo => todo.completed)
            default:
                return todos
        }
    }
</script>

<div class="container mx-auto max-w-md p-4">
    <h1 class="text-2xl font-bold mb-4 text-center">Todo List</h1>

    <div class="mb-6">
        <div class="flex">
            <input
                type="text"
                bind:value={newTodoText}
                placeholder="What needs to be done?"
                class="flex-grow px-3 py-2 border rounded-l focus:outline-none"
                on:keypress={e => e.key === "Enter" && addTodo()}
            />
            <button on:click={addTodo} class="bg-blue-500 text-white px-4 py-2 rounded-r hover:bg-blue-600 transition"> Add </button>
        </div>
    </div>

    <!-- Filter buttons -->
    {#if todos.length > 0}
        <div class="flex justify-center mb-4 space-x-2">
            <button
                class="px-3 py-1 rounded {filter === 'all' ? 'bg-blue-500 text-white' : 'bg-gray-200'}"
                on:click={() => (filter = "all")}
            >
                All
            </button>
            <button
                class="px-3 py-1 rounded {filter === 'active' ? 'bg-blue-500 text-white' : 'bg-gray-200'}"
                on:click={() => (filter = "active")}
            >
                Active
            </button>
            <button
                class="px-3 py-1 rounded {filter === 'completed' ? 'bg-blue-500 text-white' : 'bg-gray-200'}"
                on:click={() => (filter = "completed")}
            >
                Completed
            </button>
        </div>
    {/if}

    <ul class="divide-y">
        {#each getFilteredTodos() as todo (todo.id)}
            <li class="py-3 flex items-center justify-between group">
                <div class="flex items-center">
                    <input type="checkbox" checked={todo.completed} on:change={() => toggleTodo(todo.id)} class="mr-3 h-5 w-5" />
                    <span class={todo.completed ? "line-through text-gray-500" : ""}>
                        {todo.text}
                    </span>
                </div>
                <button
                    on:click={() => deleteTodo(todo.id)}
                    class="opacity-0 group-hover:opacity-100 text-red-500 hover:text-red-700 transition"
                >
                    ✕
                </button>
            </li>
        {:else}
            <li class="py-3 text-center text-gray-500">
                {filter === "all" ? "No todos yet. Add one above!" : filter === "active" ? "No active todos" : "No completed todos"}
            </li>
        {/each}
    </ul>

    {#if todos.length > 0}
        <div class="mt-4 text-sm text-gray-600 flex justify-between items-center">
            <span>{getRemainingCount()} items left</span>

            {#if getCompletedCount() > 0}
                <button class="text-gray-500 hover:text-gray-700 transition" on:click={clearCompleted}> Clear completed </button>
            {/if}
        </div>
    {/if}
</div>

<style>
    input[type="checkbox"] {
        transform: scale(1.2);
        cursor: pointer;
    }

    button {
        cursor: pointer;
    }
</style>
