Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB8D3E5E5E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 16:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242219AbhHJOvL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 10:51:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43854 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238617AbhHJOsy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 10:48:54 -0400
Date:   Tue, 10 Aug 2021 14:48:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628606910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rQoXve8pZEefDfzy1MSlgSkrq0iQwG1KVUsJRu5Ya68=;
        b=kxNzHV7VyWE9A95z2Z/K1DPwiEiN0sMSKqWcpX3hGpSof7XDRL0y2uNU3V914fxwZOhU8B
        4Vk87UT10zEEjFuFecoYzBJC578Rsjwqd9TTXjaFCP2h4PN6+qFWzr7wrtXq6vgWEe11nS
        evIJtt6zFPJNttFOb1PCMtG64c8zpqsPz6dBMFsGxeshf2Bjfvfq0gQKMmaVIrB+k1/BDU
        NAiX3H50KtUfmvNOOy2J1tNunuruVylfKPhzn4iz+9mq/jU/gDzXMG5px2yv165rNNfJPt
        /8zfl76ifD8f+tUgpbNkXZc9cj0auQh4uGtppDhOUrkQR8oGlu6PI1//xGzOTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628606910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rQoXve8pZEefDfzy1MSlgSkrq0iQwG1KVUsJRu5Ya68=;
        b=Z5hIJjOUJnlNz98AJWv9MGl+oFglOaK800xHR1qqzfL3LCqTNAOk6rqc6GeVozFBv8C0Ee
        sX9dhP+SpgMy54AQ==
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
Message-ID: <162860690917.395.12740392525417806707.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     1d07a835819e2d3c85af8f093a02c2e6bca422d6
Gitweb:        https://git.kernel.org/tip/1d07a835819e2d3c85af8f093a02c2e6bca422d6
Author:        Baokun Li <libaokun1@huawei.com>
AuthorDate:    Sat, 05 Jun 2021 14:34:13 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 16:46:26 +02:00

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
