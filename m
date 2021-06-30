Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E053B83AA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbhF3Nu3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32992 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235504AbhF3NuF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:05 -0400
Date:   Wed, 30 Jun 2021 13:47:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RM5Kgs/eEQyAoKWH85nfbIw8aAY99H/3jyCUM2OA5EM=;
        b=zZ/fuBZ16divtMscRqJI48cSbnoEPOVeCgNSl937CX3wSuDKOFAhREUzeTMx4yhxysfpuS
        ZjT/Knc3pbkIRe6X70iXE78PNVw/uimmzmhc+hIXJhNR4gmZN7KY8ss9QaEA5ADABJCHKb
        5GNA1yEDg66wtX0G+cXIu1AIGsXZBHJ2AU9sP40ekR94DJX8HyNhOGcvEA4VUeqVdJ1dWG
        3a33UUlvxKG6nMQkDURQOefOT9gPGjgNQu+9dMuXP7xfNNiLYGMm3CU9j4VSYPLw9ZjSKS
        HhHOIYAv1hB02lW5Wz9gh1Ei2Czwjcxm5VTI8nZpX+XedYZ/S8TpCenq/YUtBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RM5Kgs/eEQyAoKWH85nfbIw8aAY99H/3jyCUM2OA5EM=;
        b=H+1GM/iNLyQgNkMCrFzyqeWVBPPz7WAtEK5nvCRxBSoYFmTwNpAvb85NWVjxOlY/gY5lns
        7KFky7agAkgxJQBA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] lockdep: Explicitly flag likely false-positive report
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506085541.395.2673607686891750565.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     1feb2cc8db481b902272559ad7aae3c091762ad0
Gitweb:        https://git.kernel.org/tip/1feb2cc8db481b902272559ad7aae3c091762ad0
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 05 Apr 2021 09:47:59 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:22:54 -07:00

lockdep: Explicitly flag likely false-positive report

The reason that lockdep_rcu_suspicious() prints the value of debug_locks
is because a value of zero indicates a likely false positive.  This can
work, but is a bit obtuse.  This commit therefore explicitly calls out
the possibility of a false positive.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/lockdep.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 48d736a..d6c3c98 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6393,6 +6393,7 @@ asmlinkage __visible void lockdep_sys_exit(void)
 void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 {
 	struct task_struct *curr = current;
+	int dl = READ_ONCE(debug_locks);
 
 	/* Note: the following can be executed concurrently, so be careful. */
 	pr_warn("\n");
@@ -6402,11 +6403,12 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 	pr_warn("-----------------------------\n");
 	pr_warn("%s:%d %s!\n", file, line, s);
 	pr_warn("\nother info that might help us debug this:\n\n");
-	pr_warn("\n%srcu_scheduler_active = %d, debug_locks = %d\n",
+	pr_warn("\n%srcu_scheduler_active = %d, debug_locks = %d\n%s",
 	       !rcu_lockdep_current_cpu_online()
 			? "RCU used illegally from offline CPU!\n"
 			: "",
-	       rcu_scheduler_active, debug_locks);
+	       rcu_scheduler_active, dl,
+	       dl ? "" : "Possible false positive due to lockdep disabling via debug_locks = 0\n");
 
 	/*
 	 * If a CPU is in the RCU-free window in idle (ie: in the section
