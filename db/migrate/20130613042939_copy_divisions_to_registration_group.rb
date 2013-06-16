class CopyDivisionsToRegistrationGroup < ActiveRecord::Migration
  def up
    registration_group_type = RegistrationGroupType.find_or_create_by_name('division')
    Division.all.each do |div|
      parent = RegistrationGroup.find_by_name(div.tier.name)
      RegistrationGroup.create({
        event_id: parent.event_id,
        name:     div.name,
        position: div.index,
        parent_id: parent.id,
        registration_group_type_id: registration_group_type.id}, without_protection: true)
    end
  end

  def down
    registration_group_type = RegistrationGroupType.where(name: 'division').first
    RegistrationGroup.where("registration_group_type_id = '?'", registration_group_type.id).destroy_all
  end
end
