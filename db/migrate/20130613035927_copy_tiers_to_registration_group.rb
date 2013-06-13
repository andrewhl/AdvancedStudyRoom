class CopyTiersToRegistrationGroup < ActiveRecord::Migration
  def up
    registration_group_type = RegistrationGroupType.find_or_create_by_name('tier')
    Tier.all.each do |tier|
      RegistrationGroup.create({
        event_id: tier.event_id,
        name: tier.name,
        position: tier.index,
        registration_group_type_id: registration_group_type.id}, without_protection: true)
    end
  end

  def down
    registration_group_type = RegistrationGroupType.where(name: 'tier').first
    RegistrationGroup.where("registration_group_type_id = '?'", registration_group_type.id).destroy_all
  end
end
