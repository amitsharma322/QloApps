{**
* NOTICE OF LICENSE
*
* This source file is subject to the Open Software License version 3.0
* that is bundled with this package in the file LICENSE.md
* It is also available through the world-wide-web at this URL:
* https://opensource.org/license/osl-3-0-php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to support@qloapps.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade this module to a newer
* versions in the future. If you wish to customize this module for your needs
* please refer to https://store.webkul.com/customisation-guidelines for more information.
*
* @author Webkul IN
* @copyright Since 2010 Webkul
* @license https://opensource.org/license/osl-3-0-php Open Software License version 3.0
*}

{if isset($product->id)}
	<div id="product-configuration" class="panel product-tab">
		<input type="hidden" name="submitted_tabs[]" value="Configuration" />
		<h3 class="tab"> <i class="icon-AdminAdmin"></i> {l s='Rooms'}</h3>

		<input type="hidden" id="checkConfSubmit" value="0" name="checkConfSubmit">

		<div class="from-group room-wrapper clearfix">
			<div class="rooms-list-body">
				{if isset($smarty.post.rooms_info) && is_array($smarty.post.rooms_info) && count($smarty.post.rooms_info) && !isset($bulk_delete_rooms)}
					{assign var="rooms_info" value=$smarty.post.rooms_info}
				{elseif isset($htl_room_info) && is_array($htl_room_info) && count($htl_room_info)}
					{assign var="rooms_info" value=$htl_room_info}
				{/if}
				{if isset($rooms_info) && is_array($rooms_info) && count($rooms_info)}
					{foreach from=$rooms_info key=key item=room_info}
						{assign var="var_name_room_info" value="rooms_info[`$key`]"}
						<div class="room-card room_data_values" data-row-index="{$key}" {if isset($room_info['id'])}data-id-room="{$room_info['id']}"{/if}>

							{* booked-dates kept for View Bookings modal *}
							{if isset($room_info['booked_dates']) && json_decode($room_info['booked_dates'])}
								<input type="hidden" class="booked-dates" value='{$room_info['booked_dates']|escape:'html':'UTF-8'}'>
							{/if}

							<div class="card-row">
								<div class="room-selection">
									<input type="checkbox" {if isset($room_info['id'])}value="{$room_info['id']}"{else}disabled{/if} name="selected_room_ids[]">
								</div>
								<div class="room-cell-grid">

									{* Room No — Housekeeping Status as extra-information *}
									<div class="room-field-col">
										<div class="padding-20">
											<span class="room-field-label">{l s='Room No.'}</span>
											<div class="room-field-value">{$room_info['room_num']|escape:'html':'UTF-8'}</div>
										</div>
										<div class="extra-information hook-column padding-20">
											<span class="room-field-label">{l s='Housekeeping Status'}</span>
											<div class="room-field-value room-status-badge
												{if $room_info['id_status'] == $rm_status['STATUS_ACTIVE']['id']}status-active
												{elseif $room_info['id_status'] == $rm_status['STATUS_INACTIVE']['id']}status-inactive
												{elseif $room_info['id_status'] == $rm_status['STATUS_TEMPORARY_INACTIVE']['id']}status-temp-inactive
												{/if}">
												{foreach from=$rm_status item=rs}{if $room_info['id_status'] == $rs['id']}{$rs['status']|upper}{/if}{/foreach}
											</div>
											{if isset($room_info['id'])}
												{hook h='displayHotelRoomListTableRowColumn' index=$key id_room=$room_info['id']}
											{else}
												{hook h='displayHotelRoomListTableRowColumn' index=$key}
											{/if}
										</div>
									</div>

									{* Room Name *}
									<div class="room-field-col">
										<div class="padding-20">
											<span class="room-field-label">{l s='Room Name'}</span>
											<div class="room-field-value">{$room_info['room_num']|escape:'html':'UTF-8'}</div>
										</div>
										<div class="extra-information padding-20">
                                            <span class="room-field-label">{l s='Guest'}</span>
											<div class="room-field-value room-status-badge">
                                                {$room_info['adults']|intval} {l s='Adults'}, {$room_info['children']|intval} {l s='Children'}
											</div>
                                        </div>
									</div>

									{* Floor *}
									<div class="room-field-col">
										<div class="padding-20">
											<span class="room-field-label">{l s='Floor'}</span>
											<div class="room-field-value">{$room_info['floor']|escape:'html':'UTF-8'}</div>
										</div>
										<div class="extra-information padding-20"></div>
									</div>

									{* Status *}
									<div class="room-field-col">
										<div class="padding-20">
											<span class="room-field-label">{l s='Status'}</span>
											<div class="room-field-value room-status-badge
												{if $room_info['id_status'] == $rm_status['STATUS_ACTIVE']['id']}status-active
												{elseif $room_info['id_status'] == $rm_status['STATUS_INACTIVE']['id']}status-inactive
												{elseif $room_info['id_status'] == $rm_status['STATUS_TEMPORARY_INACTIVE']['id']}status-temp-inactive
												{/if}">
												{foreach from=$rm_status item=rs}{if $room_info['id_status'] == $rs['id']}{$rs['status']|upper}{/if}{/foreach}
											</div>
										</div>
										<div class="extra-information padding-20"></div>
									</div>

									{* Disable Dates *}
									<div class="room-field-col">
										<div class="padding-20">
											<span class="room-field-label">{l s='Disable Dates'}</span>
											<div class="dates-wrap">
												<a class="btn btn-default btn-sm deactiveDatesModal "
												   data-toggle="modal" data-target="#deactiveDatesModal"
												   data-id-room="{if isset($room_info['id'])}{$room_info['id']}{/if}">
													{if $room_info['id_status'] != $rm_status['STATUS_TEMPORARY_INACTIVE']['id']}{l s='Add Dates'}{else}{l s='View Dates'}{/if}
												</a>

											</div>
										</div>
										<div class="extra-information padding-20"></div>
									</div>

									{* Remarks *}
									<div class="room-field-col">
										<div class="padding-20">
											<span class="room-field-label">{l s='Remarks'}</span>
											<div class="room-field-value">
												{if isset($room_info['comment']) && $room_info['comment'] != ''}{$room_info['comment']|escape:'html':'UTF-8'}{else}&mdash;{/if}
											</div>
										</div>
										<div class="extra-information padding-20"></div>
									</div>

								</div>

								{* Action *}
								<div class="col-action">
									<span class="room-field-label">{l s='Action'}</span>
									{if isset($room_info['id'])}
										<div class="btn-group">
											<button type="button" class="btn btn-default btn-sm btn-edit-room">
												<i class="icon-pencil"></i> {l s='Edit'}
											</button>
											<button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
												<span class="caret"></span>
											</button>
											<ul class="dropdown-menu dropdown-menu-right">
												{if isset($room_info['booked_dates']) && json_decode($room_info['booked_dates'])}
													<li>
														<a href="#" class="view_htl_room" data-toggle="modal" data-target="#room-dates-modal" data-id-room="{$room_info['id']}">
															<i class="icon-info"></i> {l s='View Bookings'}
														</a>
													</li>
												{/if}
												<li>
													<a href="#" class="rm_htl_room" data-id-htl-info="{$room_info['id']}">
														<i class="icon-trash"></i> {l s='Delete'}
													</a>
												</li>
											</ul>
										</div>
									{else}
										<div class="btn-group">
											<button type="button" class="btn btn-default btn-sm btn-edit-room">
												<i class="icon-pencil"></i> {l s='Edit'}
											</button>
											<button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
												<span class="caret"></span>
											</button>
											<ul class="dropdown-menu dropdown-menu-right">
												<li>
													<a href="#" class="remove-rooms-button">
														<i class="icon-trash"></i> {l s='Delete'}
													</a>
												</li>
											</ul>
										</div>
									{/if}
								</div>
							</div>

						</div>
					{/foreach}
				{else}
					<div class="alert alert-info">{l s='No rooms have been added yet.'}</div>
				{/if}
			</div>
			<div class="form-group">
				<div class="col-sm-12">
                    <div class="btn-group rooms_bulk_actions dropup">
                        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                            {l s='Bulk actions'}
                            <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="#" id="select-all-rooms">
                                    <i class="icon-check-sign"></i>&nbsp;{l s='Select all'}
                                </a>
                            </li>
                            <li>
                                <a href="#" id="unselect-all-rooms">
                                    <i class="icon-check-empty"></i>&nbsp;{l s='Unselect all'}
                                </a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a href="#" id="bulk-update-rooms-button" class="bulkUpdateRoomModal" data-toggle="modal" data-target="#bulkUpdateRoomModal" type="button" data-size="s" data-style="expand-right" disabled>
                                    <i class="icon-edit"></i>&nbsp;{l s='Update selection'}
                                </a>
                            </li>
                            <li>
                                <a href="#" id="bulk-delete-rooms-button">
                                    <i class="icon-trash"></i>&nbsp;{l s='Delete selection'}
                                </a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a id="bulk-create-rooms-button" class="bulkCreateRoomModal" data-toggle="modal" data-target="#bulkCreateRoomModal" type="button" data-size="s" data-style="expand-right">
                                    <i class="icon-plus"></i>&nbsp;{l s='Create Rooms'}
                                </a>
                            </li>
                        </ul>
                    </div>
					<button id="add-more-rooms-button" class="btn btn-default" type="button" data-size="s" data-style="expand-right">
						<i class="icon icon-plus"></i>
						{l s='Add More Rooms'}
					</button>
				</div>
			</div>
		</div>
		<div class="panel-footer">
			<a href="{$link->getAdminLink('AdminProducts')|escape:'html':'UTF-8'}{if isset($smarty.request.page) && $smarty.request.page > 1}&amp;submitFilterproduct={$smarty.request.page|intval}{/if}" class="btn btn-default">
				<i class="process-icon-cancel"></i>
				{l s='Cancel'}
			</a>
			<button type="submit" name="submitAddproduct" class="btn btn-default pull-right checkConfigurationClick" disabled="disabled">
				<i class="process-icon-loading"></i>
				{l s='Save'}
			</button>
			<button type="submit" name="submitAddproductAndStay" class="btn btn-default pull-right checkConfigurationClick"  disabled="disabled">
				<i class="process-icon-loading"></i>
					{l s='Save and stay'}
			</button>
		</div>
	</div>

