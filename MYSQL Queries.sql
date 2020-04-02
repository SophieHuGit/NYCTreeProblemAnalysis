# Get the percentage of each tree problem and group by boroughs and species
SELECT
	nl.borough,
    nt.spc_common,
	SUM(CASE WHEN np.root_stone = "Yes" THEN 1 ELSE 0 END)/(SELECT COUNT(nt.tree_id)) AS root_stone,
    SUM(CASE WHEN np.root_grate = "Yes" THEN 1 ELSE 0 END)/(SELECT COUNT(nt.tree_id)) AS root_grate,
    SUM(CASE WHEN np.root_other = "Yes" THEN 1 ELSE 0 END)/(SELECT COUNT(nt.tree_id)) AS root_other,
    SUM(CASE WHEN np.brch_light = "Yes" THEN 1 ELSE 0 END)/(SELECT COUNT(nt.tree_id)) AS brch_light,
    SUM(CASE WHEN np.brch_shoe = "Yes" THEN 1 ELSE 0 END)/(SELECT COUNT(nt.tree_id)) AS brch_shoe,
    SUM(CASE WHEN np.brch_other = "Yes" THEN 1 ELSE 0 END)/(SELECT COUNT(nt.tree_id)) AS brch_other,
    SUM(CASE WHEN np.trnk_light = "Yes" THEN 1 ELSE 0 END)/(SELECT COUNT(nt.tree_id)) AS trunk_light,
    SUM(CASE WHEN np.trunk_wire = "Yes" THEN 1 ELSE 0 END)/(SELECT COUNT(nt.tree_id)) AS trunk_wire,
    SUM(CASE WHEN np.trnk_other = "Yes" THEN 1 ELSE 0 END)/(SELECT COUNT(nt.tree_id)) AS trunk_other
FROM
	new_york_trees_analysis.tree AS nt
INNER JOIN 
	new_york_trees_analysis.location AS nl
ON nt.location_id = nl.location_id
INNER JOIN
	new_york_trees_analysis.problem AS np
ON nt.problem_id = np.problem_id
GROUP BY nl.borough, nt.spc_common; 

# Count number of problem group by steward activity
SELECT
	na.steward,
	SUM(CASE WHEN np.root_stone = "Yes" THEN 1 ELSE 0 END) AS root_stone,
    SUM(CASE WHEN np.root_grate = "Yes" THEN 1 ELSE 0 END) AS root_grate,
    SUM(CASE WHEN np.root_other = "Yes" THEN 1 ELSE 0 END) AS root_other,
    SUM(CASE WHEN np.brch_light = "Yes" THEN 1 ELSE 0 END) AS brch_light,
    SUM(CASE WHEN np.brch_shoe = "Yes" THEN 1 ELSE 0 END) AS brch_shoe,
    SUM(CASE WHEN np.brch_other = "Yes" THEN 1 ELSE 0 END) AS brch_other,
    SUM(CASE WHEN np.trnk_light = "Yes" THEN 1 ELSE 0 END) AS trunk_light,
    SUM(CASE WHEN np.trunk_wire = "Yes" THEN 1 ELSE 0 END) AS trunk_wire,
    SUM(CASE WHEN np.trnk_other = "Yes" THEN 1 ELSE 0 END) AS trunk_other
FROM
	new_york_trees_analysis.problem AS np
INNER JOIN
	new_york_trees_analysis.tree AS nt
ON np.problem_id = nt.problem_id
INNER JOIN
    new_york_trees_analysis.activity AS na
ON na.activity_id = na.activity_id
INNER JOIN
	new_york_trees_analysis.location AS nl
ON nt.location_id = nl.location_id
GROUP BY na.steward;

# calculate average of tree diameters of each species and categorize them with borough and health status
SELECT
	nl.borough,
	nh.health,
    nt.spc_common,
    COUNT(nt.tree_id) AS num_of_trees,
    AVG(nt.tree_dbh) AS average_diamter
FROM
	new_york_trees_analysis.location AS nl
INNER JOIN
	new_york_trees_analysis.tree AS nt
	ON nl.location_id = nt.location_id
INNER JOIN
	new_york_trees_analysis.health AS nh
    ON nt.health_id = nh.health_id
WHERE
	nh.health <> "Dead" AND nt.spc_common = "London planetree" OR
    nt.spc_common = "honeylocus" OR nt.spc_common = "ginkgo" OR nt.spc_common = "Norway maple" OR
    nt.spc_common = "Japanese zelkova"
GROUP BY nt.spc_common, nh.health, nl.borough;

# Analyze that trees in good condition near the sidewalk with no damage group by species
SELECT
	nt.spc_common,
    SUM(CASE WHEN na.sidewalk = "NoDamage" THEN 1 ELSE 0 END)/(COUNT(na.sidewalk)) AS no_damage_sidewalk,
    SUM(CASE WHEN na.sidewalk = "Damage" THEN 1 ELSE 0 END)/(COUNT(na.sidewalk)) AS damage_sidewalk
FROM
	new_york_trees_analysis.health AS nh
INNER JOIN
	new_york_trees_analysis.tree AS nt
	ON nh.health_id = nt.health_id
INNER JOIN 
	new_york_trees_analysis.location AS nl 
	ON nl.location_id = nt.location_id
INNER JOIN
	new_york_trees_analysis.activity AS na
    ON na.activity_id = nt.activity_id
INNER JOIN
	new_york_trees_analysis.problem AS np
    ON nt.problem_id = nt.problem_id
WHERE
	nh.health = "Good"
GROUP BY nt.spc_common;


