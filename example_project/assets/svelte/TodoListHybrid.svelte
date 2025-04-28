<script>
    /** @type {{initialTodos?: Array<{id: number, text: string, completed: boolean}>}} */
    let {initialTodos = []} = $props()

    // State for new todo input
    let newTodoText = $state("")
    let filter = $state("all") // 'all', 'active', or 'completed'

    // We use the initialTodos directly since we're syncing with the server
    $effect(() => {
        console.log("Todos updated:", initialTodos)
    })

    function addTodo() {
        if (newTodoText.trim() === "") return

        // Send event to LiveView
        window.pushEvent("add_todo", {text: newTodoText})
        newTodoText = ""
    }

    // Filtered todos based on current filter
    function getFilteredTodos() {
        switch (filter) {
            case "active":
                return initialTodos.filter(todo => !todo.completed)
            case "completed":
                return initialTodos.filter(todo => todo.completed)
            default:
                return initialTodos
        }
    }

    function getCompletedCount() {
        return initialTodos.filter(todo => todo.completed).length
    }

    function getRemainingCount() {
        return initialTodos.length - getCompletedCount()
    }
</script>

<div class="container mx-auto max-w-md p-4">
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
    {#if initialTodos.length > 0}
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
                    <input
                        type="checkbox"
                        checked={todo.completed}
                        on:change={() => window.pushEvent("toggle_todo", {id: todo.id})}
                        class="mr-3 h-5 w-5"
                    />
                    <span class={todo.completed ? "line-through text-gray-500" : ""}>
                        {todo.text}
                    </span>
                </div>
                <button
                    on:click={() => window.pushEvent("delete_todo", {id: todo.id})}
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

    {#if initialTodos.length > 0}
        <div class="mt-4 text-sm text-gray-600 flex justify-between items-center">
            <span>{getRemainingCount()} items left</span>

            {#if getCompletedCount() > 0}
                <button class="text-gray-500 hover:text-gray-700 transition" on:click={() => window.pushEvent("clear_completed", {})}>
                    Clear completed
                </button>
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
