Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A705E158F16
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Feb 2020 13:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbgBKMtV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 11 Feb 2020 07:49:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46066 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbgBKMs0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 11 Feb 2020 07:48:26 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j1Uxi-0007kD-Fw; Tue, 11 Feb 2020 13:48:22 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 148A11C2017;
        Tue, 11 Feb 2020 13:48:22 +0100 (CET)
Date:   Tue, 11 Feb 2020 12:48:21 -0000
From:   "tip-bot2 for Davidlohr Bueso" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/percpu-rwsem: Add might_sleep() for
 writer locking
Cc:     Davidlohr Bueso <dbueso@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200108013305.7732-1-dave@stgolabs.net>
References: <20200108013305.7732-1-dave@stgolabs.net>
MIME-Version: 1.0
Message-ID: <158142530179.411.17952389583883812912.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     41f0e29190ac9e38099a37abd1a8a4cb1dc21233
Gitweb:        https://git.kernel.org/tip/41f0e29190ac9e38099a37abd1a8a4cb1dc21233
Author:        Davidlohr Bueso <dave@stgolabs.net>
AuthorDate:    Tue, 07 Jan 2020 17:33:04 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 11 Feb 2020 13:11:02 +01:00

locking/percpu-rwsem: Add might_sleep() for writer locking

We are missing this annotation in percpu_down_write(). Correct
this.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://lkml.kernel.org/r/20200108013305.7732-1-dave@stgolabs.net
---
 kernel/locking/percpu-rwsem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 8048a9a..183a3aa 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -212,6 +212,7 @@ static bool readers_active_check(struct percpu_rw_semaphore *sem)
 
 void percpu_down_write(struct percpu_rw_semaphore *sem)
 {
+	might_sleep();
 	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
 
 	/* Notify readers to take the slow path. */
