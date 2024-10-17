Return-Path: <linux-tip-commits+bounces-2492-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 267979A1A1B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Oct 2024 07:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C059DB2315E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Oct 2024 05:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2318C7580C;
	Thu, 17 Oct 2024 05:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="M3fcxRrK"
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FDB21E3C1;
	Thu, 17 Oct 2024 05:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729142419; cv=none; b=gjllJ+6SwhPehPmvH4C1UamnrE7j0JHCKlHThjbY4umd3BQHO6gneH+J7WdxrF90ZhjzzZ2VhcycBPTXByNFlLO01+c7BOayzbMApZRTyTUTWt39Auyh7+urCWHd4lu3gzPqk3tuLoeol4As1PWKZHMnYcC50QMQJ05SglUZ3D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729142419; c=relaxed/simple;
	bh=+Xj8w6UaZp0Z4waMG1QWp/dr6aJ6tqBvpERnjXWuQuc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m5+n78tBsH0ecUE5l1s386x1Fdp2Ymsgh8axzlhqFq7tl4z5VHPhZ89rzq5CHpx0faBYk3nxUL9tFJdOaEu2/J5pOqNDwef8k5gil54qBBHEDQnuXsZ4mtTDUP03D6NdMAyEAJtP8+2HR1C0PjDsm737YYWUX34MTSanNvDuSbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=M3fcxRrK; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729142418; x=1760678418;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PyM8z3sI+W+xh15WCmRe0Enxn0PlpEuOGN4i5iNNDig=;
  b=M3fcxRrKHfXgaDwm5iX2wRLXBfv63CXfvIDC+cXDeQLM9Y0Yo+jX4/lz
   Ms5YGSdsiX6RJDM8ejJ63F3G7c9zrmvDZf/KoLuMIpTUW1eSHZTNuT0nz
   wvn0WNEmCceaY5ucrS8t4tk4w8al241W1VwXr7ionSp2S4LBbpHWm3t5u
   s=;
X-IronPort-AV: E=Sophos;i="6.11,210,1725321600"; 
   d="scan'208";a="376971359"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 05:20:17 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:13163]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.23:2525] with esmtp (Farcaster)
 id a239f07b-d0c2-46bd-a0e5-2c1e3121e7e6; Thu, 17 Oct 2024 05:20:16 +0000 (UTC)
X-Farcaster-Flow-ID: a239f07b-d0c2-46bd-a0e5-2c1e3121e7e6
Received: from EX19D016UWA004.ant.amazon.com (10.13.139.119) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 17 Oct 2024 05:20:16 +0000
Received: from 88665a51a6b2.amazon.com (10.106.178.54) by
 EX19D016UWA004.ant.amazon.com (10.13.139.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 17 Oct 2024 05:20:14 +0000
From: Cristian Prundeanu <cpru@amazon.com>
To: <linux-tip-commits@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Bjoern Doebel <doebel@amazon.com>,
	Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>, Geoff Blake
	<blakgeof@amazon.com>, Ali Saidi <alisaidi@amazon.com>, Csaba Csoma
	<csabac@amazon.com>, Cristian Prundeanu <cpru@amazon.com>
Subject: [PATCH 0/2] [tip: sched/core] sched: Disable PLACE_LAG and RUN_TO_PARITY and move them to sysctl
Date: Thu, 17 Oct 2024 00:19:58 -0500
Message-ID: <20241017052000.99200-1-cpru@amazon.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
 EX19D016UWA004.ant.amazon.com (10.13.139.119)

This patchset disables the scheduler features PLACE_LAG and RUN_TO_PARITY 
and moves them to sysctl.

Replacing CFS with the EEVDF scheduler in kernel 6.6 introduced 
significant performance degradation in multiple database-oriented 
workloads. This degradation manifests in all kernel versions using EEVDF, 
across multiple Linux distributions, hardware architectures (x86_64, 
aarm64, amd64), and CPU generations.

For example, running mysql+hammerdb results in a 12-17% throughput 
reduction and 12-18% latency increase compared to kernel 6.5 (using 
default scheduler settings everywhere). The magnitude of this performance 
impact is comparable to the average performance difference of a CPU 
generation over its predecessor.

Testing combinations of available scheduler features showed that the 
largest improvement (short of disabling all EEVDF features) came from 
disabling both PLACE_LAG and RUN_TO_PARITY:

Kernel   | default  | NO_PLACE_LAG and
aarm64   | config   | NO_RUN_TO_PARITY
---------+----------+-----------------
6.5      | baseline |  N/A
6.6      | -13.2%   | -6.8%
6.7      | -13.1%   | -6.0%
6.8      | -12.3%   | -6.5%
6.9      | -12.7%   | -6.9%
6.10     | -13.5%   | -5.8%
6.11     | -12.6%   | -5.8%
6.12-rc2 | -12.2%   | -8.9%
---------+----------+-----------------

Kernel   | default  | NO_PLACE_LAG and
x86_64   | config   | NO_RUN_TO_PARITY
---------+----------+-----------------
6.5      | baseline |  N/A
6.6      | -16.8%   | -10.8%
6.7      | -16.4%   |  -9.9%
6.8      | -17.2%   |  -9.5%
6.9      | -17.4%   |  -9.7%
6.10     | -16.5%   |  -9.0%
6.11     | -15.0%   |  -8.5%
6.12-rc2 | -12.7%   | -10.9%
---------+----------+-----------------

While the long term approach is debugging and fixing the scheduler 
behavior, algorithm changes to address performance issues of this nature 
are specialized (and likely prolonged or open-ended) research. Until a 
change is identified which fixes the performance degradation, in the 
interest of a better out-of-the-box performance: (1) disable these 
features by default, and (2) expose these values in sysctl instead of 
debugfs, so they can be more easily persisted across reboots.

Cristian Prundeanu (2):
  sched: Disable PLACE_LAG and RUN_TO_PARITY
  sched: Move PLACE_LAG and RUN_TO_PARITY to sysctl

 include/linux/sched/sysctl.h |  8 ++++++++
 kernel/sched/core.c          | 13 +++++++++++++
 kernel/sched/fair.c          |  5 +++--
 kernel/sched/features.h      | 10 ----------
 kernel/sysctl.c              | 20 ++++++++++++++++++++
 5 files changed, 44 insertions(+), 12 deletions(-)

-- 
2.40.1


