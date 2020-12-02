Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AE22CBA8F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Dec 2020 11:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgLBK2p (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 2 Dec 2020 05:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbgLBK2o (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 2 Dec 2020 05:28:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31FDC0613CF;
        Wed,  2 Dec 2020 02:28:04 -0800 (PST)
Date:   Wed, 02 Dec 2020 10:28:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606904883;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GZJQsQNhrH/5pVvSDLr2TDadb/o0VDkOMz7MrTikpUk=;
        b=ooSXoMBIdZ74nMhGmcD4v8LUXzpfOGfN/9hzTuR4Blxt5ei/vj4ArNtWXfvWrSBF2tKxIM
        LKzptS0YgbD1/BmGNmgcfYbnrX6gJbDu/3j87vNnJLhsRl84FTCG30fpYJOsb0BfaWof8C
        oOGaLEV27drkTFyzQfJL0LFsmOWDX9TvOYcRX6GbKKG5t4RDTKl8MvITB5Epyf+01CHlOM
        4sWO15PSdxJ5poxL01VIzAMazVzQF9MD8/qXk7wRjK+vlm5N28D61LOvklrSHSQB90iapw
        1dp+RmSAEQbNu/kvbF1PX9iV5kEovGyrF07CgbHbp4WbATT75QbramMTXUWtVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606904883;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GZJQsQNhrH/5pVvSDLr2TDadb/o0VDkOMz7MrTikpUk=;
        b=05wjwML6N0cpmCT1EYSSrscFhRxmaqzeWXSamXt4ZP4h+VsJ1TvEHZSZ+izlW7JwODgiel
        UYe9+HrQMoIIuiDg==
From:   "tip-bot2 for Dexuan Cui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] iommu/hyper-v: Remove I/O-APIC ID check from
 hyperv_irq_remapping_select()
Cc:     Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201202004510.1818-1-decui@microsoft.com>
References: <20201202004510.1818-1-decui@microsoft.com>
MIME-Version: 1.0
Message-ID: <160690488231.3364.5753445245767279779.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     26ab12bb9d96133b7880141d68b5e01a8783de9d
Gitweb:        https://git.kernel.org/tip/26ab12bb9d96133b7880141d68b5e01a8783de9d
Author:        Dexuan Cui <decui@microsoft.com>
AuthorDate:    Tue, 01 Dec 2020 16:45:10 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Dec 2020 11:22:55 +01:00

iommu/hyper-v: Remove I/O-APIC ID check from hyperv_irq_remapping_select()

commit a491bb19f728 ("iommu/hyper-v: Implement select() method on remapping
irqdomain") restricted the irq_domain_ops::select() callback to match on
I/O-APIC index 0, which was correct until the parameter was changed to
carry the I/O APIC ID in commit f36a74b9345a.

If the ID is not 0 then the match fails. Therefore I/O-APIC init fails to
retrieve the parent irqdomain for the I/O-APIC resulting in a boot panic:

    kernel BUG at arch/x86/kernel/apic/io_apic.c:2408!

Fix it by matching the I/O-APIC independent of the ID as there is only one
I/O APIC emulated by Hyper-V.

[ tglx: Amended changelog ]

Fixes: f36a74b9345a ("x86/ioapic: Use I/O-APIC ID for finding irqdomain, not index")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lore.kernel.org/r/20201202004510.1818-1-decui@microsoft.com
---
 drivers/iommu/hyperv-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index 9438daa..1d21a0b 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -105,8 +105,8 @@ static int hyperv_irq_remapping_select(struct irq_domain *d,
 				       struct irq_fwspec *fwspec,
 				       enum irq_domain_bus_token bus_token)
 {
-	/* Claim only the first (and only) I/OAPIC */
-	return x86_fwspec_is_ioapic(fwspec) && fwspec->param[0] == 0;
+	/* Claim the only I/O APIC emulated by Hyper-V */
+	return x86_fwspec_is_ioapic(fwspec);
 }
 
 static const struct irq_domain_ops hyperv_ir_domain_ops = {
