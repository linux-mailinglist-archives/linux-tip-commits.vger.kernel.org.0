Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D00434283C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Mar 2021 22:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhCSVyD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 19 Mar 2021 17:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhCSVx4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 19 Mar 2021 17:53:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A2FC06175F;
        Fri, 19 Mar 2021 14:53:56 -0700 (PDT)
Date:   Fri, 19 Mar 2021 21:53:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616190834;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IN2AzD/cRScGqE8yPRX/Pp5ZazZQZ5o2YcTgs8GOjHc=;
        b=E3FjMZliTGS94Hva3MJAgOGEyA+SEJ302rwfGymnI4J8SOWzTihIv+NL+y7gTh4mPw8uM2
        tXaKJoXsonPZ5zJUd3T4sVFs6oh5lXCTJ0drTfaYYiLYZzUCjymNIvPzRJOoH9ne+tFBpG
        wlVTq+qnquOIdGm9lLouLRMhwSmlkNObeJWmNPp/y1rDKLT1Ye2KPXcw4Pv9GXrNhByRHi
        t9NBknUi7vAGIos2Gqg5JgSxh/Oj910jGInV1BJDO/hPqjuU3Ax4jVsx3uDUg153uvRPW3
        odolyxbWRALoGuD9UfgZZyutzy9MRgLq7GTRNwMJgPIScMdcmixp59lNSHrFjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616190834;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IN2AzD/cRScGqE8yPRX/Pp5ZazZQZ5o2YcTgs8GOjHc=;
        b=YwJ8Kr1lFfGZswbUf/qHcxefwdbrXJIvXylFhMxL1HV4PYNVcXS8UjaqY8nBIq3EHb3B/Q
        /uCrWu18C0OIm4Dw==
From:   "tip-bot2 for Vitaly Kuznetsov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/matrix: Prevent allocation counter corruption
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210319111823.1105248-1-vkuznets@redhat.com>
References: <20210319111823.1105248-1-vkuznets@redhat.com>
MIME-Version: 1.0
Message-ID: <161619083334.398.8036450907118788955.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c93a5e20c3c2dabef8ea360a3d3f18c6f68233ab
Gitweb:        https://git.kernel.org/tip/c93a5e20c3c2dabef8ea360a3d3f18c6f68233ab
Author:        Vitaly Kuznetsov <vkuznets@redhat.com>
AuthorDate:    Fri, 19 Mar 2021 12:18:23 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 19 Mar 2021 22:52:11 +01:00

genirq/matrix: Prevent allocation counter corruption

When irq_matrix_free() is called for an unallocated vector the
managed_allocated and total_allocated counters get out of sync with the
real state of the matrix. Later, when the last interrupt is freed, these
counters will underflow resulting in UINTMAX because the counters are
unsigned.

While this is certainly a problem of the calling code, this can be catched
in the allocator by checking the allocation bit for the to be freed vector
which simplifies debugging.

An example of the problem described above:
https://lore.kernel.org/lkml/20210318192819.636943062@linutronix.de/

Add the missing sanity check and emit a warning when it triggers.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210319111823.1105248-1-vkuznets@redhat.com

---
 kernel/irq/matrix.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 6f8b1d1..578596e 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -422,7 +422,9 @@ void irq_matrix_free(struct irq_matrix *m, unsigned int cpu,
 	if (WARN_ON_ONCE(bit < m->alloc_start || bit >= m->alloc_end))
 		return;
 
-	clear_bit(bit, cm->alloc_map);
+	if (WARN_ON_ONCE(!test_and_clear_bit(bit, cm->alloc_map)))
+		return;
+
 	cm->allocated--;
 	if(managed)
 		cm->managed_allocated--;
