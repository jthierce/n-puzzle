class Initialize
    def self.create_face color
        return [[color, color, color], [color, color, color], [color, color, color]]
    end

    def self.ini_rubik
        rubik = { up: [], down: [], sider: [], sidel: [], back: [], front: [] }
        rubik[:up] = create_face('y')
        rubik[:down] = create_face('w')
        rubik[:front] = create_face('b')
        rubik[:sider] = create_face('r')
        rubik[:sidel] = create_face('o')
        rubik[:back] = create_face('g')
        return rubik
    end
end