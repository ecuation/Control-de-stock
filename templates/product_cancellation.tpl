{include file="header.tpl"}
<div class="popup">
	<span class="close-popup" onclick="closePopUp()">x</span>
	{include file="preloader.tpl"}
	<div class="searcher-wrapper">
		<br>
		<p>
			Please, enter product name to search
		</p>
		<input placeholder="search..." type="text" class="autocomplete-ajax" id="input-primary-product"/>

		{if {$hasChildrenCategories} eq "true"} 
		 	<input placeholder="search..." type="text" id="input-secondary-product" class="autocomplete-ajax"/>
		{/if}
	</div>
	<div class="canvas">
		<ul class="category"></ul>
	</div>
</div>
<div class="container">
	<h2>{$cancellation|ucfirst}</h2>
	<form method="post" action="product_cancellation.php?id_category={$smarty.get.id_category}" name="product_form">
		<input type="hidden" name="id_product" id="id_product_target">
		<input type="hidden" name="id_sale_type" value="0">
		<input type="hidden" value="3" id="invoice" name="invoice">
		<input type="hidden" name="id_category" value="{$smarty.get.id_category}">
		<!-- recoge el valor de la id del producto -->
		<span class="icon-tag">&nbsp;</span>
		<span id="primary-trigger">{$product_holder}</span>
		
		<script type="text/javascript" src="js/productClassInit.js"></script>
		<hr>
		<span class="txt-highlight">Qty: </span><input type="number" name="quantity" min="1" max="100" value="1" width="5" id="qty" onchange="calculateAmount();">
		<hr>
		<span class="txt-highlight euro">Price: </span><input type="text" name="price" size="5" id="price" onchange="calculateAmount();">
		<span class="txt-highlight euro">Total: </span><span class="amount"></span>
		<hr>
		<span class="txt-highlight">Type: </span>
		<input type="radio" value="5" name="id_payment_type" id="refund" checked="checked"><label for="refund">{$refund}</label>
		<input type="radio" value="6" name="id_payment_type" id="cancellation"><label for="cancellation">{$cancellation}</label>
		<input type="radio" value="7" name="id_payment_type" id="replacement"><label for="replacement">{$replacement}</label>
		<input type="radio" value="8" name="id_payment_type" id="other"><label for="other">{$other}</label>
		<!--
			5 = refund
			6 = cancellation
			7 = replacement
			4 = other
		-->
		<hr>
		<span class="icon-help"></span><br>
		<span>{$hint_refund}</span><br>
		<span>{$hint_cancellation}</span><br>
		<span>{$hint_replacement}</span>
		<hr>
		<span class="icon-speech-bubble" id="note-trigger"></span>
		<textarea name="note" rows="2" cols="36" maxlength="90" class="txt-alert" placeholder="({$note_holder})"></textarea>
		<hr>
		<script type="text/javascript" src="js/Autocomplete.js"></script>
		<script type="text/javascript">			

			var autocompleteCategory = new Autocomplete();
			autocompleteCategory.setPopupTrigger('#primary-trigger');
			autocompleteCategory.setContainer('.canvas');
			autocompleteCategory.setInputAutocomplete('#input-primary-product');
			autocompleteCategory.setAjaxPath("tools/ajax/AutoComplete.php");
			autocompleteCategory.setPathVars("id_category="+{$smarty.get.id_category}+"&delimiter="+{$smarty.get.delimiter}+"&action=category");
			autocompleteCategory.init();

			autocompleteCategory.onSelect = function (elem, data)
			{
				$('#primary-trigger').html(data.value);
				$('#id_product_target').val(data.id_product);
				$('.popup').hide('normal');	
				$('#qty').val(1);
				$('#price').val(data.price);
				calculateAmount();
			};
		</script>
		<!-- if the parent category has children category this will be showed -->
		{if {$hasChildrenCategories} eq "true"} 
			<a id="secondary-trigger" class="get-related" href="#"> click to add subproduct </a>
			<br>
			<div id="autocomplete-selection"></div>
				
			<script type="text/javascript">
				var autocompleteRelated = new Autocomplete();
				autocompleteRelated.setPopupTrigger('#secondary-trigger');
				autocompleteRelated.setContainer('.canvas');
				autocompleteRelated.setInputAutocomplete('#input-secondary-product');
				autocompleteRelated.setAjaxPath("tools/ajax/AutoComplete.php");
				autocompleteRelated.setPathVars("id_category="+{$smarty.get.id_category}+"&delimiter="+{$smarty.get.delimiter}+"&action=related");
				autocompleteRelated.init();

				autocompleteRelated.onSelect = function (elem, data)
				{
					$('#autocomplete-selection').html(data.value);
					$('#id_product_related').val(data.id_product);
					$('#subproduct_stock').val(data.stock);
					$('.popup').hide('normal');	
				};		
			</script>
		{/if}  
		<br>
		<input type="hidden" name="id_product_related" id="id_product_related">
		<input type="hidden" value="0" name="sub_product_stock" id="subproduct_stock">
		<span class="icon-circle-check"></span><input class="button confirm" type="submit" name="confirm" value="{$confirm}">
		<span class="icon-circle-cross"></span><a href="sale.php" class="button cancel">{$cancel}</a>
		<span class="icomoon-cycle2"></span><a href="http://{$smarty.server.HTTP_HOST}{$smarty.server.REQUEST_URI}" class="button reset">{$reset}</a>
	</form>
	<script type="text/javascript">
		var frmvalidator  = new Validator("product_form");
		  frmvalidator.addValidation("id_product","req","{$productFormMessage}");
		  frmvalidator.addValidation("price","numeric","{$priceFormMessage}");
		  frmvalidator.addValidation("price","req","{$reqPrice}");
		  frmvalidator.addValidation("note","maxlen=150","Note max length is 150");
	</script>
</div>
</div>
<!-- end of wrapper -->
</body>
</html>