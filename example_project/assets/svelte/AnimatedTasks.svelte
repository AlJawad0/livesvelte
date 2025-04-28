<script>
    import {fade, fly, scale} from "svelte/transition"
    import {elasticOut} from "svelte/easing"

    // State for tasks
    let tasks = $state([
        {id: 1, text: "Learn Svelte animations", completed: false},
        {id: 2, text: "Create an animated component", completed: false},
        {id: 3, text: "Share with the team", completed: false},
    ])

    // State for tracking completed tasks for celebration
    let recentlyCompleted = $state(null)
    let confettiActive = $state(false)

    function toggleTask(id) {
        tasks = tasks.map(task => {
            if (task.id === id) {
                // If we're marking as completed, show celebration
                if (!task.completed) {
                    recentlyCompleted = task
                    showConfetti()
                }
                return {...task, completed: !task.completed}
            }
            return task
        })
    }

    function showConfetti() {
        confettiActive = true
        setTimeout(() => {
            confettiActive = false
        }, 2000)
    }

    function addTask(text) {
        const newId = tasks.length ? Math.max(...tasks.map(t => t.id)) + 1 : 1
        tasks = [...tasks, {id: newId, text, completed: false}]
    }

    let newTaskText = $state("")

    function handleAddTask() {
        if (newTaskText.trim()) {
            addTask(newTaskText)
            newTaskText = ""
        }
    }
</script>

<div class="container mx-auto max-w-md p-6 bg-white rounded-lg shadow-lg">
    <h1 class="text-2xl font-bold mb-6 text-center">Animated Tasks</h1>

    <!-- Add task form -->
    <div class="mb-6">
        <div class="flex">
            <input
                type="text"
                bind:value={newTaskText}
                placeholder="Add a new task..."
                class="flex-grow px-3 py-2 border rounded-l focus:outline-none"
                on:keypress={e => e.key === "Enter" && handleAddTask()}
            />
            <button on:click={handleAddTask} class="bg-purple-600 text-white px-4 py-2 rounded-r hover:bg-purple-700 transition">
                Add
            </button>
        </div>
    </div>

    <!-- Tasks list with animations -->
    <ul class="space-y-3">
        {#each tasks as task (task.id)}
            <li
                class="p-3 border rounded-lg transition-all duration-300 flex items-center justify-between"
                class:bg-green-50={task.completed}
                in:fly={{y: 20, duration: 300}}
                out:fade={{duration: 200}}
                animate:flip={{duration: 300}}
            >
                <div class="flex items-center">
                    <input
                        type="checkbox"
                        checked={task.completed}
                        on:change={() => toggleTask(task.id)}
                        class="mr-3 h-5 w-5 text-purple-600 focus:ring-purple-500"
                    />
                    <span class={task.completed ? "line-through text-gray-500" : "text-gray-800"}>
                        {task.text}
                    </span>
                </div>

                {#if task.completed}
                    <span in:scale={{duration: 200, easing: elasticOut}}>
                        <span class="text-green-500 text-xl">✓</span>
                    </span>
                {/if}
            </li>
        {/each}
    </ul>

    <!-- Celebration animation when task completed -->
    {#if confettiActive}
        <div class="fixed inset-0 pointer-events-none flex items-center justify-center">
            <div in:scale={{duration: 500, easing: elasticOut}} class="confetti-container">
                {#each Array(50) as _, i}
                    <div
                        class="confetti"
                        style="
                            --confetti-color: hsl({Math.random() * 360}, 100%, 70%); 
                            --fall-distance: {Math.random() * 100}vh;
                            --fall-delay: {Math.random() * 0.5}s;
                            --fall-speed: {Math.random() * 4 + 2}s;
                            --size: {Math.random() * 0.5 + 0.2}rem;
                            --rotation: {Math.random() * 360}deg;
                            --left-pos: {Math.random() * 100}%;
                        "
                    ></div>
                {/each}
            </div>
        </div>
    {/if}

    <!-- Message when task completed -->
    {#if recentlyCompleted}
        <div class="mt-6 p-4 bg-green-100 text-green-700 rounded-lg text-center" in:fly={{y: 10, duration: 300}} out:fade={{duration: 300}}>
            Great job! You completed: <strong>{recentlyCompleted.text}</strong>
        </div>
    {/if}
</div>

<style>
    /* Animation styles */
    .confetti-container {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        pointer-events: none;
        z-index: 100;
    }

    .confetti {
        position: absolute;
        top: -10px;
        width: var(--size);
        height: var(--size);
        background-color: var(--confetti-color);
        border-radius: 2px;
        left: var(--left-pos);
        opacity: 0;
        transform: rotate(var(--rotation));
        animation: fall var(--fall-speed) var(--fall-delay) forwards;
    }

    @keyframes fall {
        0% {
            opacity: 1;
            top: -10px;
            transform: translateX(0) rotate(var(--rotation));
        }

        50% {
            opacity: 1;
            transform: translateX(20px) rotate(calc(var(--rotation) + 180deg));
        }

        100% {
            opacity: 0;
            top: var(--fall-distance);
            transform: translateX(-20px) rotate(calc(var(--rotation) + 360deg));
        }
    }

    input[type="checkbox"] {
        cursor: pointer;
    }
</style>
