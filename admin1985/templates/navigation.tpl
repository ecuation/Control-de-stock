
<nav>
    <ul id="breadcrumb">
        {foreach from=$navigator item=page_name key=num}
            {if {$num} eq  {$navigator|@count-1}}
                <li><a class="lastcrumb" href="../{$page_name}{if $page_name neq 'admin1985'}.php{/if}">{${$page_name}}</a></li>
            {else}
                <li><a href="../{$page_name}{if $page_name neq 'admin1985'}.php{/if}">{${$page_name}}</a></li>
            {/if}         
        {/foreach}
        <li>{${$current_page}}</li>
    </ul>
</nav>