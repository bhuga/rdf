module RDF class Query
  ##
  # An RDF query solution.
  class Solution
    undef_method *(instance_methods - %w(__id__ __send__ __class__ __eval__ instance_eval inspect class object_id))

    include Enumerable

    ##
    # @param  [Hash{Symbol => Value}] bindings
    def initialize(bindings = {})
      @bindings = bindings
    end

    ##
    # Enumerates over every variable binding in this solution.
    #
    # @yield  [name, value]
    # @yieldparam [Symbol, Value]
    # @return [Enumerator]
    def each_binding(&block)
      @bindings.each(&block)
    end

    alias_method :each, :each_binding

    ##
    # Enumerates over every variable name in this solution.
    #
    # @yield  [name]
    # @yieldparam [Symbol]
    # @return [Enumerator]
    def each_name(&block)
      @bindings.each_key(&block)
    end

    alias_method :each_key, :each_name

    ##
    # Enumerates over every variable value in this solution.
    #
    # @yield  [value]
    # @yieldparam [Value]
    # @return [Enumerator]
    def each_value(&block)
      @bindings.each_value(&block)
    end

    ##
    # Enumerates over every variable in this solution.
    #
    # @yield  [variable]
    # @yieldparam [Variable]
    # @return [Enumerator]
    def each_variable(&block)
      @bindings.each do |name, value|
        block.call(Variable.new(name, value))
      end
    end

    ##
    # Returns the value of the variable `name`.
    #
    # @param  [Symbol] name
    # @return [Value]
    def [](name)
      @bindings[name.to_sym]
    end

    ##
    # @return [Array<Array(Symbol, Value)>}
    def to_a
      @bindings.to_a
    end

    ##
    # @return [Hash{Symbol => Value}}
    def to_hash
      @bindings.dup
    end

    ##
    # @return [String]
    def inspect
      sprintf("#<%s:%#0x(%s)>", self.class.name, object_id, @bindings.inspect)
    end

    protected

      ##
      # @param  [Symbol] name
      # @return [Value]
      def method_missing(name, *args, &block)
        if args.empty? && @bindings.has_key?(name.to_sym)
          @bindings[name.to_sym]
        else
          super
        end
      end

  end
end end