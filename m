Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E7626C415
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 17:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgIPPWi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 11:22:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49582 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbgIPPUf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 11:20:35 -0400
Date:   Wed, 16 Sep 2020 15:12:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269150;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=aGsFh/euLVJTpFe64sDHpwkI+UN4e/dj4KxLmmR37ko=;
        b=yN0X3PdVW67rDtWG25uGobkSYxtExAcN0T5d/V0Ue+xoCl0BP3E7m+1QA0EFUkVFcYOwUT
        NnumLJEvHzOxZv3HfX2KF7eOzu4/anYjv2+cfRcZpDDaNRV9QW2KK4g9Vc6ak1giFs/JLZ
        pQBxAzrHU6fSf9sYITx0E237wbOOkC5Vcd759e+yuZ9iywhnabgYuQ5fItbhuvmMjZ505R
        S8aiNcUeMpL/RFNvnZvHO+ICvzBJ2Sp9P54t2rgFAvz6l6VBZo4KCE1s+QmZGZ99gG0cE7
        wi9qlDkrdBphZDLdcujp00JiV18IlylpAVTAyT+kaQHaka074SM+InZ/2/u3kA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269150;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=aGsFh/euLVJTpFe64sDHpwkI+UN4e/dj4KxLmmR37ko=;
        b=1kkfR/TbWwj2QemsJ1mCKAjzrKdyChd6oRcsbaFhyejIjed4C8yE7OBALreQQsb9X7KA3Z
        yTN/z0tniXGui5CA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] iommu/amd: Prevent NULL pointer dereference
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <jroedel@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160026914966.15536.6087229780481843966.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     23357b61f8062a8a8c9c84c0252056cd6d849ec8
Gitweb:        https://git.kernel.org/tip/23357b61f8062a8a8c9c84c0252056cd6d849ec8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:16:29 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:25 +02:00

iommu/amd: Prevent NULL pointer dereference

Dereferencing irq_data before checking it for NULL is suboptimal.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Joerg Roedel <jroedel@suse.de>

---
 drivers/iommu/amd/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 07ae8b9..db44ce6 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3731,8 +3731,8 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 
 	for (i = 0; i < nr_irqs; i++) {
 		irq_data = irq_domain_get_irq_data(domain, virq + i);
-		cfg = irqd_cfg(irq_data);
-		if (!irq_data || !cfg) {
+		cfg = irq_data ? irqd_cfg(irq_data) : NULL;
+		if (!cfg) {
 			ret = -EINVAL;
 			goto out_free_data;
 		}
