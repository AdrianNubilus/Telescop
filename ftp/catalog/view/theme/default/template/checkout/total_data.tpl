<?php foreach($totals as $total) { ?>
<tr>
	<td colspan="4" class="price"><b><?php echo $total['title']; ?>:</b></td>
	<td class="total"><?php echo $total['text']; ?></td>
</tr>
	<?php } ?>
