class CoordPair {

private:
    float x_pos;
    float y_pos;

public:
    /**
     * The constructor for a CoordPair.
     *
     * @param x the x-coordinate
     * @param y the y-coordinate
     */
    CoordPair(float x, float y);

    /**
     * The destructor for a CoordPair.
     */
    ~CoordPair(void);

    /**
     * Getter for the x-coordinate.
     *
     * @return x-coordinate of this CoordPair
     */
    float get_x_pos(void) const;

    /**
     * Getter for the y-coordinate.
     *
     * @return y-coordinate of this CoordPair
     */
    float get_y_pos(void) const;

    /**
     * This method translates the CoordPair along the x-axis.
     *
     * @param amount the amount by which to translate the CoordPair
     */
    void translate_x_pos(float amount);

    /**
     * This method translates the CoordPair along the y-axis.
     *
     * @param amount the amount by which to translate the CoordPair
     */
    void translate_y_pos(float amount);

    /**
     * This method rotates the CoordPair around another CoordPair.
     *
     * @param axis_x the x-coordinate of the point about which to rotate
     * @param axis_y the y-coordinate of the point about which to rotate
     * @param theta_degrees number of degrees to rotate
     */
    void rotate_around(
        float axis_x,
        float axis_y,
        float theta_degrees
    );
};
