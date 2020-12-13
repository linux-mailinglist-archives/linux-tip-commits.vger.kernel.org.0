Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F9D2D9011
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732651AbgLMTCJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:02:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46712 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729699AbgLMTBx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:01:53 -0500
Date:   Sun, 13 Dec 2020 19:01:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886071;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=I6D+gUuNmcGc/bG2YlP7J6T/iIc5F5fqVYdiedr5JqU=;
        b=0rIJ01v/hQaq+e+CjdqDLSVyPvRrFzEBU00b9MR7ib1soIPnZ1PRcvMeTUf0gob/4dzUXi
        IGemusitOFGs+PJcpBwk4/AJ092HcGg+2GmmLlrMEjYzz6kiwDOO4Qobf+3h5lhTOs10w+
        WGxmspM1rHN6irF5xv/caFpNHbOAj29QyDWhus0ZFNOo7MUtYiV6is15SmALE0HqtanN/+
        oeF6VHZP7PshtAmD7u1pYCrpFQZbODQ6pFdJ8ut3I/oBQeQ6ZFKy1NsgeSfKhKG3faN5wI
        5qqzIiDGT9ZTzK48sSFu3rEI7gVR14FVXX7DNHZ9qSzafJFh9KkVGSedMMGkOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886071;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=I6D+gUuNmcGc/bG2YlP7J6T/iIc5F5fqVYdiedr5JqU=;
        b=CfxuyosBZ8oRNnm9xB1p3X0VOOOPDiRNbpYRB7BIWfRbDzJAhETSuksTtWQes91kzAFR1Q
        ZacLYuuKGglKLGCw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] locktorture: Track time of last ->writeunlock()
Cc:     Davidlohr Bueso <dbueso@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788607099.3364.5643051816742676927.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     3480d6774f07341e3e1cf3114f58bef98ea58ae0
Gitweb:        https://git.kernel.org/tip/3480d6774f07341e3e1cf3114f58bef98ea58ae0
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 30 Aug 2020 21:48:23 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:13:29 -08:00

locktorture: Track time of last ->writeunlock()

This commit adds a last_lock_release variable that tracks the time of
the last ->writeunlock() call, which allows easier diagnosing of lock
hangs when using a kernel debugger.

Acked-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 62d215b..316531d 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -60,6 +60,7 @@ static struct task_struct **reader_tasks;
 
 static bool lock_is_write_held;
 static bool lock_is_read_held;
+static unsigned long last_lock_release;
 
 struct lock_stress_stats {
 	long n_lock_fail;
@@ -632,6 +633,7 @@ static int lock_torture_writer(void *arg)
 		lwsp->n_lock_acquired++;
 		cxt.cur_ops->write_delay(&rand);
 		lock_is_write_held = false;
+		WRITE_ONCE(last_lock_release, jiffies);
 		cxt.cur_ops->writeunlock();
 
 		stutter_wait("lock_torture_writer");
