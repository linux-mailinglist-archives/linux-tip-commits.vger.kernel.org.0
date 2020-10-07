Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78801285913
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 09:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgJGHMa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 03:12:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41508 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgJGHMF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 03:12:05 -0400
Date:   Wed, 07 Oct 2020 07:12:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602054722;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vm5LUo0TROVTJgWH9l59fEH3l19VpF5GXK+0tXVEXMI=;
        b=jsxmAspMcAWGGdCjQu7KkLWjaP/oqtrv3zmoB3WRUNGeia8VCutPLRCSI/ZSjhZ7kDQfEz
        Xj2t0TrLTiGhoY9foCRd6aQP5gxsjFUYG1SKZyy/TKdsKvvyWP3iEi9XsGsWnOJw6us0vf
        lE3+HiVvawYMcaaLQXOdtVGiYUvtibL2u7HbbvgUmJllQx21Q/PuXz0576o6JvbbUAT8NC
        +Hbnhp363bzT0PwZA46VmDHoQgm+/9BU+BP09bkHJlDpR5EbCrO7bD9Tj2XVSquCjTn9hc
        8/qzroFdvevMfT64i0Q1O4NaLeYqwpkGi5t5PIGz8mnJdeLgYgRb1OLycGTOEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602054722;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vm5LUo0TROVTJgWH9l59fEH3l19VpF5GXK+0tXVEXMI=;
        b=IfkMgSFzdqTQd3cz29vk4kpqb9bGu8PInWxoacJQEnWNEqkkSxGqjIACbTG/MMEGMRhJa7
        IX6667SLJATzu/BQ==
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Update UV5 MMR references in UV GRU
Cc:     Mike Travis <mike.travis@hpe.com>, Borislav Petkov <bp@suse.de>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201005203929.148656-10-mike.travis@hpe.com>
References: <20201005203929.148656-10-mike.travis@hpe.com>
MIME-Version: 1.0
Message-ID: <160205472176.7002.8699094948278009056.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     a74a7e992caf0745f548a63b263ac34c6a4a29dd
Gitweb:        https://git.kernel.org/tip/a74a7e992caf0745f548a63b263ac34c6a4a29dd
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Mon, 05 Oct 2020 15:39:25 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 07 Oct 2020 09:08:00 +02:00

x86/platform/uv: Update UV5 MMR references in UV GRU

Make modifications to the GRU mappings to accommodate changes for UV5.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lkml.kernel.org/r/20201005203929.148656-10-mike.travis@hpe.com
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 30 +++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 5aed07f..64a1c59 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -82,6 +82,9 @@ static unsigned long __init uv_early_read_mmr(unsigned long addr)
 
 static inline bool is_GRU_range(u64 start, u64 end)
 {
+	if (!gru_start_paddr)
+		return false;
+
 	return start >= gru_start_paddr && end <= gru_end_paddr;
 }
 
@@ -909,13 +912,24 @@ static __init void map_high(char *id, unsigned long base, int pshift, int bshift
 static __init void map_gru_high(int max_pnode)
 {
 	union uvh_rh_gam_gru_overlay_config_u gru;
-	int shift = UVH_RH_GAM_GRU_OVERLAY_CONFIG_BASE_SHFT;
-	unsigned long mask = UVH_RH_GAM_GRU_OVERLAY_CONFIG_BASE_MASK;
-	unsigned long base;
+	unsigned long mask, base;
+	int shift;
+
+	if (UVH_RH_GAM_GRU_OVERLAY_CONFIG) {
+		gru.v = uv_read_local_mmr(UVH_RH_GAM_GRU_OVERLAY_CONFIG);
+		shift = UVH_RH_GAM_GRU_OVERLAY_CONFIG_BASE_SHFT;
+		mask = UVH_RH_GAM_GRU_OVERLAY_CONFIG_BASE_MASK;
+	} else if (UVH_RH10_GAM_GRU_OVERLAY_CONFIG) {
+		gru.v = uv_read_local_mmr(UVH_RH10_GAM_GRU_OVERLAY_CONFIG);
+		shift = UVH_RH10_GAM_GRU_OVERLAY_CONFIG_BASE_SHFT;
+		mask = UVH_RH10_GAM_GRU_OVERLAY_CONFIG_BASE_MASK;
+	} else {
+		pr_err("UV: GRU unavailable (no MMR)\n");
+		return;
+	}
 
-	gru.v = uv_read_local_mmr(UVH_RH_GAM_GRU_OVERLAY_CONFIG);
 	if (!gru.s.enable) {
-		pr_info("UV: GRU disabled\n");
+		pr_info("UV: GRU disabled (by BIOS)\n");
 		return;
 	}
 
@@ -1288,7 +1302,11 @@ static void __init uv_init_hub_info(struct uv_hub_info_s *hi)
 	/* Show system specific info: */
 	pr_info("UV: N:%d M:%d m_shift:%d n_lshift:%d\n", hi->n_val, hi->m_val, hi->m_shift, hi->n_lshift);
 	pr_info("UV: gpa_mask/shift:0x%lx/%d pnode_mask:0x%x apic_pns:%d\n", hi->gpa_mask, hi->gpa_shift, hi->pnode_mask, hi->apic_pnode_shift);
-	pr_info("UV: mmr_base/shift:0x%lx/%ld gru_base/shift:0x%lx/%ld\n", hi->global_mmr_base, hi->global_mmr_shift, hi->global_gru_base, hi->global_gru_shift);
+	pr_info("UV: mmr_base/shift:0x%lx/%ld\n", hi->global_mmr_base, hi->global_mmr_shift);
+	if (hi->global_gru_base)
+		pr_info("UV: gru_base/shift:0x%lx/%ld\n",
+			hi->global_gru_base, hi->global_gru_shift);
+
 	pr_info("UV: gnode_upper:0x%lx gnode_extra:0x%x\n", hi->gnode_upper, hi->gnode_extra);
 }
 
