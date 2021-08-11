Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921533E9199
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Aug 2021 14:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhHKMhV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Aug 2021 08:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhHKMhN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Aug 2021 08:37:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F1CC061798;
        Wed, 11 Aug 2021 05:36:49 -0700 (PDT)
Date:   Wed, 11 Aug 2021 12:36:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628685408;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OZ00XsBC9sj3e4ShVnxhNyU/wkk5woiSazLSjmAKBXg=;
        b=j+sii+vZyk2xLXZMmQCqKk3FRcyCaEzCoM6p8/Z82VbEAHbL5RK2JF6QW239uSQHy4/it8
        1LthlgbQLeMT2JayKipiZuWV/efw52k+AmIjSGhpbEhrX3d0owx/0374/17kOF/JellYSC
        wCTwVS2N7mYp/8YTkjcAvVtO4E8RRUhFRpOytbXI/6HfcveF4JYi5nLs1KJjeVSXIalapY
        ryHVz8yMrlP7p/DwzUuUBM9G04YDE7XArUa0JCP3ddTxbCi8csh0eo4+A7NFvqSFTdK/XN
        C38BnyUwmJfP4CETvbpqLxxCPf9pKq1GOVBrUdRB70DM+gLPZjpaPnlm0tgeCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628685408;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OZ00XsBC9sj3e4ShVnxhNyU/wkk5woiSazLSjmAKBXg=;
        b=CsOQ34+4bvKDfe+rZ4F/iWSV3YFHihpIy3mwyBqNrp+G34VhZI/ex4aepr6w5GL3Jqv/v6
        sXBlKTzRHPGVX2Cw==
From:   "tip-bot2 for Zhen Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/timings: Fix error return code in
 irq_timings_test_irqs()
Cc:     Hulk Robot <hulkci@huawei.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210811093333.2376-1-thunder.leizhen@huawei.com>
References: <20210811093333.2376-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Message-ID: <162868540746.395.5341157331429759306.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     290fdc4b7ef14e33d0e30058042b0e9bfd02b89b
Gitweb:        https://git.kernel.org/tip/290fdc4b7ef14e33d0e30058042b0e9bfd02b89b
Author:        Zhen Lei <thunder.leizhen@huawei.com>
AuthorDate:    Wed, 11 Aug 2021 17:33:32 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 11 Aug 2021 14:33:35 +02:00

genirq/timings: Fix error return code in irq_timings_test_irqs()

Return a negative error code from the error handling case instead of 0, as
done elsewhere in this function.

Fixes: f52da98d900e ("genirq/timings: Add selftest for irqs circular buffer")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210811093333.2376-1-thunder.leizhen@huawei.com

---
 kernel/irq/timings.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index d309d6f..59affb3 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -794,12 +794,14 @@ static int __init irq_timings_test_irqs(struct timings_intervals *ti)
 
 		__irq_timings_store(irq, irqs, ti->intervals[i]);
 		if (irqs->circ_timings[i & IRQ_TIMINGS_MASK] != index) {
+			ret = -EBADSLT;
 			pr_err("Failed to store in the circular buffer\n");
 			goto out;
 		}
 	}
 
 	if (irqs->count != ti->count) {
+		ret = -ERANGE;
 		pr_err("Count differs\n");
 		goto out;
 	}
