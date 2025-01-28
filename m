Return-Path: <linux-tip-commits+bounces-3297-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25C2A214E7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Jan 2025 00:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5251667FC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 Jan 2025 23:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B1A1DF72C;
	Tue, 28 Jan 2025 23:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kYUELt+b"
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B284193402;
	Tue, 28 Jan 2025 23:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738105783; cv=none; b=bl3G0KaceNRjB8b2YVu6fDU0oN22vWE+tnQ4xBMw4/aMD07pdRsLmTrZnucLl2jXNerZaUsQ2HIZhCb4JvA+HxYk8xz4cJKlTjGcASXBNOpfHOXmd2DzZGqPNXVaGpZ6DbvKYFJ3AXcl8EaO6DoJmlag4sw4HB+hMIGu+NklZlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738105783; c=relaxed/simple;
	bh=FvB8tZxJFAZv2wksBAdQUfjXYKSZ2PJfoAco7hkfXpk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q27pgG64ubqaUPu5twbndlOv16LFFyPI0DEF4MTdUO6bFQN8XUuOg0Mz0HJt77B2FZoOqAGvWtWcfrLWOkrtRbLlWbxv5rjqmuKMS9BY8vatRBeb+AoUcf/dBHuonjq3ZL+z4nLaYUZhiIh2N3NlUrrD+/5QhYOzi5iwKp+xKsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kYUELt+b; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738105782; x=1769641782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/0W2o0hkDJje6TvICiv/xRrM6lz4rUh/UvN51cJhJUo=;
  b=kYUELt+b0eUrEX/BMU61q54pHX1r5s+STvfmRbWdtQfGMqVW3vJjBz9P
   tcXVuVEKVSh3SmKniVIHatWAuK47+GjtNx9VRDi9xZfC+sHoINlv4A+Fx
   KImusKQ/ShoBk3NOf/RxohEr3/IPCuRLaKDAnXgFRZaQ9s0G+eEJMILD1
   0=;
X-IronPort-AV: E=Sophos;i="6.13,242,1732579200"; 
   d="scan'208";a="714298510"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 23:09:39 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:57712]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.10:2525] with esmtp (Farcaster)
 id c0c7093e-98ea-47a8-98a5-47be9e4a4b48; Tue, 28 Jan 2025 23:09:38 +0000 (UTC)
X-Farcaster-Flow-ID: c0c7093e-98ea-47a8-98a5-47be9e4a4b48
Received: from EX19D016UWA004.ant.amazon.com (10.13.139.119) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 28 Jan 2025 23:09:38 +0000
Received: from 88665a51a6b2.amazon.com (10.106.179.50) by
 EX19D016UWA004.ant.amazon.com (10.13.139.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 28 Jan 2025 23:09:35 +0000
From: Cristian Prundeanu <cpru@amazon.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <cpru@amazon.com>, <kprateek.nayak@amd.com>, <abuehaze@amazon.com>,
	<alisaidi@amazon.com>, <benh@kernel.crashing.org>, <blakgeof@amazon.com>,
	<csabac@amazon.com>, <doebel@amazon.com>, <gautham.shenoy@amd.com>,
	<joseph.salisbury@oracle.com>, <dietmar.eggemann@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-tip-commits@vger.kernel.org>, <mingo@redhat.com>, <x86@kernel.org>,
	<torvalds@linux-foundation.org>, <bp@alien8.de>
Subject: Re: [PATCH 0/2] [tip: sched/core] sched: Disable PLACE_LAG and RUN_TO_PARITY and move them to sysctl
Date: Tue, 28 Jan 2025 17:09:26 -0600
Message-ID: <20250128230926.11715-1-cpru@amazon.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: 20241017052000.99200-1-cpru@amazon.com
References: 20250119110410.GAZ4zcKkx5sCjD5XvH@fat_crate.local
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D016UWA004.ant.amazon.com (10.13.139.119)

Peter,

Thank you for the recent scheduler rework which went into kernel 6.13. 
Here are the latest test results using mysql+hammerdb, using a standalone 
reproducer (details and instructions below).

Kernel | Runtime      | Throughput | P50 latency
aarm64 | parameters   | (NOPM)     | (larger is worse)
-------+--------------+------------+------------------
6.5    | default      |  baseline  |  baseline
-------+--------------+------------+------------------
6.8    | default      |  -6.9%     |  +7.9%
       | NO_PL NO_RTP |  -1%       |  +1%
       | SCHED_BATCH  |  -9%       |  +10.7%
-------+--------------+------------+------------------
6.12   | default      |  -5.5%     |  +6.2%
       | NO_PL NO_RTP |  -0.4%     |  +0.1%
       | SCHED_BATCH  |  -4.1%     |  +4.9%
-------+--------------+------------+------------------
6.13   | default      |  -4.8%     |  +5.4%
       | NO_PL NO_RTP |  -0.3%     |  +0.01%
       | SCHED_BATCH  |  -4.8%     |  +5.4%
-------+--------------+------------+------------------

A performance improvement is noticeable in kernel 6.13 over 6.12, both in 
latency and throughput. At the same time, SCHED_BATCH no longer has the 
same positive effect it had in 6.12.

Disabling PLACE_LAG and RUN_TO_PARITY is still as effective as before. 
For this reason, I'd like to ask once again that this patch set be 
considered for merging and for backporting to kernels 6.6+.

> This patchset disables the scheduler features PLACE_LAG and RUN_TO_PARITY 
> and moves them to sysctl.
>
> Replacing CFS with the EEVDF scheduler in kernel 6.6 introduced 
> significant performance degradation in multiple database-oriented 
> workloads. This degradation manifests in all kernel versions using EEVDF, 
> across multiple Linux distributions, hardware architectures (x86_64, 
> aarm64, amd64), and CPU generations.

When weighing the relevance of various testing approaches, please keep in 
mind that mysql is a real-life workload, while the test which prompted the 
introduction of PLACE_LAG is much closer to a synthetic benchmark.


Instructions for reproducing the above tests:

1. Code: The repro scenario that was used for this round of testing can be 
found here: https://github.com/aws/repro-collection

2. Setup: I used a 16 vCPU / 32G RAM / 1TB RAID0 SSD instance as SUT, 
running Ubuntu 22.04 with the latest updates. All kernels were compiled 
from source, preserving the same config (as much as possible) to minimize 
noise - in particular, CONFIG_HZ=250 was used everywhere.

3. Running: To run the repro, set up a SUT machine and a LDG (loadgen) 
machine on the same network, clone the git repo on both, and run:

(on the SUT) ./repro.sh repro-mysql-EEVDF-regression SUT --ldg=<loadgen_IP> 

(on the LDG) ./repro.sh repro-mysql-EEVDF-regression LDG --sut=<SUT_IP>

The repro will build and test multiple combinations of kernel versions and 
scheduler settings, and will prompt you when to reboot the SUT and rerun 
the same command to continue the process.

More instructions can be found both in the repo's README and by running 
'repro.sh --help'.

