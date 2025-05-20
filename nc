<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Is Your Home Safe from Radon?</title>
  <style>
    body { font-family: Arial, sans-serif; padding: 20px; background: #f7f7f7; }
    .container { max-width: 650px; margin: auto; background: white; padding: 20px; border-radius: 8px; }
    h1, h2 { color: #2b2b2b; text-align: center; }
    h2 { margin-top: 30px; }
    p { line-height: 1.5; }
    label { display: block; margin-top: 20px; font-weight: bold; }
    select { width: 100%; padding: 8px; margin-top: 5px; }
    .result { margin-top: 30px; background: #e6f4ea; padding: 15px; border-radius: 6px; }
    button { margin-top: 20px; padding: 10px 20px; background: #007B5E; color: white; border: none; border-radius: 5px; cursor: pointer; }
    button:hover { background: #005f47; }
    img.map { width: 100%; border: 1px solid #ccc; border-radius: 4px; margin-top: 15px; }
    .legend { display: flex; justify-content: space-around; margin-top: 10px; }
    .legend div { display: flex; align-items: center; }
    .legend span { display: inline-block; width: 16px; height: 16px; margin-right: 5px; }
    .low { background: green; }
    .medium { background: orange; }
    .high { background: red; }

    /* New classes to color the risk message text */
    .text-low    { color: green; }
    .text-medium { color: orange; }
    .text-high   { color: red; }
  </style>
</head>
<body>
  <div class="container">
    <h1>Is Your Home Safe from Radon?</h1>

    <h2>What is Radon?</h2>
    <p>Radon is an invisible, odorless gas that comes from the dirt and rock under your home. It can build up to levels that increase your chance of lung cancer.</p>
    <p>We measure radon in <strong>picocuries per liter (pCi/L)</strong>. A pCi/L shows how much radon is in the air you breathe. The EPA says you should fix your home if it reads <strong>4 pCi/L</strong> or higher. Even 2–3.9 pCi/L can be risky.</p>

    <h2>Radon Levels in North Carolina</h2>
    <img src="nc_radon_map_colored.png" alt="Map of North Carolina counties colored by radon risk level" class="map">
    <div class="legend">
      <div><span class="high"></span>High (≥4 pCi/L)</div>
      <div><span class="medium"></span>Medium (2–3.9 pCi/L)</div>
      <div><span class="low"></span>Low (<2 pCi/L)</div>
    </div>

    <label for="county">What North Carolina county do you live in?</label>
    <select id="county">
      <!-- (options unchanged) -->
      <option value="high">Buncombe County</option>
      <option value="high">Catawba County</option>
      <option value="high">Forsyth County</option>
      <option value="high">Granville County</option>
      <option value="high">Guilford County</option>
      <option value="low">Hyde County</option>
      <!-- all others medium -->
    </select>

    <label for="foundation">Which best describes your home’s foundation?</label>
    <select id="foundation">
      <option value="basement">Basement foundation</option>
      <option value="crawlspace">Crawlspace foundation</option>
      <option value="slab">Slab-on-grade (no basement)</option>
      <option value="mobile">Mobile home</option>
      <option value="unknown">I’m not sure</option>
    </select>

    <label for="ownership">Do you rent or own your home?</label>
    <select id="ownership">
      <option value="rent">I rent my home</option>
      <option value="own">I own my home</option>
      <option value="public">I live in public housing</option>
    </select>

    <label for="tested">Has your home been tested for radon?</label>
    <select id="tested">
      <option value="high">Yes, it was 4 pCi/L or higher</option>
      <option value="low">Yes, it was below 4 pCi/L</option>
      <option value="no">No / I don’t know</option>
    </select>

    <button onclick="generateResult()">Show My Radon Risk</button>

    <div id="output" class="result" style="display:none;"></div>
  </div>

  <script>
    function generateResult() {
      const county  = document.getElementById("county").value;
      const foundation = document.getElementById("foundation").value;
      const ownership  = document.getElementById("ownership").value;
      const tested     = document.getElementById("tested").value;

      let message = `<h3>Your Radon Risk</h3>`;

      // County risk (now colored)
      if (county === "high") {
        message += `<p class="text-high">Your county has <strong>high radon levels</strong>. Testing is very important.</p>`;
      } else if (county === "medium") {
        message += `<p class="text-medium">Your county has <strong>medium radon levels</strong>. You should test your home.</p>`;
      } else {
        message += `<p class="text-low">Your county has <strong>low radon levels</strong>. But only a test tells you for sure.</p>`;
      }

      // Foundation risk
      if (foundation === "basement" || foundation === "crawlspace") {
        message += `<p>Houses with basements or crawlspaces often let more radon in.</p>`;
      } else if (foundation === "mobile") {
        message += `<p>Mobile homes are usually safe if vented well, but testing is still good.</p>`;
      } else if (foundation === "slab") {
        message += `<p>Slab foundations may let radon in through cracks. Testing is a good idea.</p>`;
      }

      // Rental advice with real link
      if (ownership === "rent") {
        message += `<p>If you rent, your landlord must keep your home safe. <a href="radon_landlord_letter.pdf" target="_blank">Download a sample letter</a> to ask them to test for radon.</p>`;
      }

      // Test history
      if (tested === "no") {
        message += `<p><strong>You haven’t tested, or you don’t know. Please test your home soon.</strong></p>`;
      } else if (tested === "high") {
        message += `<p>Your last test showed <strong>high radon</strong>. Contact a radon professional to fix this.</p>`;
      }

      message += `<p><strong>Need a free test kit?</strong> Call your local health department. Many North Carolina counties give them out for free.</p>`;

      const output = document.getElementById("output");
      output.style.display = "block";
      output.innerHTML = message;
    }
  </script>
</body>
</html>
