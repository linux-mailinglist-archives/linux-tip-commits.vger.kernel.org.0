Return-Path: <linux-tip-commits+bounces-1359-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F93D9027CE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Jun 2024 19:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA7D1F22B14
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Jun 2024 17:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA271147C85;
	Mon, 10 Jun 2024 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dkdhCZvD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZDhO8Q6S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352ED13C3CA;
	Mon, 10 Jun 2024 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718040950; cv=none; b=BRPI1ZFnHVUZ184dDJMu36QOMDJhtIhiNLzJEbKUzVf44Q5yr8Zm/AjQrP0CjYTl6X771x/xaAC0Qx+vk94+lRV2XTmXkCpROrkAg0plhiqgge9DR+p8j5hvo5xfwyHkRuXWoFoy2HW0MYKWPYc7UkgDRbEaNR3611NrmiEAbfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718040950; c=relaxed/simple;
	bh=j7EkDPs2uA59IlORwfy3tAkiJ8Q8G4Tt2JutwnSNVb8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cmD59TJ3MUOO7A9wOMgHc7ukRipkb9jkZd6f2yEWuttSlFxo1tki1fT9i9FHZOtSJ0QoBcqNCaKWazKeejh/u+IzsqUCRMe4fNOXVxGKsZnUa7BO/eWfKEDrzdQCqsTDlZ94toKuDkXqcJPEXWoJGpii6rdBDDqTTRSoDjS98bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dkdhCZvD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZDhO8Q6S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Jun 2024 17:35:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718040946;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZeQc6APKp3F8+1RlWJ+IKxyE2V4GfC5Yyn6Tqq97g0=;
	b=dkdhCZvDE+doAOHZkPW6iJAmB8/SsgYkpVou1/8RgTw1oe2poElPMGmgUTs+Y++TvEpCtI
	LWEzWOiHy8a5TIUwWHPc21iriNB0bgen789klcpGzt6uBtGjqujgEBgj08VAX1R59+qpvi
	0fJdXGKdfLBkDCSc5aUn/6nQ5eQ5t6KstnaFewtBBHQQCPcx753akT7206TTXJ+4a3dwTm
	PXzfDT9ua3JkMwC7wgTuuzn7ZcrmMqKxToRHr1mlS523Ff+2KZ66ne8+BR6D1Tp+3Jip02
	y2i/dYGwQAFZsbYLIMvb0oKrp2lEXfIt7dqW03MaxpKNOa9Ssd8NgSea5xaAVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718040946;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZeQc6APKp3F8+1RlWJ+IKxyE2V4GfC5Yyn6Tqq97g0=;
	b=ZDhO8Q6Skmdl3d3tKtGyDyPurnWD/r6i9kuyTyEjqVWgnyQvdyXSHk7xSLoGyGBlvioAei
	cZDY2uR4LulVdLAg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Replace open coded cacheinfo searches
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240610003927.341707-5-tony.luck@intel.com>
References: <20240610003927.341707-5-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171804094606.10875.14582463014769482343.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     f385f024639431bec3e70c33cdbc9563894b3ee5
Gitweb:        https://git.kernel.org/tip/f385f024639431bec3e70c33cdbc9563894b3ee5
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Sun, 09 Jun 2024 17:39:27 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 10 Jun 2024 08:50:12 +02:00

x86/resctrl: Replace open coded cacheinfo searches

pseudo_lock_region_init() and rdtgroup_cbm_to_size() open code a search for
details of a particular cache level.

Replace with get_cpu_cacheinfo_level().

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/20240610003927.341707-5-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 17 ++++++-----------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 14 +++++---------
 2 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index aacf236..1bbfd3c 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -292,9 +292,8 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
  */
 static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
 {
-	struct cpu_cacheinfo *ci;
+	struct cacheinfo *ci;
 	int ret;
-	int i;
 
 	/* Pick the first cpu we find that is associated with the cache. */
 	plr->cpu = cpumask_first(&plr->d->cpu_mask);
@@ -306,15 +305,11 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
 		goto out_region;
 	}
 
-	ci = get_cpu_cacheinfo(plr->cpu);
-
-	plr->size = rdtgroup_cbm_to_size(plr->s->res, plr->d, plr->cbm);
-
-	for (i = 0; i < ci->num_leaves; i++) {
-		if (ci->info_list[i].level == plr->s->res->cache_level) {
-			plr->line_size = ci->info_list[i].coherency_line_size;
-			return 0;
-		}
+	ci = get_cpu_cacheinfo_level(plr->cpu, plr->s->res->cache_level);
+	if (ci) {
+		plr->line_size = ci->coherency_line_size;
+		plr->size = rdtgroup_cbm_to_size(plr->s->res, plr->d, plr->cbm);
+		return 0;
 	}
 
 	ret = -1;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 02f213f..cb68a12 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1450,18 +1450,14 @@ out:
 unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
 				  struct rdt_domain *d, unsigned long cbm)
 {
-	struct cpu_cacheinfo *ci;
 	unsigned int size = 0;
-	int num_b, i;
+	struct cacheinfo *ci;
+	int num_b;
 
 	num_b = bitmap_weight(&cbm, r->cache.cbm_len);
-	ci = get_cpu_cacheinfo(cpumask_any(&d->cpu_mask));
-	for (i = 0; i < ci->num_leaves; i++) {
-		if (ci->info_list[i].level == r->cache_level) {
-			size = ci->info_list[i].size / r->cache.cbm_len * num_b;
-			break;
-		}
-	}
+	ci = get_cpu_cacheinfo_level(cpumask_any(&d->cpu_mask), r->cache_level);
+	if (ci)
+		size = ci->size / r->cache.cbm_len * num_b;
 
 	return size;
 }

