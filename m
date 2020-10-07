Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4FB285907
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 09:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbgJGHMK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 03:12:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41516 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbgJGHMF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 03:12:05 -0400
Date:   Wed, 07 Oct 2020 07:12:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602054723;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CKVBvqfEIX8wjP0zkprXBSYrjgfm4xHtk+deLm/6KuI=;
        b=l4xkBwsPsxBTsEyBjyltGtdQAhUC8e0WpvU15j82D15jpPhRZpSi7VNvJCbBSXLBHZGGqL
        aRDsaiK/NlTJwMUY0X9Iuqgc+X+qmMqW9gFVJs4mRc74l16t888KaALV7l8WiOqu5m59ER
        DAqPAtF8qCQJCsmBmnDASJBpmzfP1ln1cjISBuqiB2QT6PzCNBeJfZdt10VSNAC1Iq3G+I
        2JjMy31Q06KkV1JdqVbiw5lTnhOzFyrOrsEjQu7ZABotTtmLzNCL+GQQonT9sr9kYB1gak
        OqMcZPyN1leWvqDuHRKK8wWPr/K9sgHyH57chmvxSOgdV8/gqmKjJYKBoY3ktQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602054723;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CKVBvqfEIX8wjP0zkprXBSYrjgfm4xHtk+deLm/6KuI=;
        b=uB1K6DAahIwYygFvBTgsVvLlnrxQPK1GxKAC8+G4RfQzjhjfDtllQaNg0if47VHIoSziPn
        PTaM12NC+7YQPZBw==
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Adjust GAM MMR references
 affected by UV5 updates
Cc:     Mike Travis <mike.travis@hpe.com>, Borislav Petkov <bp@suse.de>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201005203929.148656-9-mike.travis@hpe.com>
References: <20201005203929.148656-9-mike.travis@hpe.com>
MIME-Version: 1.0
Message-ID: <160205472234.7002.15898184460104250991.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     8540b2cf0de09b6d96b7dce56a16e26ab4fe8a9b
Gitweb:        https://git.kernel.org/tip/8540b2cf0de09b6d96b7dce56a16e26ab4fe8a9b
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Mon, 05 Oct 2020 15:39:24 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 07 Oct 2020 09:07:44 +02:00

x86/platform/uv: Adjust GAM MMR references affected by UV5 updates

Make modifications to the GAM MMR mappings to accommodate changes for UV5.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lkml.kernel.org/r/20201005203929.148656-9-mike.travis@hpe.com
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 30 ++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index e2e866a..5aed07f 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -927,12 +927,32 @@ static __init void map_gru_high(int max_pnode)
 
 static __init void map_mmr_high(int max_pnode)
 {
-	union uvh_rh_gam_mmr_overlay_config_u mmr;
-	int shift = UVH_RH_GAM_MMR_OVERLAY_CONFIG_BASE_SHFT;
+	unsigned long base;
+	int shift;
+	bool enable;
+
+	if (UVH_RH10_GAM_MMR_OVERLAY_CONFIG) {
+		union uvh_rh10_gam_mmr_overlay_config_u mmr;
+
+		mmr.v = uv_read_local_mmr(UVH_RH10_GAM_MMR_OVERLAY_CONFIG);
+		enable = mmr.s.enable;
+		base = mmr.s.base;
+		shift = UVH_RH10_GAM_MMR_OVERLAY_CONFIG_BASE_SHFT;
+	} else if (UVH_RH_GAM_MMR_OVERLAY_CONFIG) {
+		union uvh_rh_gam_mmr_overlay_config_u mmr;
+
+		mmr.v = uv_read_local_mmr(UVH_RH_GAM_MMR_OVERLAY_CONFIG);
+		enable = mmr.s.enable;
+		base = mmr.s.base;
+		shift = UVH_RH_GAM_MMR_OVERLAY_CONFIG_BASE_SHFT;
+	} else {
+		pr_err("UV:%s:RH_GAM_MMR_OVERLAY_CONFIG MMR undefined?\n",
+			__func__);
+		return;
+	}
 
-	mmr.v = uv_read_local_mmr(UVH_RH_GAM_MMR_OVERLAY_CONFIG);
-	if (mmr.s.enable)
-		map_high("MMR", mmr.s.base, shift, shift, max_pnode, map_uc);
+	if (enable)
+		map_high("MMR", base, shift, shift, max_pnode, map_uc);
 	else
 		pr_info("UV: MMR disabled\n");
 }
