<?php
/**
 * @file
 * content_type_basic_page.features.inc
 */

/**
 * Implements hook_ctools_plugin_api().
 */
function content_type_basic_page_ctools_plugin_api($module = NULL, $api = NULL) {
  if ($module == "strongarm" && $api == "strongarm") {
    return array("version" => "1");
  }
}

/**
 * Implements hook_node_info().
 */
function content_type_basic_page_node_info() {
  $items = array(
    'page' => array(
      'name' => t('Eenvoudige pagina'),
      'base' => 'node_content',
      'description' => t('Gebruik <em>basispagina\'s</em> voor vaste inhoud, zoals een \'Over ons\'-pagina.'),
      'has_title' => '1',
      'title_label' => t('Titel'),
      'help' => '',
    ),
  );
  drupal_alter('node_info', $items);
  return $items;
}
