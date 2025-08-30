package ar.edu.unlp.oo1.ejercicio1;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

/**
 * A WallpostTest is a test class for testing the behavior of Wallpost
 */
class WallPostTest {

	WallPost wallPost;
	WallPost coolPost;

	@BeforeEach
	void setUp() {
		wallPost = new WallPost();
		coolPost = new WallPost();
		coolPost.like();
		coolPost.like();
		coolPost.like();
		coolPost.like();
		coolPost.toggleFeatured();
	}

	@Test
	void testCreation() {
		assertEquals("Undefined post", wallPost.getText());
		assertEquals(0, wallPost.getLikes());
		assertEquals(false, wallPost.isFeatured());
	}

	@Test
	void testDislike() {
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
	void testFeatured() {
		assertFalse(wallPost.isFeatured());
	}

	@Test
	void testLike() {
		assertEquals(0, wallPost.getLikes());
		wallPost.like();
		assertEquals(1, wallPost.getLikes());
		wallPost.like();
		wallPost.like();
		wallPost.like();
		assertEquals(4, wallPost.getLikes());
	}

	@Test
	void testText() {
		final String hello = "Hello";
		wallPost.setText(hello);
		assertEquals(hello, wallPost.getText());

		final String bye = "Bye";
		wallPost.setText(bye);
		assertEquals(bye, wallPost.getText());
	}

	@Test
	void testToggleFeatured() {
		wallPost.toggleFeatured();
		assertTrue(wallPost.isFeatured());
		coolPost.toggleFeatured();
		assertFalse(coolPost.isFeatured());
	}

	@Test
	void testWallpost() {
		assertEquals(0, wallPost.getLikes());
	}

}
