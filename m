Return-Path: <linux-tip-commits+bounces-5041-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EDCA91D35
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 15:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B85D7B1201
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 13:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0489F2459C2;
	Thu, 17 Apr 2025 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LY2ITH1a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ppp+CyGl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DD624C67F;
	Thu, 17 Apr 2025 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744894900; cv=none; b=tRBhSrUvoWeo52vHwD7KI0jq2hdKpgGCnysrB36+IiSKFhoYtWZFY6GNQcyUS40sZXmbBlsky7Qzk4z8IGkLFMoZT3ZUgNXRa2Qi0BTiqeP4dFGs0huPsR18W0Hi42Bq/fY6XdcN4WoV2nj7k4Y4T7gw51qH0c0C8s74tgqSm9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744894900; c=relaxed/simple;
	bh=EI1cSxGUGr+iXJEvpu+bRLYjcpS1YC/pkqZPX5GwSnE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oW36/MII1nJwlP7uO0II7aVr9W45CEbwaxpIouJAXd/gKEF0a2Smpn8sBjIrG/XSbm+yvd2+v49B5Wbuxeod1HFealC9yqm59qoBMGrD/1UNflj5vyNmgL8RD7RTXWP6ubmVrKipCwE+41u3WAuhhOinkvBJG4tVSJlkHSyjBfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LY2ITH1a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ppp+CyGl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 13:01:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744894898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bqonwy7IIp2NI8HPIcvSb8RzQspGFzpIhY2O1RUgr4E=;
	b=LY2ITH1aIhjl0wNsevACOWI4YGNCDp1uYe8MouvFzYe5f926W5W5HMct3lhmVuXQIljxZc
	QjBdNiSOimHF3WtKmDrQwh4ru06vpf1Mk1CL9jkWHoU6RmQmQu1TuDyudxUpZivKJQVLhU
	OIT0YrdNqKNgizdT/JgKkkwQGNyNO/1CRi28VhGtlP+iINaSyVqa1npd4OmMJpU3qVhpgT
	McUnT8bzEJEzUWxGJod5rpnltisz1AaK+DCu5V/OvaWg+T21TwdgViYfrUBCk9chDBT2gg
	cMtXvTCsfKqWSo4IdM5ly0JvEf5WS+Qz3n3GAV9aDshPVjEPULftkcs+t7ucZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744894898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bqonwy7IIp2NI8HPIcvSb8RzQspGFzpIhY2O1RUgr4E=;
	b=Ppp+CyGlPh8DSDRxXOE59DnB7yjpEktE4kwhC2Tt/sw5eiZsEIIRR1r0jyc3RVj30/jwF0
	9Wxad/4jaDBvI/AQ==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Add Panther Lake support
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250415114428.341182-2-dapeng1.mi@linux.intel.com>
References: <20250415114428.341182-2-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174489489686.31282.1123467555641432023.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7950de14ff5fd8da355d872b887ee8b7b5a1f327
Gitweb:        https://git.kernel.org/tip/7950de14ff5fd8da355d872b887ee8b7b5a1f327
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 15 Apr 2025 11:44:07 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 17 Apr 2025 14:19:59 +02:00

perf/x86/intel: Add Panther Lake support

>From PMU's perspective, Panther Lake is similar to the previous
generation Lunar Lake. Both are hybrid platforms, with e-core and
p-core.

The key differences are the ARCH PEBS feature and several new events.
The ARCH PEBS is supported in the following patches.
The new events will be supported later in perf tool.

Share the code path with the Lunar Lake. Only update the name.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20250415114428.341182-2-dapeng1.mi@linux.intel.com
---
 arch/x86/events/intel/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2b70a3a..00dfe48 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -7314,8 +7314,17 @@ __init int intel_pmu_init(void)
 		name = "meteorlake_hybrid";
 		break;
 
+	case INTEL_PANTHERLAKE_L:
+		pr_cont("Pantherlake Hybrid events, ");
+		name = "pantherlake_hybrid";
+		goto lnl_common;
+
 	case INTEL_LUNARLAKE_M:
 	case INTEL_ARROWLAKE:
+		pr_cont("Lunarlake Hybrid events, ");
+		name = "lunarlake_hybrid";
+
+	lnl_common:
 		intel_pmu_init_hybrid(hybrid_big_small);
 
 		x86_pmu.pebs_latency_data = lnl_latency_data;
@@ -7337,8 +7346,6 @@ __init int intel_pmu_init(void)
 		intel_pmu_init_skt(&pmu->pmu);
 
 		intel_pmu_pebs_data_source_lnl();
-		pr_cont("Lunarlake Hybrid events, ");
-		name = "lunarlake_hybrid";
 		break;
 
 	case INTEL_ARROWLAKE_H:

