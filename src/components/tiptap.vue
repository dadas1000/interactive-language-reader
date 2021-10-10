<template>
  <editor-content :editor="editor" />
</template>

<script>
import { Editor, EditorContent } from '@tiptap/vue-2'
import StarterKit from '@tiptap/starter-kit'

export default {
  components: {
    EditorContent
  },

  data () {
    return {
      editor: null
    }
  },

  mounted () {
    this.editor = new Editor({
      content: {
        type: 'doc',
        content: [{
          type: 'paragraph',
          content: [
            { type: 'text', text: 'Lorsque j\'avais six ans j\'ai vu, une fois, une magnifique image, dans un livre sur la Forêt Vierge qui s\'appelait "Histoires Vécues". Ça représentait un serpent boa qui avalait un fauve. Voilà la copie du dessin.\n\nOn disait dans le livre: "Les serpents boas avalent leur proie tout entière, sans la mâcher. Ensuite ils ne peuvent plus bouger et ils dorment pendant les six mois de leur digestion".\n\nJ\'ai alors beaucoup réfléchi sur les aventures de la jungle et, à mon tour, j\'ai réussi, avec un crayon de couleur, à tracer mon premier dessin. Mon dessin numéro 1.' }
          ]
        }]
      },

      onUpdate () {
        const json = this.getJSON()
        console.log(JSON.stringify(json))
      },
      extensions: [
        StarterKit
      ]
    })
  },

  beforeDestroy () {
    this.editor.destroy()
  }
}
</script>
