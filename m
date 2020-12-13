Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECB12D9027
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbgLMTB4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:01:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46628 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbgLMTBu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:01:50 -0500
Date:   Sun, 13 Dec 2020 19:01:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bvmAIlVjhtU6GZaTHkP/xJhOOBYnt6v/xtySe+Lxtrk=;
        b=zm5idZ3Wocy8FEwPtCr0xdqe9TZ0AAhBKALDYgn4nY0Rh05mNPJPXRx0vycisLuvreY1nh
        ygSO3AO2zDLQW9P3m9FkWAYkcogKjDQet206c4vLlbQjyOZfypMvdtIfGMnD6PYG6vlZRB
        wIcL68ZJxFIvMIbPdnKoTnHBNKhO/uoX468VMZDecipxDNbkwZHp0MM33l9+MQSAGPqeDN
        tK4cRMRGhNrVJjyIszFfOZyJqMm/5rrhznKp2uTJNxYlnumuj+AoPG8NaGayckbCFWgnpV
        TUo1eUWlIoWVwsMMrHSZraGjmKdyAx/3Izw1oXYx6ntmTzoQ8IgjyBP8ietAsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bvmAIlVjhtU6GZaTHkP/xJhOOBYnt6v/xtySe+Lxtrk=;
        b=LyCMiR2lPeaGNhy8HzL48f1xrseGhjiN/xsW+YHVnQ0sNhJ8m+adJlL2eeFXgeZuwemgsj
        4d/QrClgvoJtXUDw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Small code cleanups
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606789.3364.13277474191983409443.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     293b93d66f149a9bd124aae195f048268e11870c
Gitweb:        https://git.kernel.org/tip/293b93d66f149a9bd124aae195f048268e11870c
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 23 Sep 2020 16:46:36 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:13:55 -08:00

rcutorture: Small code cleanups

The rcu_torture_cleanup() function fails to NULL out the reader_tasks
pointer after freeing it and its fakewriter_tasks loop has redundant
braces.  This commit therefore cleans these up.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 4391d2f..e7d52fd 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2496,13 +2496,13 @@ rcu_torture_cleanup(void)
 			torture_stop_kthread(rcu_torture_reader,
 					     reader_tasks[i]);
 		kfree(reader_tasks);
+		reader_tasks = NULL;
 	}
 
 	if (fakewriter_tasks) {
-		for (i = 0; i < nfakewriters; i++) {
+		for (i = 0; i < nfakewriters; i++)
 			torture_stop_kthread(rcu_torture_fakewriter,
 					     fakewriter_tasks[i]);
-		}
 		kfree(fakewriter_tasks);
 		fakewriter_tasks = NULL;
 	}
