module RDF
  ##
  # An RDF blank node, also known as an unlabeled node.
  class Node < Resource
    attr_accessor :id

    def initialize(id = nil)
      @id = id || object_id
    end

    def anonymous?() true end

    def labeled?()   !unlabeled? end
    def unlabeled?() anonymous? end

    def to_s
      "_:%s" % id
    end
  end
end