CREATE TABLE `do_sprawdzanie` (
  `id` mediumint(9) NOT NULL,
  `dcid` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `do_sprawdzanie`
--
ALTER TABLE `do_sprawdzanie`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `do_sprawdzanie`
--
ALTER TABLE `do_sprawdzanie`
  MODIFY `id` mediumint(9) NOT NULL AUTO_INCREMENT;
COMMIT;