module CasSessionStore
  module DbCasSession
    def self.included(base)
      cas_session_model_path = "#{Rails.root}/app/models/cas_session.rb"
      if File.exists?(cas_session_model_path)
        require cas_session_model_path
      else
        Object.const_set(:CasSession, Class.new(ActiveRecord::Base)) unless Object.const_defined?(:CasSession)
        base.extend(ClassMethods)
      end
    end

    module ClassMethods
      def store_service_session_lookup(st, sid)
        CasSession.create(:service_ticket => st.ticket, :session_id => sid)
      end

      def read_service_session_lookup(st)
        CasSession.find_by_service_ticket(st).session_id
      end

      def delete_service_session_lookup(st)
        CasSession.find_by_service_ticket(st).destroy
      end
    end
  end
end
