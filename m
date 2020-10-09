Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DD32882A6
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731716AbgJIGij (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:38:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55474 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731900AbgJIGfW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:22 -0400
Date:   Fri, 09 Oct 2020 06:35:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kz9uJtUCKxzNai/4OIEp7S4PHB9Jc12PJnCLmTgZ+CM=;
        b=Sa6hJxWBBj9+F207V5xVw6IuEHDDwZjhTQGWUmrj81DnUu0j3tVrXTAue/nShP8KFFUtD5
        tKBuV5FuSRMzsCKoYmXG1MCt9hXh5QbDwcSBGO+pClBbwF6ZWASeSFWm0IWPVAFvQCdc6D
        STxUW/gbrjbuJrhnbbcH1BBk/FAE6sUlgRsEQB0Vux+BswyVCWyYd8/oZddA74XINkGlP3
        vWokFBiNnvMrrDO9qnk3AvT7ZsIomwnYx7giQ9Mq87pxD/Uayp/QyxAIc3l9mY337xAqKl
        Ax9fPqSx3sXkhDdvKqBRT4mCnT7olx0/n80750waziQQ45K9bAPFwFd2siBsCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kz9uJtUCKxzNai/4OIEp7S4PHB9Jc12PJnCLmTgZ+CM=;
        b=uRsdyfy+eQfME2wvjASGqJ4ahXLmyoK0CIINgKcb2XHCi6y4d5a/2DILi22/zhV0k/GAjn
        WWc78VmCExZd9JCA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: IPI all CPUs at GP end for strict GPs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222531945.7002.7999758507380674564.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     4e025f52a1e0e8ff4e303fa0a80e2061ccfa27d6
Gitweb:        https://git.kernel.org/tip/4e025f52a1e0e8ff4e303fa0a80e2061ccfa27d6
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 06 Aug 2020 19:42:47 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:40:26 -07:00

rcu: IPI all CPUs at GP end for strict GPs

Currently, each CPU discovers the end of a given grace period on its
own time, which is again good for efficiency but bad for fast grace
periods, given that it is things like kfree() within the RCU callbacks
that will cause trouble for pointers leaked from RCU read-side critical
sections.  This commit therefore uses on_each_cpu() to IPI each CPU
after grace-period cleanup in order to inform each CPU of the end of
the old grace period in a timely manner, but only in kernels build with
CONFIG_RCU_STRICT_GRACE_PERIOD=y.

Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 88f4fa6..4bbedfc 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2052,6 +2052,10 @@ static void rcu_gp_cleanup(void)
 			   rcu_state.gp_flags & RCU_GP_FLAG_INIT);
 	}
 	raw_spin_unlock_irq_rcu_node(rnp);
+
+	// If strict, make all CPUs aware of the end of the old grace period.
+	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
+		on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
 }
 
 /*
