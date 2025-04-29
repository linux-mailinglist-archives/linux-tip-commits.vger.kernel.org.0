Return-Path: <linux-tip-commits+bounces-5135-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E51AA39F2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Apr 2025 23:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A41F4C1483
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Apr 2025 21:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6BC262FD8;
	Tue, 29 Apr 2025 21:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kVn7y2Us"
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A84626A0CA;
	Tue, 29 Apr 2025 21:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745962737; cv=none; b=AhIkEpjWIiVJ3VbPPtjVR5CPr3PXBzdlwqJQCEzSdpF/XFIKmC05dZXI817JnP7tQTT6VjyfoddGxVILXSM5IEKTTZjmbMDLI9aaVCi33RKYuhQNQmYDY0qtZugH2rvLyOX0e3rgPvAch/Mhwp5dOIUSWFALwedYxVOUOtuTmjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745962737; c=relaxed/simple;
	bh=NgXlRi7ByvyuqoGSVzg0p9LuPp3ZSSrv2et1Oir0qnE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O7iscL+ybrwr2ne0cybFqlzy8hTiFkMbe5TNHVmV9u9mEx0sN+XcqbW83fsuyyi/Vsq5S5HU6ktTKM+qBU86fiftiniqUfZKeaUgpcIFjB3RrmxjWIjEyh3ljwytK34/MiV06XzK8uZotG7ixcy1GYVWUz44e9HVDyanF+euwD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kVn7y2Us; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1745962736; x=1777498736;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6pWS6UFOhe9i4/+rtYoRtmh+LDBHour1WcHut23/qrU=;
  b=kVn7y2UsugburEFpGHMxf8KWHXg9OOgkvD6/3JLXmpJzCqb4BBQXdUJh
   1TO26bLGkx2RTnOnT0XZ29fp/DBWZ5lrl/+Bk2iEVsgHTTj6e24KFU0/b
   ECfS4Wr9Ag13tfytZcBbOnllRJUc9U8KNfL+6ijInY2aOY2C+5QFvSixF
   8=;
X-IronPort-AV: E=Sophos;i="6.15,250,1739836800"; 
   d="scan'208";a="292876582"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 21:38:52 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:37204]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.68:2525] with esmtp (Farcaster)
 id 9febca8e-c496-45a3-a44b-1c2b580bfebb; Tue, 29 Apr 2025 21:38:51 +0000 (UTC)
X-Farcaster-Flow-ID: 9febca8e-c496-45a3-a44b-1c2b580bfebb
Received: from EX19D016UWA004.ant.amazon.com (10.13.139.119) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 29 Apr 2025 21:38:51 +0000
Received: from 88665a51a6b2.amazon.com (10.106.178.54) by
 EX19D016UWA004.ant.amazon.com (10.13.139.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 29 Apr 2025 21:38:48 +0000
From: Cristian Prundeanu <cpru@amazon.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Cristian Prundeanu <cpru@amazon.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
	"Ali Saidi" <alisaidi@amazon.com>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Geoff Blake <blakgeof@amazon.com>, Csaba Csoma
	<csabac@amazon.com>, Bjoern Doebel <doebel@amazon.com>, Gautham Shenoy
	<gautham.shenoy@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, "Joseph
 Salisbury" <joseph.salisbury@oracle.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, Borislav Petkov <bp@alien8.de>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-tip-commits@vger.kernel.org>, <x86@kernel.org>
Subject: EEVDF regression still exists
Date: Tue, 29 Apr 2025 16:38:17 -0500
Message-ID: <20250429213817.65651-1-cpru@amazon.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC004.ant.amazon.com (10.13.139.206) To
 EX19D016UWA004.ant.amazon.com (10.13.139.119)

Peter,

Here are the latest results for the EEVDF impact on database workloads. 
The regression introduced in kernel 6.6 still persists and doesn't look 
like it is improving.

This time I've compared apples to apples - default 6.5 vs default 6.12+ 
and SCHED_BATCH on 6.5 vs SCHED_BATCH on 6.12+. The results are below.

Kernel   | Runtime     | Throughput | P50 latency
aarm64   | parameters  | (NOPM)     | (larger is worse)
---------+-------------+------------+------------------
6.5.13   | default     |  baseline  |  baseline
---------+-------------+------------+------------------
6.12.25  | default     |  -5.1%     |  +7.8%
---------+-------------+------------+------------------
6.14.4   | default     |  -7.4%     |  +9.6%
---------+-------------+------------+------------------
6.15-rc4 | default     |  -7.4%     |  +10.2%
======================================================
6.5.13   | SCHED_BATCH |  baseline  |  baseline
---------+-------------+------------+------------------
6.12.25  | SCHED_BATCH |  -8.1%     |  +8.7%
---------+-------------+------------+------------------
6.14.4   | SCHED_BATCH |  -7.9%     |  +8.3%
---------+-------------+------------+------------------
6.15-rc4 | SCHED_BATCH |  -10.6%    |  +11.8%
---------+-------------+------------+------------------

The tests were run with the mysql reproducer published before (link and 
instructions below), using two networked machines running hammerdb and 
mysql respectively. The full test details and reports from "perf sched 
stats" are also posted [1], not included here for brevity.

[1] https://github.com/aws/repro-collection/blob/main/repros/repro-mysql-EEVDF-regression/results/20250428/README.md


At this time, we have accumulated numerous data points and many hours of 
testing exhibiting this regression. The only counter arguments I've seen 
are relying on either synthetic test cases or unrealistic simplified tests 
(e.g. SUT and loadgen on the same machine, or severely limited thread 
count). It's becoming painfully obvious that EEVDF replaced CFS before it 
was ready to be released; yet most of what we've been debating is whether 
SCHED_BATCH is a good enough workaround.

Please let's take a fresh approach at what's happening, and find out why 
the scheduler is underperforming. I'm happy to provide additional data if 
it helps debug this. I've backported and forward ported Swapnil's "perf 
sched stats" command [2] so it is ready to run on any kernel from 6.5 up 
to 6.15, and the reproducer already runs it automatically for convenience.

[2] https://lore.kernel.org/lkml/20250311120230.61774-1-swapnil.sapkal@amd.com/


Instructions for reproducing the above tests (same as before):

1. Code: The reproducer scenario and framework can be found here: 
https://github.com/aws/repro-collection

2. Setup: I used a 16 vCPU / 32G RAM / 1TB RAID0 SSD instance as SUT, 
running Ubuntu 22.04 with the latest updates. All kernels were compiled 
from source, preserving the same config across versions (as much as 
possible) to minimize noise - in particular, CONFIG_HZ=250 was used 
everywhere.

3. Running: To run the repro, set up a SUT machine and a LDG (loadgen) 
machine on the same network, clone the git repo on both, and run:

(on the SUT) ./repro.sh repro-mysql-EEVDF-regression SUT --ldg=<loadgen_IP> 

(on the LDG) ./repro.sh repro-mysql-EEVDF-regression LDG --sut=<SUT_IP>

The repro will build and test multiple combinations of kernel versions and 
scheduler settings, and will prompt you when to reboot the SUT and rerun 
the same above command to continue the process.

More instructions can be found both in the repo's README and by running 
'repro.sh --help'.

