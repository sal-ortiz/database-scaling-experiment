// https://www.postgresql.org/docs/9.6/errcodes-appendix.html


module.exports = {

  // Class 00 — Successful Completion
  '00000': {
    message: 'Successful Completion',
    identifier: 'successful_completion',
  },

  // Class 01 — Warning
  '01000': {
    message: 'Warning',
    identifier: 'warning',
  },

  '0100C': {
    message: 'Warning',
    identifier: 'dynamic_result_sets_returned',
  },

  '0100B': {
    message: 'Warning',
    identifier: 'implicit_zero_bit_padding',
  },

  '01003': {
    message: 'Warning',
    identifier: 'null_value_eliminated_in_set_function',
  },

  '01007': {
    message: 'Warning',
    identifier: 'privilege_not_granted',
  },

  '01006': {
    message: 'Warning',
    identifier: 'privilege_not_revoked',
  },

  '01004': {
    message: 'Warning',
    identifier: 'string_data_right_truncation',
  },

  '01P01': {
    message: 'Warning',
    identifier: 'deprecated_feature',
  },

  // Class 02 — No Data (this is also a warning class per the SQL standard)
  '02000': {
    message: 'No Data',
    identifier: 'no_data',
  },

  '02001': {
    message: 'No Data',
    identifier: 'no_additional_dynamic_result_sets_returned',
  },

  // Class 03 — SQL Statement Not Yet Complete
  '03000': {
    message: 'SQL Statement Not Yet Complete',
    identifier: 'sql_statement_not_yet_complete',
  },

  // Class 08 — Connection Exception
  '08000': {
    message: 'Connection Exception',
    identifier: 'connection_exception',
  },

  '08003': {
    message: 'Connection Exception',
    identifier: 'connection_does_not_exist',
  },

  '08006': {
    message: 'Connection Exception',
    identifier: 'connection_failure',
  },

  '08001': {
    message: 'Connection Exception',
    identifier: 'sqlclient_unable_to_establish_sqlconnection',
  },

  '08004': {
    message: 'connection exception',
    identifier: 'sqlserver_rejected_establishment_of_sqlconnection',
  },

  '08007': {
    message: 'Connection Exception',
    identifier: 'transaction_resolution_unknown',
  },

  '08P01': {
    message: 'Connection Exception',
    identifier: 'protocol_violation',
  },

  // Class 09 — Triggered Action Exception
  '09000': {
    message: 'Triggered Action Exception',
    identifier: 'triggered_action_exception',
  },

  // Class 0A — Feature Not Supported
  '0A000': {
    message: 'Feature Not Supported',
    identifier: 'feature_not_supported',
  },

  // Class 0B — Invalid Transaction Initiation
  '0B000': {
    message: 'Invalid Transaction Initiation',
    identifier: 'invalid_transaction_initiation',
  },

  // Class 0F — Locator Exception
  '0F000': {
    message: 'Locator Exception',
    identifier: 'locator_exception',
  },

  '0F001': {
    message: 'Locator Exception',
    identifier: 'invalid_locator_specification',
  },

  // Class 0L — Invalid Grantor
  '0L000': {
    message: 'Invalid Grantor',
    identifier: 'invalid_grantor',
  },

  '0LP01': {
    message: 'Invalid Grantor',
    identifier: 'invalid_grant_operation',
  },

  // Class 0P — Invalid Role Specification
  '0P000': {
    message: 'Invalid Role Specification',
    identifier: 'invalid_role_specification',
  },

  // Class 0Z — Diagnostics Exception
  '0Z000': {
    message: 'Diagnostics Exception',
    identifier: 'diagnostics_exception',
  },

  '0Z002': {
    message: 'Diagnostics Exception',
    identifier: 'stacked_diagnostics_accessed_without_active_handler',
  },

  // Class 20 — Case Not Found
  '20000': {
    message: 'Case Not Found',
    identifier: 'case_not_found',
  },

  // Class 21 — Cardinality Violation
  '21000': {
    message: 'Cardinality Violation',
    identifier: 'cardinality_violation',
  },

  // Class 22 — Data Exception
  '22000': {
    message: 'Data Exception',
    identifier: 'data_exception',
  },

  '2202E': {
    message: 'Data Exception',
    identifier: 'array_subscript_error',
  },

  '22021': {
    message: 'Data Exception',
    identifier: 'character_not_in_repertoire',
  },

  '22008': {
    message: 'Data Exception',
    identifier: 'datetime_field_overflow',
  },

  '22012': {
    message: 'Data Exception',
    identifier: 'division_by_zero',
  },

  '22005': {
    message: 'Data Exception',
    identifier: 'error_in_assignment',
  },

  '2200B': {
    message: 'Data Exception',
    identifier: 'escape_character_conflict',
  },

  '22022': {
    message: 'Data Exception',
    identifier: 'indicator_overflow',
  },

  '22015': {
    message: 'Data Exception',
    identifier: 'interval_field_overflow',
  },

  '2201E': {
    message: 'Data Exception',
    identifier: 'invalid_argument_for_logarithm',
  },

  '22014': {
    message: 'Data Exception',
    identifier: 'invalid_argument_for_ntile_function',
  },

  '22016': {
    message: 'Data Exception',
    identifier: 'invalid_argument_for_nth_value_function',
  },

  '2201F': {
    message: 'Data Exception',
    identifier: 'invalid_argument_for_power_function',
  },

  '2201G': {
    message: 'Data Exception',
    identifier: 'invalid_argument_for_width_bucket_function',
  },

  '22018': {
    message: 'Data Exception',
    identifier: 'invalid_character_value_for_cast',
  },

  '22007': {
    message: 'Data Exception',
    identifier: 'invalid_datetime_format',
  },

  '22019': {
    message: 'Data Exception',
    identifier: 'invalid_escape_character',
  },

  '2200D': {
    message: 'Data Exception',
    identifier: 'invalid_escape_octet',
  },

  '22025': {
    message: 'Data Exception',
    identifier: 'invalid_escape_sequence',
  },

  '22P06': {
    message: 'Data Exception',
    identifier: 'nonstandard_use_of_escape_character',
  },

  '22010': {
    message: 'Data Exception',
    identifier: 'invalid_indicator_parameter_value',
  },

  '22023': {
    message: 'Data Exception',
    identifier: 'invalid_parameter_value',
  },

  '2201B': {
    message: 'Data Exception',
    identifier: 'invalid_regular_expression',
  },

  '2201W': {
    message: 'Data Exception',
    identifier: 'invalid_row_count_in_limit_clause',
  },

  '2201X': {
    message: 'Data Exception',
    identifier: 'invalid_row_count_in_result_offset_clause',
  },

  '2202H': {
    message: 'Data Exception',
    identifier: 'invalid_tablesample_argument',
  },

  '2202G': {
    message: 'Data Exception',
    identifier: 'invalid_tablesample_repeat',
  },

  '22009': {
    message: 'Data Exception',
    identifier: 'invalid_time_zone_displacement_value',
  },

  '2200C': {
    message: 'Data Exception',
    identifier: 'invalid_use_of_escape_character',
  },

  '2200G': {
    message: 'Data Exception',
    identifier: 'most_specific_type_mismatch',
  },

  '22004': {
    message: 'Data Exception',
    identifier: 'null_value_not_allowed',
  },

  '22002': {
    message: 'Data Exception',
    identifier: 'null_value_no_indicator_parameter',
  },

  '22003': {
    message: 'Data Exception',
    identifier: 'numeric_value_out_of_range',
  },

  '22026': {
    message: 'Data Exception',
    identifier: 'string_data_length_mismatch',
  },

  '22001': {
    message: 'Data Exception',
    identifier: 'string_data_right_truncation',
  },

  '22011': {
    message: 'Data Exception',
    identifier: 'substring_error',
  },

  '22027': {
    message: 'Data Exception',
    identifier: 'trim_error',
  },

  '22024': {
    message: 'Data Exception',
    identifier: 'unterminated_c_string',
  },

  '2200F': {
    message: 'Data Exception',
    identifier: 'zero_length_character_string',
  },

  '22P01': {
    message: 'Data Exception',
    identifier: 'floating_point_exception',
  },

  '22P02': {
    message: 'Data Exception',
    identifier: 'invalid_text_representation',
  },

  '22P03': {
    message: 'Data Exception',
    identifier: 'invalid_binary_representation',
  },

  '22P04': {
    message: 'Data Exception',
    identifier: 'bad_copy_file_format',
  },

  '22P05': {
    message: 'Data Exception',
    identifier: 'untranslatable_character',
  },

  '2200L': {
    message: 'Data Exception',
    identifier: 'not_an_xml_document',
  },

  '2200M': {
    message: 'Data Exception',
    identifier: 'invalid_xml_document',
  },

  '2200N': {
    message: 'Data Exception',
    identifier: 'invalid_xml_content',
  },

  '2200S': {
    message: 'Data Exception',
    identifier: 'invalid_xml_comment',
  },

  '2200T': {
    message: 'Data Exception',
    identifier: 'invalid_xml_processing_instruction',
  },

  //Class 23 — Integrity Constraint Violation
  '23000': {
    message: 'Integrity Constraint Violation',
    identifier: 'integrity_constraint_violation',
  },

  '23001': {
    message: 'Integrity Constraint Violation',
    identifier: 'restrict_violation',
  },

  '23502': {
    message: 'Integrity Constraint Violation',
    identifier: 'not_null_violation',
  },

  '23503': {
    message: 'Integrity Constraint Violation',
    identifier: 'foreign_key_violation',
  },

  '23505': {
    message: 'Integrity Constraint Violation',
    identifier: 'unique_violation',
  },

  '23514': {
    message: 'Integrity Constraint Violation',
    identifier: 'check_violation',
  },

  '23P01': {
    message: 'Integrity Constraint Violation',
    identifier: 'exclusion_violation',
  },

  // Class 24 — Invalid Cursor State
  '24000': {
    message: 'Invalid Cursor State',
    identifier: 'invalid_cursor_state',
  },

  // Class 25 — Invalid Transaction State
  '25000': {
    message: 'Invalid Transaction State',
    identifier: 'invalid_transaction_state',
  },

  '25001': {
    message: 'Invalid Transaction State',
    identifier: 'active_sql_transaction',
  },

  '25002': {
    message: 'Invalid Transaction State',
    identifier: 'branch_transaction_already_active',
  },

  '25008': {
    message: 'Invalid Transaction State',
    identifier: 'held_cursor_requires_same_isolation_level',
  },

  '25003': {
    message: 'Invalid Transaction State',
    identifier: 'inappropriate_access_mode_for_branch_transaction',
  },

  '25004': {
    message: 'Invalid Transaction State',
    identifier: 'inappropriate_isolation_level_for_branch_transaction',
  },

  '25005': {
    message: 'Invalid Transaction State',
    identifier: 'no_active_sql_transaction_for_branch_transaction',
  },

  '25006': {
    message: 'Invalid Transaction State',
    identifier: 'read_only_sql_transaction',
  },

  '25007': {
    message: 'Invalid Transaction State',
    identifier: 'schema_and_data_statement_mixing_not_supported',
  },

  '25P01': {
    message: 'Invalid Transaction State',
    identifier: 'no_active_sql_transaction',
  },

  '25P02': {
    message: 'Invalid Transaction State',
    identifier: 'in_failed_sql_transaction',
  },

  '25P03': {
    message: 'Invalid Transaction State',
    identifier: 'idle_in_transaction_session_timeout',
  },

  // Class 26 — Invalid SQL Statement Name
  '26000': {
    message: 'Invalid SQL Statement Name',
    identifier: 'invalid_sql_statement_name',
  },

  // Class 27 — Triggered Data Change Violation
  '27000': {
    message: 'Triggered Data Change Violation',
    identifier: 'triggered_data_change_violation',
  },

  // Class 28 — Invalid Authorization Specification
  '28000': {
    message: 'Invalid Authorization Specification',
    identifier: 'invalid_authorization_specification',
  },

  '28P01': {
    message: 'Invalid Authorization Specification',
    identifier: 'invalid_password',
  },

  // Class 2B — Dependent Privilege Descriptors Still Exist
  '2B000': {
    message: 'Dependent Privilege Descriptors Still Exist',
    identifier: 'dependent_privilege_descriptors_still_exist',
  },

  '2BP01': {
    message: 'Dependent Privilege Descriptors Still Exist',
    identifier: 'dependent_objects_still_exist',
  },

  // Class 2D — Invalid Transaction Termination
  '2D000': {
    message: 'Invalid Transaction Termination',
    identifier: 'invalid_transaction_termination',
  },

  // Class 2F — SQL Routine Exception
  '2F000': {
    message: 'SQL Routine Exception',
    identifier: 'sql_routine_exception',
  },

  '2F005': {
    message: 'SQL Routine Exception',
    identifier: 'function_executed_no_return_statement',
  },

  '2F002': {
    message: 'SQL Routine Exception',
    identifier: 'modifying_sql_data_not_permitted',
  },

  '2F003': {
    message: 'SQL Routine Exception',
    identifier: 'prohibited_sql_statement_attempted',
  },

  '2F004': {
    message: 'SQL Routine Exception',
    identifier: 'reading_sql_data_not_permitted',
  },

  // Class 34 — Invalid Cursor Name
  '34000': {
    message: 'Invalid Cursor Name',
    identifier: 'invalid_cursor_name',
  },

  // Class 38 — External Routine Exception
  '38000': {
    message: 'External Routine Exception',
    identifier: 'external_routine_exception',
  },

  '38001': {
    message: 'External Routine Exception',
    identifier: 'containing_sql_not_permitted',
  },

  '38002': {
    message: 'External Routine Exception',
    identifier: 'modifying_sql_data_not_permitted',
  },

  '38003': {
    message: 'External Routine Exception',
    identifier: 'prohibited_sql_statement_attempted',
  },

  '38004': {
    message: 'External Routine Exception',
    identifier: 'reading_sql_data_not_permitted',
  },

  // Class 39 — External Routine Invocation Exception
  '39000': {
    message: 'External Routine Invocation Exception',
    identifier: 'external_routine_invocation_exception',
  },

  '39001': {
    message: 'External Routine Invocation Exception',
    identifier: 'invalid_sqlstate_returned',
  },

  '39004': {
    message: 'External Routine Invocation Exception',
    identifier: 'null_value_not_allowed',
  },

  '39P01': {
    message: 'External Routine Invocation Exception',
    identifier: 'trigger_protocol_violated',
  },

  '39P02': {
    message: 'External Routine Invocation Exception',
    identifier: 'srf_protocol_violated',
  },

  '39P03': {
    message: 'External Routine Invocation Exception',
    identifier: 'event_trigger_protocol_violated',
  },

  // Class 3B — Savepoint Exception
  '3B000': {
    message: 'Savepoint Exception',
    identifier: 'savepoint_exception',
  },

  '3B001': {
    message: 'Savepoint Exception',
    identifier: 'invalid_savepoint_specification',
  },

  // Class 3D — Invalid Catalog Name
  '3D000': {
    message: 'Invalid Catalog Name',
    identifier: 'invalid_catalog_name',
  },

  // Class 3F — Invalid Schema Name
  '3F000': {
    message: 'Invalid Schema Name',
    identifier: 'invalid_schema_name',
  },

  // Class 40 — Transaction Rollback
  '40000': {
    message: 'Transaction Rollback',
    identifier: 'transaction_rollback',
  },

  '40002': {
    message: 'Transaction Rollback',
    identifier: 'transaction_integrity_constraint_violation',
  },

  '40001': {
    message: 'Transaction Rollback',
    identifier: 'serialization_failure',
  },

  '40003': {
    message: 'Transaction Rollback',
    identifier: 'statement_completion_unknown',
  },

  '40P01': {
    message: 'Transaction Rollback',
    identifier: 'deadlock_detected',
  },

  // Class 42 — Syntax Error or Access Rule Violation
  '42000': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'syntax_error_or_access_rule_violation',
  },

  '42601': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'syntax_error',
  },

  '42501': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'insufficient_privilege',
  },

  '42846': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'cannot_coerce',
  },

  '42803': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'grouping_error',
  },

  '42P20': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'windowing_error',
  },

  '42P19': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'invalid_recursion',
  },

  '42830': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'invalid_foreign_key',
  },

  '42602': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'invalid_name',
  },

  '42622': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'name_too_long',
  },

  '42939': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'reserved_name',
  },

  '42804': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'datatype_mismatch',
  },

  '42P18': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'indeterminate_datatype',
  },

  '42P21': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'collation_mismatch',
  },

  '42P22': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'indeterminate_collation',
  },

  '42809': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'wrong_object_type',
  },

  '42703': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'undefined_column',
  },

  '42883': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'undefined_function',
  },

  '42P01': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'undefined_table',
  },

  '42P02': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'undefined_parameter',
  },

  '42704': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'undefined_object',
  },

  '42701': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'duplicate_column',
  },

  '42P03': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'duplicate_cursor',
  },

  '42P04': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'duplicate_database',
  },

  '42723': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'duplicate_function',
  },

  '42P05': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'duplicate_prepared_statement',
  },

  '42704': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'undefined_object',
  },

  '42701': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'duplicate_column',
  },

  '42P03': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'duplicate_cursor',
  },

  '42P04': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'duplicate_database',
  },

  '42723': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'duplicate_function',
  },

  '42P05': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'duplicate_prepared_statement',
  },

  '42P06': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'duplicate_schema',
  },

  '42P07': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'duplicate_table',
  },

  '42712': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'duplicate_alias',
  },

  '42710': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'duplicate_object',
  },

  '42702': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'ambiguous_column',
  },

  '42725': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'ambiguous_function',
  },

  '42P08': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'ambiguous_parameter',
  },

  '42P09': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'ambiguous_alias',
  },

  '42P10': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'invalid_column_reference',
  },

  '42611': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'invalid_column_definition',
  },

  '42P11': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'invalid_cursor_definition',
  },

  '42P12': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'invalid_database_definition',
  },

  '42P13': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'invalid_function_definition',
  },

  '42P14': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'invalid_prepared_statement_definition',
  },

  '42P15': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'invalid_schema_definition',
  },

  '42P16': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'invalid_table_definition',
  },

  '42P17': {
    message: 'Syntax Error or Access Rule Violation',
    identifier: 'invalid_object_definition',
  },

  // Class 44 — WITH CHECK OPTION Violation
  '44000': {
    message: 'WITH CHECK OPTION Violation',
    identifier: 'with_check_option_violation',
  },

  // Class 53 — Insufficient Resources
  '53000': {
    message: 'Insufficient Resources',
    identifier: 'insufficient_resources',
  },

  '53100': {
    message: 'Insufficient Resources',
    identifier: 'disk_full',
  },

  '53200': {
    message: 'Insufficient Resources',
    identifier: 'out_of_memory',
  },

  '53300': {
    message: 'Insufficient Resources',
    identifier: 'too_many_connections',
  },

  '53400': {
    message: 'Insufficient Resources',
    identifier: 'configuration_limit_exceeded',
  },

  // Class 54 — Program Limit Exceeded
  '54000': {
    message: 'Program Limit Exceeded',
    identifier: 'program_limit_exceeded',
  },

  '54001': {
    message: 'Program Limit Exceeded',
    identifier: 'statement_too_complex',
  },

  '54011': {
    message: 'Program Limit Exceeded',
    identifier: 'too_many_columns',
  },

  '54023': {
    message: 'Program Limit Exceeded',
    identifier: 'too_many_arguments',
  },

  // Class 55 — Object Not In Prerequisite State
  '55000': {
    message: 'Object Not In Prerequisite State',
    identifier: 'object_not_in_prerequisite_state',
  },

  '55006': {
    message: 'Object Not In Prerequisite State',
    identifier: 'object_in_use',
  },

  '55P02': {
    message: 'Object Not In Prerequisite State',
    identifier: 'cant_change_runtime_param',
  },

  '55P03': {
    message: 'Object Not In Prerequisite State',
    identifier: 'lock_not_available',
  },

  // Class 57 — Operator Intervention
  '57000': {
    message: 'Operator Intervention',
    identifier: 'operator_intervention',
  },

  '57014': {
    message: 'Operator Intervention',
    identifier: 'query_canceled',
  },

  '57P01': {
    message: 'Operator Intervention',
    identifier: 'admin_shutdown',
  },

  '57P02': {
    message: 'Operator Intervention',
    identifier: 'crash_shutdown',
  },

  '57P03': {
    message: 'Operator Intervention',
    identifier: 'cannot_connect_now',
  },

  '57P04': {
    message: 'Operator Intervention',
    identifier: 'database_dropped',
  },

  // Class 58 — System Error (errors external to PostgreSQL itself)
  '58000': {
    message: 'System Error',
    identifier: 'system_error',
  },

  '58030': {
    message: 'System Error',
    identifier: 'io_error',
  },

  '58P01': {
    message: 'System Error',
    identifier: 'undefined_file',
  },

  '58P02': {
    message: 'System Error',
    identifier: 'duplicate_file',
  },

  // Class 72 — Snapshot Failure
  '72000': {
    message: 'Snapshot Failure',
    identifier: 'snapshot_too_old',
  },

  // Class F0 — Configuration File Error
  'F0000': {
    message: 'Configuration File Error',
    identifier: 'config_file_error',
  },

  'F0001': {
    message: 'Configuration File Error',
    identifier: 'lock_file_exists',
  },

  // Class HV — Foreign Data Wrapper Error (SQL/MED)
  'HV000': {
    message: 'Foreign Data Wrapper Error',
    identifier: 'fdw_error',
  },

  'HV005': {
    message: 'Foreign Data Wrapper Error',
    identifier: 'fdw_column_name_not_found',
  },

  'HV002': {
    message: 'Foreign Data Wrapper Error',
    identifier: 'fdw_dynamic_parameter_value_needed',
  },

  'HV010': {
    message: 'Foreign Data Wrapper Error',
    identifier: 'fdw_function_sequence_error',
  },

  'HV021': {
    message: 'Foreign Data Wrapper Error',
    identifier: 'fdw_inconsistent_descriptor_information',
  },

  'HV024': {
    message: 'Foreign Data Wrapper Error',
    identifier: 'fdw_invalid_attribute_value',
  },

  'HV007': {
    message: 'Foreign Data Wrapper Error',
    identifier: 'fdw_invalid_column_name',
  },

  'HV008': {
    message: 'Foreign Data Wrapper Error',
    identifier: 'fdw_invalid_column_number',
  },

  'HV004': {
    message: 'Foreign Data Wrapper Error',
    identifier: 'fdw_invalid_data_type',
  },

  'HV006': {
    message: 'Foreign Data Wrapper Error',
    identifier: 'fdw_invalid_data_type_descriptors',
  },

  'HV091': {
    message: 'Foreign Data Wrapper Error',
    identifier: 'fdw_invalid_descriptor_field_identifier',
  },

  'HV00B': {
    message: 'Foreign Data Wrapper Error',
    identifier: 'fdw_invalid_handle',
  },

  'HV00C': {
    message: 'Foreign Data Wrapper Error',
    identifier: 'fdw_invalid_option_index',
  },

  'HV00D': {
    message: 'Foreign Data Wrapper Error',
    identifier: 'fdw_invalid_option_name',
  },

  'HV090': {
    message: 'Foreign Data Wrapper Error',
    identifier: 'fdw_invalid_string_length_or_buffer_length',
  },

  'HV00A': {
    message: 'Foreign Data Wrapper Error',
    identifier: 'fdw_invalid_string_format',
  },

  'HV009': {
    message: 'Foreign Data Wrapper Error',
    identifier: 'fdw_invalid_use_of_null_pointer',
  },

  'HV014': {
    message: 'Foreign Data Wrapper Error',
    identifier: 'fdw_too_many_handles',
  },

  'HV001': {
    message: 'Foreign Data Wrapper Error',
    identifier: 'fdw_out_of_memory',
  },

  'HV00P': {
    message: 'Foreign Data Wrapper Error',
    identifier: 'fdw_no_schemas',
  },

  'HV00J': {
    message: 'Foreign Data Wrapper Error',
    identifier: 'fdw_option_name_not_found',
  },

  'HV00K': {
    message: 'Foreign Data Wrapper Error',
    identifier: 'fdw_reply_handle',
  },

  'HV00Q': {
    message: 'Foreign Data Wrapper Error',
    identifier: 'fdw_schema_not_found',
  },

  'HV00R': {
    message: 'Foreign Data Wrapper Error',
    identifier: 'fdw_table_not_found',
  },

  'HV00L': {
    message: 'Foreign Data Wrapper Error',
    identifier: 'fdw_unable_to_create_execution',
  },

  'HV00M': {
    message: 'Foreign Data Wrapper Error',
    identifier: 'fdw_unable_to_create_reply',
  },

  'HV00N': {
    message: 'Foreign Data Wrapper Error',
    identifier: 'fdw_unable_to_establish_connection',
  },

  // Class P0 — PL/pgSQL Error
  'P0000': {
    message: 'PL/pgSQL Error',
    identifier: 'plpgsql_error',
  },

  'P0001': {
    message: 'PL/pgSQL Error',
    identifier: 'raise_exception',
  },

  'P0002': {
    message: 'PL/pgSQL Error',
    identifier: 'no_data_found',
  },

  'P0003': {
    message: 'PL/pgSQL Error',
    identifier: 'too_many_rows',
  },

  'P0004': {
    message: 'PL/pgSQL Error',
    identifier: 'assert_failure',
  },

  // Class XX — Internal Error
  'XX000': {
    message: 'Internal Error',
    identifier: 'internal_error',
  },

  'XX001': {
    message: 'Internal Error',
    identifier: 'data_corrupted',
  },

  'XX002': {
    message: 'Internal Error',
    identifier: 'index_corrupted',
  },

};
