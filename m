Return-Path: <linux-tip-commits+bounces-5673-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3835ABE261
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 May 2025 20:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D5B3A63D1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 May 2025 18:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DD927F16F;
	Tue, 20 May 2025 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="eLCfiSaw"
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7791E25EB;
	Tue, 20 May 2025 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747764913; cv=none; b=eDPWDOx/TT4eGYdVM6X33N+hcPWpgV9vCpi5io8U7zzClpWmxwMAjuuPOZiq/fREYVNWnBko91jJjPGrJs4kuq9XWHhkZScVCo4eUCD1OENvxQJRzbYrHwI6lLwq2L1QQE1F8rUoPIjICmQLhmpQF+hh5PbMBGh1x0in4KtsXO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747764913; c=relaxed/simple;
	bh=C66kqRSeWdjx8QY1oWGBQH7q1qycqRR9JLExZ+Yrcvc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=swQZ8U4bRZF0nvdv8AStkPgk1ObRYg9JzlJ5QlinCo4IYB7rhTQL6xqxUo/owZzaRF6h9pv1gbzW6Ha/BDPB2JLw5aKBOO/zufwLBFwnPPXZhqRRKIJcFzry/E7DecPH6xSmeYFpT3GpEM6svSqULTnTD3XulmOppcju61+c3NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=eLCfiSaw; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747764912; x=1779300912;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LzohEFSyN+OrM/0tt622ly3buW/LPGAt5UJsdRD3IFo=;
  b=eLCfiSawA/UziNHDeOSciwpjh39pHHDNUneVj+L9JDM8aJawgVa8W6O/
   bCtQPoU9+B2Ayq+ba7fj/U4+7VivbVJI8O7hLBK8+QVYmnedsuUElgTn2
   cchHf6kVMUeExqw7cn8bhEghbZfGX5mt3ntiUX/xj9G89f7ZR6an5u3CH
   XFeKT4bOWO5QqG4o0J68BjnUJpumwYnw3dFL35HLd5GaMUHltncWD9y1z
   ho6Wh750QufSToQ6JGGk4nB91irwpULU5BJGBjOd7MSRzK0gVT9Y2/sBt
   xfRznwou4ybs1ehaOXxrC7Vvc5rlsMXB1hd777IjsGJhQ7OUEeqqTPDhp
   A==;
X-IronPort-AV: E=Sophos;i="6.15,302,1739836800"; 
   d="scan'208";a="198951662"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 18:15:11 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:50819]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.48:2525] with esmtp (Farcaster)
 id 6d333323-4d85-42d1-89c7-66d208457dbc; Tue, 20 May 2025 18:15:11 +0000 (UTC)
