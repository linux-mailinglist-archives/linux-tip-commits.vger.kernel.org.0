Return-Path: <linux-tip-commits+bounces-5036-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 636CCA91D2A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 15:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032DD1899A64
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 13:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF8424A040;
	Thu, 17 Apr 2025 13:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="or/ZNvL0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XjLIVPYd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA25E24635E;
	Thu, 17 Apr 2025 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744894895; cv=none; b=fTAll3tpaI4Tk97jS4Q9xTAZHAVQXNvtRGS4B9p5IIsPuEqNJs+rJPSACIOFEbz7XTYd0RVhvarC2MEY9NGLcRNd/oEUOvViyKdbb0qoAJhB8FiFXB8HNtXQkBDbn9aSbddQoIrlpuVWJ2dx4oPEMejNX//Jje9Q29ctkUW6hA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744894895; c=relaxed/simple;
	bh=B4OL0Xz4/iXhAVkaRjOaEjC2Aby3ASGaKZnFj9xkK/U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J9EtC1qiDU+jT10dtND/KrmXaYRsN4xRMEu2bmKplcIUqyiwmceCGXhtblZYrFFl1kmXuivwPBZ4gKVZmqgrto3oWgdRNBi5qIIF4BzJguecX6nO7iXKGg8lnG07USuuyxqzN81TOV8A+r2UR1RlG4Gs/qVUkte9s1ZwVgrSkMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=or/ZNvL0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XjLIVPYd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 13:01:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744894892;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKJu+fMyldXdIQrlT+3cN6z1WTQoPrFBWVJPNeKPcR0=;
	b=or/ZNvL0fkX+VDblUqeHxZ0/CEY9VYa0oJHKq1iWhBh8v+9YoIuNpxk+Xroa6U5pYicUCY
	46d6K51NI4TU1olRHpLMnj+LkWPXDK4KdLbJym+18Iy8UbwtNkPj8QOC1P0jvuFvRSmNfn
	KBZ1Lqg6FDqHKz0DtMRISq9tlQjE9oFP0U+4/4AhCqcNevOY3ZXJFu+k7M3nVBEhG9wkBy
	sdyxhJzil70dFZVpiGzjp175/0748jjIq/ASpUjJ11kQVro7Lh5QeXOOQPW0zOS5vzEZIC
	a1IPGZ6KyQ1DV9I7eitjMWOd1t8Y2tkvz6jwTCIiFox012jnT29C4R/RJhkr/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744894892;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKJu+fMyldXdIQrlT+3cN6z1WTQoPrFBWVJPNeKPcR0=;
	b=XjLIVPYdhKK/m+UJ31+M7I+TYxCYlE4Oredv6Y0O2Xk3zr9yM1JoZrmT4yEYC61CWz9+OF
	iGh+LgG4VmJPC3AA==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/intel: Add PMU support for Clearwater Forest
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250415114428.341182-3-dapeng1.mi@linux.intel.com>
References: <20250415114428.341182-3-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174489489103.31282.14812181703320848903.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     48d66c89dce1e3687174608a5f5c31d5961a9916
Gitweb:        https://git.kernel.org/tip/48d66c89dce1e3687174608a5f5c31d5961a9916
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Tue, 15 Apr 2025 11:44:08 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 17 Apr 2025 14:21:23 +02:00

perf/x86/intel: Add PMU support for Clearwater Forest

>From the PMU's perspective, Clearwater Forest is similar to the previous
generation Sierra Forest.

The key differences are the ARCH PEBS feature and the new added 3 fixed
counters for topdown L1 metrics events.

The ARCH PEBS is supported in the following patches. This patch provides
support for basic perfmon features and 3 new added fixed counters.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20250415114428.341182-3-dapeng1.mi@linux.intel.com
---
 arch/x86/events/intel/core.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f107dd8..adc0187 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2224,6 +2224,18 @@ static struct extra_reg intel_cmt_extra_regs[] __read_mostly = {
 	EVENT_EXTRA_END
 };
 
+EVENT_ATTR_STR(topdown-fe-bound,       td_fe_bound_skt,        "event=0x9c,umask=0x01");
+EVENT_ATTR_STR(topdown-retiring,       td_retiring_skt,        "event=0xc2,umask=0x02");
+EVENT_ATTR_STR(topdown-be-bound,       td_be_bound_skt,        "event=0xa4,umask=0x02");
+
+static struct attribute *skt_events_attrs[] = {
+	EVENT_PTR(td_fe_bound_skt),
+	EVENT_PTR(td_retiring_skt),
+	EVENT_PTR(td_bad_spec_cmt),
+	EVENT_PTR(td_be_bound_skt),
+	NULL,
+};
+
 #define KNL_OT_L2_HITE		BIT_ULL(19) /* Other Tile L2 Hit */
 #define KNL_OT_L2_HITF		BIT_ULL(20) /* Other Tile L2 Hit */
 #define KNL_MCDRAM_LOCAL	BIT_ULL(21)
@@ -7142,6 +7154,18 @@ __init int intel_pmu_init(void)
 		name = "crestmont";
 		break;
 
+	case INTEL_ATOM_DARKMONT_X:
+		intel_pmu_init_skt(NULL);
+		intel_pmu_pebs_data_source_cmt();
+		x86_pmu.pebs_latency_data = cmt_latency_data;
+		x86_pmu.get_event_constraints = cmt_get_event_constraints;
+		td_attr = skt_events_attrs;
+		mem_attr = grt_mem_attrs;
+		extra_attr = cmt_format_attr;
+		pr_cont("Darkmont events, ");
+		name = "darkmont";
+		break;
+
 	case INTEL_WESTMERE:
 	case INTEL_WESTMERE_EP:
 	case INTEL_WESTMERE_EX:

