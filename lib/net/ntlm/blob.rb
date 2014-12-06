module Net
  module NTLM

    BLOB_SIGN = 0x00000101

    class Blob < FieldSet
      int32LE    :blob_signature, {:value => BLOB_SIGN}
      int32LE    :reserved,       {:value => 0}
      int64LE    :timestamp,      {:value => 0}
      string     :challenge,      {:value => "", :size => 8}
      int32LE    :unknown1,       {:value => 0}
      string     :target_info,    {:value => "", :size => 0}

      def parse(str, offset=0)
        if str.size > 28
          enable(:target_info)
          self[:target_info].value = str[28..-1]

        end
        super
      end
    end

  end
end
