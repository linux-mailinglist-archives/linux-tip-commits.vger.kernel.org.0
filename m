Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFBE28829C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbgJIGiX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731927AbgJIGf0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360EDC0613D8;
        Thu,  8 Oct 2020 23:35:22 -0700 (PDT)
Date:   Fri, 09 Oct 2020 06:35:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0uxbyUGHheHQfTPPZADyuAxibTid8+QBnNocbmH/Qlk=;
        b=kNDB+lBIpS6O0Fjn314xmba8cP3V30XNbc3xqU53uOIYQdzlbgsvKgtt8cJAkUH4TEX6mV
        Tl1Fqm8ThDnZeSbRvh/U7m1r5ostyMvC6fQODxR6UPyuYVXHATWd59N+oIGy8i5O2ksd//
        q16SfkQFVViF+1ztWCZBYzMzI+ICGxRGsngOem9Vk6RaTVO1diAFmu+iY9BySO37rVcxV8
        TEQfQzxcyTKeW65zLK00F197+NX2SHD/pO8xVgg77daG3MHXB8l1vzQ7Aguli6ip1SyM7q
        XDTCaRPD2uV+jATlb2ORlo41BNAvtqkcBwxPCvL24gml+yA2CJQvaQwRh0Imww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0uxbyUGHheHQfTPPZADyuAxibTid8+QBnNocbmH/Qlk=;
        b=0xh5GfrdLJwHLgpTdm30njCLNxcQ2AbUSeXelQ1VZGKvzmH5qmpgiJ9KqFD1zrTB4+TRue
        Xwbt4rNBY8rFdAAA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: IPI all CPUs at GP start for strict GPs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222532005.7002.11821129524019912080.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     933ada2c3310aa88807e65c8d498b74a2159a9a2
Gitweb:        https://git.kernel.org/tip/933ada2c3310aa88807e65c8d498b74a2159a9a2
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 06 Aug 2020 19:21:48 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:40:26 -07:00

rcu: IPI all CPUs at GP start for strict GPs

Currently, each CPU discovers the beginning of a given grace period
on its own time, which is again good for efficiency but bad for fast
grace periods.  This commit therefore uses on_each_cpu() to IPI each
CPU after grace-period initialization in order to inform each CPU of
the new grace period in a timely manner, but only in kernels build with
CONFIG_RCU_STRICT_GRACE_PERIOD=y.

Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 36a860c..88f4fa6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1696,6 +1696,15 @@ static void rcu_gp_torture_wait(void)
 }
 
 /*
+ * Handler for on_each_cpu() to invoke the target CPU's RCU core
+ * processing.
+ */
+static void rcu_strict_gp_boundary(void *unused)
+{
+	invoke_rcu_core();
+}
+
+/*
  * Initialize a new grace period.  Return false if no grace period required.
  */
 static bool rcu_gp_init(void)
@@ -1823,6 +1832,10 @@ static bool rcu_gp_init(void)
 		WRITE_ONCE(rcu_state.gp_activity, jiffies);
 	}
 
+	// If strict, make all CPUs aware of new grace period.
+	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
+		on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
+
 	return true;
 }
 
