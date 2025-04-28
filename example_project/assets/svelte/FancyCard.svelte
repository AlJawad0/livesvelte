<script>
  export let title = "Title";
  export let subtitle = "Subtitle";
  export let image = "https://placehold.co/400x200";
  export let content = "This is a beautiful, reusable card component built with Svelte and styled for high fidelity.";
  import { createEventDispatcher } from "svelte";
  const dispatch = createEventDispatcher();
  function handleClick() {
    dispatch("cardClick", { title, subtitle, image, content });
  }
</script>

<style>
.card {
  border-radius: 1rem;
  box-shadow: 0 4px 32px rgba(0,0,0,0.07), 0 1.5px 4px rgba(0,0,0,0.06);
  background: white;
  overflow: hidden;
  max-width: 400px;
  margin: 1rem auto;
  transition: transform 0.2s, box-shadow 0.2s;
}
.card:hover {
  transform: translateY(-4px) scale(1.02);
  box-shadow: 0 8px 40px rgba(0,0,0,0.13), 0 2px 8px rgba(0,0,0,0.08);
}
.card-img {
  width: 100%;
  object-fit: cover;
  height: 200px;
}
.card-body {
  padding: 1.25rem;
}
.card-title {
  font-size: 1.5rem;
  font-weight: bold;
  margin-bottom: 0.5rem;
}
.card-subtitle {
  color: #888;
  font-size: 1rem;
  margin-bottom: 0.75rem;
}
.card-content {
  color: #333;
  line-height: 1.5;
}
</style>

<div class="card" on:click={handleClick} style="cursor:pointer">
  <img class="card-img" src={image} alt={title} />
  <div class="card-body">
    <div class="card-title">{title}</div>
    <div class="card-subtitle">{subtitle}</div>
    <div class="card-content">{content}</div>
  </div>
</div>
