Return-Path: <linux-tip-commits+bounces-1605-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C29C3928E78
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 23:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005181C21592
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 21:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95163148FE0;
	Fri,  5 Jul 2024 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iadMFySD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CiXbFNCP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A17713C9A2;
	Fri,  5 Jul 2024 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213605; cv=none; b=s9rum8AjAL6i3k25ZGFEHDKyZDI2v8np4G59OZnveuOg06V8VzEczjBdq9ttYf1TDJX89Twq6K6vp2ILn8Zo21OtB6Bgs3RVNQGVWpmHjo36VqCsBhLzKYUDcSxZIzSRTHmECx9tl7UZNl5srxM84u5zQIXAUmt1ZDD+x9ILPQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213605; c=relaxed/simple;
	bh=ofUYwB9tHwM9J2ZQXQKuMoPMRiKk2vpjZobnsehrkxo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=X8qOigiB2BgbMXw/WBXhRS6YeGR4TL/U0BZC323V+ujdE99eSXU1To7d1a/Wvtv3kS0eIgfIokjVZh24/gKyuEwfNyNZod3Ax2hjAbJC373JcrVLYxgWTvZ3T8pD3H2l5dtlxOSL/svfdjgoUixEy6IJW50iaigmiy17QmNT+44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iadMFySD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CiXbFNCP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Jul 2024 21:06:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720213600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zmVpobcB0+CJnbNi5wQJPO69nb94Q4U1I2htOAuS1ZM=;
	b=iadMFySDM1KiS3VmjdwEWmUOXQyv6dpgQHn8nWKBpg2eGw6mpQy9EAUDFhuKtVeBYMUc/t
	P1OAmj76GLDxCxRPgtgy+RmQlujz8MFKbx8QiyLHBozT0cLKtkDw+F2yMDG5SGOp/RjuNt
	8aVPSraz0D4fss6l2LgtiVm/r2f0oFYale5P/SQNbs5+xWSUYlrtSn/099G15n8koRZYqB
	plcAYWZoUgX8Q6EqMFxeKqjkWjtky3Ae6zAa+Ob/6M+6UUu0eZH0RjSladuQRzTwoHyAHF
	bU4Vgd73GYc3byKCGlqJwJOTevx4yFPOifX+aHrSQ4DZ+AQ+X34FFjj44lzjAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720213600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zmVpobcB0+CJnbNi5wQJPO69nb94Q4U1I2htOAuS1ZM=;
	b=CiXbFNCPtFvEfwvTWEyMqxe+nTZDqeOmZER3D+IO60RmNSdclDguxpF5v1Yrd5EDhxDejj
	ZmrcEqjcSYaWN7Bw==
From: "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/amd/uncore: Fix DF and UMC domain identification
Cc: Sandipan Das <sandipan.das@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240626074942.1044818-1-sandipan.das@amd.com>
References: <20240626074942.1044818-1-sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172021360014.2215.15480084415768774361.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     57e11990f45f89bc29d0f84dd7b13a4e4263eeb2
Gitweb:        https://git.kernel.org/tip/57e11990f45f89bc29d0f84dd7b13a4e4263eeb2
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Wed, 26 Jun 2024 13:19:42 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Jul 2024 16:00:41 +02:00

perf/x86/amd/uncore: Fix DF and UMC domain identification

For uncore PMUs, a single context is shared across all CPUs in a domain.
The domain can be a CCX, like in the case of the L3 PMU, or a socket,
like in the case of DF and UMC PMUs. This information is available via
the PMU's cpumask.

For contexts shared across a socket, the domain is currently determined
from topology_die_id() which is incorrect after the introduction of
commit 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD
0x80000026 leaf") as it now returns a CCX identifier on Zen 4 and later
systems which support CPUID leaf 0x80000026.

Use topology_logical_package_id() instead as it always returns a socket
identifier irrespective of the availability of CPUID leaf 0x80000026.

Fixes: 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20240626074942.1044818-1-sandipan.das@amd.com
---
 arch/x86/events/amd/uncore.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index a0b4405..0bfde2e 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -643,7 +643,7 @@ void amd_uncore_df_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
 	info.split.aux_data = 0;
 	info.split.num_pmcs = NUM_COUNTERS_NB;
 	info.split.gid = 0;
-	info.split.cid = topology_die_id(cpu);
+	info.split.cid = topology_logical_package_id(cpu);
 
 	if (pmu_version >= 2) {
 		ebx.full = cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
@@ -903,8 +903,8 @@ void amd_uncore_umc_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
 	cpuid(EXT_PERFMON_DEBUG_FEATURES, &eax, &ebx.full, &ecx, &edx);
 	info.split.aux_data = ecx;	/* stash active mask */
 	info.split.num_pmcs = ebx.split.num_umc_pmc;
-	info.split.gid = topology_die_id(cpu);
-	info.split.cid = topology_die_id(cpu);
+	info.split.gid = topology_logical_package_id(cpu);
+	info.split.cid = topology_logical_package_id(cpu);
 	*per_cpu_ptr(uncore->info, cpu) = info;
 }
 

