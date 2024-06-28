--  You will be using Rnacen (RNACentral) schema to find and explore the data available in all tables that will help you to recognise the potential tables you can query to answer the following questions

-- Write a query to get data having length of Rna structures more than 12 with them being added after 2008

select * from rna
where (length(seq_short)>12
	 and timestamp >= '2009-1-1')
	order by "timestamp"
	 limit 5
;
-- Result

-- 8	URS0000000008	2014-05-29 13:51:05.000	RNACEN	A6FA958EE502C5AE	72	ATATCCTTAATTTAATGGGTAAAATATTAGAATACGGATCTAATTATATAGGTTCAATTCCTATAGGATATT		030c81880acd1fa3c25884e934a79329
-- 9	URS0000000009	2014-05-29 13:51:05.000	RNACEN	C6904E92F9C9F562	405	AGGTCTTGACATCTTGCGCTAACCTAAGAGATTAGGCGTTCCCTTCGGGGACGCAATGACAGGTGGTGCATGGTCGTCGTCAGCTCGTGTCGTGAGATGTTGGGTTAAGTCCCGCAACGAGCGCAACCCTTGTTACTAGTTGCCAGCATTCAGTTGGGCACTCTAGTGAGACTGCCGGTGACAAACCGGAGGAAGGTGGGGACGACGTCAGATCATCATGCCCCTTATGACCTGGGCTACACACGTGCTACAATGGCCGGTACAACGAGCAGCTAACCCGCGAGGGTGTGCAAATCTCTTAAAGCCGGTCTCAGTTCGGACTGCAGTCTGCAACTCGACTGCACGAAGTCGGAATCGCTAGTAATCGCGGATCAGCATGCCGCGGTGAATACGTTCCCGGGCCTT		6bba218d4452230c1b54d4800b72b0d7
-- 3	URS0000000003	2014-05-29 13:51:05.000	RNACEN	8A2659C67178A964	363	GTATGCAACTTACCTTTTACTAGAGAATAGCCAAGAGAAATTTTGATTAATGCTCTATGTTCTTATTTACTCGCATGAGTAAATAAGCAAAGCTCCGGCGGTAAAAGATGGGCATGCGTCCTATTAGCTTGTAGGTGAGGTAATGGCTCACCTAAGCTCCGATAGGTAGGGGTCCTGAGAGGGAGATCCCCCACACTGGTACTGAGACACGGACCAGACTTCTACGGAAGGCAGCAGTAAGGAATATTGGACAATGGAGGCAACTCTGATCCAGCCATGCCGCGTGAAGGAAGACGGCCTTATGGGTTGTAAACTTCTTTTATACAGGAAGAAACCTTTCCACGTGTGGAAAGCTGACGGTAC		7bb11d0572ff6bb42427ce74450ba564
-- 6	URS0000000006	2014-05-29 13:51:05.000	RNACEN	624610370AFE74D7	558	TTAGTAGTAAAGTCTGCTCCATGAATACTTAAATAGCCGCAATTCGTGCTAAGGTAGCATAATCATTTGTCTTTTAAATGAGGACTAGAACAAAAGATTTAACATTTTAAATTATTTATTTAAATTAATTATTTAAATTTTCTTAAGCGTAAAAAGACACTTATTAAAAAGAAAGACGACAAGACCCTATCGAACTTAACTCAAGTTTAACTGGGGTAGTTAATTAATTATTATTTTAATATACTATAACTACTAATTATCTAATTAATTAATAATCCAGTTACCGTAGGGATAACAGCGCAATTAAATTTTAAAGTACTTATTTAAAAAATAGATTACGACCTCGATGTTGAATTAATAACCTATTTGAAGCAAATTTCAAAAAAGGAAGTCTGTTCGACTTTTAAAAAATTACATGATTTGAGTTCAGACCGGTATAAGCCAGGTCGGTTTCAATCTTCTAAAAACTCTTTTACAGTACGAAAGGACCTAAAAATATAATTTAATTATTTATATTGGCAGAAAAATGCATTAGAATTAGAATCTAATAAAACTTTT		030c7b604f2cd2801786b27280b2fc7d
-- 10	URS000000000A	2014-05-29 13:51:05.000	RNACEN	DECDB7CA6C583617	399	ATTGAACGCTGGCGGCATGCTTTACACATGCAAGTCGAACGGCAGCGGGTCCTTCGGGATGCCGGCGAGTGGCGAACGGGTGAGTAATGCATCGGAACGTACCCAGACGTGGGGGATAACTACGCGAAAGCGTAGCTAATACCGCATACGCCCTGAGGGGGAAAGCGGGGGATCTTCGGACCTCGCGCGATTGGAGCGGCCGATGTCGGATTAGCTAGTTGGTGGGGTAAAGGCCTACCAAGGCGATGATCCGTAGCTGGTCTGAGAGGATGATCAGCCACACTGGGACTGAGACACGGCCCAGACTCCTACGGGAGGCAGCAGTGGGGAATTTTGGACAATGGGCGCAAGCCTGATCCAGCCATGCCGCGTGAGTGAAGAAGGCCTCGGTTGTAAGTA		7bb11f65665abfa62b67392e4fd51895


