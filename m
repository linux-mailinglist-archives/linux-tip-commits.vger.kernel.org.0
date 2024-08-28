Return-Path: <linux-tip-commits+bounces-2133-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B8A962377
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Aug 2024 11:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EAA7284584
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Aug 2024 09:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354D8165F08;
	Wed, 28 Aug 2024 09:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YWl8HtX6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ek9K/nzk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B5815A849;
	Wed, 28 Aug 2024 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837576; cv=none; b=GItMtd9H59cnWzVuH1lNqe/0MvZsKUcAGFDpRi7/it41JPZcvGOmqrUy6PST3dKr4/7SUoMa6TiNzVqobaEwT8KDlxBbdJeoCgH7p1ojUMSamASCxjlbqTeToDymF8oY5UFPR6YBikP3FOykKIYJJBALcrEer36sNcbvv5AsDTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837576; c=relaxed/simple;
	bh=vZZw+ORznNMCMicLAkZ4F8SvhcJYS4ykDqDMMHy9rgE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MmpyntSE5VkywRfbeVdHOvbrBxgX2MI/Ss1jqTVygdLXvurNSZWMJCQqM1WgqFWFmeAsXWa9H7eYHi0y8nF78bXNZtOp8KuxzA3wuae5R/RamD4P8W8GUSe6fDDWLmpsiaGaIvEsZnL5bABv/2iYLGyce9vHDfH2j5SenM2uxOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YWl8HtX6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ek9K/nzk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Aug 2024 09:32:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724837571;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VsP8XsA2Ijbw1HeJVvhDCE3/EcYczzLku/tHmbCQZt0=;
	b=YWl8HtX6OEaA1iG7wLgD6x2cPFARX/NkeAgJcLeVnCAiTIwIm0/mmGZLguoItzCljJJljf
	KljRK5AdROq/YbSQFa6gT9qY9WFHQRFlVJtc6IeGdTExJEgCc/iqxWCYVR98MBR3q9+Hnr
	DMK24wbXnuIKm8Az37ocCCYdPZt4uGk7jeKR1C4UhJ0JsUdjK+TRtfpB8n0VA1hb0CFdbd
	ygMO/M/W3kz690n+uOs+Y9lbToXYSL5ybEDjHMM0PQa3jEf1/6TytIWUnKBWWqldocwg43
	8FG3Io6BmEZwGIHECJ/cUMNCFIytjd0vvyIvQJMwENK5dgZhYKq9ttWx62pR4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724837571;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VsP8XsA2Ijbw1HeJVvhDCE3/EcYczzLku/tHmbCQZt0=;
	b=ek9K/nzkMMdL0ZlNZWZtj+UwfJNApGZZOzwrcCKdPqUhPwvubWMoBg+VKYoQiwP36qlHkF
	0qOmTn2Tkz8ILxAA==
From: "tip-bot2 for Peter Newman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/resctrl: Fix arch_mbm_* array overrun on SNC
Cc: Peter Newman <peternewman@google.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240822190212.1848788-1-peternewman@google.com>
References: <20240822190212.1848788-1-peternewman@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172483757117.2215.5020261219136287381.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     a547a5880cba6f287179135381f1b484b251be31
Gitweb:        https://git.kernel.org/tip/a547a5880cba6f287179135381f1b484b251be31
Author:        Peter Newman <peternewman@google.com>
AuthorDate:    Thu, 22 Aug 2024 12:02:11 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 28 Aug 2024 11:13:08 +02:00

x86/resctrl: Fix arch_mbm_* array overrun on SNC

When using resctrl on systems with Sub-NUMA Clustering enabled, monitoring
groups may be allocated RMID values which would overrun the
arch_mbm_{local,total} arrays.

This is due to inconsistencies in whether the SNC-adjusted num_rmid value or
the unadjusted value in resctrl_arch_system_num_rmid_idx() is used. The
num_rmid value for the L3 resource is currently:

  resctrl_arch_system_num_rmid_idx() / snc_nodes_per_l3_cache

As a simple fix, make resctrl_arch_system_num_rmid_idx() return the
SNC-adjusted, L3 num_rmid value on x86.

Fixes: e13db55b5a0d ("x86/resctrl: Introduce snc_nodes_per_l3_cache")
Signed-off-by: Peter Newman <peternewman@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/20240822190212.1848788-1-peternewman@google.com
---
 arch/x86/include/asm/resctrl.h     | 6 ------
 arch/x86/kernel/cpu/resctrl/core.c | 8 ++++++++
 include/linux/resctrl.h            | 1 +
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 12dbd25..8b1b6ce 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -156,12 +156,6 @@ static inline void resctrl_sched_in(struct task_struct *tsk)
 		__resctrl_sched_in(tsk);
 }
 
-static inline u32 resctrl_arch_system_num_rmid_idx(void)
-{
-	/* RMID are independent numbers for x86. num_rmid_idx == num_rmid */
-	return boot_cpu_data.x86_cache_max_rmid + 1;
-}
-
 static inline void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid)
 {
 	*rmid = idx;
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 1930fce..8591d53 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -119,6 +119,14 @@ struct rdt_hw_resource rdt_resources_all[] = {
 	},
 };
 
+u32 resctrl_arch_system_num_rmid_idx(void)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+
+	/* RMID are independent numbers for x86. num_rmid_idx == num_rmid */
+	return r->num_rmid;
+}
+
 /*
  * cache_alloc_hsw_probe() - Have to probe for Intel haswell server CPUs
  * as they do not have CPUID enumeration support for Cache allocation.
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index b0875b9..d94abba 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -248,6 +248,7 @@ struct resctrl_schema {
 
 /* The number of closid supported by this resource regardless of CDP */
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
+u32 resctrl_arch_system_num_rmid_idx(void);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 
 /*

