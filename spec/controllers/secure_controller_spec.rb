require 'rails_helper'


RSpec.describe 'SecureController' do
    context 'roles configuration' do
        class FakeSecureController < SecureController
            allow_roles Roles::CLIENT, Roles::ADMIN 
        end

        it 'allowed' do
            expect(FakeSecureController.new.allowed_roles).to eq([Roles::CLIENT, Roles::ADMIN])
        end

        it 'allowed inherith' do
            class ChildFakeSecureController < FakeSecureController; end
            expect(ChildFakeSecureController.new.allowed_roles).to eq([Roles::CLIENT, Roles::ADMIN])
        end

        it 'allowed inherith more than one level' do
            class ChildAFakeSecureController < FakeSecureController; end
            class ChildBFakeSecureController < ChildAFakeSecureController; end
            expect(ChildBFakeSecureController.new.allowed_roles).to eq([Roles::CLIENT, Roles::ADMIN])
        end

        it 'override parent allowed' do
            class OverrideSecureController < FakeSecureController
                allow_roles Roles::SUPER_ADMIN
            end
            expect(OverrideSecureController.new.allowed_roles).to eq([Roles::SUPER_ADMIN])
        end
    end
end