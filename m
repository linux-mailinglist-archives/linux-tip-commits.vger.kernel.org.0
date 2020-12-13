Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242992D902B
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgLMTBm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgLMTBm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:01:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133ACC0613D3;
        Sun, 13 Dec 2020 11:01:02 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:00:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886060;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=cZWEl44H21BytcJKHnwGIbV4ULromhqo7I+Kk9OhCXg=;
        b=dZhO2RiaNAzcpFVAq9YSKXI5tXJMnc0hJCa3/lGYr339fOZmxJOLWt0zRxyH9dlt8wyMzg
        Xx9mPAoqhND7sBSzLWj7hwRn67dj1+FrQFYVvl46nGyHZfJ2U/BAqW1KhAyfRLAghZyl5E
        zhK8i8eHrE6E6T5VwIc2/KEtCGVrbRWrKtGhsKVJUD8jTy3yAbpL4qiXDFw2hBsV/s26cM
        QR9D7OXpUvokOyTuLXGxj3yhN8IriO/1Fw6gSFSsVXqCtMdBxY3u4gVP86I79LmoDm+3Fi
        PnGmciGTV0seqNLmjCH5Vbzub5sqxYFaoZzn8BLuvf6HWXkRz0sya8BxXop3Yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886060;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=cZWEl44H21BytcJKHnwGIbV4ULromhqo7I+Kk9OhCXg=;
        b=YyfX8SkDrVHzkkQHFTNaplTjbOeI0Ry5p0LV+0gohRfbe6Hm2PbWZ/4xw3ek7Mcb4JRz0I
        K94iGPl+O6U+v/CQ==
From:   "tip-bot2 for Zhouyi Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Fix a typo in rcu_blocking_is_gp() header comment
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788605983.3364.7573622432671547557.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     354c3f0e22dcb17c10d0b79f6e1c5ba286eec0b0
Gitweb:        https://git.kernel.org/tip/354c3f0e22dcb17c10d0b79f6e1c5ba286eec0b0
Author:        Zhouyi Zhou <zhouzhouyi@gmail.com>
AuthorDate:    Thu, 15 Oct 2020 03:53:03 
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 19 Nov 2020 19:37:17 -08:00

rcu: Fix a typo in rcu_blocking_is_gp() header comment

This commit fixes a typo in the rcu_blocking_is_gp() function's header
comment.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3438534..0f278d6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3572,7 +3572,7 @@ void __init kfree_rcu_scheduler_running(void)
  * During early boot, any blocking grace-period wait automatically
  * implies a grace period.  Later on, this is never the case for PREEMPTION.
  *
- * Howevr, because a context switch is a grace period for !PREEMPTION, any
+ * However, because a context switch is a grace period for !PREEMPTION, any
  * blocking grace-period wait automatically implies a grace period if
  * there is only one CPU online at any point time during execution of
  * either synchronize_rcu() or synchronize_rcu_expedited().  It is OK to
