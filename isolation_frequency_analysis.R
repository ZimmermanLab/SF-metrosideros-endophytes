# script to analyze preliminary isolation data for m. excelsa in San Francisco
# Emma Gibson, egibson@dons.usfca.edu, 4/20/17
# adding a comment for git

isolation_data <- read.csv("data/metrosideros_preliminary_data_R.csv")

isolation_data$fraction_grew <- isolation_data$tubes_grew / isolation_data$tubes_total

pdf("isolation_freq_plot_1.pdf")
boxplot(fraction_grew ~ site,
        data = isolation_data, 
        main = "Isolation Frequencies",
        xlab = "Site",
        ylab = "Isolation Frequency",
        lwd = 2,
        col = "#65c675",
        cex.main = 1.5,
        cex.lab = 1.5,
        cex.axis = 1.5)

#png("isolation_freq_plot_1.png", width = 1600, height = 2400, units = "px")
#par(cex.lab = 8)
#par(cex.axis = 6)
#par(mai=c(4,4,5.1,1))
#par(mgp = c(5, 1, 0))
#par(omi=c(2.5,3,5.1,1))
#boxplot(fraction_grew ~ site,
#        data = isolation_data, 
#        main = "Isolation Frequencies",
#        xlab = NA,
#        ylab = NA,
#        xaxt = 'n',
#        yaxt = 'n',
#        lwd = 8,
#        col = "#65c675",
#        cex.main = 8,
#        cex.lab = 6,
#        cex.axis = 6)
#title(ylab = "Fraction of Tubes with Growth", cex.lab = 6,
#      line =10)

#box(lwd=5)


#title(xlab = "Site", cex.lab = 6, line = 10)

#axis(side = 1,at = c(1,2,3), tcl = -0.5, lwd.ticks = 6)
#axis(side = 1, at = c(1,2,3), tcl = -0.5, lwd = 0, lwd.ticks = 0, line = 3.5)
#axis(side = 1, at = c(1,2,3), tcl = -0.5, lwd = 0, lwd.ticks = 7, labels = NA)

# y axis
#title(ylab = "Isolation Frequency", cex.lab = 6, line = 10)
#axis(side = 2, at = seq(0.2, 0.8, 0.1), tcl = -0.5, lwd.ticks = 7, labels = NA)
#axis(side = 2, at = seq(0.2, 0.8, 0.1), tcl = -0.5, lwd = 0, lwd.ticks = 0, line = 2)
dev.off()

kruskal.test(fraction_grew ~ site,
        data = isolation_data)
