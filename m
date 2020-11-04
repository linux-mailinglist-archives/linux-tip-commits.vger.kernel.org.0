Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9FC2A6149
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Nov 2020 11:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgKDKNl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 4 Nov 2020 05:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbgKDKNk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 4 Nov 2020 05:13:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8E4C0613D3;
        Wed,  4 Nov 2020 02:13:40 -0800 (PST)
Date:   Wed, 04 Nov 2020 10:13:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604484818;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tQP19svj7zoZI5FQx6Ol/pT+zPjAIX339Dbz0Fjqlqo=;
        b=HDNpjvEpHyW/ZL5egeogmpFeA05cle8PHqezNYJmrhidROgTDRFC3YL3QMgsIAMoSxyMSN
        ODMJIvUH4/pRdO35W05iqO5w4zGLBnNt1S4qJf3roTFYogjOHF5X+qw2IjN9BJmgrNVGQ/
        iJIHMWvEg2AshP9Sunp7oh/tLtLa8MEN1YZNAKwzLADN6Pi7Hpf3b8vSS1n/hMVW6OG8RU
        MSFt6M2OFwbVyTYhENS0QkMeDjP4QbELPiPns5i4SAk2X+td74kUo132iotM6bOYIJoYm+
        hzBi6BRfApHqx3TYORPL+FdViUQ2W3YF0Takz/+FWBAQVWnYmA+BDcysJzgtBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604484818;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tQP19svj7zoZI5FQx6Ol/pT+zPjAIX339Dbz0Fjqlqo=;
        b=pB2K5RV4FNE6as+du1B+t5HhIaG3TdBVB2uS1iyZ/HvVCVaPDyjctZCu9ySBphSX291rv5
        2M4uh2rQMpc7RLAg==
From:   "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/ioapic: Use I/O-APIC ID for finding irqdomain, not index
Cc:     lkp <oliver.sang@intel.com>, David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <57adf2c305cd0c5e9d860b2f3007a7e676fd0f9f.camel@infradead.org>
References: <57adf2c305cd0c5e9d860b2f3007a7e676fd0f9f.camel@infradead.org>
MIME-Version: 1.0
Message-ID: <160448481750.397.15987267180792702259.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     f36a74b9345aebaf5d325380df87a54720229d18
Gitweb:        https://git.kernel.org/tip/f36a74b9345aebaf5d325380df87a54720229d18
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Tue, 03 Nov 2020 16:36:22 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 04 Nov 2020 11:11:35 +01:00

x86/ioapic: Use I/O-APIC ID for finding irqdomain, not index

In commit b643128b917 ("x86/ioapic: Use irq_find_matching_fwspec() to
find remapping irqdomain") the I/O-APIC code was changed to find its
parent irqdomain using irq_find_matching_fwspec(), but the key used
for the lookup was wrong. It shouldn't use 'ioapic' which is the index
into its own ioapics[] array. It should use the actual arbitration
ID of the I/O-APIC in question, which is mpc_ioapic_id(ioapic).

Fixes: b643128b917 ("x86/ioapic: Use irq_find_matching_fwspec() to find remapping irqdomain")
Reported-by: lkp <oliver.sang@intel.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/57adf2c305cd0c5e9d860b2f3007a7e676fd0f9f.camel@infradead.org

---
 arch/x86/kernel/apic/io_apic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 1cfd65e..0602c95 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2345,14 +2345,14 @@ static int mp_irqdomain_create(int ioapic)
 	if (cfg->dev) {
 		fn = of_node_to_fwnode(cfg->dev);
 	} else {
-		fn = irq_domain_alloc_named_id_fwnode("IO-APIC", ioapic);
+		fn = irq_domain_alloc_named_id_fwnode("IO-APIC", mpc_ioapic_id(ioapic));
 		if (!fn)
 			return -ENOMEM;
 	}
 
 	fwspec.fwnode = fn;
 	fwspec.param_count = 1;
-	fwspec.param[0] = ioapic;
+	fwspec.param[0] = mpc_ioapic_id(ioapic);
 
 	parent = irq_find_matching_fwspec(&fwspec, DOMAIN_BUS_ANY);
 	if (!parent) {