{*Disable Dates Model*}
<div class="modal fade" id="deactiveDatesModal" tabindex="-1" role="dialog" aria-labelledby="deactiveDatesLabel">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
                <div class="modal-title">
                    <div class="row">
                        <div class="disable_dates_title"><i class="icon-calendar"></i>&nbsp; {l s='Disable Dates'} <span class="disable_dates_room_num"></span></div>
                        <div class="pull-right">
                            <button type="submit" class="btn btn-success add_disable_dates"><i class="icon-plus-circle"></i> {l s='Add Dates'}</button>
                            <button type="submit" class="btn btn-danger remove_disable_dates"><i class="icon-trash"></i> {l s='Remove Dates'}</button>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </div>
                </div>
			</div>
			<div class="modal-body">
                <div class="text-left messages-wrap" style="display: none;"></div>
                <div class="text-left room_not_found" style="display: none;">
                    <div class="alert alert-warning">
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                        <ul class="list-unstyled">
                            <li>{l s='Please save this room first to add dates.'}</li>
                        </ul>
                    </div>
                </div>
                <div id="disable_dates_form" class="panel" hidden>
                    <input type="hidden" class="id_disable_date">
                    <input type="hidden" class="id_calendar_event">
                    <div class="panel-heading col-xs-12">
                        <div class="disable_dates_form_title disable_dates_form_title_add"><i class="icon-plus-circle"></i> {l s='Add Dates'}</div>
                        <div class="disable_dates_form_title disable_dates_form_title_update"><i class="icon-pencil"></i> {l s='Update Dates'}</div>
                        <div class="disable_dates_form_title disable_dates_form_title_delete"><i class="icon-trash"></i> {l s='Remove Dates'}</div>
                    </div>
                    <div class="panel-content">
                        <div class="row form-group">
                            <div class="col-sm-6 date_from_container">
                                <label class="control-label" for="disable_date_from">
                                    <span>{l s='Date From'}</span>
                                </label>
                                <div>
                                    <div class="input-group">
                                        <input type="text" class="form-control disable_date_from" name="disable_date_from" value="" readonly>
                                        <div class="input-group-addon"><i class="icon-calendar"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 date_to_container">
                                <label class="control-label" for="disable_date_to">
                                    <span>{l s='Date To'}</span>
                                </label>
                                <div>
                                    <div class="input-group">
                                        <input type="textarea" class="form-control disable_date_to" name="disable_date_to" value="" readonly>
                                        <div class="input-group-addon"><i class="icon-calendar"></i></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row form-group">
                            <div class="col-xs-12">
                                <label class="control-label" for="room_disable_reason">
                                    <span>{l s='Reason'}</span>
                                </label>
                                <div class="input-group col-xs-12">
                                    <textarea class="form-control room_disable_reason" name="room_disable_reason" value=""></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-6">
                                <button type="button" class="btn btn-default pull-left close_disable_dates_form">{l s='Close'}</button>
                            </div>
                            <div class="col-xs-6">
                                <button type="button" class="btn btn-primary pull-right submit_add_disable_date">{l s='Submit'}</button>
                                <button type="button" class="btn btn-primary pull-right submit_remove_disable_date">{l s='Remove'}</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="disable_dates_full_calendar"></div>
			</div>
		</div>
	</div>
</div>
{*END*}

<div class="modal fade modal-right" id="bulkUpdateRoomModal" tabindex="-1" role="dialog" aria-labelledby="bulkUpdateRoomLabel">
	<div class="modal-dialog modal-dialog-right" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close margin-right-10" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title"><i class="icon-calendar"></i>&nbsp; {l s='Bulk Update Rooms'}</h4>
			</div>
			<div class="modal-body padding-top-20">
				<div class="text-left errors-wrap" style="display: none;"></div>
                <div class="form-group">
                    <label class="room-edit-label control-label col-xs-4">
                        <span>{l s='Floor'}</span>
                    </label>
                    <div class="col-xs-8">
                        <input type="text" name="bulk_update_room_floor"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="room-edit-label control-label col-xs-4">
                        <span>{l s='Status'}</span>
                    </label>
                    <div class="col-xs-8">
                        <select class="form-control bulk_update_room_status" name="bulk_update_room_status">
                            {foreach from=$rm_status item=room_stauts}
                                <option value="{$room_stauts['id']}">{$room_stauts['status']|escape:'htmlall':'UTF-8'}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="room-edit-label control-label col-xs-4">
                        <span>{l s='Remark'}</span>
                    </label>
                    <div class="col-xs-8">
                        <input type="text" name="bulk_update_room_comment"/>
                    </div>
                </div>
				<div class="from-group table-responsive-row clearfix" style="display:none;">
                    <div class="rooms-disable-dates-title">{l s='Disable Dates'}</div>
                    <table class="table rooms-disable-dates">
                        <thead>
                            <tr class="nodrag nodrop">
                                <th class="col-sm-1 center">
                                    <div>{l s='Date From'}</span>
                                </th>
                                <th class="col-sm-2 center">
                                    <span>{l s='Date To'}</span>
                                </th>
                                <th class="col-sm-2 center">
                                    <span>{l s='Reason'}</span>
                                </th>
                                <th class="col-sm-1 center"></th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                    <div class="form-group add_disable_date_row_container">
                        <div class="col-sm-12">
                            <a href="#" class="add_bulk_room_update_disable_date btn btn-default">
                                <i class="icon icon-plus"></i>
                                <span>{l s="Add More"}</span>
                            </a>
                        </div>
                    </div>
			    </div>
		    </div>
            <div class="modal-footer modal-footer-right">
                <button type="button" class="btn btn-default" name="submitBulkUpdateRooms" id="saveRoomAndClose">
                    <i class="process-icon-save"></i>
                    {l s='Submit'}
                </button>
            </div>
	    </div>
	</div>
</div>

<div class="modal fade modal-right" id="bulkCreateRoomModal" tabindex="-1" role="dialog" aria-labelledby="bulkCreateRoomLabel">
	<div class="modal-dialog modal-dialog-right" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close margin-right-10" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title"><i class="icon-calendar"></i>&nbsp; {l s='Bulk Create Rooms'}</h4>
			</div>
			<div class="modal-body padding-top-20">
				<div class="text-left errors-wrap" style="display: none;"></div>
                <div class="form-group">
                    <label class="room-edit-label control-label col-xs-4">
                        <span>{l s='Room prefix'}</span>
                    </label>
                    <div class="col-xs-8">
                        <input type="text" name="bulk_create_room_prefix"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="room-edit-label control-label col-xs-4">
                        <span>{l s='Starting Room No.'}</span>
                    </label>
                    <div class="col-xs-8">
                        <input type="text" name="bulk_create_room_num"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="room-edit-label control-label required col-xs-4">
                        <span>{l s='Number of Rooms'}</span>
                    </label>
                    <div class="col-xs-8">
                        <input type="text" name="bulk_create_room_qty"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="room-edit-label control-label col-xs-4">
                        <span>{l s='Floor'}</span>
                    </label>
                    <div class="col-xs-8">
                        <input type="text" name="bulk_create_room_floor"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="room-edit-label control-label col-xs-4">
                        <span>
                            {l s='Status'}
                        </span>
                    </label>
                    <div class="col-xs-8">
                        <select class="form-control bulk_create_room_status" name="bulk_create_room_status">
                            {foreach from=$rm_status item=room_stauts}
                                <option value="{$room_stauts['id']}">{$room_stauts['status']|escape:'htmlall':'UTF-8'}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="room-edit-label control-label col-xs-4">
                        <span>
                            {l s='Remarks'}
                        </span>
                    </label>
                    <div class="col-xs-8">
                        <input type="text" name="bulk_create_room_comment"/>
                    </div>
                </div>
				<div class="from-group table-responsive-row clearfix" style="display:none;">
                    <div class="rooms-disable-dates-title">{l s='Disable Dates'}</div>
                    <table class="table rooms-disable-dates">
                        <thead>
                            <tr class="nodrag nodrop">
                                <th class="col-sm-1 center">
                                    <div>{l s='Date From'}</span>
                                </th>
                                <th class="col-sm-2 center">
                                    <span>{l s='Date To'}</span>
                                </th>
                                <th class="col-sm-2 center">
                                    <span>{l s='Reason'}</span>
                                </th>
                                <th class="col-sm-1 center"></th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                    <div class="form-group add_disable_date_row_container">
                        <div class="col-sm-12">
                            <a href="#" class="add_bulk_room_create_disable_date btn btn-default">
                                <i class="icon icon-plus"></i>
                                <span>{l s="Add More"}</span>
                            </a>
                        </div>
                    </div>
			    </div>
		    </div>
            <div class="modal-footer modal-footer-right">
                <button type="button" name="submitBulkCreateRooms"  id="saveRoomAndClose" class="btn btn-default pull-right checkConfigurationClick">
                    <i class="process-icon-save"></i>
                    {l s='Submit'}
                </button>
            </div>
	    </div>
	</div>
</div>

<div class="modal fade modal-right" id="room-dates-modal" tabindex="-1" role="dialog" aria-labelledby="">
    <div class="modal-dialog modal-dialog-right" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close margin-right-10" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title"><i class="icon-calendar"></i>&nbsp; {l s='Upcoming bookings'}</h4>
            </div>
            <div class="room-booked-dates-table modal-body">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th><span>{l s='Order'}</span></th>
                                <th><span>{l s='Date From'}</span></th>
                                <th><span>{l s='Date To'}</span></th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer modal-footer-right">
                <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="Close">{l s='Done'}</button>
            </div>
        </div>
    </div>
</div>

{* ── Room Add / Edit Modal ── *}
<div class="modal fade modal-right" id="roomModal" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-dialog-right" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="roomModalTitle"></h4>
			</div>
			<div class="modal-body">
				<input type="hidden" id="rm_modal_row_index">
				<input type="hidden" id="rm_modal_mode">
				<input type="hidden" id="rm_id_room">
				<input type="hidden" id="rm_id_product" value="{if isset($product->id)}{$product->id|intval}{/if}">
				<div class="rm-modal-error alert alert-danger" style="display:none;"></div>
				<div class="form-horizontal rm-form">
					<div class="form-group room-edit-group">
						<label class="room-edit-label required col-xs-4 control-label">{l s='Room No'}</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="rm_num" placeholder="{l s='e.g. 101'}">
						</div>
					</div>
					<div class="form-group room-edit-group rm-edit-only">
						<label class="room-edit-label col-xs-4 control-label">{l s='Room Name'}</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="rm_name" placeholder="{l s='Room name'}">
						</div>
					</div>
					<div class="form-group room-edit-group">
						<label class="room-edit-label col-xs-4 control-label">{l s='Floor'}</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="rm_floor" placeholder="{l s='e.g. First Floor'}">
						</div>
					</div>
					<div class="form-group room-edit-group">
						<label class="room-edit-label col-xs-4 control-label">{l s='Status'}</label>
						<div class="col-xs-8">
							<select class="form-control" id="rm_status_sel">
								{foreach from=$rm_status item=rs}
									<option value="{$rs['id']}">{$rs['status']|escape:'html':'UTF-8'}</option>
								{/foreach}
							</select>
						</div>
					</div>
					<div class="form-group room-edit-group rm-edit-only">
						<label class="room-edit-label col-xs-4 control-label">{l s='Disable Dates'}</label>
						<div class="col-xs-8">
							<button type="button" class="btn btn-default btn-sm open-edit-disable-dates">
								<i class="icon-calendar"></i> {l s='Manage Dates'}
							</button>
						</div>
					</div>
					<div class="form-group room-edit-group">
						<label class="room-edit-label col-xs-4 control-label">{l s='Remarks'}</label>
						<div class="col-xs-8">
							<textarea class="form-control" id="rm_comment" rows="3" placeholder="{l s='Optional remarks'}"></textarea>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer modal-footer-right">
                <button type="button" name="submitAddproduct" id="saveRoomAndStay" class="btn btn-default pull-right checkConfigurationClick">
                    <i class="process-icon-save"></i>
                    {l s='Save'}
                </button>
                <button type="button" name="submitAddproductAndStay"  id="saveRoomAndClose" class="btn btn-default pull-right checkConfigurationClick">
                    <i class="process-icon-save"></i>
                    {l s='Save and stay'}
                </button>
			</div>
		</div>
	</div>
