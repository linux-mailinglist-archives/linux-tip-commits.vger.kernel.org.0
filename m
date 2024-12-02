Return-Path: <linux-tip-commits+bounces-2912-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0450D9E0078
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AECC8B2A804
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98103203719;
	Mon,  2 Dec 2024 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gW789VlX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XmX5smRs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DF11FDE17;
	Mon,  2 Dec 2024 11:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138063; cv=none; b=mojm/oaNXMIHarFSuHIcw6YU5GicBcGtA24vfGcNipWn0gPO0VkrmTXd80wclQfoaNk+nuj8GMK0Np3ZgJ4rZlawGh7CgY3Tg4uv+A8Qz8M3BABeY8hRQjZMtItlY5EmorziMynj1r+tV9N13x2iOX328/wAKfKYEYSN6AAWobs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138063; c=relaxed/simple;
	bh=N8CS/e4hTEFerWX7YMNUgaHHEid9DwGhUfx4QzOHHx0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JuWfFNipgcl8q3cTAwtuV0QOFoJbEfJieJhjKACI0oLAyVGc4P2DwlXVSLABYLJCcD79X6gtFMmKhiLm3a/9slI86xSeM7WTcoVYVdXm1eCZ86hiQx8HmOypGhPOwZqQ0TyF7z69WfY/YRIIeLYmtdlbEATeLcMCWEH2flFqwf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gW789VlX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XmX5smRs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138060;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EcTIty4yJGBihpEnrNxqI20WM2uz0eVJyaAaSPMhIwI=;
	b=gW789VlXW4Kcqv1di+3/sHEr6c+wTT3pv/A3lK0qAeH4GHjO8yQN5vO6RUb80Z8nyjO5Ez
	Yt6BuYhQksPQDyjHYId1Gd3tDV5uKA+m3oIBLrTLyIKCVlzqPnlulCODYgadbjHAT0Mh8d
	xAuM3T8nxYJVVrvGOcLNfcWsNooDMC2CbXQswTaR/1LB1xAqgxans2nOEmTsB4fjwOSwWd
	C6SijS5XKzRZXJVb12Wf/so7aak/H4b/4jZR07GkpEJr857Ad7PHa3ScPech3/7U8yMNQE
	30H5frAV5dN4Lq+GyYG6wBIp2aXrhaLBWSskgsSaoQDO0gSW6n5lVFe6piK/ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138060;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EcTIty4yJGBihpEnrNxqI20WM2uz0eVJyaAaSPMhIwI=;
	b=XmX5smRsxxl7AEEXNhU+0T/L4dLCzuSYtQf/Iz/Fs4E9GiqHpaVJohrf4CRxIrCW/DBYy0
	NAbeCW9jLfV7+KBg==
From: "tip-bot2 for Dhananjay Ugwekar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/rapl: Remove the unused
 get_rapl_pmu_cpumask() function
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Zhang Rui <rui.zhang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241115060805.447565-2-Dhananjay.Ugwekar@amd.com>
References: <20241115060805.447565-2-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313805916.412.5558253403944642615.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2f2db347071a8736c2adcdbf2658ce532e0afc0a
Gitweb:        https://git.kernel.org/tip/2f2db347071a8736c2adcdbf2658ce532e0afc0a
Author:        Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
AuthorDate:    Fri, 15 Nov 2024 06:07:57 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:35 +01:00

perf/x86/rapl: Remove the unused get_rapl_pmu_cpumask() function

commit 9e9af8bbb5f9 ("perf/x86/rapl: Clean up cpumask and hotplug")
removes the cpumask handling from rapl. Post that, we no longer need the
get_rapl_pmu_cpumask() function. So remove it.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20241115060805.447565-2-Dhananjay.Ugwekar@amd.com
---
 arch/x86/events/rapl.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index a8defc8..f70c49c 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -153,7 +153,7 @@ static u64 rapl_timer_ms;
 static struct perf_msr *rapl_msrs;
 
 /*
- * Helper functions to get the correct topology macros according to the
+ * Helper function to get the correct topology id according to the
  * RAPL PMU scope.
  */
 static inline unsigned int get_rapl_pmu_idx(int cpu)
@@ -162,12 +162,6 @@ static inline unsigned int get_rapl_pmu_idx(int cpu)
 					 topology_logical_die_id(cpu);
 }
 
-static inline const struct cpumask *get_rapl_pmu_cpumask(int cpu)
-{
-	return rapl_pmu_is_pkg_scope() ? topology_core_cpumask(cpu) :
-					 topology_die_cpumask(cpu);
-}
-
 static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
 {
 	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);

