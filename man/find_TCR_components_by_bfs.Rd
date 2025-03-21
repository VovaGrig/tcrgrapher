% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/component_search_bfs.R
\name{find_TCR_components_by_bfs}
\alias{find_TCR_components_by_bfs}
\title{find_TCR_components_by_bfs}
\usage{
find_TCR_components_by_bfs(TCRgrObject, v_gene = TRUE, j_gene = FALSE)
}
\arguments{
\item{TCRgrObject}{input object}

\item{v_gene}{Boolean value. If 'v_gene' is 'TRUE', only clonotypes with the
same V genes will be part of one connectivity component. Default value is 'TRUE'.}

\item{j_gene}{Boolean value. If 'j_gene' is 'TRUE', only clonotypes with the
same J genes will be part of one connectivity component. Default value is 'FALSE'.}
}
\value{
The function returns TCRgrapher object. The clonoset has the new column "cluster_id", where
every connectivity component has a unique value. TCRgrapher  object contains
found edges. To see them use edges(\if{html}{\out{<your object>}})
}
\description{
The function searches for connectivity components of the graph, where every node is a
clonotype with a unique clone_id and edges connect clonotypes that differ by one
amino acid mismatch. It returns the same TCRgrapher object with list of edges and
with additional column cluster_id in the clonoset table.
}
