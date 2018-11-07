class CreateProjTagNephrologyTables < ActiveRecord::Migration[5.2]

  def up

    create_table "proj_tag_nephrology.tagged_terms" do |t|
      t.string  'term'
    end

    create_table "proj_tag_nephrology.analyzed_studies" do |t|
      t.string  'nct_id'
      t.string  'brief_title'
      t.string  'keywords'
      t.string  'conditions'
      t.string  'mesh_terms'
    end

    #  Views that join across schemas can cause problem for pg_restore. It can get hung up on
    #  dependencies when it's trying to drop/refresh one schema that joins to another
    #  through a view. To get around this problem, we use functions that create the views.
    #  When Core AACT restores the Public Database by dumping/restoring the staging database,
    #  it drops all views before hand. When it's done restoring, it runs a function to recreate
    #  the view.
    execute <<-SQL
        CREATE OR REPLACE FUNCTION proj.create_views() RETURNS void AS
        $BODY$
        BEGIN
          EXECUTE 'CREATE OR REPLACE VIEW proj_tag_nephrology.tagged_studies AS ' ||

            ' select distinct * from ctgov.studies where nct_id in (' ||
              ' select distinct s.nct_id' ||
               ' from ctgov.studies s, ctgov.browse_conditions bc ' ||
               ' where s.study_type=''Interventional''  ' ||
                 ' and s.study_first_posted_date >= ''2007-10-01'' ' ||
                 ' and s.study_first_posted_date < ''2018-11-01'' ' ||
                 ' and s.nct_id = bc.nct_id ' ||
                 ' and bc.downcase_mesh_term IN (select term from proj_tag_nephrology.tagged_terms) '
              ' union ' ||
              '   select distinct s.nct_id ' ||
              '   from ctgov.studies s, ctgov.keywords k ' ||
              '   where s.study_type=''Interventional'' ' ||
              '   and s.study_first_posted_date >= ''2007-10-01'' ' ||
              '   and s.study_first_posted_date < ''2018-11-01'' ' ||
              '   and s.nct_id = k.nct_id ' ||
              '  and k.downcase_name IN (select term from proj_tag_nephrology.tagged_terms)  ' ||
              ' union  ' ||
              '   select distinct s.nct_id  ' ||
              '   from studies s, conditions c  ' ||
              '   where s.study_type=''Interventional''  ' ||
              '   and s.study_first_posted_date >= ''2007-10-01''  ' ||
              '   and s.study_first_posted_date < ''2018-11-01''  ' ||
              '   and s.nct_id = c.nct_id  ' ||
              '   and c.downcase_name IN (select term from proj_tag_nephrology.tagged_terms)  ' ||
              '   ) ';

          RETURN;
        END;
        $BODY$ LANGUAGE plpgsql STRICT;
     SQL

  end

  def down
    execute "DROP SCHEMA proj_tag_nephrology CASCADE;"
  end

end
