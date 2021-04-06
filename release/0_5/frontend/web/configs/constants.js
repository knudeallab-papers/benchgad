export const QUERY_LIST = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22];

export const QUEUE_LIST = ["Executing", "Waiting", "Waiting", "Waiting", "Waiting", "Waiting"];
export const RESULT_LIST = ["Success", "Failure", "Success", "Success", "Success", "Success", "Success"];

export const PEOPLE_HISTORY = [
    {
        label: "DIRECTOR",
        title: "Young Kyoon, Suh, Ph.D.",
        history: [
            "Assistant Professor of Kyungpook National University",
            "B.S./ M.S./ Ph.D. in Computer Science",
            "(Past) KISTI Specialized Research Staff",
            "Director of Data & Knowledge Engineering Laboratory",
        ],
        contact: [
            "#Address: Deagu, Republic of Korea 41566",
            "#Phone: +82-53-950-6372",
            "#Email: yksuh at knu.ac.kr",
        ],
        homepage: "www.google.com",
    },
    {
        label: "WebPage Producer",
        title: "Research Intern",
    }
]

export const GENERATION_LIST = ["GTX 1080ti", "GTX 2080ti", "GTX 3090ti"];

export const RAM_SIZES = ["4", "8", "16", "32", "64", "128", "CUSTOM"]

export const SCALE_FACTORS = ["1", "2", "4", "8", "16", "32", "64", "128", "256", "512", "1024", "CUSTOM"]

export const DEFAULT_RSCRIPT = [
    '#install.packages("dplyr")', 
    'library(dplyr)', 
    '#install.packages("pastecs")', 
    'library(pastecs)',
    '#install.packages("ggplot2")',
    'library(ggplot2)',
    '#install.packages("ggpubr")',
    '#library("ggpubr")',
    '',
    '#folder <- ',
    'folder <- "."',
    'setwd(folder)',
    'source(paste0(folder, "/ReArrange.R"), echo=TRUE)',
    '',
    '#dataset <- read.csv(file=paste0(folder, "/Integrated_concat.csv"), header = TRUE,stringsAsFactors = FALSE)',
    'dataset <- read.csv(file=paste0(folder, "/raw_dataset.csv"), header = TRUE,stringsAsFactors = FALSE)',
    '#features <- c("RAM_Size,"NumJoins, "NumFTAtts, "NumAllAtts, "NumAllTbl,"NumDsTbl,"NumIK, "DHT, "HDT,"KT, "ET)',
];