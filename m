Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210E231BB94
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhBOO46 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhBOO4n (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:56:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF19EC061793;
        Mon, 15 Feb 2021 06:55:46 -0800 (PST)
Date:   Mon, 15 Feb 2021 14:55:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400944;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=NVk0BbyitPFSFLG1NYz4snFzpILI/41drSvFlwe3BSA=;
        b=FWtitFWxDw0LFCdLCnbCzOaMmqvMlW07gRn509QhRCyau8USKwDnxnXnv8wku8ArotBhiI
        kEA+921uj4/t+tc+legc02uvu8bV2l+tc7H0ayvMnpCzZx0FWwXfT4I+dHxHfXuQbxSDbR
        Go9DUWJFfjTuHrNELopZbYI3+XnnH725EIeo6HkGZcB0O+ms9SRgvwIeEK1FXodCB2YyFS
        2l6RUZ+nE63leCecqW1R6jVv7DZ/K86XRXC5e+ZLQyh3f0iLFF+AYdzklTfvbLqBGWjy6s
        epJVrNxeNwxFPxzjwFqFgIyGF/remSCxr7RVoJBlDHLa2fE94ZAim82vjDOC5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400944;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=NVk0BbyitPFSFLG1NYz4snFzpILI/41drSvFlwe3BSA=;
        b=QIZnsqMCM9YTb3Ji+5PNvC6t63GVRGxNIfUtmguvZYWZ6T3XEyVglxZsGPVGdTHkUE1RTs
        AW4KSsjw6+geucCQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] srcu: Add comment explaining cookie overflow/wrap
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340094396.20312.1026790904001043841.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     4e7ccfae52b39aeee93ed39d4184d50ea201fbef
Gitweb:        https://git.kernel.org/tip/4e7ccfae52b39aeee93ed39d4184d50ea201fbef
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 15 Nov 2020 20:33:38 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 13:53:39 -08:00

srcu: Add comment explaining cookie overflow/wrap

This commit adds to the poll_state_synchronize_srcu() header comment
describing the issues surrounding SRCU cookie overflow/wrap for the
different kernel configurations.

Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index c5d0c03..119938d 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1058,6 +1058,21 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_srcu);
  * get_state_synchronize_srcu() or start_poll_synchronize_srcu(), and
  * returns @true if an SRCU grace period elapsed since the time that the
  * cookie was created.
+ *
+ * Because cookies are finite in size, wrapping/overflow is possible.
+ * This is more pronounced on 32-bit systems where cookies are 32 bits,
+ * where in theory wrapping could happen in about 14 hours assuming
+ * 25-microsecond expedited SRCU grace periods.  However, a more likely
+ * overflow lower bound is on the order of 24 days in the case of
+ * one-millisecond SRCU grace periods.  Of course, wrapping in a 64-bit
+ * system requires geologic timespans, as in more than seven million years
+ * even for expedited SRCU grace periods.
+ *
+ * Wrapping/overflow is much more of an issue for CONFIG_SMP=n systems
+ * that also have CONFIG_PREEMPTION=n, which selects Tiny SRCU.  This uses
+ * a 16-bit cookie, which rcutorture routinely wraps in a matter of a
+ * few minutes.  If this proves to be a problem, this counter will be
+ * expanded to the same size as for Tree SRCU.
  */
 bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie)
 {
