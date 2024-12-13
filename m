Return-Path: <linux-tip-commits+bounces-3062-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E609F17BC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Dec 2024 22:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 034787A16E9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Dec 2024 21:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CF7198841;
	Fri, 13 Dec 2024 21:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bO9420M2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OqXK/YXo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B800B194096;
	Fri, 13 Dec 2024 21:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123764; cv=none; b=CEKSHYpcaE0BKXJpUlcDMt5n+JfiADBFy9NkYOU8gOyllXvbO0gVjyH0HtjNLDChtTCA5Zs3jiq5wr179Dc9Y+r0C0YK6sfpqHwatMYRRl5bzB7S6w0dwH3VIOl3almhrhRpe9fSt/dPW7voptkVkpEzfqBlGCbGgAyNFsXCfQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123764; c=relaxed/simple;
	bh=OrDlxbqOyu6ZVyDrxExuBbeDpTCg1aLIjIadJYOmgo8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Qai4GKMkjkWeBhLO3bQzCC/k4sd73Is8QuLH3zs4T0IUYwmemSx8JELmSNYL3mUe86WCtqkUnOsblYS2uhT7RJUtF5Uc/zHwQ5t4bKYmSTJDN9gwoASHvG9pMpIpkaFamDGESCAp8BeEqSXWptwrHivSHSQ6X3PWdfG1BWcLZWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bO9420M2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OqXK/YXo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Dec 2024 21:02:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734123761;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UGuIC7Mej5H+tRF//kRMZG1iKvvD+yQJ9cGdU2YmrAA=;
	b=bO9420M2KwHJV43fwGX767pNhs5p1YVJsFKAxtyvshK2zurymHqzTfLfpeWNZ3o1HJ19j2
	hYFoazjRY8VGkDRC14E86vS/NwVvKVcuykC6oGB5vm1uRzIvtdt0h+vSncl36TW20DA90n
	/YBCeR4TPqYgInavQ/u3N//soi/9FhzFw3YO1g7a+s19jPAT12wmM0VV6l6CwTOqmoTaM7
	UIwxmdqNVSs+wMb+H+Vvq3J7xHsrpSePKkegf53an7LZ+zOQZ8PVXTGhFQxuElbrhoT9r1
	U3TrwEURYZV0MiuBPY6z3bJYd2Sq9M/Zhy/jekNZJP9eEI8QFHSq+4TLWchBoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734123761;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UGuIC7Mej5H+tRF//kRMZG1iKvvD+yQJ9cGdU2YmrAA=;
	b=OqXK/YXoii7lBDMdVzFT7H5U9XM/M4mATuD9tTde4RrEvt35FCFfxh0EUpXZxfkGy3T5Tq
	yGUmeUaoE6x+brDg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Compute memory bandwidth for all
 supported events
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Babu Moger <babu.moger@amd.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241206163148.83828-5-tony.luck@intel.com>
References: <20241206163148.83828-5-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173412375987.412.3633757337856888946.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     2c272fadb58b590eb973c6c447b039f10631f5f7
Gitweb:        https://git.kernel.org/tip/2c272fadb58b590eb973c6c447b039f10631f5f7
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 06 Dec 2024 08:31:44 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 10 Dec 2024 16:13:48 +01:00

x86/resctrl: Compute memory bandwidth for all supported events

Switching between local and total memory bandwidth events as the input
to the mba_sc feedback loop would be cumbersome and take effect slowly
in the current implementation as the bandwidth is only known after two
consecutive readings of the same event.

Compute the bandwidth for all supported events. This doesn't add
significant overhead and will make changing which event is used
simple.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20241206163148.83828-5-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 72 +++++++++++---------------
 1 file changed, 33 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index adb18f0..94a1d97 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -663,9 +663,12 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
  */
 static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)
 {
-	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
-	struct mbm_state *m = &rr->d->mbm_local[idx];
 	u64 cur_bw, bytes, cur_bytes;
+	struct mbm_state *m;
+
+	m = get_mbm_state(rr->d, closid, rmid, rr->evtid);
+	if (WARN_ON_ONCE(!m))
+		return;
 
 	cur_bytes = rr->val;
 	bytes = cur_bytes - m->prev_bw_bytes;
@@ -815,54 +818,45 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_mon_domain *dom_mbm)
 	resctrl_arch_update_one(r_mba, dom_mba, closid, CDP_NONE, new_msr_val);
 }
 
-static void mbm_update(struct rdt_resource *r, struct rdt_mon_domain *d,
-		       u32 closid, u32 rmid)
+static void mbm_update_one_event(struct rdt_resource *r, struct rdt_mon_domain *d,
+				 u32 closid, u32 rmid, enum resctrl_event_id evtid)
 {
 	struct rmid_read rr = {0};
 
 	rr.r = r;
 	rr.d = d;
+	rr.evtid = evtid;
+	rr.arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
+	if (IS_ERR(rr.arch_mon_ctx)) {
+		pr_warn_ratelimited("Failed to allocate monitor context: %ld",
+				    PTR_ERR(rr.arch_mon_ctx));
+		return;
+	}
+
+	__mon_event_count(closid, rmid, &rr);
 
 	/*
-	 * This is protected from concurrent reads from user
-	 * as both the user and we hold the global mutex.
+	 * If the software controller is enabled, compute the
+	 * bandwidth for this event id.
 	 */
-	if (is_mbm_total_enabled()) {
-		rr.evtid = QOS_L3_MBM_TOTAL_EVENT_ID;
-		rr.val = 0;
-		rr.arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
-		if (IS_ERR(rr.arch_mon_ctx)) {
-			pr_warn_ratelimited("Failed to allocate monitor context: %ld",
-					    PTR_ERR(rr.arch_mon_ctx));
-			return;
-		}
+	if (is_mba_sc(NULL))
+		mbm_bw_count(closid, rmid, &rr);
 
-		__mon_event_count(closid, rmid, &rr);
-
-		resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
-	}
-	if (is_mbm_local_enabled()) {
-		rr.evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
-		rr.val = 0;
-		rr.arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
-		if (IS_ERR(rr.arch_mon_ctx)) {
-			pr_warn_ratelimited("Failed to allocate monitor context: %ld",
-					    PTR_ERR(rr.arch_mon_ctx));
-			return;
-		}
-
-		__mon_event_count(closid, rmid, &rr);
+	resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
+}
 
-		/*
-		 * Call the MBA software controller only for the
-		 * control groups and when user has enabled
-		 * the software controller explicitly.
-		 */
-		if (is_mba_sc(NULL))
-			mbm_bw_count(closid, rmid, &rr);
+static void mbm_update(struct rdt_resource *r, struct rdt_mon_domain *d,
+		       u32 closid, u32 rmid)
+{
+	/*
+	 * This is protected from concurrent reads from user as both
+	 * the user and overflow handler hold the global mutex.
+	 */
+	if (is_mbm_total_enabled())
+		mbm_update_one_event(r, d, closid, rmid, QOS_L3_MBM_TOTAL_EVENT_ID);
 
-		resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
-	}
+	if (is_mbm_local_enabled())
+		mbm_update_one_event(r, d, closid, rmid, QOS_L3_MBM_LOCAL_EVENT_ID);
 }
 
 /*

