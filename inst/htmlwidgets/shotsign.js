HTMLWidgets.widget({

  name: 'shotsign',

  type: 'output',

  initialize: function(el, width, height) {

    return {
      // TODO: add instance fields as required
    }

  },

  renderValue: function(el, x, instance) {
    
    // all attribution and credit belongs to Peter Beshai @pbeshai
    // https://gist.github.com/pbeshai/ffd0f9d84b4e8df27db2

    // get your data
    var data = [{"x":0,"y":0.7984084880636605,"widthValue":158,"colorValue":0.1629224750896936},{"x":1,"y":0.765993265993266,"widthValue":145,"colorValue":0.16595424641159695},{"x":2,"y":0.7241379310344827,"widthValue":74,"colorValue":0.14788844079931118},{"x":3,"y":0.6082191780821917,"widthValue":36,"colorValue":0.09604064011114222},{"x":4,"y":0.45348837209302323,"widthValue":35,"colorValue":0.0205093443427537},{"x":5,"y":0.37333333333333335,"widthValue":39,"colorValue":-0.015647382920110142},{"x":6,"y":0.3744075829383886,"widthValue":39,"colorValue":-0.012850902701298128},{"x":7,"y":0.3926940639269407,"widthValue":37,"colorValue":0.0016039868744902042},{"x":8,"y":0.4619047619047619,"widthValue":22,"colorValue":0.07160931036145685},{"x":9,"y":0.4788135593220339,"widthValue":45,"colorValue":0.0874320387619314},{"x":10,"y":0.4979423868312757,"widthValue":45,"colorValue":0.10551911317398666},{"x":11,"y":0.4542253521126761,"widthValue":42,"colorValue":0.06070052516549129},{"x":12,"y":0.4503311258278146,"widthValue":44,"colorValue":0.05378653654579513},{"x":13,"y":0.4110787172011662,"widthValue":66,"colorValue":0.009121101429431566},{"x":14,"y":0.4196185286103542,"widthValue":61,"colorValue":0.01780232246319491},{"x":15,"y":0.42819148936170215,"widthValue":64,"colorValue":0.02163884827966278},{"x":16,"y":0.41988950276243087,"widthValue":71,"colorValue":0.016918338868285643},{"x":17,"y":0.45425867507886436,"widthValue":50,"colorValue":0.04975728463782164},{"x":18,"y":0.4141791044776119,"widthValue":45,"colorValue":0.015415540872963762},{"x":19,"y":0.4752475247524752,"widthValue":37,"colorValue":0.07919199741203164},{"x":20,"y":0.41830065359477125,"widthValue":20,"colorValue":0.030376008752275918},{"x":21,"y":0.4928571428571429,"widthValue":13,"colorValue":0.10821499731174294},{"x":22,"y":0.45592705167173253,"widthValue":18,"colorValue":0.07432771905345104},{"x":23,"y":0.43107221006564544,"widthValue":39,"colorValue":0.05587993676927633},{"x":24,"y":0.4125364431486881,"widthValue":221,"colorValue":0.041212020305431696},{"x":25,"y":0.3859060402684564,"widthValue":127,"colorValue":0.023158322960854794},{"x":26,"y":0.36511156186612576,"widthValue":60,"colorValue":0.00876771640727797},{"x":27,"y":0.32627118644067793,"widthValue":22,"colorValue":-0.017285514590249906},{"x":28,"y":0.25555555555555554,"widthValue":3,"colorValue":-0.07036667774454414},{"x":29,"y":0.34375,"widthValue":2,"colorValue":0.043655332912590716},{"x":30,"y":0.2,"widthValue":0,"colorValue":-0.06235399820305482}];

    // initialize SVG
    var width = 600, height = 200;
    var svg = d3.select(el).append("svg")
      .attr("width", width)
      .attr("height", height);
    // x = distance in shooting signatures
    var x = d3.scale.linear()
      .domain([0, 30])
      .range([0, width]);
    // for gradient offset (needs % - so map x domain to 0-100%)
    var offset = d3.scale.linear()
      .domain(x.domain())
      .range([0, 100]);
    // y = Field Goal % in shooting signatures
    var y = d3.scale.linear()
      .domain([0, 1])
      .range([height, 0]);
    // scale for the width of the signature
    var minWidth = 1;
    var maxWidth = height / 4;
    var w = d3.scale.linear()
      .domain([0, 250])
      .range([minWidth, maxWidth]);
    // NOTE: if you want maxWidth to truly be the maximum width of the signature,
    // you'll need to add .clamp(true) to w.
    // need two area plots to make the signature extend in width in both directions around the line
    var areaAbove = d3.svg.area()
      .x(function(d) { return x(d.x); })
      .y0(function (d) { return y(d.y) - w(d.widthValue); })
      .y1(function(d) { return Math.ceil(y(d.y)); }) // ceil and floor prevent line between areas
      .interpolate("basis");
    var areaBelow = d3.svg.area()
      .x(function(d) { return x(d.x); })
      .y0(function (d) { return y(d.y) + w(d.widthValue); })
      .y1(function(d) { return Math.floor(y(d.y)); }) // ceil and floor prevent line between areas
      .interpolate("basis");
    // add the areas to the svg
    var gArea = svg.append("g").attr("class", "area-group");
    gArea.append("path")
      .datum(data)
      .attr("class", "area area-above")
      .attr("d", areaAbove)
      .style("fill", "url(#area-gradient)"); // specify the linear gradient #area-gradient as the colouring
      // NOTE: the colouring won't work if you have multiple signatures on the same page.
      // In this case, you'll need to generate unique IDs for each gradient.
    gArea.append("path")
      .datum(data)
      .attr("class", "area area-below")
      .attr("d", areaBelow)
      .style("fill", "url(#area-gradient)");
    /*
    // you can draw the line the signature is based around using the following code:
    var line = d3.svg.line()
      .x(function(d) { return x(d.x); })
      .y(function(d) { return y(d.y); })
      .interpolate("basis");
    gArea.append("path")
      .datum(data)
      .attr("d", line)
      .style("stroke", "#fff")
      .style("fill", "none")
    */
    // set-up colours
    var colorSchemes = {
      buckets: {
        domain: [-0.15, 0.15],
        range: ["#405A7C", "#7092C0", "#BDD9FF", "#FFA39E", "#F02C21", "#B80E05"]
      },
      goldsberry: {
        domain: [-0.15, 0.15],
        range: ["#5357A1", "#6389BA", "#F9DC96", "#F0825F", "#AE2A47"]
      }
    };
    var activeColorScheme = colorSchemes.goldsberry;
    // Note that the quantize scale does not interpolate between colours
    var colorScale = d3.scale.quantize()
      .domain(activeColorScheme.domain)
      .range(activeColorScheme.range);
    // generate colour data
    var colorData = [];
    var stripe = false; // set stripe to true to prevent linear gradient fading
    for (var i = 0; i < data.length; i++) {
      var prevData = data[i - 1];
      var currData = data[i];
      if (stripe && prevData) {
        colorData.push({
          offset: offset(currData.x) + "%",
          stopColor: colorScale(prevData.colorValue)
        });
      }
      colorData.push({
        offset: offset(currData.x) + "%",
        stopColor: colorScale(currData.colorValue)
      });
    }
    // generate the linear gradient used by the signature
    gArea.append("linearGradient")
      .attr("id", "area-gradient")
      .attr("gradientUnits", "userSpaceOnUse")
      .attr("y1", 0)
      .attr("y2", 0)
      .selectAll("stop")
        .data(colorData)
        .enter().append("stop")
          .attr("offset", function(d) { return d.offset })
          .attr("stop-color", function (d) { return d.stopColor; });

  },

  resize: function(el, width, height, instance) {

  }

});
