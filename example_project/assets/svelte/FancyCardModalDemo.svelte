<script>
  import FancyCard from "./FancyCard.svelte";
  let showModal = false;
  let modalData = {};

  function handleCardClick(event) {
    modalData = event.detail;
    showModal = true;
  }

  function closeModal() {
    showModal = false;
  }
</script>

<div class="flex flex-col items-center gap-8">
  <FancyCard
    title="Reusable Svelte Card"
    subtitle="Powered by LiveSvelte"
    image="https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80"
    content="This card is rendered as a Svelte component, seamlessly integrated with Phoenix LiveView via LiveSvelte. You can reuse this component anywhere!"
    on:cardClick={handleCardClick}
  />
  <FancyCard
    title="Another Card"
    subtitle="With different props!"
    image="https://placehold.co/400x200/EEE/31343C"
    content="You can pass different props to reuse the component in various contexts."
    on:cardClick={handleCardClick}
  />
</div>

{#if showModal}
  <div class="modal-overlay" on:click={closeModal}>
    <div class="modal-content" on:click|stopPropagation>
      <button class="modal-close" on:click={closeModal}>×</button>
      <img src={modalData.image} alt={modalData.title} class="modal-img" />
      <h2 class="modal-title">{modalData.title}</h2>
      <h3 class="modal-subtitle">{modalData.subtitle}</h3>
      <p class="modal-text">{modalData.content}</p>
    </div>
  </div>
{/if}

<style>
.modal-overlay {
  position: fixed;
  top: 0; left: 0; right: 0; bottom: 0;
  background: rgba(0,0,0,0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
}
.modal-content {
  background: #fff;
  border-radius: 1rem;
  padding: 2rem;
  position: relative;
  max-width: 420px;
  width: 100%;
  text-align: center;
  box-shadow: 0 8px 40px rgba(0,0,0,0.13), 0 2px 8px rgba(0,0,0,0.08);
  animation: popup 0.2s cubic-bezier(.4,2,.6,1) both;
}
@keyframes popup {
  from { transform: scale(0.8); opacity: 0; }
  to { transform: scale(1); opacity: 1; }
}
.modal-close {
  position: absolute;
  top: 1rem;
  right: 1rem;
  background: transparent;
  border: none;
  font-size: 2rem;
  cursor: pointer;
  color: #888;
}
.modal-img {
  width: 100%;
  border-radius: 0.5rem;
  margin-bottom: 1rem;
  object-fit: cover;
  max-height: 200px;
}
.modal-title {
  font-size: 1.5rem;
  font-weight: bold;
  margin-bottom: 0.5rem;
}
.modal-subtitle {
  color: #888;
  font-size: 1rem;
  margin-bottom: 0.75rem;
}
.modal-text {
  color: #333;
  line-height: 1.5;
}
</style>