</div>

<div class="hidden">
    <div id="tooltip_info_block">
        <div class="tooltip_container tooltip_info_block">
            <div class="tooltip_title"></div>
            <div class="tooltip_content">
                <div class="row col-xs-6">
                    <div class="tooltip_label">{l s='Duration'} </div>
                    <div>
                        <span class="tooltip_date_from"></span> - <span class="tooltip_date_to"></span>
                    </div>
                </div>
                <div class="row col-xs-6">
                    <div class="tooltip_label">{l s='Disabled on'} </div>
                    <span class="tooltip_date_add"></span>
                </div>
                <div class="row col-xs-12 id_event"><div class="tooltip_label">{l s='Event Id'} </div><span class="tooltip_id_event"></span></div>
                <div><div class="tooltip_label tooltip_reason_container col-xs-12">{l s='Reason'}</div><span class="tooltip_reason col-xs-12"></span></div>
            </div>
        </div>
    </div>
    <div id="tooltip_action_block">
        <div class="tooltip_container tooltip_action_block">
            <div class="tooltip_title">{l s='Select Action'}
                <button type="button" class="close margin-right-10" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="tooltip_content">
                <ul class="disable_dates_actions">
                    <li class="enable_selected_dates btn btn-default">
                        <span class="enable_selected_dates">
                            <i class="icon-check"></i>
                            {l s='Make Room Available'}
                        </span>
                    </li>
                    <li class="disabled_selected_dates btn btn-default">
                        <span class="disabled_selected_dates">
                            <i class="icon-ban"></i>
                            {l s='Disable Room'}
                        </span>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

