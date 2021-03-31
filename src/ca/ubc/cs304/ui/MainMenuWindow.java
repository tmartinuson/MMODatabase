package ca.ubc.cs304.ui;

import ca.ubc.cs304.controller.GameManager;
import ca.ubc.cs304.model.*;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class MainMenuWindow extends JFrame implements ActionListener {
    // constants
    private static final String JLABEL_FORMAT_1 = "<html><div style='text-align: center;'>";
    private static final String JLABEL_FORMAT_2 = "</div></html>";

    // components of the main menu window
    private JTextField insertUsername;
    private JTextField insertId;
    private JTextField insertMoney;
    private JTextField insertLevel;
    private JTextField insertAttackPower;
    private JTextField deletePlayerId;
    private JTextField updateBiome;
    private JTextField selectDate;
    private JTextField joinLevel;
    private JLabel resultsLabel = new JLabel("");
    private String currentLocation = "Ludi";

    // delegate
    private GameManager delegate;

    public MainMenuWindow() {
        super("Main Menu");
    }

    public void showFrame(GameManager delegate) {
        this.delegate = delegate;
        String missingData = "Please fill in the missing information.";

        // create labels
        JLabel optionMessage = new JLabel(JLABEL_FORMAT_1 + "Please select an action" + JLABEL_FORMAT_2);
        JLabel usernameLabel = new JLabel(JLABEL_FORMAT_1 + "Username"  + JLABEL_FORMAT_2);
        JLabel idLabel = new JLabel(JLABEL_FORMAT_1 + "Player Id"  + JLABEL_FORMAT_2);
        JLabel moneyLabel = new JLabel(JLABEL_FORMAT_1 + "Money"  + JLABEL_FORMAT_2);
        JLabel levelLabel = new JLabel(JLABEL_FORMAT_1 + "Level"  + JLABEL_FORMAT_2);
        JLabel attackPowerLabel = new JLabel(JLABEL_FORMAT_1 + "Attack Power"  + JLABEL_FORMAT_2);
        JLabel playerIdLabel = new JLabel(JLABEL_FORMAT_1 + "Player Id"  + JLABEL_FORMAT_2);
        JLabel locationLabel = new JLabel(JLABEL_FORMAT_1 + "Location"  + JLABEL_FORMAT_2);
        JLabel biomeLabel = new JLabel(JLABEL_FORMAT_1 + "Biome"  + JLABEL_FORMAT_2);
        JLabel dateLabel = new JLabel(JLABEL_FORMAT_1 + "Date"  + JLABEL_FORMAT_2);
        JLabel levelLabel2 = new JLabel(JLABEL_FORMAT_1 + "Level"  + JLABEL_FORMAT_2);

        // create buttons
        JButton insertButton = new JButton("Add an Assassin Player");
        JButton deleteButton = new JButton("Delete a Warrior Player");
        JButton updateButton = new JButton("Update a Location's Biome");
        JButton selectButton = new JButton(JLABEL_FORMAT_1 + "Show the players who have conversed with" +
                "<br/>an NPC after a given date (yyyy/mm/dd)."
                + JLABEL_FORMAT_2);
        JButton projectButton = new JButton(JLABEL_FORMAT_1 + "Show the items with corresponding<br/>" +
                "stats shop names, and location names" + JLABEL_FORMAT_2);
        JButton joinButton = new JButton("Show all players who are under the given level");
        JButton aggregationGroupButton = new JButton(JLABEL_FORMAT_1 + "Show the number of monster<br/>races at each location" + JLABEL_FORMAT_2);
        JButton aggregationHavingButton = new JButton(JLABEL_FORMAT_1 + "Show the numbers of shops at<br/>each location with inventory<br/>" +
                "amount greater than or equal to 50." + JLABEL_FORMAT_2);
        JButton nestedAggregationButton = new JButton(JLABEL_FORMAT_1 + "Show prices of the most expensive<br/>after averaging by shop type in location" + JLABEL_FORMAT_2);
        JButton divisionButton = new JButton(JLABEL_FORMAT_1 + "Show the players who have purchased an<br/>item at every location" + JLABEL_FORMAT_2);
        JButton quitOption = new JButton("Quit");

        // create text fields
        insertUsername = new JTextField(LoginWindow.TEXT_FIELD_WIDTH);
        insertId = new JTextField(LoginWindow.TEXT_FIELD_WIDTH);
        insertMoney = new JTextField(LoginWindow.TEXT_FIELD_WIDTH);
        insertLevel = new JTextField(LoginWindow.TEXT_FIELD_WIDTH);
        insertAttackPower = new JTextField(LoginWindow.TEXT_FIELD_WIDTH);
        deletePlayerId = new JTextField(LoginWindow.TEXT_FIELD_WIDTH);
        updateBiome = new JTextField(LoginWindow.TEXT_FIELD_WIDTH);
        selectDate = new JTextField(LoginWindow.TEXT_FIELD_WIDTH);
        joinLevel = new JTextField(LoginWindow.TEXT_FIELD_WIDTH);

        // for dropdown menu
        String[] locations = {"Ludi", "Kerning", "Ellinia", "Henney", "Perion"};
        final JComboBox<String> locationDropDown = new JComboBox<String>(locations);

        // TODO make a forloop for this
        // set font
        optionMessage.setFont(LoginWindow.LUCIDA_SANS_UNICODE);
        insertButton.setFont(LoginWindow.LUCIDA_SANS_UNICODE);
        deleteButton.setFont(LoginWindow.LUCIDA_SANS_UNICODE);
        updateButton.setFont(LoginWindow.LUCIDA_SANS_UNICODE);
        locationDropDown.setFont(LoginWindow.LUCIDA_SANS_UNICODE);
        selectButton.setFont(LoginWindow.LUCIDA_SANS_UNICODE);
        projectButton.setFont(LoginWindow.LUCIDA_SANS_UNICODE);
        joinButton.setFont(LoginWindow.LUCIDA_SANS_UNICODE);
        resultsLabel.setFont(LoginWindow.LUCIDA_SANS_UNICODE);
        aggregationGroupButton.setFont(LoginWindow.LUCIDA_SANS_UNICODE);
        aggregationHavingButton.setFont(LoginWindow.LUCIDA_SANS_UNICODE);
        nestedAggregationButton.setFont(LoginWindow.LUCIDA_SANS_UNICODE);
        divisionButton.setFont(LoginWindow.LUCIDA_SANS_UNICODE);
        quitOption.setFont(LoginWindow.LUCIDA_SANS_UNICODE);

        // set button colour
        insertButton.setBackground(LoginWindow.LIGHT_BLUE);
        deleteButton.setBackground(LoginWindow.LIGHT_BLUE);
        updateButton.setBackground(LoginWindow.LIGHT_BLUE);
        locationDropDown.setBackground(LoginWindow.LIGHT_BLUE);
        selectButton.setBackground(LoginWindow.LIGHT_BLUE);
        projectButton.setBackground(LoginWindow.LIGHT_BLUE);
        joinButton.setBackground(LoginWindow.LIGHT_BLUE);
        aggregationGroupButton.setBackground(LoginWindow.LIGHT_BLUE);
        aggregationHavingButton.setBackground(LoginWindow.LIGHT_BLUE);
        nestedAggregationButton.setBackground(LoginWindow.LIGHT_BLUE);
        divisionButton.setBackground(LoginWindow.LIGHT_BLUE);
        quitOption.setBackground(LoginWindow.LIGHT_BLUE);


        // create panel
        JPanel contentPane = new JPanel();
        this.setContentPane(contentPane);
        contentPane.setBackground(Color.white);

        // layout components using the GridBag layout manager
        GridBagLayout gb = new GridBagLayout();
        GridBagConstraints c = new GridBagConstraints();
        contentPane.setLayout(gb);
        contentPane.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        c.gridwidth = 1;
        c.gridx = 0;
        c.gridy = 1;


        // place optionMessage label
        c.insets = new Insets(10, 10, 5, 0);
        c.anchor = GridBagConstraints.CENTER;
        gb.setConstraints(optionMessage, c);
        contentPane.add(optionMessage);

        // place username label
        c.gridy+=2;
        c.gridx++;
        c.insets = new Insets(10, 10, 5, 0);
        c.anchor = GridBagConstraints.CENTER;
        gb.setConstraints(usernameLabel, c);
        contentPane.add(usernameLabel);

        // place username label
        c.gridx++;
        c.insets = new Insets(10, 10, 5, 0);
        c.anchor = GridBagConstraints.CENTER;
        gb.setConstraints(idLabel, c);
        contentPane.add(idLabel);

        // place money label
        c.gridx++;
        c.insets = new Insets(10, 10, 5, 0);
        c.anchor = GridBagConstraints.CENTER;
        gb.setConstraints(moneyLabel, c);
        contentPane.add(moneyLabel);

        // place xp label
        c.gridx++;
        c.insets = new Insets(10, 10, 5, 0);
        c.anchor = GridBagConstraints.CENTER;
        gb.setConstraints(levelLabel, c);
        contentPane.add(levelLabel);

        // place attack power label
        c.gridx++;
        c.insets = new Insets(10, 10, 5, 0);
        c.anchor = GridBagConstraints.CENTER;
        gb.setConstraints(attackPowerLabel, c);
        contentPane.add(attackPowerLabel);

        // place the insertButton button
        c.gridx = 0;
        c.gridy = 1;
        c.gridy+=3;
        c.insets = new Insets(10, 10, 10, 10);
        c.anchor = GridBagConstraints.CENTER;
        insertButton.setFocusPainted(false);
        gb.setConstraints(insertButton, c);
        contentPane.add(insertButton);

        // place the text field for the username
        c.gridx++;
        c.insets = new Insets(5, 0, 5, 10);
        c.anchor = GridBagConstraints.CENTER;
        gb.setConstraints(insertUsername, c);
        contentPane.add(insertUsername);

        // place the text field for the id
        c.gridx++;
        c.insets = new Insets(5, 0, 5, 10);
        c.anchor = GridBagConstraints.CENTER;
        gb.setConstraints(insertId, c);
        contentPane.add(insertId);

        // place the text field for the money
        c.gridx++;
        c.insets = new Insets(5, 0, 5, 10);
        c.anchor = GridBagConstraints.CENTER;
        gb.setConstraints(insertMoney, c);
        contentPane.add(insertMoney);

        // place the text field for the xp
        c.gridx++;
        c.insets = new Insets(5, 0, 5, 10);
        c.anchor = GridBagConstraints.CENTER;
        gb.setConstraints(insertLevel, c);
        contentPane.add(insertLevel);

        // place the text field for the attackPower
        c.gridx++;
        c.insets = new Insets(5, 0, 5, 10);
        c.anchor = GridBagConstraints.CENTER;
        gb.setConstraints(insertAttackPower, c);
        contentPane.add(insertAttackPower);

        // place branchId Label
        c.gridx = 1;
        c.gridy+=2;
        c.insets = new Insets(5, 10, 5, 0);
        gb.setConstraints(playerIdLabel, c);
        contentPane.add(playerIdLabel);

        // place the deleteButton button
        c.gridx = 0;
        c.gridy++;
        c.insets = new Insets(5, 10, 10, 10);
        c.anchor = GridBagConstraints.CENTER;
        deleteButton.setFocusPainted(false);
        gb.setConstraints(deleteButton, c);
        contentPane.add(deleteButton);

        // place the text field for the branchID
        c.gridx++;
        c.insets = new Insets(5, 0, 5, 10);
        c.anchor = GridBagConstraints.CENTER;
        gb.setConstraints(deletePlayerId, c);
        contentPane.add(deletePlayerId);

        // place location Label
        c.gridx = 1;
        c.gridy+=2;
        c.insets = new Insets(5, 10, 5, 0);
        gb.setConstraints(locationLabel, c);
        contentPane.add(locationLabel);

        // place biome Label
        c.gridx++;
        c.insets = new Insets(5, 10, 5, 0);
        gb.setConstraints(biomeLabel, c);
        contentPane.add(biomeLabel);

        // place the updateButton button
        c.gridx = 0;
        c.gridy++;
        c.insets = new Insets(5, 10, 10, 10);
        c.anchor = GridBagConstraints.CENTER;
        updateButton.setFocusPainted(false);
        gb.setConstraints(updateButton, c);
        contentPane.add(updateButton);

        // the drop down for the location
        c.gridx = 1;
        c.insets = new Insets(0, 10, 5, 0);
        c.anchor = GridBagConstraints.CENTER;
        gb.setConstraints(locationDropDown, c);
        contentPane.add(locationDropDown);

        // the text field for the biome
        c.gridx++;
        c.insets = new Insets(5, 10, 5, 0);
        c.anchor = GridBagConstraints.CENTER;
        gb.setConstraints(updateBiome, c);
        contentPane.add(updateBiome);

        // new row
        // place the selectButton button
        c.gridwidth = 3;
        c.gridx = 0;
        c.gridy+=3;
        c.insets = new Insets(5, 10, 10, 10);
        c.anchor = GridBagConstraints.CENTER;
        selectButton.setFocusPainted(false);
        gb.setConstraints(selectButton, c);
        contentPane.add(selectButton);

        // place the select date label
        c.gridx+=2;
        c.insets = new Insets(5, 10, 5, 10);
        c.anchor = GridBagConstraints.CENTER;
        gb.setConstraints(dateLabel, c);
        contentPane.add(dateLabel);

        // place the select date field
        c.gridx++;
        c.insets = new Insets(5, 10, 10, 10);
        c.anchor = GridBagConstraints.CENTER;
        gb.setConstraints(selectDate, c);
        contentPane.add(selectDate);

        // new row
        // place the joinButton button
        c.gridx = 0;
        c.gridy++;
        c.insets = new Insets(5, 10, 10, 10);
        c.anchor = GridBagConstraints.CENTER;
        joinButton.setFocusPainted(false);
        gb.setConstraints(joinButton, c);
        contentPane.add(joinButton);

        // place the join level label
        c.gridx+=2;
        c.insets = new Insets(5, 10, 10, 10);
        c.anchor = GridBagConstraints.CENTER;
        gb.setConstraints(levelLabel2, c);
        contentPane.add(levelLabel2);

        // place the join level field
        c.gridx++;
        c.insets = new Insets(5, 10, 10, 10);
        c.anchor = GridBagConstraints.CENTER;
        gb.setConstraints(joinLevel, c);
        contentPane.add(joinLevel);

        // new row
        // place the aggregationGroupBy button
        c.gridx = 0;
        c.gridy++;
        c.insets = new Insets(5, 10, 10, 10);
        c.anchor = GridBagConstraints.CENTER;
        aggregationGroupButton.setFocusPainted(false);
        gb.setConstraints(aggregationGroupButton, c);
        contentPane.add(aggregationGroupButton);

        // place the divisionButton button
        c.gridx+=3;
        c.insets = new Insets(5, 10, 10, 10);
        c.anchor = GridBagConstraints.CENTER;
        divisionButton.setFocusPainted(false);
        gb.setConstraints(divisionButton, c);
        contentPane.add(divisionButton);

        // new row
        // place the aggregationHavingButton button
        c.gridx = 0;
        c.gridy++;
        c.insets = new Insets(5, 10, 10, 10);
        c.anchor = GridBagConstraints.CENTER;
        aggregationHavingButton.setFocusPainted(false);
        gb.setConstraints(aggregationHavingButton, c);
        contentPane.add(aggregationHavingButton);

        // place the nestedAggregationButton button
        c.gridx+=3;
        c.insets = new Insets(5, 10, 10, 10);
        c.anchor = GridBagConstraints.CENTER;
        nestedAggregationButton.setFocusPainted(false);
        gb.setConstraints(nestedAggregationButton, c);
        contentPane.add(nestedAggregationButton);

        // place the quitOption button
        c.gridx = 1;
        c.gridy+=3;
        c.insets = new Insets(5, 10, 10, 10);
        c.anchor = GridBagConstraints.CENTER;
        quitOption.setFocusPainted(false);
        gb.setConstraints(quitOption, c);
        contentPane.add(quitOption);

        // register buttons with action event handler
        insertButton.addActionListener(
                new ActionListener() {
                    @Override
                    public void actionPerformed(ActionEvent e) {
                        JFrame resultFrame = createResultsPane();
                        resultFrame.setTitle("Add Assassin Player");
                        String username = insertUsername.getText().trim();
                        String id = insertId.getText().trim();
                        String money = insertMoney.getText().trim();
                        String level = insertLevel.getText().trim();
                        String attackPower = insertAttackPower.getText().trim();

                        if (isAnyStringNullOrEmpty(username, id, money, level, attackPower)) {
                            setupPrintStatements(resultFrame, missingData);
                        } else if (Pattern.matches("[a-zA-Z]+", id) || Pattern.matches("[a-zA-Z]+", money)
                                || Pattern.matches("[a-zA-Z]+", level) ||
                                Pattern.matches("[a-zA-Z]+", attackPower)) {
                            setupPrintStatements(resultFrame, "Please make sure Player Id, Money, Level, and " +
                                    "Attack Power are numbers.");
                        } else {
                            delegate.insertAssassinPlayerCharacter(username, id, Integer.parseInt(money),
                                    Integer.parseInt(level), Integer.parseInt(attackPower));
                            insertUsername.setText("");
                            insertId.setText("");
                            insertMoney.setText("");
                            insertLevel.setText("");
                            insertAttackPower.setText("");
                            setupPrintStatements(resultFrame, "New Assassin Player, " + username + ", Added!");
                        }
                    }
                }
        );

        deleteButton.addActionListener(
                new ActionListener() {
                    @Override
                    public void actionPerformed(ActionEvent e) {
                        JFrame resultFrame = createResultsPane();
                        resultFrame.setTitle("Delete Warrior Player");
                        String playerId = deletePlayerId.getText().trim();
                        if (isAnyStringNullOrEmpty(playerId)) {
                            setupPrintStatements(resultFrame, missingData);
                        } else if (Pattern.matches("[a-zA-Z]+", playerId)) {
                            setupPrintStatements(resultFrame, "Please make sure Player Id is a number.");
                        } else {
                            delegate.deleteGivenWarrior(playerId);
                            deletePlayerId.setText("");
                            setupPrintStatements(resultFrame, "Warrior #" + playerId + " Deleted!");
                        }
                    }
                }
        );

        locationDropDown.addActionListener(
                new ActionListener() {
                    @Override
                    public void actionPerformed(ActionEvent e) {
                        JComboBox locationJCB = (JComboBox)e.getSource();
                        String location = (String)locationJCB.getSelectedItem();
                        currentLocation = location;
                    }
                }
        );

        updateButton.addActionListener(
                new ActionListener() {
                    @Override
                    public void actionPerformed(ActionEvent e) {
                        JFrame resultFrame = createResultsPane();
                        resultFrame.setTitle("Update Location's Biome");
                        String biome = updateBiome.getText().trim();

                        if (isAnyStringNullOrEmpty(currentLocation, biome)) {
                            setupPrintStatements(resultFrame, missingData);
                        } else {
                            delegate.updateLocationBiome(currentLocation, biome);
                            updateBiome.setText("");
                            setupPrintStatements(resultFrame, "Location's Biome updated!");
                        }
                    }
                }
        );

        selectButton.addActionListener(
                new ActionListener() {
                    @Override
                    public void actionPerformed(ActionEvent e) {
                        JFrame resultFrame = createResultsPane();
                        resultFrame.setTitle("Player Converses with NPC on Specific Date");
                        String date = selectDate.getText().trim();
                        Pattern datePattern = Pattern.compile("\\d{4}/\\d{2}/\\d{2}");
                        Matcher matcher = datePattern.matcher(date);

                        if (isAnyStringNullOrEmpty(date)) {
                            setupPrintStatements(resultFrame, missingData);
                        } else if (!matcher.find()) {
                            setupPrintStatements(resultFrame, "Please make sure date is in yyyy/mm/dd.");
                        } else {
                            ArrayList<Conversation> result = delegate.findPlayersConverses(date);
                            String[][] arrayOfItems = new String[result.size()][];
                            for (int j = 0; j < arrayOfItems.length; j++) {
                                String playerId = result.get(j).getPlayerId();
                                String npcName = result.get(j).getNPCName();
                                String converseDate = result.get(j).getConverseDate().toString();
                                arrayOfItems[j] = new String[]{playerId, npcName, converseDate};
                            }
                            selectDate.setText("");
                            String[] column = {"Player ID", "NPC", "Date Conversed"};
                            setupTable(resultFrame, arrayOfItems, column);
                        }
                    }
                }
        );

        projectButton.addActionListener(
                new ActionListener() {
                    @Override
                    public void actionPerformed(ActionEvent e) {
                        JFrame resultFrame = createResultsPane();
                        resultFrame.setTitle("Items: Stats, Shop, Location");
                        ArrayList<SimplifiedItemModel> result = delegate.projectFromItems();
                        String[][] arrayOfItems = new String[result.size()][];
                        for (int j = 0; j < arrayOfItems.length; j++) {
                            String itemId = result.get(j).getId();
                            String itemStats = result.get(j).getStats();
                            String shopName = result.get(j).getShopName();
                            String locationName = result.get(j).getLocationName();
                            arrayOfItems[j] = new String[]{itemId, itemStats, shopName, locationName};
                        }
                        String[] column ={"Item ID","Stats","Shop Name","Location Name"};
                        setupTable(resultFrame, arrayOfItems, column);
                    }
                }
        );

        joinButton.addActionListener(
                new ActionListener() {
                    @Override
                    public void actionPerformed(ActionEvent e) {
                        JFrame resultFrame = createResultsPane();
                        resultFrame.setTitle("Players Under a Specified Level");
                        String joinlevel = joinLevel.getText().trim();

                        if (isAnyStringNullOrEmpty(joinlevel)) {
                            setupPrintStatements(resultFrame, missingData);
                        } else if (Pattern.matches("[a-zA-Z]+", joinlevel)) {
                            setupPrintStatements(resultFrame, "Please make sure Level is a number.");
                        }else {
                            ArrayList<Player> result = delegate.findAllPlayersWithLevelsUnder(Integer.parseInt(joinlevel));
                            String[][] arrayOfItems = new String[result.size()][];
                            for (int j = 0; j < arrayOfItems.length; j++) {
                                String playerId = result.get(j).getPlayerID();
                                String username = result.get(j).getPlayerUsername();
                                Integer level = result.get(j).getPlayerLevel();
                                Integer xp = result.get(j).getPlayerXP();
                                arrayOfItems[j] = new String[]{playerId, username, Integer.toString(level), Integer.toString(xp)};
                            }
                            joinLevel.setText("");
                            String[] column = {"Id", "Username", "Level", "Threshold XP"};
                            setupTable(resultFrame, arrayOfItems, column);
                        }
                    }
                }
        );

        aggregationGroupButton.addActionListener(
                new ActionListener() {
                    @Override
                    public void actionPerformed(ActionEvent e) {
                        JFrame resultFrame = createResultsPane();
                        resultFrame.setTitle("Number of Monster Races by Location");
                        ArrayList<LocationRace> result = delegate.countRaceByLocation();
                        String[][] arrayOfItems = new String[result.size()][];
                        for (int j = 0; j < arrayOfItems.length; j++) {
                            String location = result.get(j).getLocation();
                            Integer raceNum = result.get(j).getRaceCount();
                            arrayOfItems[j] = new String[]{location, Integer.toString(raceNum)};
                        }
                        String[] column = {"Location","Number of Monster Races"};
                        setupTable(resultFrame, arrayOfItems, column);
                    }
                }
        );

        aggregationHavingButton.addActionListener(
                new ActionListener() {
                    @Override
                    public void actionPerformed(ActionEvent e) {
                        JFrame resultFrame = createResultsPane();
                        resultFrame.setTitle("Shops with Inventory Amount of 50+ at Each Location");
                        ArrayList<LocationShop> result = delegate.countShopsByLocation();
                        String[][] arrayOfItems = new String[result.size()][];
                        for (int j = 0; j < arrayOfItems.length; j++) {
                            String location = result.get(j).getLocationName();
                            Integer shopCount = result.get(j).getShopCount();
                            arrayOfItems[j] = new String[]{location, Integer.toString(shopCount)};
                        }
                        String[] column ={"Location","Number of Shops"};
                        setupTable(resultFrame, arrayOfItems, column);
                    }
                }
        );

        nestedAggregationButton.addActionListener(
                new ActionListener() {
                    @Override
                    public void actionPerformed(ActionEvent e) {
                        JFrame resultFrame = createResultsPane();
                        resultFrame.setTitle("Most Expensive Item at Each Location");
                        ArrayList<LocationAndPrice> result = delegate.nestedPriceQuery();
                        String[][] arrayOfItems = new String[result.size()][];
                        for (int j = 0; j < arrayOfItems.length; j++) {
                            String location = result.get(j).getLocation();
                            double maxPrice = result.get(j).getMaxPrice();
                            arrayOfItems[j] = new String[]{location, Double.toString(maxPrice)};
                        }
                        String[] column ={"Location","Price"};
                        setupTable(resultFrame, arrayOfItems, column);
                    }
                }
        );

        divisionButton.addActionListener(
                new ActionListener() {
                    @Override
                    public void actionPerformed(ActionEvent e) {
                        JFrame resultFrame = createResultsPane();
                        resultFrame.setTitle("Players That Bought From All Locations");
                        ArrayList<Player> result = delegate.findPlayersThatBoughtFromAllLocations();

                        String[][] arrayOfItems = new String[result.size()][];
                        for (int j = 0; j < arrayOfItems.length; j++) {
                            String playerId = result.get(j).getPlayerID();
                            String username = result.get(j).getPlayerUsername();
                            arrayOfItems[j] = new String[]{playerId, username};
                        }
                        String[] column ={"Id","Username"};
                        setupTable(resultFrame, arrayOfItems, column);
                    }
                }
        );

        quitOption.addActionListener(
                new ActionListener() {
                    @Override
                    public void actionPerformed(ActionEvent e) {
                        handleQuitOption();
                    }
                }
        );

        // anonymous inner class for closing the window
        this.addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {
                delegate.terminalTransactionsFinished();
                System.exit(0);
            }
        });

        // size the window to obtain a best fit for the components
        this.pack();

        // center the frame
        Dimension d = this.getToolkit().getScreenSize();
        Rectangle r = this.getBounds();
        this.setLocation( (d.width - r.width)/2, (d.height - r.height)/2 );

        // make the window visible
        this.setVisible(true);

        // place the cursor in the text field for the username
        insertUsername.requestFocus();
    }

    private void setupPrintStatements(JFrame resultFrame, String message) {
        // layout components using the GridBag layout manager
        GridBagLayout gb = new GridBagLayout();
        GridBagConstraints c = new GridBagConstraints();
        resultFrame.setLayout(gb);
        c.gridwidth = 1;
        c.gridx = 0;
        c.gridy = 1;

        resultsLabel.setText(message);

        // place resultsLabel label
        c.insets = new Insets(10, 10, 5, 0);
        c.anchor = GridBagConstraints.CENTER;
        gb.setConstraints(resultsLabel, c);
        resultFrame.add(resultsLabel);
    }

    public static boolean isAnyStringNullOrEmpty(String... strings) {
        for (String s : strings)
            if (s == null || s.isEmpty())
                return true;
        return false;
    }

    private void handleQuitOption() {
        delegate.terminalTransactionsFinished();
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        handleQuitOption();
    }

    // create results panel
    private JFrame createResultsPane() {

        JFrame resultFrame = new JFrame();
        resultFrame.setBackground(Color.white);

        // center the frame
        Dimension d = resultFrame.getToolkit().getScreenSize();
        Rectangle r = resultFrame.getBounds();
        resultFrame.setLocation( (d.width - r.width)/2, (d.height - r.height)/2 );
        resultFrame.setSize(700,400);
        resultFrame.setLocationByPlatform(true);
        resultFrame.setVisible(true);

        return resultFrame;
    }

    private void setupTable(JFrame resultFrame, String[][] data, String[] column) {
        JTable resultTable = new JTable(data,column);
        resultTable.setEnabled(false);
        resultTable.setFont(LoginWindow.LUCIDA_SANS_UNICODE);
        resultTable.getTableHeader().setBackground(LoginWindow.LIGHT_BLUE);
        resultTable.setBounds(30,40,500,500);
        JScrollPane scrollPane = new JScrollPane(resultTable);
        resultFrame.add(scrollPane);
    }

}
