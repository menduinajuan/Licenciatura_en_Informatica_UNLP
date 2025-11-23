package oo1_e1;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class WallPostTest {

    private WallPost wallPost;
    private WallPost coolPost;

    @BeforeEach
    public void setUp() throws Exception {
        this.wallPost=new WallPost();
        this.coolPost=new WallPost();
        this.coolPost.like();
        this.coolPost.like();
        this.coolPost.like();
        this.coolPost.like();
        this.coolPost.toggleFeatured();
    }

    @Test
    public void testConstructor() {
        assertEquals("Undefined post", this.wallPost.getText());
        assertEquals(0, this.wallPost.getLikes());
        assertEquals(false, this.wallPost.isFeatured());
    }

    @Test
    public void testText() {
        final String hello="Hello";
        this.wallPost.setText(hello);
        assertEquals(hello, this.wallPost.getText());
        final String bye="Bye";
        this.wallPost.setText(bye);
        assertEquals(bye, this.wallPost.getText());
    }

    @Test
    public void testLike() {
        assertEquals(0, this.wallPost.getLikes());
        this.wallPost.like();
        assertEquals(1, this.wallPost.getLikes());
        this.wallPost.like();
        this.wallPost.like();
        this.wallPost.like();
        assertEquals(4, this.wallPost.getLikes());
    }

    @Test
    public void testDislike() {
        this.coolPost.dislike();
        assertEquals(3, this.coolPost.getLikes());
        this.coolPost.dislike();
        this.coolPost.dislike();
        assertEquals(1, this.coolPost.getLikes());
        this.coolPost.dislike();
        assertEquals(0, this.coolPost.getLikes());
        this.coolPost.dislike();
        assertEquals(0, this.coolPost.getLikes());
    }

    @Test
    public void testFeatured() {
        assertFalse(this.wallPost.isFeatured());
    }

    @Test
    public void testToggleFeatured() {
        this.wallPost.toggleFeatured();
        assertTrue(this.wallPost.isFeatured());
        this.coolPost.toggleFeatured();
        assertFalse(this.coolPost.isFeatured());
    }

}