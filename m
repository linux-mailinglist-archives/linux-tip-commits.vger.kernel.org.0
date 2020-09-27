Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A0427A392
	for <lists+linux-tip-commits@lfdr.de>; Sun, 27 Sep 2020 22:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgI0UAY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 27 Sep 2020 16:00:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41774 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgI0T5a (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 27 Sep 2020 15:57:30 -0400
Date:   Sun, 27 Sep 2020 19:57:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601236648;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a786VCv1z2fJcpCMIo7y6Vm7zl4rBDgJhy6TGsHsmKY=;
        b=uQ9Y1Nt0I3J2+gj6Dnxs3OHqNpOoVlXd20sprku0hNoZ3q7zoiWjBegA1jPOpHGbb7oocV
        OzlQKRqBV/zC/2D5AwW5moSIKxT8Is/v+BqHbf8eoDPoSZtfAPV8RW2pzECF6LIUMB+7C+
        DlaSV1Mosad/V+4Amf6W1bJoVkXbXGAcAcDOikMVXu7PSxfb91uRL/27vRsRK0KSB+65tA
        +Ko0quSmrpvoldAKg33W1L3ABzIlvDVbWHarDFFJJ0hGYOg14+z1B45PUo7qGgSAiI1FVj
        eozwCVoJ7W0mUUIlDOQNiyBjw82CUYyRonugIuNGFJJV9+8OsU47Sn1UvEYcQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601236648;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a786VCv1z2fJcpCMIo7y6Vm7zl4rBDgJhy6TGsHsmKY=;
        b=GXextnyg1zjdLCUyRYucI62PQYjrxw81gg5ZNiUDB+1fVV4V0UfE0dyxEHh7Nc0CeRiCUI
        BNTxFqFrRru5D/Cw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/apic/msi: Unbreak DMAR and HPET MSI
Cc:     Qian Cai <cai@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <87wo0fli8b.fsf@nanos.tec.linutronix.de>
References: <87wo0fli8b.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <160123664742.7002.8496872646322552146.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     d27e623ace6af259075b6e0437380ee8d6268c5d
Gitweb:        https://git.kernel.org/tip/d27e623ace6af259075b6e0437380ee8d6268c5d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 27 Sep 2020 10:46:44 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 27 Sep 2020 21:53:41 +02:00

x86/apic/msi: Unbreak DMAR and HPET MSI

Switching the DMAR and HPET MSI code to use the generic MSI domain ops
missed to add the flag which tells the core code to update the domain
operations with the defaults. As a consequence the core code crashes
when an interrupt in one of those domains is allocated.

Add the missing flags.

Fixes: 9006c133a422 ("x86/msi: Use generic MSI domain ops")
Reported-by: Qian Cai <cai@redhat.com>
Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/87wo0fli8b.fsf@nanos.tec.linutronix.de

---
 arch/x86/kernel/apic/msi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 3b522b0..6313f0a 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -309,6 +309,7 @@ static struct msi_domain_ops dmar_msi_domain_ops = {
 static struct msi_domain_info dmar_msi_domain_info = {
 	.ops		= &dmar_msi_domain_ops,
 	.chip		= &dmar_msi_controller,
+	.flags		= MSI_FLAG_USE_DEF_DOM_OPS,
 };
 
 static struct irq_domain *dmar_get_irq_domain(void)
@@ -408,6 +409,7 @@ static struct msi_domain_ops hpet_msi_domain_ops = {
 static struct msi_domain_info hpet_msi_domain_info = {
 	.ops		= &hpet_msi_domain_ops,
 	.chip		= &hpet_msi_controller,
+	.flags		= MSI_FLAG_USE_DEF_DOM_OPS,
 };
 
 struct irq_domain *hpet_create_irq_domain(int hpet_id)
