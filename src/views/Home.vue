<template>
  <div id="Home">
    <b-container id="save_n_load">
      <input v-on:change="load_txt_file" id="textFileUpload" type="file" hidden>
      <button v-on:click="load_text">Load New Text File</button>
      <input v-on:change="load_project" id="annotationFileUpload" type="file" hidden>
      <button v-on:click="load_anno">Load Project File</button>
      <button v-on:click="save">Save Project File</button>
    </b-container>
    <br>
    <b-container class="bv-example-row"  id="annotate_rec">
      <b-row>
        <b-col sm="8" offset="2" class="editor" id='text'>
          Lorsque j'avais six ans j'ai vu, une fois, une magnifique image, dans un livre sur la Forêt Vierge qui s'appelait "Histoires Vécues".<br> Ça représentait un serpent boa qui avalait un fauve. Voilà la copie du dessin.<br> <br> On disait dans le livre: "Les serpents boas avalent leur proie tout entière, sans la mâcher.<br> Ensuite ils ne peuvent plus bouger et ils dorment pendant les six mois de leur digestion".<br><br> J'ai alors beaucoup réfléchi sur les aventures de la jungle et, à mon tour, j'ai réussi, avec un crayon de couleur, à tracer mon premier dessin. Mon dessin numéro 1.
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>

import { Recogito } from '@recogito/recogito-js'

import '@recogito/recogito-js/dist/recogito.min.css'
// import '@recogito/annotorious/dist/annotorious.min.css'

export default {
  data () {
    return {
      r: ''
    }
  },

  components: { },
  name: 'Home',

  mounted () {
    const ColorSelectorWidget = function (args) {
      // Create Tag element
      var addTag = function (evt) {
        args.onAppendBody({
          type: 'TextualBody',
          purpose: 'highlighting',
          value: evt.target.dataset.tag
        })
      }

      // 4. This part renders the UI elements
      var createButton = function (value) {
        var button = document.createElement('button')
        button.dataset.tag = value
        button.style.backgroundColor = value
        button.addEventListener('click', addTag)
        return button
      }

      var container = document.createElement('div')
      container.className = 'colorselector-widget'

      var button1 = createButton('RED')
      var button2 = createButton('GREEN')
      var button3 = createButton('BLUE')

      container.appendChild(button1)
      container.appendChild(button2)
      container.appendChild(button3)

      return container
    }

    this.r = new Recogito({
      content: document.getElementById('annotate_rec'),
      widgets: ['COMMENT', 'TAG', ColorSelectorWidget]
    })

    // Load sample comments (Not working yet)
    var myAnnotation = {
      '@context': 'http://www.w3.org/ns/anno.jsonld',
      id: 'https://www.example.com/recogito-js-example/foo',
      type: 'Annotation',
      body: [{
        type: 'TextualBody',
        value: 'When'
      }],
      target: {
        selector: [{
          type: 'TextQuoteSelector',
          exact: 'Lorsque'
        }, {
          type: 'TextPositionSelector',
          start: 1,
          end: 8
        }]
      }
    }

    this.r.addAnnotation(myAnnotation)

    // Add an event handler
    this.r.on('createAnnotation', function (annotation, previous) {
      console.log('updated', previous, 'with', annotation)
    })
  },

  methods: {
    save () {
      var projectData = { text: '', annotations: '' }
      projectData.text = document.getElementById('text').innerText
      projectData.annotations = this.r.getAnnotations()
      var dataStr = JSON.stringify(projectData)
      var blob = new Blob([dataStr], { type: 'text/text;charset=utf-8' })
      const link = document.createElement('a')
      link.href = URL.createObjectURL(blob)
      link.download = 'filename.txt'
      link.click()
      URL.revokeObjectURL(link.href)
    },
    load_text () {
      document.getElementById('textFileUpload').click()
    },
    load_txt_file (event) {
      console.log(1)
      const files = event.target.files
      const fileReader = new FileReader()
      fileReader.addEventListener('load', () => {
        var newText = fileReader.result
        try {
          var jsonText = JSON.parse(newText)
          document.getElementById('text').innerText = jsonText.text
        } catch (e) {
          document.getElementById('text').innerText = newText
        }
      })
      fileReader.readAsText(files[0])
    },
    load_anno () {
      document.getElementById('annotationFileUpload').click()
    },
    load_project (event) {
      this.load_txt_file(event)
      this.load_anno_file(event)
    },
    load_anno_file (event) {
      console.log(2)
      const files = event.target.files
      const fileReader = new FileReader()
      fileReader.addEventListener('load', () => {
        var newText = fileReader.result
        var jsonFile = JSON.parse(newText).annotations
        for (const idx in jsonFile) {
          this.r.addAnnotation(jsonFile[idx])
        }
      })
      fileReader.readAsText(files[0])
    }
  }

}
</script>
