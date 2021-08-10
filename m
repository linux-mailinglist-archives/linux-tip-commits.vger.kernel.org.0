Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B3F3E84A8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 22:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbhHJUxJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 16:53:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45894 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbhHJUxJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 16:53:09 -0400
Date:   Tue, 10 Aug 2021 20:52:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628628765;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iB+/vF6PsFvdkS91kFy/wK6G7KsTsousXDU4teBoqfs=;
        b=YbaCxG2m0cfTQxssMuh6750swQs/kSmLSNUD6W7F27wKp/FbZsijJcso97xymJAxeXAU4w
        nDqa3608gzwE1G1gkP16ctKE4hY45QsMe3vEZzzpqFcRfV8Cz1aYNhdYjwkF3IhUSjUt2c
        cY+gl5chzHuI78oNRjCV8SAdecJIG2vRXEyJRATgAjitZ2VC/Y/A7gyurc4NvDiCo1b3yz
        sGk10ErvbMzPUtEsAJRESHNtCnyVRUjMv0e3kG5wWLLhFs7KfZYkdyDXxVaVzOQ8bF52XE
        /Uh7PWYDe2znf6FX6ibbLiHwlM61+Mkwmun2i50mXIBHH0DXsibu/NQz1IazJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628628765;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iB+/vF6PsFvdkS91kFy/wK6G7KsTsousXDU4teBoqfs=;
        b=9Mfiv5xmQDwkYWqC5cSxN9FzB19ZKqUbKJGS2Mx3lKxx7MlUw+I3KZl3CKxBwDJ2BRAusx
        RkJDMcX0X+SppRAA==
From:   "tip-bot2 for Baokun Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/matrix: Fix kernel doc warnings for
 irq_matrix_alloc_managed()
Cc:     Baokun Li <libaokun1@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210605063413.684085-1-libaokun1@huawei.com>
References: <20210605063413.684085-1-libaokun1@huawei.com>
MIME-Version: 1.0
Message-ID: <162862876446.395.6827089715538356182.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     92848731c45f4f9c3d9818e6b4ba1b2884002324
Gitweb:        https://git.kernel.org/tip/92848731c45f4f9c3d9818e6b4ba1b2884002324
Author:        Baokun Li <libaokun1@huawei.com>
AuthorDate:    Sat, 05 Jun 2021 14:34:13 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 22:50:07 +02:00

genirq/matrix: Fix kernel doc warnings for irq_matrix_alloc_managed()

Describe the arguments correctly.

Fixes the following W=1 kernel build warning(s):

kernel/irq/matrix.c:287: warning: Function parameter or
 member 'msk' not described in 'irq_matrix_alloc_managed'
kernel/irq/matrix.c:287: warning: Function parameter or
 member 'mapped_cpu' not described in 'irq_matrix_alloc_managed'
kernel/irq/matrix.c:287: warning: Excess function
 parameter 'cpu' description in 'irq_matrix_alloc_managed'

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210605063413.684085-1-libaokun1@huawei.com


---
 kernel/irq/matrix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 578596e..bbfb264 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -280,7 +280,8 @@ void irq_matrix_remove_managed(struct irq_matrix *m, const struct cpumask *msk)
 /**
  * irq_matrix_alloc_managed - Allocate a managed interrupt in a CPU map
  * @m:		Matrix pointer
- * @cpu:	On which CPU the interrupt should be allocated
+ * @msk:	Which CPUs to search in
+ * @mapped_cpu:	Pointer to store the CPU for which the irq was allocated
  */
 int irq_matrix_alloc_managed(struct irq_matrix *m, const struct cpumask *msk,
 			     unsigned int *mapped_cpu)
