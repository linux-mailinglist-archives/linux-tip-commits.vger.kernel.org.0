Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DFD319E8C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhBLMif (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:38:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45332 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhBLMhv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:37:51 -0500
Date:   Fri, 12 Feb 2021 12:37:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133427;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hObuhokv9DXAro6iPtrPgaGy2mZjO+YCQuxrkoxn7gc=;
        b=hMa8PROhqH/Vk7kgpqtU85qYeaN2c4MqzTzo0pg7RIga0Ig7Go6Q2MkyqERsVwH0WmcBL3
        Lt/0IDdKYpkdgdAKImVYHhWJXpOWZ3bY3WTf+85xRQH3Ba0sxreRjhiI1p2XasHLd0Ib22
        ADF7+dnj68xKr2e9hJCTdRqJa2f7n/wXCfcgKAMmERQt1R7RyA1it/TXVDbtJognV0fAzm
        bRNanAbvlcWFthEr90uNhjmdfrdF5hA8rsWUmtXm5I6rkgNPqwd3vYgL7vpiKoqMaSPnmI
        UIczuPbzHYjC7HeYuKchkZ40u+FdskTKxIe7U5/flH9onX2JElfP6lPGgvNL2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133427;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hObuhokv9DXAro6iPtrPgaGy2mZjO+YCQuxrkoxn7gc=;
        b=SPgz1CJzLHdhDPljIw+y6aKcbxPawjqfOYLmG3O+8j/0wsxuQ0ksvzQYPsNkoT91M0YRQB
        Hwo5bByD/eR5UuBA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Add rcutree.use_softirq=0 to RUDE01 and TASKS01
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313342734.23325.4567901204038337648.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     d945f797e483979bdeded76266c366f35929afb8
Gitweb:        https://git.kernel.org/tip/d945f797e483979bdeded76266c366f35929afb8
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 25 Dec 2020 07:40:48 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 12 Jan 2021 09:55:23 -08:00

rcutorture: Add rcutree.use_softirq=0 to RUDE01 and TASKS01

RCU's rcutree.use_softirq=0 kernel boot parameter substitutes the per-CPU
rcuc kthreads for softirq, which is used in real-time installations.
However, none of the rcutorture scenarios test this parameter.
This commit therefore adds rcutree.use_softirq=0 to the RUDE01 and
TASKS01 rcutorture scenarios, both of which indirectly exercise RCU.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/RUDE01.boot  | 1 +
 tools/testing/selftests/rcutorture/configs/rcu/TASKS01.boot | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/RUDE01.boot b/tools/testing/selftests/rcutorture/configs/rcu/RUDE01.boot
index 9363708..932a079 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/RUDE01.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/RUDE01.boot
@@ -1 +1,2 @@
 rcutorture.torture_type=tasks-rude
+rcutree.use_softirq=0
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TASKS01.boot b/tools/testing/selftests/rcutorture/configs/rcu/TASKS01.boot
index cd2a188..22cdece 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TASKS01.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TASKS01.boot
@@ -1 +1,2 @@
 rcutorture.torture_type=tasks
+rcutree.use_softirq=0
