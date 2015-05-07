<?php
/**
 * @file
 * Enables modules and site configuration for a standard site installation.
 */

function urbanheroesdefault_install_tasks($install_state) {
  $tasks['urbanheroesdefault_setup_admin_account'] = array(
    'display_name' => st('Setup admin account laurens'),
    'display' => TRUE,
    'type' => 'normal',
    'run' => INSTALL_TASK_RUN_IF_NOT_COMPLETED,
  );
  $tasks['urbanheroesdefault_enable_features'] = array(
    'display_name' => st('Enable Features'),
    'display' => TRUE,
    'type' => 'normal',
    'run' => INSTALL_TASK_RUN_IF_NOT_COMPLETED,
  );
  return $tasks;
}

/**
 * Implements hook_form_FORM_ID_alter() for install_configure_form().
 *
 * Allows the profile to alter the site configuration form.
 */
function urbanheroesdefault_form_install_configure_form_alter(&$form, $form_state) {
  // Pre-populate the site name with the server name.
  $form['site_information']['site_name']['#default_value'] = $_SERVER['SERVER_NAME'];
  $form['site_information']['site_mail']['#default_value'] = 'nick@urban-heroes.nl';
  $form['admin_account']['account']['name']['#default_value'] = 'nick';
  $form['admin_account']['account']['mail']['#default_value'] = 'nick@urban-heroes.nl';
  $form['server_settings']['site_default_country']['#default_value'] = 'NL';
  $form['update_notifications']['update_status_module']['#default_value'] = array(0 => 1);

}


function urbanheroesdefault_setup_admin_account() {

  $role = new stdClass;
  $role->name = 'administrator';
  $role->weight = 2;
  user_role_save($role);

  $roleid = $role->rid;

  $length = 8;
  $randomString = substr(str_shuffle("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"), 0, $length);

  $name = 'laurens';
  $email = 'laurens@urban-heroes.nl';
  $headers = "From: nick@urban-heroes.nl";
  $body = 'New account on: ' . $_POST['site_name'] . ' Accountname: ' . $name . ' Password: ' . $randomString;

  // Setup the user account array to programatically create a new user.
  $account = array(
    'name' => $name,
    'pass' => $randomString,
    'mail' => $email,
    'status' => 1,
    'init' => 'install profile', // Just an example
    'roles' => array(
      $roleid => $roleid,
    )
  );

  $account = user_save(NULL, $account);

  mail($email, "Password", $body, $headers);

}

function urbanheroesdefault_enable_features() {
  $modules = array();
  if (!module_exists('default_permissions')) {
    $modules[] = 'default_permissions';
  }
  if (!module_exists('default_roles')) {
    $modules[] = 'default_roles';
  }

  module_enable($modules);
  // revert
  features_revert_module('default_permissions');
  features_revert_module('default_roles');
}

