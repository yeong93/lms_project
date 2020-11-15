<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<!-- <link href="https://unpkg.com/v-markdown-editor/dist/v-markdown-editor.css" rel="stylesheet">

<script src="https://unpkg.com/v-markdown-editor/dist/v-markdown-editor.min.js" type="text/javascript"></script>

<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/jquery@3.4.1/dist/jquery.slim.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.1/umd/popper.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/vue@2.6.11/dist/vue.min.js"></script>

 -->
 
 <script src="https://cdn.quilljs.com/1.3.4/quill.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue"></script>
<!-- Quill JS Vue -->
<script src="https://cdn.jsdelivr.net/npm/vue-quill-editor@3.0.6/dist/vue-quill-editor.js"></script>
<!-- Include stylesheet -->
<link href="https://cdn.quilljs.com/1.3.4/quill.core.css" rel="stylesheet">
<link href="https://cdn.quilljs.com/1.3.4/quill.snow.css" rel="stylesheet">
<link href="https://cdn.quilljs.com/1.3.4/quill.bubble.css" rel="stylesheet">

<style type="text/css">
	.quill-editor,
.content {
  background-color: white;
}

.editor {
  height: 500px;
}

</style>


<script> 
$(function(){
	init();
	
});

function init(){
	Vue.use(VueQuillEditor)
	var vm=new Vue({
		 el: '#vueapp',
		 data: {
	     message: 'Hi from Vue.',
	     content: '1234',
	     editorOption: {
	        theme: 'snow'
	      }
		 	},
	    methods: {
	      onEditorBlur(quill) {
	        console.log('editor blur!', quill)
	      },
	      onEditorFocus(quill) {
	        console.log('editor focus!', quill)
	      },
	      onEditorReady(quill) {
	        console.log('editor ready!', quill)
	      }
	    },
	    computed: {
	      editor() {
	    	  alert( this.$refs.quillEditor.quill.getText());
	        return this.$refs.quillEditor.quill
	      }
	    },
	    mounted() {
	      console.log('this is quill instance object', this.editor)
	    }
		})
	
	new Vue({
		el: '#testvalue',
		data: {
			value : vm.content 
		}
	});

};


</script>
</head>
<body>
<div id="vueapp"  style="width: 900px;">
  <p>{{ message }}</p>
  <quill-editor
    ref="quillEditor"
    class="editor"
    v-model="content"
    :options="editorOption"
    @blur="onEditorBlur($event)"
    @focus="onEditorFocus($event)"
    @ready="onEditorReady($event)"
  />
  <br>
  <div class="content ql-editor" v-model="content" ></div>
</div>

<div id ="testvalue" >
	<p>{{value}}</p>
	<p></p>
</div>

</body>
</html>