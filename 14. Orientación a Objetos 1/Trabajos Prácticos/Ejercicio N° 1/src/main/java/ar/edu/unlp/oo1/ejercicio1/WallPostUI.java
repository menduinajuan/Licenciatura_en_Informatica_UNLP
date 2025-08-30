package ar.edu.unlp.oo1.ejercicio1;

import java.awt.GridLayout;

import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;

public class WallPostUI {

  private WallPost wallPost;
  private JButton console; 
  private JTextArea textArea;
  private JLabel featuredLabelTitle;
  private JCheckBox featuredCheckbox;
  private JLabel likesLabelTitle;
  private JLabel likesLabel;
  private JButton like; 
  private JButton dislike; 
  private JFrame window;

  public WallPostUI() {
    this.wallPost = new WallPost();
    this.console = new JButton("Print to Console");
    this.textArea = new JTextArea();
    this.featuredLabelTitle = new JLabel("Featured");
    this.featuredCheckbox = new JCheckBox();
    this.likesLabelTitle = new JLabel("Likes");
    this.like = new JButton("Like");
    this.likesLabel = new JLabel();
    this.dislike = new JButton("Dislike");
    this.window = new JFrame("WallPost");
    this.setUpWindow();
    this.wireComponents();
    this.window.setVisible(true);
  }

  private void setUpWindow() {
    JPanel pane = new JPanel();
    this.window.getContentPane().add(pane);
    this.window.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    this.window.setSize(640, 480);
    pane.setLayout(new GridLayout(5,1,1,10));
    pane.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));
    pane.add(this.console);

    JScrollPane scrollPane = new JScrollPane(this.textArea);
    pane.add(scrollPane);
    this.textArea.setEditable(true);
    this.textArea.setLineWrap(true);
    this.textArea.setWrapStyleWord(true);

    JPanel featuredPane = new JPanel();
    featuredPane.setLayout(new GridLayout(1, 2));
    featuredPane.add(this.featuredLabelTitle);
    featuredPane.add(this.featuredCheckbox);
    pane.add(featuredPane);

    JPanel likesPane = new JPanel();
    likesPane.setLayout(new GridLayout(1, 2));
    likesPane.add(this.likesLabelTitle);
    likesPane.add(this.likesLabel);
    likesLabel.setText("0");
    pane.add(likesPane);

    JPanel likeButtonsPane = new JPanel();
    likeButtonsPane.setLayout(new GridLayout(1, 2));
    likeButtonsPane.add(this.like);
    likeButtonsPane.add(this.dislike);
    pane.add(likeButtonsPane);

    this.window.setLocationRelativeTo(null);
    this.window.pack();
  }

  private void wireComponents() {
    this.like.addActionListener( e -> {
      this.wallPost.like();
      this.likesLabel.setText(String.valueOf(this.wallPost.getLikes()));
    });
    
    this.dislike.addActionListener( e -> {
      this.wallPost.dislike();
      this.likesLabel.setText(String.valueOf(this.wallPost.getLikes()));
    });
    
    this.featuredCheckbox.addActionListener(e -> {
      this.wallPost.toggleFeatured();
    });
    
    this.textArea.getDocument().addDocumentListener(new DocumentListener() {
      
      @Override
      public void removeUpdate(DocumentEvent e) {
        wallPost.setText(textArea.getText());
      }
      
      @Override
      public void insertUpdate(DocumentEvent e) {
        wallPost.setText(textArea.getText());
      }
      
      @Override
      public void changedUpdate(DocumentEvent e) {
        wallPost.setText(textArea.getText());
      }
    });
    
    this.console.addActionListener(e -> {
      System.out.println(this.wallPost.toString());
    });
    
  }
}