<style>
	/* Hotel Room Cards Layout */
	.room-wrapper { margin-top: 10px; }
	.rooms-list-body { margin-bottom: 10px; border: 1px solid #F2F2F2; }
	.room-card {
		background: #FFFFFF;
		border-bottom: 1px solid #EAEDEF;
		transition: box-shadow 0.15s ease;
	}
	.room-card:hover { box-shadow: 0 1px 5px rgba(0,0,0,0.08); }
	.card-row {
		display: flex;
		align-items: stretch;
		flex-wrap: nowrap;
        padding: 12px 0px;
	}
	.room-selection {
		width: 34px;
		flex-shrink: 0;
		display: flex;
		align-items: flex-start;
		padding: 18px 0 0 12px;
	}
	.room-cell-grid {
		display: flex;
		flex: 1;
		flex-wrap: wrap;
		align-items: stretch;
	}
	.room-field-col {
		flex: 1;
		min-width: 130px;
		display: flex;
		flex-direction: column;
	}
	.room-field-col:last-child { border-right: none; }
	.padding-20 { padding: 10px 1px 6px 16px; }

	.hook-column { min-height: 36px; }
	.room-field-label {
		display: block;
		color: #555555;
		margin-bottom: 5px;
		font-family: Inter;
		font-weight: 400;
		font-size: 12px;
		line-height: 100%;
		letter-spacing: 0px;
	}
	.room-field-value {
		font-family: Inter;
		font-weight: 600;
		font-size: 12px;
		line-height: 24px;
		letter-spacing: 0px;
		color: #555555;
	}
	/* Status badge colors */
	.room-status-badge {
		display: inline-block;
		font-size: 12px;
		font-weight: 700;
		letter-spacing: 0.3px;
	}
	.room-status-badge.status-active   { color: #00a65a; }
	.room-status-badge.status-inactive { color: #EF4444; }
	.room-status-badge.status-temp-inactive { color: #f39c12; }
	.col-action {
		width: 130px;
		flex-shrink: 0;
		padding: 14px 10px;
	}
	.dates-wrap { display: flex; align-items: center; gap: 6px; padding: 2px 0; }
	.dates-wrap .btn-sm { padding: 3px 8px; font-size: 12px; }
	.dates-info-icon { color: #5bc0de; cursor: pointer; font-size: 15px; }
	.col-action .btn-group .btn-sm { padding: 3px 8px; font-size: 12px; }
	@media (max-width: 992px) {
		.card-row { flex-wrap: wrap; }
		.room-cell-grid { flex-direction: column; }
		.room-field-col { min-width: 100%; border-right: none; border-bottom: 1px solid #F0F0F0; }
		.col-action { width: 100%; border-left: none; border-top: 1px solid #F0F0F0; padding: 10px; }
	}

	.modal-right .modal-dialog.modal-dialog-right {
		position: fixed;
		right: 0;
		top: 0;
		bottom: 0;
		margin: 0;
		width: 480px;
		max-width: 100%;
		height: 100%;
		transform: translateX(100%);
		transition: transform 0.25s ease-out;
	}
	.modal-right.in .modal-dialog.modal-dialog-right {
		transform: translateX(0);
	}
	.modal-right .modal-content {
		height: 100%;
		border-radius: 0;
		border: none;
		box-shadow: -4px 0 20px rgba(0,0,0,0.12);
		display: flex;
		flex-direction: column;
	}
	.modal-right .modal-header {
		border-bottom: 1px solid #EAEDEF;
		padding: 16px 20px;
		flex-shrink: 0;
	}
	.modal-right .modal-header .close {
		margin-top: 0;
		font-size: 20px;
		opacity: 0.6;
	}
	.modal-right .modal-header .close:hover { opacity: 1; }
	.modal-right .modal-title {
		font-size: 15px;
		font-weight: 600;
		color: #333;
	}
	.modal-right .modal-body {
		flex: 1;
		overflow-y: auto;
		padding: 20px;
	}
	.modal-right .modal-backdrop {
		background: rgba(0,0,0,0.3);
	}
	.modal-right label.required:before {
		content: none;
	}
	.modal-right label.required:after {
		content: "*";
		color: red;
		font-size: 14px;
		position: relative;
		line-height: 12px;
	}
	.rm-form.form-horizontal { margin: 0; }
	.room-edit-group { margin-bottom: 14px; }
	.room-edit-group:last-child { margin-bottom: 0; }
	.room-edit-label {
        font-family: Inter;
        font-weight: 400;
        font-style: Regular;
        font-size: 14px;
        line-height: 100%;
        letter-spacing: 0px;
        text-align: left!important;
	}
	.room-edit-group .form-control {
		border-radius: 4px;
		border-color: #DCDFE6;
		font-size: 13px;
		color: #333;
		height: 34px;
	}
	.room-edit-group textarea.form-control { height: auto; }
	.room-edit-group .form-control:focus {
		border-color: #5b9bd5;
		box-shadow: 0 0 0 2px rgba(91,155,213,0.15);
	}
	.modal-footer-right {
		border-top: 1px solid #EAEDEF;
		padding: 12px 20px;
		display: flex;
		justify-content: flex-end;
		gap: 8px;
		flex-shrink: 0;
	}
	.modal-footer-right .btn { min-width: 80px; }
</style>

<script>
    var prod_link = "{$link->getAdminLink('AdminProducts')}";
    var rm_status = {$rm_status|@json_encode};
    var confirmText = "{l s='Are you sure?' js=1}";
    var removeDisableDateText = "{l s='Are you sure you want to remove the selected date range?' js=1}";
    var currentRoomRow = 0;
    $(document).ready(function() {
        var tooltipCounter = 0;
        var disableDatesCounter = {};
        // Setting the Date object without current time.
        const dateToday = new Date("{date('Y-m-d')}");
        {literal}
        $('#room-dates-modal').on('show.bs.modal', function(e) {
            const triggerRoom = $(e.relatedTarget);
            $('#room-dates-modal tbody').html('');
            var bookedDates = JSON.parse($(triggerRoom).closest('.room_data_values').find('.booked-dates').val());
            if (bookedDates.length) {
                if (bookedDates.length) {
                    $('#room-dates-modal .room-booked-dates-table').show();
                    $(bookedDates).each(function() {
                        $('#room-dates-modal .room-booked-dates-table tbody').append(`<tr>
                            <td><a href="{/literal}{$link->getAdminLink('AdminOrders')|escape:'html':'UTF-8'}{literal}&vieworder&id_order=${this.id_order}" target="_blank">#${this.id_order}</a></td>
                            <td>${this.date_from_formatted}</td>
                            <td>${this.date_to_formatted}</td>
                        </tr>`);
                    });
                }
            } else {
                $('#room-dates-modal .room-booked-dates-table tbody').append(`<tr>
                    <td colspan="3" class="center">{/literal}{l s='No Booking for this room'}{literal}</td>
                </tr>`);
            }
        });
        {/literal}


        // delete room
        $('.rm_htl_room').on('click',function(e) {
            e.preventDefault();
            var $current = $(this);
            var id_htl_info = $(this).attr('data-id-htl-info');
            $.ajax({
                url: prod_link,
                type: 'POST',
                dataType: 'JSON',
                data: {
                    ajax:true,
                    action:'deleteHotelRoom',
                    id: id_htl_info,
                },
                success: function (response) {
                    if (response.success) {
                        showSuccessMessage("{l s='Removed successfully'}");
                        $current.closest(".room_data_values").remove();
                    } else {
                        if (response.errors)
                        showErrorMessage(response.errors);
                    }
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    showErrorMessage("{l s='Some error occurred'}");
                }
            });
        });

        $(".checkConfigurationClick").on("click", function() {
            $("#checkConfSubmit").val(1);
            return true;
        });

        // remove room row
        $(document).on('click', '.remove-rooms-button', function(e) {
            e.preventDefault();
            $(this).closest('.room_data_values').remove();
            $('#product-configuration .rooms-list-body .room_data_values').each(function(iOuter, card) {
                $(card).attr('data-row-index', iOuter);
                $(card).find('input, select').each(function (iInner, inputField) {
                    let fieldName = $(inputField).attr('name');
                    fieldName = fieldName.replace(/[0-9]+/, iOuter)
                    $(inputField).attr('name', fieldName);
                });
            });
        });

        // on changing the room status as disabled for some date range
        $(document).on('change', '.room_status', function(){
            var status_val = $(this).val();
            if (status_val == rm_status.STATUS_TEMPORARY_INACTIVE.id) {
                $(this).closest('.room_data_values').find('.deactiveDatesModal').removeClass('disabled');
            } else {
                $(this).closest('.room_data_values').find('.deactiveDatesModal').addClass('disabled');
            }
        });

        // Initializing datepicker for date from for the disable dates calendar
        $('#disable_dates_form .date_from_container').datepicker({
            showOtherMonths: true,
            dateFormat: 'yy-mm-dd',
            minDate: 0,
            onSelect: function(selectedDate) {
                let objDateToMin = $.datepicker.parseDate('yy-mm-dd', selectedDate);
                $(this).find('.disable_date_from').val(selectedDate);
                objDateToMin.setDate(objDateToMin.getDate());

                $(this).closest('#disable_dates_form').find('.date_to_container').datepicker('option', 'minDate', objDateToMin);
                var dateTo = $(this).closest('#disable_dates_form').find('.disable_date_to').val();
                $(this).find('.ui-datepicker').hide();
                if (!dateTo || (dateTo && selectedDate > dateTo)) {
                    $('#disable_dates_form .disable_date_to').val($.datepicker.formatDate('yy-mm-dd', objDateToMin));
                    $('#disable_dates_form .date_to_container').datepicker("setDate", $.datepicker.formatDate('yy-mm-dd', objDateToMin));
                    $('#disable_dates_form .date_to_container').find('.ui-datepicker').show();
                }
            }
        });

        // Initializing datepicker for date to for the disable dates calendar
        $('#disable_dates_form .date_to_container').datepicker({
            showOtherMonths: true,
            dateFormat: 'yy-mm-dd',
            minDate: 0,
            beforeShow: function (input, instance) {
                let dateFrom = $(this).closest('#disable_dates_form').find('.disable_date_from').val();

                let objDateToMin = null;
                if (typeof dateFrom != 'undefined' && dateFrom != '') {
                    objDateToMin = $.datepicker.parseDate('yy-mm-dd', dateFrom);
                } else {
                    objDateToMin = new Date();
                }

                objDateToMin.setDate(objDateToMin.getDate() + 1);
                $(this).datepicker('option', 'minDate', objDateToMin);
                $(this).datepicker("setDate", objDateToMin);
            },
            onSelect: function(selectedDate) {
                $(this).find('.disable_date_to').val(selectedDate);
                $(this).find('.ui-datepicker').hide();
            }
        });

        // Since the datepickers are mounted on to the container instead of the input fields, we are handeling the date picker hide and show events.
        $(document).on('focus', '#disable_dates_form .disable_date_from, #disable_dates_form .disable_date_to', function() {
            if ($(this).hasClass('disable_date_from')) {
                $('#disable_dates_form .date_to_container').find('.ui-datepicker').hide();
                $('#disable_dates_form .date_from_container').find('.ui-datepicker').show();
            } else if ($(this).hasClass('disable_date_to')) {
                $('#disable_dates_form .date_to_container').find('.ui-datepicker').show();
                $('#disable_dates_form .date_from_container').find('.ui-datepicker').hide();
            }
        });

        // Handeling the date picker hide and show events for the click events.
        $('#disable_dates_form').on('focus click', function(e) {
            if (!$(e.target).closest('.date_from_container, .date_to_container').length
                && ($(e.target).hasClass('disable_date_from') || $(e.target).hasClass('disable_date_to'))
            ) {
                $('#disable_dates_form .ui-datepicker').hide();
            } else {
                if ($(e.target).hasClass('disable_date_from')) {
                    $('#disable_dates_form .date_to_container').find('.ui-datepicker').hide();
                    $('#disable_dates_form .date_from_container').find('.ui-datepicker').show();
                } else if ($(e.target).hasClass('disable_date_to')) {
                    $('#disable_dates_form .date_to_container').find('.ui-datepicker').show();
                    $('#disable_dates_form .date_from_container').find('.ui-datepicker').hide();
                } else if (!$(e.target).parents('.ui-datepicker').length
                    && (!$(e.target).hasClass('ui-corner-all') && !$(e.target).hasClass('ui-icon'))
                ) {
                    $('#disable_dates_form .ui-datepicker').hide();
                }
            }
        });

        // Removing single disable date range and its event from calendar.
        $(document).on('click', '#disable_dates_full_calendar .delete_disable_dates', function() {
            if (confirm(confirmText)) {
                var calendarEventId = parseInt($(this).parent().find('.fc-event-title').attr('data-id_calendar_event'));
                var calendarEvent = DisableDatesCalendar.getEventById(calendarEventId);
                $('#disable_dates_full_calendar .id_calendar_event_'+calendarEventId).find('.fc-event-main-frame').tooltip('hide');
                DisableDatesObj.deleteDisableDate(calendarEvent.extendedProps.id_disable_date)
                    .then(function(response) {
                        if (response) {
                            $('#disable_dates_full_calendar .id_calendar_event_'+calendarEventId).find('.fc-event-main-frame').tooltip('destroy');
                            calendarEvent.remove();
                            var formEventId = parseInt($('#disable_dates_form .id_calendar_event').val());
                            if (!isNaN(formEventId) && formEventId == eventId) {
                                DisableDatesForm.resetForm();
                                DisableDatesForm.hideForm();
                            }
                        }
                    });
            }
        });

        // Setting data for single disable date range into form for updation.
        $(document).on('click', '#disable_dates_full_calendar .edit_disable_dates', function() {
            var element = $(this).parent().find('.fc-event-title');
            var calendarEvent = DisableDatesCalendar.getEventById($(element).attr('data-id_calendar_event'));
            var formData = {
                disable_date_from : calendarEvent.extendedProps.date_from_formatted,
                disable_date_to : calendarEvent.extendedProps.date_to_formatted,
                id_disable_date : calendarEvent.extendedProps.id_disable_date,
                room_disable_reason : calendarEvent.extendedProps.reason,
                id_calendar_event: $(element).attr('data-id_calendar_event') // this will be used to identify this event on the calendar
            };
            if ($('#disable_dates_form').attr('data-form_action') == 'update'
                && $('#disable_dates_form .id_calendar_event').val() != formData.id_calendar_event
            ) {
                $('#disable_dates_form').attr('data-form_action',' ')
            }

            DisableDatesForm.displayUpdateDatesForm();
            DisableDatesForm.setFormData(formData);
        });

        // Removing multiple disable dates that intersects with the selected date range.
        $(document).on('click', '#disable_dates_form .submit_remove_disable_date', function(e) {
            e.preventDefault();
            if (confirm(removeDisableDateText)) {
                let idRoom = parseInt($('#deactiveDatesModal').attr('data-id-room'));
                if(isNaN(idRoom)) {
                    idRoom = 0;
                }

                const formElem = $('#disable_dates_form');
                var dateFrom =  $(formElem).find('.disable_date_from').val();
                var dateTo = new Date($(formElem).find('.disable_date_to').val());
                dateTo.setDate(dateTo.getDate() + 1);
                dateTo = $.datepicker.formatDate('yy-mm-dd', dateTo);
                var data = {
                    ajax: true,
                    action: 'removeDisableDatesInDateRange',
                    id_room: idRoom,
                    date_from: dateFrom,
                    date_to: dateTo
                }
                $.ajax({
                    url: prod_link,
                    type: 'POST',
                    data: data,
                    dataType: 'JSON',
                    success: function(response) {
                        if (response.status) {
                            DisableDatesObj.reset(false);
                            if (response.disable_dates.length) {
                                DisableDatesObj.initEvents(response.disable_dates);
                            }
                        }
                        DisableDatesForm.showMessages(response.msg);
                    }
                });
            }
        });

        // opening form for adding new disable date.
        $(document).on('click', '#deactiveDatesModal .add_disable_dates, #deactiveDatesModal .disabled_selected_dates', function(e){
            e.preventDefault();
            DisableDatesForm.displayAddDatesForm();
        });

        // closing the actions tooltip for the calendar drag drop event.
        $(document).on('click', '#disable_dates_full_calendar .tooltip_action_block .close', function(){
            $(this).closest('.tooltip_action_block').remove();
        });

        // opening form for removing disable date.
        $(document).on('click', '#deactiveDatesModal .remove_disable_dates, #deactiveDatesModal .enable_selected_dates', function(e){
            e.preventDefault();
            DisableDatesForm.displayRemoveDatesForm();
        });

        // to save the dates on submit button click event
        $(document).on('click', '#disable_dates_form .submit_add_disable_date', function(e){
            e.preventDefault();
            if (confirm(confirmText)) {
                DisableDatesObj.submitDisableDates();
            }
        });

        // Closing the form on click event.
        $(document).on('click', '#disable_dates_form .close_disable_dates_form', function(){
            DisableDatesForm.resetForm();
            DisableDatesForm.hideForm();
        });

        // Hide tooltips on click.
        $(document).on('click', function(e) {
            var hideAll = true;
            if ($(e.target).closest('.tooltip_info_block').length) {
                hideAll = false;
            }

            $('#disable_dates_full_calendar .tooltip_info_block').each(function(){
                var tooltipId = $(this).attr('data-tooltip-id');
                if (!$('#tooltip-id-'+tooltipId).length) {
                    $('#disable_dates_full_calendar .tooltip_info_block').remove();
                } else if (hideAll) {
                    $('#tooltip-id-'+tooltipId).tooltip('hide');
                }
            });
        });

        // Called after the modal is shown, since the modal is hidden at first, the size of the fullcalendar is render incorrectly.
        $('#deactiveDatesModal').on('shown.bs.modal', function(e) {
            DisableDatesCalendar.updateSize();
            $('#page-loader').hide();
            $('#deactiveDatesModal').css('visibility', 'visible');
        });

        // Reseting and populating the modal.
        $('#deactiveDatesModal').on('show.bs.modal', function(e) {
            $('#deactiveDatesModal').css('visibility', 'hidden');
            $('#page-loader').show();
            DisableDatesObj.reset();
            DisableDatesObj.init($(e.relatedTarget));
        });

        // Disable dates data filling in the tr so that we cal validate it while saving this room type.
        $('#deactiveDatesModal').on('hide.bs.modal', function(e) {
            const disableDates = DisableDatesObj.getAllDisableDates();
            const roomRowIndex = parseInt($('#deactiveDatesModal').attr('data-room-row-index'));
            const roomRow = $('#product-configuration .hotel-room tr.room_data_values[data-row-index='+roomRowIndex+']');
            $(roomRow).find('.disable_dates_json').val(JSON.stringify(disableDates));
            DisableDatesObj.reset();
            DisableDatesObj.allowCalendarActions();
        });

        $('[name="selected_room_ids[]"]').on('change', function(){
            BulkUpdateRoomModal.toggleBulkUpdateButton();
        });

        $('[name="rooms_checkbox"]').on('change', function() {
            BulkUpdateRoomModal.toggleBulkUpdateButton();
        });

        $('#select-all-rooms').on('click', function(e) {
            e.preventDefault();
            $('[type="checkbox"][name="selected_room_ids[]"]').each(function(){
                if (!$(this).prop('disabled')) {
                    $(this).prop('checked', true);
                }
            });
            BulkUpdateRoomModal.toggleBulkUpdateButton();
        });

        $('#unselect-all-rooms').on('click', function(e) {
            e.preventDefault();
            $('[type="checkbox"][name="selected_room_ids[]"]').each(function(){
                $(this).prop('checked', false);
            });

            BulkUpdateRoomModal.toggleBulkUpdateButton();
        });

        $('#bulk-delete-rooms-button').on('click', function(e) {
            e.preventDefault();
            BulkUpdateRoomModal.submitBulkDelete();
        });

        $(document).on('change', 'select[name="bulk_update_room_status"], select[name="bulk_create_room_status"]', function(){
            var status_val = $(this).val();
            if (status_val == rm_status.STATUS_TEMPORARY_INACTIVE.id) {
                $(this).closest('.modal-body').find('.rooms-disable-dates').parent().show();
            } else {
                $(this).closest('.modal-body').find('.rooms-disable-dates').parent().hide();
            }
        });

        $(document).on('focus', '.disabled_date_from, .disabled_date_to', function () {
            $('.disabled_date_from').datepicker({
                showOtherMonths: true,
                dateFormat: 'yy-mm-dd',
                minDate: 0,
                onSelect: function(selectedDate) {
                    var date_format = selectedDate.split('-');
                    selectedDate = new Date($.datepicker.formatDate('yy-mm-dd', new Date(date_format[0], date_format[1] - 1, date_format[2])));
                    selectedDate.setDate(selectedDate.getDate() + 1);
                    $(this).closest('tr').find('.disabled_date_to').datepicker('option', 'minDate', selectedDate);
                },
                onClose: function(selectedDate) {
                    var dateTo = $(this).closest('tr').find('.disabled_date_to').val();
                    if (!dateTo || (dateTo && selectedDate >= dateTo)) {
                        $(this).closest('tr').find('.disabled_date_to').datepicker('show');
                    }
                },
            });

            $('.disabled_date_to').datepicker({
                showOtherMonths: true,
                dateFormat: 'yy-mm-dd',
                minDate: 0,
                beforeShow: function (input, instance) {
                    var date_to = $(this).closest('tr').find('.disabled_date_from').val();
                    if (typeof date_to != 'undefined' && date_to != '') {
                        var date_format = date_to.split('-');
                        var selectedDate = new Date($.datepicker.formatDate('yy-mm-dd', new Date(date_format[0], date_format[1] - 1, date_format[2])));
                    } else {
                        var date_format = new Date();
                        var selectedDate = new Date($.datepicker.formatDate('yy-mm-dd', new Date()));
                    }
                    selectedDate.setDate(selectedDate.getDate()+1);
                    $(this).datepicker('option', 'minDate', selectedDate);
                },
            });
        });

        $('#bulkUpdateRoomModal').on('show.bs.modal', function(e){
            if (!$(e.relatedTarget).attr('disabled')) {
                $('#bulkUpdateRoomModal table tbody').html('');
                $('.bulk_update_room_status').val(rm_status.STATUS_ACTIVE.id).closest('.modal-body').find('.rooms-disable-dates').parent().hide();
                $('[name="bulk_update_room_comment"]').val('');
                $('[name="bulk_update_room_floor"]').val('');
                $('#page-loader').show();
                BulkUpdateRoomModal.init();
            } else {
                return false;
            }
        });

        $('#bulkUpdateRoomModal').on('shown.bs.modal', function(e){
            $('#page-loader').hide();
        });

        $('#bulkCreateRoomModal').on('show.bs.modal', function(e){
            $('#bulkCreateRoomModal table tbody').html('');
            $('.bulk_create_room_status').val(rm_status.STATUS_ACTIVE.id).closest('.modal-body').find('.rooms-disable-dates').parent().hide();
            $('[name="bulk_create_room_comment"]').val('');
            $('[name="bulk_create_room_floor"]').val('');
            $('[name="bulk_create_room_prefix"]').val(''),
            $('[name="bulk_create_room_num"]').val(''),
            $('[name="bulk_create_room_qty"]').val(''),
            BulkCreateRoomModal.init();
        });

        $('#bulkCreateRoomModal').on('shown.bs.modal', function(e){
            $('#page-loader').hide();
        });

        $('.add_bulk_room_update_disable_date').on('click', function() {
            BulkUpdateRoomModal.addNewRow();
        });

        $('.add_bulk_room_create_disable_date').on('click', function() {
            BulkCreateRoomModal.addNewRow();
        });

        $(document).on('click','.remove-room-bulk-disable-dates-button',function(e) {
            e.preventDefault();
            $(this).closest('tr').remove();
        });

        $(document).on('click','button[name="submitBulkUpdateRooms"]',function(e) {
            BulkUpdateRoomModal.submitBulkUpdateModal();
        });

        $(document).on('click','button[name="submitBulkCreateRooms"]',function(e) {
            BulkCreateRoomModal.submitBulkCreateModal();
        });

        const BulkUpdateRoomModal = {
            init: function() {
                BulkUpdateRoomModal.addNewRow();
                BulkUpdateRoomModal.hideErrors();
            },
            addNewRow: function() {
                $('#bulkUpdateRoomModal tbody').append(this.getDisableDatesRowHtml());
            },
            removeAllInvalidRowDataMarkers: function(tr) {
                $('#bulkUpdateRoomModal .room-disable-dates tr').css('outline', '');
                $(tr).css('outline', '');
            },
            markRowDataInvalid: function(tr) {
                $(tr).css({ 'outline': '1px solid #D27C82', 'border-radius': '2px' });
            },
            hideErrors: function() {
                $('#bulkUpdateRoomModal .errors-wrap').hide();
                $('#bulkUpdateRoomModal .errors-wrap').html('');
            },
            toggleBulkUpdateButton: function() {
                let selectedRooms = BulkUpdateRoomModal.getSelectedRooms();
                if (selectedRooms.length != 0) {
                    $('#bulk-update-rooms-button').attr('disabled', false);
                } else {
                    $('#bulk-update-rooms-button').attr('disabled', true);
                }
            },
            getSelectedRooms: function(){
                let selectedRooms = [];
                $('[type="checkbox"][name="selected_room_ids[]"]').each(function(){
                    if ($(this).prop('checked')) {
                        selectedRooms.push($(this).val());
                    }
                })

                return selectedRooms;
            },
            getSelectedDates: function() {
                let disableDates = [];
                $('#bulkUpdateRoomModal .rooms-disable-dates tbody tr').each(function(i, tr) {
                    let date_from = $(tr).find('.disabled_date_from').val().trim();
                    let date_to = $(tr).find('.disabled_date_to').val().trim();
                    let reason = $(tr).find('.room_disable_reason').val().trim();
                    disableDates.push({ date_from, date_to, reason});
                });

                return disableDates;
            },
            showErrors: function(errors) {
                $('#bulkUpdateRoomModal .errors-wrap').html(errors);
                $('#bulkUpdateRoomModal .errors-wrap').show();
            },
            submitBulkUpdateModal: function() {
                let dates = this.getSelectedDates();
                let data = {
                    ajax : 1,
                    action: 'bulkUpdateRooms',
                    id_rooms: this.getSelectedRooms(),
                    disable_dates: this.getSelectedDates(),
                    floor: $('[name="bulk_update_room_floor"]').val(),
                    room_comment: $('[name="bulk_update_room_comment"]').val(),
                    id_status: $('.bulk_update_room_status').val(),
                    id_product: $('[name="id_product"]').val()
                };

                $('#page-loader').show();
                $.ajax({
                    url: prod_link,
                    type: 'POST',
                    data: data,
                    dataType: 'JSON',
                    success: function(response) {
                        if (response.status) {
                            window.location.href = response.href;
                        } else {
                            BulkUpdateRoomModal.showErrors(response.msg);
                            BulkUpdateRoomModal.addInvalidRowDataMarkers(response.rows_to_highlight);
                        }
                    },
                    complete: function() {
                        $('#page-loader').hide();
                    }
                });
            },
            submitBulkDelete: function() {
                if (confirm("{l s='Delete selected rooms?'}")) {
                    $('#product_form').append('<input type="hidden" name="submitBulkDeleteRooms" value="1"/>');
                    $('form#product_form').submit();
                }
            },
            addInvalidRowDataMarkers: function(rowsToHighlight) {
                if (rowsToHighlight.length != 0) {
                    rowsToHighlight.map(function (rowIndex) {
                        const tr = $('#bulkUpdateRoomModal .rooms-disable-dates tbody tr').eq(rowIndex);
                        BulkUpdateRoomModal.markRowDataInvalid(tr);
                    });
                }
            },
            getDisableDatesRowHtml: function () {
                let dateFromElem = $('<td>').addClass('col-sm-2 center').append($('<input>').attr('type', 'text').addClass('form-control disabled_date_from').prop('readonly', 'readonly'));
                let dateToElem = $('<td>').addClass('col-sm-2 center').append($('<input>').attr('type', 'text').addClass('form-control disabled_date_to').prop('readonly', 'readonly'));
                let reasonElem = $('<td>').addClass('col-sm-6 center').append($('<input>').attr('type', 'text').addClass('form-control room_disable_reason'));
                let removeRowElem = $('<td>').addClass('col-sm-1 center').append($('<a>').attr('href', '#').addClass('remove-room-bulk-disable-dates-button btn btn-default').append($('<i>').addClass('icon-trash')));
                let rowElem = $('<tr>').addClass('disabledDatesTr')
                    .append(dateFromElem)
                    .append(dateToElem)
                    .append(reasonElem)
                    .append(removeRowElem);

                return $(rowElem).prop('outerHTML');
            }
        };

        const BulkCreateRoomModal = {
            init: function() {
                BulkCreateRoomModal.addNewRow();
                BulkCreateRoomModal.hideErrors();
            },
            addNewRow: function() {
                $('#bulkCreateRoomModal tbody').append(this.getDisableDatesRowHtml());
            },
            removeAllInvalidRowDataMarkers: function(tr) {
                $('#bulkCreateRoomModal .room-disable-dates tr').css('outline', '');
                $(tr).css('outline', '');
            },
            markRowDataInvalid: function(tr) {
                $(tr).css({ 'outline': '1px solid #D27C82', 'border-radius': '2px' });
            },
            hideErrors: function() {
                $('#bulkCreateRoomModal .errors-wrap').hide();
                $('#bulkCreateRoomModal .errors-wrap').html('');
            },
            getSelectedDates: function() {
                let disableDates = [];
                $('#bulkCreateRoomModal .rooms-disable-dates tbody tr').each(function(i, tr) {
                    let date_from = $(tr).find('.disabled_date_from').val().trim();
                    let date_to = $(tr).find('.disabled_date_to').val().trim();
                    let reason = $(tr).find('.room_disable_reason').val().trim();
                    disableDates.push({ date_from, date_to, reason});
                });

                return disableDates;
            },
            showErrors: function(errors) {
                $('#bulkCreateRoomModal .errors-wrap').html(errors);
                $('#bulkCreateRoomModal .errors-wrap').show();
            },
            submitBulkCreateModal: function() {
                let dates = this.getSelectedDates();
                let data = {
                    ajax : 1,
                    action: 'bulkCreateRooms',
                    disable_dates: this.getSelectedDates(),
                    prefix: $('[name="bulk_create_room_prefix"]').val(),
                    num: $('[name="bulk_create_room_num"]').val(),
                    qty: $('[name="bulk_create_room_qty"]').val(),
                    floor: $('[name="bulk_create_room_floor"]').val(),
                    room_comment: $('[name="bulk_create_room_comment"]').val(),
                    id_status: $('.bulk_create_room_status').val(),
                    id_product: $('[name="id_product"]').val()
                };

                $('#page-loader').show();
                $('[name="submitBulkCreateRooms"]').attr('disabled', 'disable');
                $.ajax({
                    url: prod_link,
                    type: 'POST',
                    data: data,
                    dataType: 'JSON',
                    success: function(response) {
                        if (response.status) {
                            window.location.href = response.href;
                        } else {
                            BulkCreateRoomModal.showErrors(response.msg);
                            BulkCreateRoomModal.addInvalidRowDataMarkers(response.rows_to_highlight);
                        }
                    },
                    complete: function() {
                        $('#page-loader').hide();
                        $('[name="submitBulkCreateRooms"]').attr('disabled', false);
                    }
                });
            },
            addInvalidRowDataMarkers: function(rowsToHighlight) {
                if (rowsToHighlight.length != 0) {
                    rowsToHighlight.map(function (rowIndex) {
                        const tr = $('#bulkCreateRoomModal .rooms-disable-dates tbody tr').eq(rowIndex);
                        BulkCreateRoomModal.markRowDataInvalid(tr);
                    });
                }
            },
            getDisableDatesRowHtml: function () {
                let dateFromElem = $('<td>').addClass('col-sm-2 center').append($('<input>').attr('type', 'text').addClass('form-control disabled_date_from').prop('readonly', 'readonly'));
                let dateToElem = $('<td>').addClass('col-sm-2 center').append($('<input>').attr('type', 'text').addClass('form-control disabled_date_to').prop('readonly', 'readonly'));
                let reasonElem = $('<td>').addClass('col-sm-6 center').append($('<input>').attr('type', 'text').addClass('form-control room_disable_reason'));
                let removeRowElem = $('<td>').addClass('col-sm-1 center').append($('<a>').attr('href', '#').addClass('remove-room-bulk-disable-dates-button btn btn-default').append($('<i>').addClass('icon-trash')));
                let rowElem = $('<tr>').addClass('disabledDatesTr')
                    .append(dateFromElem)
                    .append(dateToElem)
                    .append(reasonElem)
                    .append(removeRowElem);

                return $(rowElem).prop('outerHTML');
            }
        };

        // Init full calender object.
        const DisableDatesCalendar = new FullCalendar.Calendar($('#disable_dates_full_calendar').get(0), {
            initialView: 'dayGridMonth',
            initialDate: '{date('Y-m-d', time())}',
            dayMaxEventRows: true,
            selectable: true,
            direction:{if isset($language_is_rtl) && $language_is_rtl}'rtl'{else}'ltr'{/if},
            locale:{if isset($locale) && $locale}'{$locale}'{else}'en'{/if},
            unselectAuto: true,
            contentHeight: 'auto',
            views: {
                dayGridMonth: {
                    dayMaxEventRows: 10
                }
            },
            // This function is used to check the clicked date on calendar can be selected.
            selectAllow: function(info) {
                $('#disable_dates_full_calendar .tooltip_container').remove();
                let idRoom = parseInt($('#deactiveDatesModal').attr('data-id-room'));
                // disabling select action incase room is not saved.
                if (isNaN(idRoom)) {
                    return false;
                }

                var date_start = new Date(info.startStr);
                if (date_start < dateToday) {
                    return false;
                }

                return true;
            },
            // This event is called every time an event has mounted successfully.
            // This event is called not called incase there is any changes in the event source.
            eventDidMount: function(info) {
                DisableDatesObj.handleEventDateBackgroundHighlight(info.event, true);
                DisableDatesObj.initEventTooltip(info.event, info.el);
                var isDeletable = info.event.extendedProps.is_deletable;
                var isEditable = info.event.extendedProps.is_editable;
                if (isDeletable) {
                    $(info.el).find('.fc-event-title-container').append('<i class="icon-trash pull-right delete_disable_dates"></i>');
                }

                if (isDeletable) {
                    $(info.el).find('.fc-event-title-container').append('<i class="icon-pencil pull-right edit_disable_dates"></i>');
                }

                if (info.isStart) {
                    $(info.el).find('.fc-event-title').addClass('event_title_container');
                }
            },
            // This event is called when a calendar event is removed from the full calendar.
            eventWillUnmount: function(info) {
                DisableDatesObj.handleEventDateBackgroundHighlight(info.event, false);
            },
            // This event is caled when admin select and dates on full calendar using mouse.
            select: function(info) {
                var selectedElement = $('#disable_dates_full_calendar .fc-daygrid-bg-harness').last();
                DisableDatesForm.resetForm();
                DisableDatesForm.hideForm();
                $('#disable_dates_form').attr('data-form_action', 'tooltip_actions');
                var formData = {
                    disable_date_from : info.startStr,
                    disable_date_to : info.endStr,
                };
                DisableDatesForm.setFormData(formData);
                var html = $('#tooltip_action_block').html();
                var options = {
                    title: ' ',
                    html: true,
                    template: html,
                    trigger: 'click',
                    container: $('#disable_dates_full_calendar').closest('div'),
                    delay: {
                        show: 600,
                        hide: 500
                    },
                    placement: {if isset($language_is_rtl) && $language_is_rtl}'left'{else}'right'{/if},
                }
                $(selectedElement).tooltip(options);
                $('#disable_dates_full_calendar .tooltip_action_block .enable_selected_dates').hide();
                setTimeout(() => {
                    $(selectedElement).tooltip('show');
                    if (!DisableDatesObj.checkDisabled(formData)) {
                        $('#disable_dates_full_calendar .tooltip_action_block .enable_selected_dates').hide();
                    }
                }, 200);
            },
            unselect: function(){
                // since unselectAuto: true will remove the element on which we are adding the tooltip, so the tooltip is destroyed on any action.
                // which will not allow the events binded to the tooltip_action_block class
                setTimeout(() => {
                    $('#disable_dates_full_calendar .tooltip_action_block').remove();
                }, 1);
            },
            eventMouseEnter: function (info) {
                var idCalendarEvent = $(info.el).find('.fc-event-title').attr('data-id_calendar_event');
                $('.id_calendar_event_' + idCalendarEvent).addClass('calendar_hover_highlight');
                $(info.el).addClass('calendar_hover_highlight');
                $(info.el).addClass('id_calendar_event_' + idCalendarEvent);
            },
            eventMouseLeave: function(info) {
                var idCalendarEvent = $(info.el).find('.fc-event-title').attr('data-id_calendar_event');
                $('.id_calendar_event_' + idCalendarEvent).removeClass('calendar_hover_highlight');
                $(info.el).removeClass('calendar_hover_highlight');
            }
        });

        DisableDatesCalendar.render();

        //Object to handle all disable date form related operations.
        const DisableDatesForm = {
            // used for resetting the disable date form form.
            resetForm: function () {
                $('#disable_dates_form .ui-datepicker').hide();
                $('#disable_dates_form .disable_date_from').val('');
                $('#disable_dates_form .disable_date_to').val('');
                $('#disable_dates_form .id_disable_date').val('');
                $('#disable_dates_form .room_disable_reason').val('');
                $('#disable_dates_form .id_calendar_event').val('');
                $('#disable_dates_form .room_disable_reason').closest('.form-group').show();
                $('#disable_dates_form .date_from_container').datepicker("option", "minDate", "{date('Y-m-d')}");
                $('#disable_dates_form .date_to_container').datepicker("setDate", null);
                $('#disable_dates_form .date_from_container').datepicker("setDate", null);
                $('#disable_dates_form .date_from_container').find('.ui-datepicker').hide();
                $('#disable_dates_form .date_to_container').find('.ui-datepicker').hide();
            },
            // used for opulating the disable dates form with the data.
            setFormData: function(formData) {
                var disableDateTo = new Date(formData.disable_date_to);
                // setting the date_to to -1 since the full calendar does not includes the date to
                disableDateTo.setDate(disableDateTo.getDate() - 1);
                disableDateTo = $.datepicker.formatDate('yy-mm-dd', disableDateTo);
                //setting the min dates dfor the date picker
                $('#disable_dates_form .disable_date_from').val(formData.disable_date_from);
                $('#disable_dates_form .date_from_container').datepicker("setDate", formData.disable_date_from);

                $('#disable_dates_form .disable_date_to').val(disableDateTo);
                $('#disable_dates_form .date_to_container').datepicker("option", "minDate", formData.disable_date_from);
                $('#disable_dates_form .date_to_container').datepicker("setDate", disableDateTo);
                if (typeof(formData.id_disable_date) !== undefined)
                    $('#disable_dates_form .id_disable_date').val(formData.id_disable_date);

                if (typeof(formData.room_disable_reason) !== undefined)
                    $('#disable_dates_form .room_disable_reason').val(formData.room_disable_reason);

                if (typeof(formData.id_calendar_event) !== undefined)
                    $('#disable_dates_form .id_calendar_event').val(formData.id_calendar_event);
            },
            // used for hiding the disable date form form.
            hideForm: function(){
                $('#disable_dates_form').hide(200);
                $('#disable_dates_form .disable_dates_form_title').hide(200);
                $('#disable_dates_form .submit_add_disable_date').hide(200);
                $('#disable_dates_form .submit_remove_disable_date').hide(200);
            },
            // used for display the disable dates form with add action.
            displayAddDatesForm: function () {
                DisableDatesForm.hideMessages();
                DisableDatesCalendar.unselect();
                if ($('#disable_dates_form').attr('data-form_action') == 'tooltip_actions') {
                    $('#disable_dates_form').attr('data-form_action', 'add');
                }

                if ($('#disable_dates_form').attr('data-form_action') != 'add') {
                    $('#disable_dates_form').attr('data-form_action', 'add');
                    DisableDatesForm.resetForm();
                    DisableDatesForm.hideForm();
                }

                DisableDatesForm.displayForm();
                $('#disable_dates_form .disable_dates_form_title_add').show(200);
                $('#disable_dates_form .submit_add_disable_date').show(200);
            },
            // used for display the disable dates form with remove action.
            displayRemoveDatesForm: function () {
                DisableDatesForm.hideMessages();
                DisableDatesCalendar.unselect();
                if ($('#disable_dates_form').attr('data-form_action') == 'tooltip_actions') {
                    $('#disable_dates_form').attr('data-form_action', 'remove');
                }

                if ($('#disable_dates_form').attr('data-form_action') != 'remove') {
                    $('#disable_dates_form').attr('data-form_action', 'remove');
                    DisableDatesForm.resetForm();
                    DisableDatesForm.hideForm();
                }

                DisableDatesForm.displayForm();
                $('#disable_dates_form .disable_dates_form_title_delete').show(200);
                $('#disable_dates_form .submit_remove_disable_date').show(200);
                $('#disable_dates_form .room_disable_reason').closest('.form-group').hide();
                $('#disable_dates_form .date_from_container').datepicker("option", "minDate", null);
            },
            // used for display the disable dates form with update action.
            displayUpdateDatesForm: function () {
                DisableDatesForm.hideMessages();
                DisableDatesCalendar.unselect();
                if ($('#disable_dates_form').attr('data-form_action') != 'update') {
                    $('#disable_dates_form').attr('data-form_action', 'update');
                    DisableDatesForm.resetForm();
                    DisableDatesForm.hideForm();
                }

                DisableDatesForm.displayForm();
                $('#disable_dates_form .disable_dates_form_title_update').show(200);
                $('#disable_dates_form .submit_add_disable_date').show(200);
            },
            // used for display the disable dates, also the screen is scrolled to top to show the form on the screen.
            displayForm: function() {
                if ($('#deactiveDatesModal').scrollTop() > 0) {
                    $('#deactiveDatesModal').animate({ scrollTop: 0 });
                }

                $('#disable_dates_form').show(200);
                setTimeout(() => {
                    $('#disable_dates_full_calendar .tooltip_info_block').remove();
                }, 610);
            },
            // used to display messages related to the disable date form
            showMessages: function(messages) {
                $('#deactiveDatesModal .messages-wrap').html(messages);
                $('#deactiveDatesModal .messages-wrap').show();
                $('#deactiveDatesModal').animate({ scrollTop: 0 });
            },
            // used to hide messages related to the disable date form
            hideMessages: function() {
                $('#deactiveDatesModal .messages-wrap').hide();
                $('#deactiveDatesModal .messages-wrap').html('');
            }
        }

        //Object to handle all calander and disable dates related operations.
        const DisableDatesObj = {
            // called to initilize and set actions for the modal.
            init: function(triggerRoomRow) {
                var idRoom = parseInt($(triggerRoomRow).attr('data-id-room'));
                var roomRowIndex = parseInt($(triggerRoomRow).closest('.room_data_values').attr('data-row-index'));
                var roomNum = $(triggerRoomRow).closest('.room_data_values').find('[name="rooms_info['+roomRowIndex+'][room_num]"]').val();
                $('#deactiveDatesModal').attr('data-room-row-index', roomRowIndex);
                $('#deactiveDatesModal').attr('data-id-room', idRoom);
                if ($.trim(roomNum) != '') {
                    roomNum = '( '+'{l s='Room No'}'+' '+roomNum+')';
                }

                $('#deactiveDatesModal .disable_dates_room_num').html(roomNum);
                if (isNaN(idRoom)) {
                    DisableDatesObj.restrictCalendarActions();
                    return;
                } else {
                    DisableDatesObj.getPopulateRoomDisableDates(idRoom);
                }
            },
            // called to add events in the calendar.
            initEvents: function(datesInfo) {
                if (datesInfo.length) {
                    var events = [];
                    $.each(datesInfo, function(index, dateInfo) {
                        var eventId = DisableDatesObj.getUniqueEventId();
                        events.push({
                            'id': DisableDatesObj.getUniqueEventId(),
                            'title': dateInfo['reason'],
                            'start': dateInfo['date_from'],
                            'end': dateInfo['date_to'],
                            'reason': dateInfo['reason'],
                            'date_add' : dateInfo['date_add'],
                            'id_disable_date' : parseInt(dateInfo['id']),
                            'is_editable' : parseInt(dateInfo['is_editable']),
                            'is_deletable' : parseInt(dateInfo['is_deletable']),
                            'event_title' : dateInfo['event_title'],
                            'date_to_formatted': dateInfo['date_to'],
                            'date_from_formatted': dateInfo['date_from'],
                            'id_event' : dateInfo['id_event'],
                            'event_url' : dateInfo['event_url']
                        });
                    });
                    DisableDatesCalendar.addEventSource(events);
                }
            },
            // called to initlized the tooltips for the events in the calendar.
            initEventTooltip: function(event, element) {
                // will be used to get this particular event
                $(element).find('.fc-event-title').attr('data-id_calendar_event', event.id);
                var dateFrom = event.extendedProps.date_from_formatted;
                var eventDateTo = new Date(event.extendedProps.date_to_formatted);
                // setting the date_to to -1 days since the full calendar does not includes the end date
                eventDateTo.setDate(eventDateTo.getDate() - 1);
                var dateTo = $.datepicker.formatDate('yy-mm-dd', eventDateTo);
                var reason = event.extendedProps.reason;
                var eventTitle = event.extendedProps.event_title;
                var idEvent = event.extendedProps.id_event;
                var eventUrl = event.extendedProps.event_url;
                var dateAdd = event.extendedProps.date_add;
                $('#tooltip_info_block .tooltip_date_from').text(dateFrom);
                $('#tooltip_info_block .tooltip_date_to').text(dateTo);
                $('#tooltip_info_block .tooltip_date_add').text(dateAdd);
                $('#tooltip_info_block .tooltip_reason').parent().hide();
                if (reason != '') {
                    $('#tooltip_info_block .tooltip_reason').text(reason).parent().show();
                }

                if (eventTitle != '' && eventTitle != null) {
                    eventTitle = '<span class="tooltip_event_title">'+eventTitle+'</span>';
                    $('#tooltip_info_block .tooltip_title').html(eventTitle).show();
                } else {
                    $('#tooltip_info_block .tooltip_title').html('').hide();
                }

                if (idEvent && idEvent !== null) {
                    var eventHtml = '';
                    if (eventUrl != '' && eventUrl != null) {
                        eventHtml = '<a target="_blank" href="'+eventUrl+'">'+ '#'+idEvent + '</a>';
                    } else {
                        eventHtml = '<span>'+ '#'+idEvent + '</span>';
                    }

                    $('#tooltip_info_block .tooltip_id_event').html(eventHtml).parent().show();
                } else {
                    $('#tooltip_info_block .tooltip_id_event').html('').parent().hide();
                }

                $('#tooltip_info_block .tooltip_container').attr('data-tooltip-id', event.id + '-'+ tooltipCounter);
                var html = $('#tooltip_info_block').html();
                var options = {
                    title: ' ',
                    html: true,
                    template: html,
                    trigger: 'click',
                    container: $('#disable_dates_full_calendar').closest('div'),
                    delay: {
                        show: 600,
                        hide: 500
                    },
                    placement: 'auto'
                }

                // linking the tooltip with the calander event, so we can perform actions on them.

                $(element).addClass('id_calendar_event_' + event.id);
                $(element).find('.fc-event-main-frame').tooltip(options);

                // since an event can be for more than one time, we have to display the tooltip for more than one time, so we are adding counter for unique id for them
                $(element).find('.fc-event-main-frame').attr('id', 'tooltip-id-' + event.id + '-' + tooltipCounter);
                tooltipCounter++;
            },
            // called to restrict and hide all actions on the modal
            restrictCalendarActions: function() {
                $('#deactiveDatesModal .add_disable_dates').hide();
                $('#deactiveDatesModal .remove_disable_dates').hide();
                $('#deactiveDatesModal .room_not_found').show();
            },
            // called to enable the restricted actions on the modal
            allowCalendarActions: function() {
                $('#deactiveDatesModal .add_disable_dates').show();
                $('#deactiveDatesModal .remove_disable_dates').show();
                $('#deactiveDatesModal .room_not_found').hide();
            },
            // called to get the disable dates for a perticular room.
            getPopulateRoomDisableDates: function(idRoom) {
                $.ajax({
                    url: prod_link,
                    type: 'POST',
                    data: {
                        ajax: true,
                        action: 'getDisableDates',
                        id_room: idRoom,
                    },
                    dataType: 'JSON',
                    success: function(response) {
                        if (response.status) {
                            if (response.disable_dates.length) {
                                DisableDatesObj.initEvents(response.disable_dates);
                            }
                        }

                        DisableDatesForm.hideMessages();
                    }
                });
            },
            // This is called to reset the disable dates calendar and the form.
            reset: function(showCurrentDay = true) {
                var source = DisableDatesCalendar.getEventSources();
                if (source.length) {
                    $.each(source, function(i, event) {
                        event.remove();
                    });
                }

                tooltipCounter = 0;

                $('#deactiveDatesModal .disable_dates_room_num').html('');
                $('#disable_dates_full_calendar .tooltip_container').remove();
                DisableDatesForm.hideMessages();
                DisableDatesForm.resetForm();
                DisableDatesForm.hideForm();
                if (showCurrentDay) {
                    // this is used to show the current day on the calendar
                    DisableDatesCalendar.today();
                }
            },
            // This is called to submit the dates selected in the disable date form.
            submitDisableDates: function() {
                let idRoom = parseInt($('#deactiveDatesModal').attr('data-id-room'));
                if(isNaN(idRoom)) {
                    idRoom = 0;
                }
                var formElem = $('#disable_dates_form');
                var dateFrom =  $(formElem).find('.disable_date_from').val();
                var dateTo = $(formElem).find('.disable_date_to').val();
                var eventId = parseInt($(formElem).find('.id_calendar_event').val());
                var reason = $(formElem).find('.room_disable_reason').val();
                var idProduct = $('[name="id_product"]').val();
                var idDisableDate = parseInt($(formElem).find('.id_disable_date').val());
                if (isNaN(idDisableDate)) {
                    idDisableDate = 0;
                }

                dateTo = new Date(dateTo);
                // setting the date_to +1 since the full calendar does not includes the date to
                dateTo.setDate(dateTo.getDate() + 1);
                dateTo = $.datepicker.formatDate('yy-mm-dd', dateTo);
                $.ajax({
                    url: prod_link,
                    type: 'POST',
                    data: {
                        ajax: true,
                        action: 'submitDisableDates',
                        id_disable_date : idDisableDate,
                        id_product: idProduct,
                        id_room: idRoom,
                        date_from: dateFrom,
                        date_to: dateTo,
                        reason: reason
                    },
                    dataType: 'JSON',
                    success: function(response) {
                        reason = $.trim(reason);
                        if (response.status) {
                            var validatedEvent = {
                                'id' : DisableDatesObj.getUniqueEventId(),
                                'title': reason,
                                'start': dateFrom,
                                'end': dateTo,
                                'date_from_formatted': dateFrom,
                                'date_to_formatted': dateTo,
                                'reason': reason,
                                'id': DisableDatesObj.getUniqueEventId(),
                                'is_deletable' : 1,
                                'is_editable' : 1,
                                'id_disable_date': response.id_disable_date,
                                'event_title' : response.event_title,
                                'id_event' : '',
                                'event_url' : '',
                                'date_add' : "{date('Y-m-d H:i:s')}"
                            }

                            if (!isNaN(eventId)) {
                                var olderEvent = DisableDatesCalendar.getEventById(eventId);
                                if (olderEvent) {
                                    validatedEvent.is_deletable = olderEvent.extendedProps.is_deletable;
                                    validatedEvent.is_editable = olderEvent.extendedProps.is_editable;
                                    validatedEvent.event_title = olderEvent.extendedProps.event_title;
                                    validatedEvent.id_event = olderEvent.extendedProps.id_event;
                                    validatedEvent.event_url = olderEvent.extendedProps.event_url;
                                    olderEvent.remove();
                                }
                            }

                            var event = [];
                            event.push(validatedEvent);
                            DisableDatesCalendar.addEventSource(event);
                            DisableDatesForm.resetForm();
                            DisableDatesForm.hideForm();
                        }
                        DisableDatesForm.showMessages(response.msg);
                    }
                });
            },
            // This is called to delete the disable date object using the idDisableDate.
            deleteDisableDate: function(idDisableDate) {
                return new Promise(function(resolve, reject) {
                    $.ajax({
                        url: prod_link,
                        type: 'POST',
                        data: {
                            ajax: true,
                            action: 'deleteDisableDate',
                            id_disable_date : idDisableDate,
                        },
                        dataType: 'JSON',
                        success: function(response) {
                            DisableDatesForm.showMessages(response.msg);
                            resolve(response.status)
                        },
                        error: function(xhr, status, error) {
                            reject(error);
                        }
                    })
                });
            },
            // This is called to get the all disable dates from the calander.
            getAllDisableDates: function() {
                var disableDates = [];
                var events = DisableDatesCalendar.getEvents();
                if (events.length) {
                    $.each(events, function(i, event) {
                        var data = {
                            date_from: event.extendedProps.date_from_formatted,
                            date_to: event.extendedProps.date_to_formatted,
                            reason: event.extendedProps.reason,
                            date_add : event.extendedProps.date_add,
                            id : event.extendedProps.id_disable_date,
                            is_editable : event.extendedProps.is_editable,
                            event_title : event.extendedProps.event_title,
                            is_deletable : event.extendedProps.is_deletable,
                            id_event : event.extendedProps.id_event,
                            event_url : event.extendedProps.event_url
                        }

                        disableDates.push(data);
                    });
                }

                return disableDates;
            },
            // This is used to generate and get a unique id for all the events, which are added to the tooltips to link them together.
            getUniqueEventId: function() {
                var id = Math.floor(Math.random() * 100000);
                var event = DisableDatesCalendar.getEventById(id);
                if (event) {
                    return DisableDatesObj.getUniqueEventId()
                }
                return id;
            },
            // This is used to set/highlight the background for all the days that are added in the calander as event.
            handleEventDateBackgroundHighlight: function(event, add) {
                if (event.start && event.end) {
                    let dateFrom = new Date(event.start);
                    let endDate = new Date(event.end);
                    dateFrom.setDate(dateFrom.getDate() + 1)
                    let startDate = dateFrom;
                    // Loop through all the days the event spans
                    for (let date = startDate; date <= endDate; date.setDate(date.getDate() + 1)) {
                        // This return the date in format of Y-m-d, and we are counting the date for overlapping events.
                        let dateString = date.toISOString().split('T')[0];
                        if (add) {
                            if (!disableDatesCounter[dateString]) {
                                disableDatesCounter[dateString] = 0;
                            }

                            disableDatesCounter[dateString]++;
                        } else {
                            disableDatesCounter[dateString]--;
                            if (disableDatesCounter[dateString] <= 0) {
                                delete disableDatesCounter[dateString];
                            }
                        }
                    }
                } else if (event.start) {
                    let dateFrom = new Date(event.start);
                    dateFrom.setDate(dateFrom.getDate() + 1);
                    let dateString = dateFrom.toISOString().split('T')[0];
                    if (add) {
                        if (!disableDatesCounter[dateString]) {
                            disableDatesCounter[dateString] = 0;
                        }

                        disableDatesCounter[dateString]++;
                    } else {
                        disableDatesCounter[dateString]--;
                        if (disableDatesCounter[dateString] <= 0) {
                            delete disableDatesCounter[dateString];
                        }
                    }
                }

                const today = new Date().toISOString().split('T')[0];
                $('#disable_dates_full_calendar .fc-daygrid-day').each(function() {
                    let dateString = $(this).data('date');
                    if (dateString !== today) {
                        if (disableDatesCounter[dateString]) {
                            $(this).addClass('highlight-event-day');
                        } else {
                            $(this).removeClass('highlight-event-day');
                        }
                    }
                });
            },
            checkDisabled: function(dates) {
                let dateFrom = new Date(dates.disable_date_from);
                let endDate = new Date(dates.disable_date_to);
                dateFrom.setDate(dateFrom.getDate())
                let startDate = dateFrom;
                for (let date = startDate; date < endDate; date.setDate(date.getDate() + 1)) {
                    let dateString = date.toISOString().split('T')[0];
                    if (disableDatesCounter[dateString]) {
                        return true;
                    }
                }

                return false;
            }
        }
    });

    /* ── Room Add / Edit Modal ── */
    const RoomModal = {
        init: function () {
            $('#add-more-rooms-button').off('click').on('click', RoomModal.openAddMode);
            $(document).on('click', '.btn-edit-room', RoomModal.openEditMode);
            $(document).on('click', '.open-edit-disable-dates', RoomModal.openDisableDatesFromEdit);
            $(document).on('click', '#saveRoomAndStay', function () { RoomModal.save($(this)); });
            $(document).on('click', '#saveRoomAndClose', function () { RoomModal.save($(this)); });
        },
        resetForm: function () {
            $('#rm_num, #rm_name, #rm_floor, #rm_comment').val('');
            $('#rm_status_sel').prop('selectedIndex', 0);
            $('#rm_id_room').val('');
            RoomModal.hideError();
        },
        showError: function (msg) {
            $('.rm-modal-error').html(msg).show();
        },
        hideError: function () {
            $('.rm-modal-error').hide().html('');
        },
        openAddMode: function () {
            RoomModal.resetForm();
            $('#rm_modal_mode').val('add');
            $('#roomModalTitle').text('{l s='Add Room'}');
            $('.rm-edit-only').hide();
            $('#roomModal').modal('show');
        },
        openEditMode: function () {
            var idRoom = $(this).closest('.room_data_values').data('id-room');
            if (!idRoom) return;

            RoomModal.resetForm();
            $('#rm_id_room').val(idRoom);
            $('#rm_modal_mode').val('edit');
            $('#roomModalTitle').text('{l s='Edit Details'}');
            $('.rm-edit-only').show();
            $('#roomModal').modal('show');

            RoomModal.fetchRoomInfo(idRoom);
        },
        fetchRoomInfo: function (idRoom) {
            $.ajax({
                url: prod_link,
                type: 'POST',
                dataType: 'json',
                data: { ajax: true, action: 'GetRoomInfo', id: idRoom },
                success: function (resp) {
                    if (resp.success && resp.room) {
                        var r = resp.room;
                        $('#rm_num').val(r.room_num);
                        $('#rm_name').val(r.room_num);
                        $('#rm_floor').val(r.floor);
                        $('#rm_status_sel').val(r.id_status);
                        $('#rm_comment').val(r.comment);
                    } else {
                        RoomModal.showError(resp.error || '{l s='Could not load room data.'}');
                    }
                },
                error: function () {
                    RoomModal.showError('{l s='Server error. Please try again.'}');
                }
            });
        },
        openDisableDatesFromEdit: function () {
            var idRoom = $('#rm_id_room').val();
            var $card  = $('.room_data_values[data-id-room="' + idRoom + '"]');
            $('#roomModal').modal('hide');
            $('#roomModal').one('hidden.bs.modal', function () {
                $card.find('.deactiveDatesModal').trigger('click');
            });
        },
        save: function ($btn) {
            RoomModal.hideError();

            $('#page-loader').show();
            $btn.prop('disabled', false);

            $.ajax({
                url:      prod_link,
                type:     'POST',
                dataType: 'json',
                data: {
                    ajax:       true,
                    action:     'SaveRoom',
                    id_room:    $('#rm_id_room').val(),
                    id_product: $('#rm_id_product').val(),
                    room_num:   $('#rm_num').val().trim(),
                    floor:      $('#rm_floor').val().trim(),
                    id_status:  $('#rm_status_sel').val(),
                    comment:    $('#rm_comment').val().trim()
                },
                success: function (resp) {
                    if (resp.success && resp.href) {
                        window.location.href = resp.href;
                    } else {
                        var msg = (resp.errors && resp.errors.length)
                            ? resp.errors.join('<br>')
                            : '{l s='Unable to save room. Please try again.'}';
                        RoomModal.showError(msg);
                    }
                },
                error: function () {
                    RoomModal.showError('{l s='Server error. Please try again.'}');
                    $btn.prop('disabled', false).text(origLabel);
                },
                complete: function () {
                    $('#page-loader').hide();
                    $btn.prop('disabled', false);
                }
            });
        }
    };

    RoomModal.init();

</script>
{/if}
