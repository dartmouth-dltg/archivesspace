# The contents of the hash declared below will be loaded into the global preferences
# record at system start-up. This has the effect of setting defaults for user preferences.
# Only keys matching properties declared in common/schemas/defaults.rb will be loaded.
# TAKE CARE editing this file as errors will prevent the system from starting.
module PreferenceConfig
  def self.defaults
    {
      'show_suppressed' => false,
      'publish' => false,
      'rde_sort_alpha' => true,
      'include_unpublished' => false,
      'digital_object_spawn' => false,
      'accession_browse_column_1' => 'title',
      'accession_browse_column_2' => 'identifier',
      'accession_browse_column_3' => 'accession_date',
      'accession_browse_column_4' => 'dates',
      'accession_browse_column_5' => 'extents',
      'accession_browse_column_6' => '',
      'accession_browse_column_7' => '',
      'accession_sort_column' => 'title',
      'accession_sort_direction' => 'asc',
      'resource_browse_column_1' => 'title',
      'resource_browse_column_2' => 'identifier',
      'resource_browse_column_3' => 'level',
      'resource_browse_column_4' => 'dates',
      'resource_browse_column_5' => 'extents',
      'resource_browse_column_6' => '',
      'resource_browse_column_7' => '',
      'resource_sort_column' => 'title',
      'resource_sort_direction' => 'asc',
      'digital_object_browse_column_1' => 'title',
      'digital_object_browse_column_2' => 'digital_object_id',
      'digital_object_browse_column_3' => '',
      'digital_object_browse_column_4' => '',
      'digital_object_browse_column_5' => '',
      'digital_object_browse_column_6' => '',
      'digital_object_browse_column_7' => '',
      'digital_object_sort_column' => 'title',
      'digital_object_sort_direction' => 'asc',
      'multi_browse_column_1' => 'primary_type',
      'multi_browse_column_2' => 'title',
      'multi_browse_column_3' => 'context',
      'multi_browse_column_4' => 'identifier',
      'multi_browse_column_5' => 'dates',
      'multi_browse_column_6' => '',
      'multi_browse_column_7' => '',
      'multi_sort_column' => 'score',
      'multi_sort_direction' => 'desc',
      'location_browse_column_1' => 'title',
      'location_browse_column_2' => 'building',
      'location_browse_column_3' => 'floor',
      'location_browse_column_4' => 'room',
      'location_browse_column_5' => 'area',
      'location_browse_column_6' => 'location_profile_display_string_u_ssort',
      'location_browse_column_7' => 'location_holdings',
      'location_sort_column' => 'title',
      'location_sort_direction' => 'asc',
      'agent_browse_column_1' => 'primary_type',
      'agent_browse_column_2' => 'title',
      'agent_browse_column_3' => 'authority_id',
      'agent_browse_column_4' => 'source',
      'agent_browse_column_5' => 'rules',
      'agent_browse_column_6' => '',
      'agent_browse_column_7' => '',
      'agent_sort_column' => 'title',
      'agent_sort_direction' => 'asc',
      'archival_object_browse_column_1' => 'title',
      'archival_object_browse_column_2' => 'context',
      'archival_object_browse_column_3' => 'identifier',
      'archival_object_browse_column_4' => 'dates',
      'archival_object_browse_column_5' => 'extents',
      'archival_object_browse_column_6' => '',
      'archival_object_browse_column_7' => '',
      'archival_object_sort_column' => 'title',
      'archival_object_sort_direction' => 'asc',
      'assessment_browse_column_1' => 'assessment_id',
      'assessment_browse_column_2' => 'assessment_records',
      'assessment_browse_column_3' => 'assessment_surveyors',
      'assessment_browse_column_4' => 'assessment_completed',
      'assessment_browse_column_5' => '',
      'assessment_browse_column_6' => '',
      'assessment_browse_column_7' => '',
      'assessment_sort_column' => 'assessment_id',
      'assessment_sort_direction' => 'asc',
      'classification_browse_column_1' => 'title',
      'classification_browse_column_2' => '',
      'classification_browse_column_3' => '',
      'classification_browse_column_4' => '',
      'classification_browse_column_5' => '',
      'classification_browse_column_6' => '',
      'classification_browse_column_7' => '',
      'classification_sort_column' => 'title',
      'classification_sort_direction' => 'asc',
      'collection_management_browse_column_1' => 'parent_title',
      'collection_management_browse_column_2' => 'parent_type',
      'collection_management_browse_column_3' => 'processing_priority',
      'collection_management_browse_column_4' => 'processing_status',
      'collection_management_browse_column_5' => 'processing_hours_total',
      'collection_management_browse_column_6' => '',
      'collection_management_browse_column_7' => '',
      'collection_management_sort_column' => 'parent_title',
      'collection_management_sort_direction' => 'asc',
      'container_profile_browse_column_1' => 'title',
      'container_profile_browse_column_2' => '',
      'container_profile_browse_column_3' => '',
      'container_profile_browse_column_4' => '',
      'container_profile_browse_column_5' => '',
      'container_profile_browse_column_6' => '',
      'container_profile_browse_column_7' => '',
      'container_profile_sort_column' => 'title',
      'container_profile_sort_direction' => 'asc',
      'digital_object_component_browse_column_1' => 'title',
      'digital_object_component_browse_column_2' => 'context',
      'digital_object_component_browse_column_3' => '',
      'digital_object_component_browse_column_4' => '',
      'digital_object_component_browse_column_5' => '',
      'digital_object_component_browse_column_6' => '',
      'digital_object_component_browse_column_7' => '',
      'digital_object_component_sort_column' => 'title',
      'digital_object_component_sort_direction' => 'asc',
      'event_browse_column_1' => 'event_type',
      'event_browse_column_2' => 'outcome',
      'event_browse_column_3' => 'agents',
      'event_browse_column_4' => 'linked_records',
      'event_browse_column_5' => '',
      'event_browse_column_6' => '',
      'event_browse_column_7' => '',
      'event_sort_column' => 'event_type',
      'event_sort_direction' => 'asc',
      'location_profile_browse_column_1' => 'title',
      'location_profile_browse_column_2' => '',
      'location_profile_browse_column_3' => '',
      'location_profile_browse_column_4' => '',
      'location_profile_browse_column_5' => '',
      'location_profile_browse_column_6' => '',
      'location_profile_browse_column_7' => '',
      'location_profile_sort_column' => 'title',
      'location_profile_sort_direction' => 'asc',
      'repositories_browse_column_1' => 'title',
      'repositories_browse_column_2' => 'publish',
      'repositories_browse_column_3' => 'audit_info',
      'repositories_browse_column_4' => '',
      'repositories_browse_column_5' => '',
      'repositories_browse_column_6' => '',
      'repositories_browse_column_7' => '',
      'repositories_sort_column' => 'title',
      'repositories_sort_direction' => 'asc',
      'subject_browse_column_1' => 'title',
      'subject_browse_column_2' => '',
      'subject_browse_column_3' => '',
      'subject_browse_column_4' => '',
      'subject_browse_column_5' => '',
      'subject_browse_column_6' => '',
      'subject_browse_column_7' => '',
      'subject_sort_column' => 'title',
      'subject_sort_direction' => 'asc',
      'top_container_browse_column_1' => 'title',
      'top_container_browse_column_2' => 'context',
      'top_container_browse_column_3' => 'type',
      'top_container_browse_column_4' => 'indicator',
      'top_container_browse_column_5' => 'barcode',
      'top_container_browse_column_6' => 'container_profile_display_string_u_sstr',
      'top_container_browse_column_7' => 'location_display_string_u_sstr',
      'top_container_sort_column' => 'title',
      'top_container_sort_direction' => 'asc',
      'job_browse_column_1' => 'status',
      'job_browse_column_2' => 'job_report_type',
      'job_browse_column_3' => 'job_data',
      'job_browse_column_4' => 'audit_info',
      'job_browse_column_5' => '',
      'job_browse_column_6' => '',
      'job_browse_column_7' => '',
      'job_sort_column' => 'time_submitted',
      'job_sort_direction' => 'desc',
      'locale' => AppConfig[:locale].to_s,
      'note_order' => [],
    }
  end
end