X-Farcaster-Flow-ID: 6d333323-4d85-42d1-89c7-66d208457dbc
Received: from EX19D016UWA004.ant.amazon.com (10.13.139.119) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 20 May 2025 18:15:07 +0000
Received: from 7cf34dda9133.amazon.com (10.106.239.26) by
 EX19D016UWA004.ant.amazon.com (10.13.139.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 20 May 2025 18:15:04 +0000
From: Cristian Prundeanu <cpru@amazon.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Cristian Prundeanu <cpru@amazon.com>, Hazem Mohamed Abuelfotoh
	<abuehaze@amazon.com>, Ali Saidi <alisaidi@amazon.com>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>, Geoff Blake <blakgeof@amazon.com>,
	Borislav Petkov <bp@alien8.de>, Csaba Csoma <csabac@amazon.com>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Bjoern Doebel <doebel@amazon.de>,
	Gautham Shenoy <gautham.shenoy@amd.com>, Joseph Salisbury
	<joseph.salisbury@oracle.com>, Chris Redpath <chris.redpath@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-tip-commits@vger.kernel.org>, <x86@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Swapnil Sapkal
	<swapnil.sapkal@amd.com>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: EEVDF regression still exists
Date: Tue, 20 May 2025 13:14:51 -0500
Message-ID: <20250520181451.18994-1-cpru@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
 EX19D016UWA004.ant.amazon.com (10.13.139.119)

>> The only _scheduler_ change that looks relevant is commit bbce3de72be5
>> ("sched/eevdf: Fix se->slice being set to U64_MAX and resulting
>> crash"). Which does affect the slice calculation, although supposedly
>> only under special circumstances.> 
>> Of course, it could be something else.
>
> Since it is the only !SCHED_EXT change in kernel/sched, Cristian can
> perhaps try reverting it on top of v6.15-rc4 and checking if the
> benchmark results jump back to v6.15-rc3 level to rule that single
> change out. Very likely it could be something else.

I have tested reverting this commit, and the performance indeed jumped back
to rc3 levels.

> The VU count should really be based on the SUT core count, and be at least
> 8 * SUT vCPUs to ensure a full load. 

I've modified the reproducer to more accurately configure the VU count
based on the SUT's vCPU count, and use the above multiplier going forward.

Retesting the entire kernel range with the resulting 128 VUs shows a
slightly higher performance everywhere compared to the previous 256 VUs.
The regression is even more visible now, with a few notable points:
- There is a performance inversion from before (6.15-rc3 now underperforms
  6.15-rc4). This may be useful data for characterizing the regression.
- Kernel 6.14.7 is about the same as 6.14.6 in default mode, but slower in
  SCHED_BATCH mode (-7.1% vs -6.4%).
- Kernel 6.15-rc5 is faster than all other 6.15-rcX builds, especially in
  default mode.
- Kernel 6.15-rc7 is worse than 6.15-rc6 everywhere except for the default
  mode throughput.
- With either VU value, disabling PLACE_LAG and RUN_TO_PARITY no longer
  improves performance significantly on up to date kernels 6.12 and above.

Summary below, full details in the reproducer repo [1].


* All without SCHED_BATCH:

Kernel   | Throughput | P50 latency       | NOPL+NORTP
aarm64   | (NOPM)     | (larger is worse) | (NOPM)
=========+============+===================+============
6.5.13   |  baseline  |  baseline         | N/A
---------+------------+-------------------+------------
6.6.91   |  -5.7%     |  +9.9%            | -2.6%
---------+------------+-------------------+------------
6.8.12   |  -6.0%     |  +10.7%           | -3.4%
---------+------------+-------------------+------------
6.12.29  |  -6.8%     |  +9.5%            | -8.0%
---------+------------+-------------------+------------
6.13.12  |  -7.6%     |  +10.5%           | -8.5%
---------+------------+-------------------+------------
6.14.7   |  -7.0%     |  +9.8%            | -9.8%
---------+------------+-------------------+------------
6.15-rc3 |  -8.5%     |  +11.7%           |
---------+------------+-------------------+------------
6.15-rc4 |  -7.5%     |  +10.2%           |
---------+------------+-------------------+------------
6.15-rc5 |  -6.4%     |  +8.6 %           |
---------+------------+-------------------+------------
6.15-rc6 |  -7.5%     |  +10.4%           | -9.0%
---------+------------+-------------------+------------
6.15-rc7 |  -7.8%     |  +11.1%           | -8.5%
=========+============+===================+============


* All with SCHED_BATCH:

Kernel   | Throughput | P50 latency
aarm64   | (NOPM)     | (larger is worse)
=========+============+==================
6.5.13   |  baseline  |  baseline
---------+------------+------------------
6.6.91   |  -5.1%     |  +7.4%
---------+------------+------------------
6.8.12   |  -6.0%     |  +8.6%
---------+------------+------------------
6.12.29  |  -6.6%     |  +8.4%
---------+------------+------------------
6.13.12  |  -6.9%     |  +8.9%
---------+------------+------------------
6.14.7   |  -7.1%     |  +8.7%
---------+------------+------------------
6.15-rc3 |  -9.6%     |  +11.8%
---------+------------+------------------
6.15-rc4 |  -7.0%     |  +8.6%
---------+------------+------------------
6.15-rc5 |  -6.6%     |  +7.9%
---------+------------+------------------
6.15-rc6 |  -6.6%     |  +8.4%
---------+------------+------------------
6.15-rc7 |  -7.7%     |  +9.7%
=========+============+==================

[1] https://github.com/aws/repro-collection/blob/main/repros/repro-mysql-EEVDF-regression/results/20250519/README.md

-Cristian