-- testing
select timestamp from rna 
	where timestamp >= date('2009-1-1') 
	limit 10
-- ->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->


-- How many pre computed RNA are present that are still active and got their last release update before 2022
select count(*) from rnc_rna_precomputed
where is_active 
and UPDATE_DATE < '2022-1-1';

-- Result
55930772

-- ->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->


-- How many total pre computed RNA records for snoRNA and tRNA were recorded in 2011, 2016, 2014, and 2020
select count(*) from rnc_rna_precomputed
where extract(year from update_date) in (2011, 2016, 2014, 2020)
and rna_type in ('snoRNA', 'tRNA');

-- Result
915377 - (1 row(s) fetched - 15m 58s (0.001s fetch), on 2024-06-28 at 09:22:44)

-- testing
-- DATE_PART('year', column_name::date)
-- extract(year from update_date);

-- ->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->



-- Can you give me the names of all databases built for RNA with minimum length other than 100, 200, 300, 400, and 15
select display_name from rnc_database
where min_length not in (100, 200, 300, 400, 15);

-- Result
-- display_name    |
-- ----------------+
-- ENA             |
-- GENCODE         |
-- MGnify          |
-- GeneCards       |
-- RDP             |
-- snoRNA Database |
-- Rfam            |
-- TAIR            |
-- PSICQUIC        |
-- WormBase        |
-- FlyBase         |
-- snoDB           |
-- SRPDB           |
-- ZFIN            |
-- tmRNA Website   |
-- Expression Atlas|
-- Ensembl Fungi   |
-- ZWD             |
-- Ensembl Protists|
-- GtRNAdb         |
-- 5SrRNAdb        |
-- Modomics        |
-- MalaCards       |
-- RiboVision      |
-- Ensembl         |
-- Ensembl Metazoa |
-- PLncDB          |
-- MGI             |
-- Ensembl/GENCODE |
-- PDBe            |
-- PomBase         |
-- SGD             |
-- HGNC            |
-- TarBase         |
-- Ribocentre      |
-- NONCODE         |
-- REDIPortal      |
-- CRW             |
-- lncRNAdb        |
-- EVLncRNAs       |
-- snOPY           |
-- MirGeneDB       |
-- RGD             |
-- Greengenes      |
-- dictyBase       |
-- LncBook         |
-- LncBase         |
-- IntAct          |

-- ->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->


-- Can you get complete 500 records of sequences for active regions and name your column as myregions in which you are getting the region name column value. 
-- Then tell me what different chromosomes with exon_count we have for regions including center, east and north using the name you set for your column
select region_name myregions, chromosome, exon_count from rnc_sequence_regions_active
where region_name in ('center', 'east', 'north')
limit 500

-- Result
-- myregions|exon_count|
-- ---------+----------+

-- ->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->