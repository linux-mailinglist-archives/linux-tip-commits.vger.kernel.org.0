Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06EF2AFB16
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 23:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbgKKWGk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 17:06:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40808 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgKKWGk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 17:06:40 -0500
Date:   Wed, 11 Nov 2020 22:06:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605132398;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eTDO01Vr/s4R/zNC/gaqopIce2jceYVkAkhNTJzqJYE=;
        b=jGKkguJ8psvP+HAMqoTx4Sf7K8a5v0z0rmunYQewKioNStM9cn8oBlFsLRid0jkRQyWtjm
        +a2tXCEtAhXzUc+YBa523ZDRQXZqsFYEOWcFli8+ju9TvWNGyezY6EEsaGXqIs25Uey1Qw
        9lMGPfRXiV+uHUMWlsv/heGeIWnpYlTBVd9P5djh86ehUslZS74wDlJkZDWG25cUpimaCj
        8zu/f0e13lO15ovl1++pRMly3wR1yJm6p8q9+wkyS8cj/CieVk44ugUGYUcjBHrD4kbzFk
        pR7h09cuIbkQJoUF60Pctws4RwsTsuKJVlrosCKNAK82HJ2tcWuAXWOp2LqFYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605132398;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eTDO01Vr/s4R/zNC/gaqopIce2jceYVkAkhNTJzqJYE=;
        b=15WPm8IhRlDD77+j1QWO0ogyB0jfGuGDu3Nzc2KHHb/Ljvfgr2lKcJjkOgHe6rI/iyfiax
        sAU/xoRPQios8OBg==
From:   "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] iommu/amd: Don't register interrupt remapping
 irqdomain when IR is disabled
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201111144322.1659970-1-dwmw2@infradead.org>
References: <20201111144322.1659970-1-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160513239668.11244.7104408892860202809.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     2df985f5e44c43f5d29d8cc3aaa8e8ac697e9de6
Gitweb:        https://git.kernel.org/tip/2df985f5e44c43f5d29d8cc3aaa8e8ac697e9de6
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Wed, 11 Nov 2020 14:43:20 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 11 Nov 2020 23:01:58 +01:00

iommu/amd: Don't register interrupt remapping irqdomain when IR is disabled

Registering the remapping irq domain unconditionally is potentially
allowing I/O-APIC and MSI interrupts to be parented in the IOMMU IR domain
even when IR is disabled. Don't do that.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201111144322.1659970-1-dwmw2@infradead.org

---
 drivers/iommu/amd/init.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c2769f2..a94b96f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1601,9 +1601,11 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 	if (ret)
 		return ret;
 
-	ret = amd_iommu_create_irq_domain(iommu);
-	if (ret)
-		return ret;
+	if (amd_iommu_irq_remap) {
+		ret = amd_iommu_create_irq_domain(iommu);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * Make sure IOMMU is not considered to translate itself. The IVRS
