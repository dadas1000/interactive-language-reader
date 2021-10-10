<template>
  <div id="Raw">
    <b-container class="bv-example-row"  id="annotate_rec">
      <b-row>
        <b-col >
          <tiptap/>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
import tiptap from '../components/tiptap.vue'

// import '@recogito/recogito-js/dist/recogito.min.css'
import '@recogito/annotorious/dist/annotorious.min.css'

export default {
  components: { tiptap },
  name: 'Raw'
}
</script>
<style lang="scss">

</style>
