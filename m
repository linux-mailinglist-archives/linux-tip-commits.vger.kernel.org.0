Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A70319EAF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhBLMkL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbhBLMie (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:38:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2948EC0617A9;
        Fri, 12 Feb 2021 04:37:12 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:37:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133429;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Vxn9G4YjPKc5sL2JgSZFGDgwEc1PgWISGp4MXwI/whk=;
        b=guD5o5LtaO6OL68U6U1VdmVyZEMPqFcjP7nBM1g1YQoMwA7BATmC7bM1lx3YPw3nH7q8VA
        Hi/uOYm6UQIX+UD1iX38CHRxQe4fNcOGXe0xWdaXLYQpwn7xzHBI/OYHvQnnp3bKNTtNlp
        HWAWdyoNgjQXHCFWg6TuoDMMA/zromc5j7utQq39an9SPu8BegqO6jUIHEtOibm5LvUX1n
        L92zCCEaSc+Fni+bP0l4OEe+7bi+qvaoHfLN4X6pTzV0Ziy2tE/AKd4s2iEq+AqLSQ6Nwy
        kjsC8lgM2jnjDz5+Y1FsPB/+kj7dz0OZTOm6uBlmfrNrZDCiIaFRQRtJiQaysg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133429;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Vxn9G4YjPKc5sL2JgSZFGDgwEc1PgWISGp4MXwI/whk=;
        b=q3j0LZfWYa7XgenRT6XHe+dkm3QVjlxdgy+uy97pctTXit7hq9XujEfyKNbATswymxl8Bn
        C1TirET26em8q6Bg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Make refscale throttle high-rate printk()s
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313342878.23325.17600408859832508616.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     414c116e016584137118067f506125f6ace6128c
Gitweb:        https://git.kernel.org/tip/414c116e016584137118067f506125f6ace6128c
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 25 Nov 2020 10:50:35 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 17:17:20 -08:00

torture: Make refscale throttle high-rate printk()s

This commit adds a short delay for verbose_batched-throttled printk()s
to further decrease console flooding.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 3da246f..02dd976 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -52,8 +52,10 @@ static atomic_t verbose_batch_ctr;
 do {											\
 	if (verbose &&									\
 	    (verbose_batched <= 0 ||							\
-	     !(atomic_inc_return(&verbose_batch_ctr) % verbose_batched)))		\
+	     !(atomic_inc_return(&verbose_batch_ctr) % verbose_batched))) {		\
+		schedule_timeout_uninterruptible(1);					\
 		pr_alert("%s" SCALE_FLAG s, scale_type, ## x);				\
+	}										\
 } while (0)
 
 #define VERBOSE_SCALEOUT_ERRSTRING(s, x...) \
