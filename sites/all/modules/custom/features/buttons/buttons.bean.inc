<?php
/**
 * @file
 * buttons.bean.inc
 */

/**
 * Implements hook_bean_admin_ui_types().
 */
function buttons_bean_admin_ui_types() {
  $export = array();

  $bean_type = new stdClass();
  $bean_type->disabled = FALSE; /* Edit this to true to make a default bean_type disabled initially */
  $bean_type->api_version = 5;
  $bean_type->name = 'buttons';
  $bean_type->label = 'buttons';
  $bean_type->options = '';
  $bean_type->description = 'buttons with text ';
  $export['buttons'] = $bean_type;

  return $export;
}
