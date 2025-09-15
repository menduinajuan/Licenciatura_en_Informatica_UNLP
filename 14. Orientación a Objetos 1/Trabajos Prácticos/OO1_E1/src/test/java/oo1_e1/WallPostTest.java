package oo1_e1;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class WallPostTest {

    WallPost wallPost;
    WallPost coolPost;

    @BeforeEach
    public void setUp() throws Exception {
        wallPost=new WallPost();
        coolPost=new WallPost();
        coolPost.like();
        coolPost.like();
        coolPost.like();
        coolPost.like();
        coolPost.toggleFeatured();
    }

    @Test
    public void testConstructor() {
        assertEquals("Undefined post", wallPost.getText());
        assertEquals(0, wallPost.getLikes());
        assertEquals(false, wallPost.isFeatured());
    }

    @Test
    public void testText() {
        final String hello="Hello";
        wallPost.setText(hello);
        assertEquals(hello, wallPost.getText());
        final String bye="Bye";
        wallPost.setText(bye);
        assertEquals(bye, wallPost.getText());
    }

    @Test
    public void testLike() {
        assertEquals(0, wallPost.getLikes());
        wallPost.like();
        assertEquals(1, wallPost.getLikes());
        wallPost.like();
        wallPost.like();
        wallPost.like();
        assertEquals(4, wallPost.getLikes());
    }

    @Test
    public void testDislike() {
        coolPost.dislike();
        assertEquals(3, coolPost.getLikes());
        coolPost.dislike();
        coolPost.dislike();
        assertEquals(1, coolPost.getLikes());
        coolPost.dislike();
        assertEquals(0, coolPost.getLikes());
        coolPost.dislike();
        assertEquals(0, coolPost.getLikes());
    }

    @Test
    public void testFeatured() {
        assertFalse(wallPost.isFeatured());
    }

    @Test
    public void testToggleFeatured() {
        wallPost.toggleFeatured();
        assertTrue(wallPost.isFeatured());
        coolPost.toggleFeatured();
        assertFalse(coolPost.isFeatured());
    }

}