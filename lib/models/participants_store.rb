class ParticipantsStore < HotCocoa::TableDataSource
  
  def add_participant(sender, participant)
    # alert(:message => "You need to fill up the form") unless participant.keys.size == 3
    NSLog(participant.inspect)
    @data << participant
    sender.reloadData
  end
  
  def tableView(view, setObjectValue:object, forTableColumn:column, row:index)
    participant = @data[index]
    case column.identifier
      when 'first_name'
        participant[:first_name] = object
      when 'last_name'
        participant[:last_name] = object
      when 'email'
        participant[:email]     = object
    end
  end
  
end