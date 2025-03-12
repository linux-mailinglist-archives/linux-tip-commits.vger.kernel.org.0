Return-Path: <linux-tip-commits+bounces-4154-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D1AA5E28E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 18:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7DC07ACEF4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 17:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5F425D8E6;
	Wed, 12 Mar 2025 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AwDUoQYV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fOnYx+kq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EB725CC9E;
	Wed, 12 Mar 2025 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800035; cv=none; b=M7V4Bs5HrZBpzm8Xafq2x2qZDaOA2GSZ86LRIJHORUp3tgUeyg+pPQ7GkAOUv4aGzuzydVCHT6127UcTgttRNJJ1WEHtfpCnpZJ2xlKCq4xwnhcv15x4BRmTYvTLMlbQc7M8rRYWOmhUGAmuX5Bwe5LMMO4QV5rJx2RrZWsogz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800035; c=relaxed/simple;
	bh=Y9PvtJCtxgQTFbkdmcjSgGnLsTQEnDTEyt/V3jc0dSY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=a3vUt0/u1EurXaSKymEj8S3ssaasMyZZ0J8XC0GrpGBYQFWJF9LCa/4P76t8ZQc1bBw2pPjuDexq0JwAXXN30XWzRK0H7f6zmWpWiPhsvCmnglsiUpI6SmM4/7nHJkAZLJYUmVBAJ8V4YgVGsX60rs/tB2GdPkB3m59/VpLbcq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AwDUoQYV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fOnYx+kq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 17:20:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741800030;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STHqwG0teOKK+1jptxmVYM3YdhGPq9HkLAY6FPHmWsA=;
	b=AwDUoQYVPQoQciBkv70VG09klKNKSHFzTuwLy25vG1qw6q3MbtH2HUYNBZGuE+SQ1/aFsF
	FL3fczDD63wk34da7BJYqjJBGzIHud0NVF4ZqJrdIMvo3+ZLhLSqJ8+tALagpGWcT1rMfE
	q0XlBeCHdsmlkZzEgqayYbiTgxRCflf+c0kZOcQ6Sp+Gm2ZhZtm6Oz7IC5FMf28yi1tlq6
	Md4GbOWi+zhQYXUtRqrxs8r7qh+k+21qFm+4+UAevIHoD5ksjrjHUsGKQXUN5LApGNp3LO
	3svpxCm4RymGAvaDblc9qWJFoUKevN0+JavUvrDk/B8rDigzqODG4MRYjMYXEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741800030;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STHqwG0teOKK+1jptxmVYM3YdhGPq9HkLAY6FPHmWsA=;
	b=fOnYx+kqGdmCcXD3b+0M+pM/ZLNOR5Kkdua0ElKOm4AS58wvHhGUTS3ucM6MfCsMBbPtDE
	AdAJa79f2t67WeBQ==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86/resctrl: Add an arch helper to reset one resource
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tony Luck <tony.luck@intel.com>, Reinette Chatre <reinette.chatre@intel.com>,
 Fenghua Yu <fenghuay@nvidia.com>, Babu Moger <babu.moger@amd.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
 Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311183715.16445-15-james.morse@arm.com>
References: <20250311183715.16445-15-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174180003010.14745.783925987153518671.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     9be68b144a5b539c8503f2944888f7a30e669291
Gitweb:        https://git.kernel.org/tip/9be68b144a5b539c8503f2944888f7a30e669291
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 11 Mar 2025 18:36:59 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Mar 2025 12:23:10 +01:00

x86/resctrl: Add an arch helper to reset one resource

On umount(), resctrl resets each resource back to its default configuration.
It only ever does this for all resources in one go.

reset_all_ctrls() is architecture specific as it works with struct
rdt_hw_resource.

Make reset_all_ctrls() an arch helper that resets one resource.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20250311183715.16445-15-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  9 +++++----
 include/linux/resctrl.h                |  9 +++++++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index b2dad68..9eb57eb 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2867,7 +2867,7 @@ static int rdt_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
-static int reset_all_ctrls(struct rdt_resource *r)
+void resctrl_arch_reset_all_ctrls(struct rdt_resource *r)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rdt_hw_ctrl_domain *hw_dom;
@@ -2896,7 +2896,7 @@ static int reset_all_ctrls(struct rdt_resource *r)
 		smp_call_function_any(&d->hdr.cpu_mask, rdt_ctrl_update, &msr_param, 1);
 	}
 
-	return 0;
+	return;
 }
 
 /*
@@ -3015,9 +3015,10 @@ static void rdt_kill_sb(struct super_block *sb)
 
 	rdt_disable_ctx();
 
-	/*Put everything back to default values. */
+	/* Put everything back to default values. */
 	for_each_alloc_capable_rdt_resource(r)
-		reset_all_ctrls(r);
+		resctrl_arch_reset_all_ctrls(r);
+
 	rmdir_all_sub();
 	rdt_pseudo_lock_release();
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 326f7ba..487b965 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -394,6 +394,15 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *d,
  */
 void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *d);
 
+/**
+ * resctrl_arch_reset_all_ctrls() - Reset the control for each CLOSID to its
+ *				    default.
+ * @r:		The resctrl resource to reset.
+ *
+ * This can be called from any CPU.
+ */
+void resctrl_arch_reset_all_ctrls(struct rdt_resource *r);
+
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 

