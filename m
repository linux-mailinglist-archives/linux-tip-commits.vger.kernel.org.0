Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9A821494F5
	for <lists+linux-tip-commits@lfdr.de>; Sat, 25 Jan 2020 11:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgAYKrD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 25 Jan 2020 05:47:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44095 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgAYKmp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 25 Jan 2020 05:42:45 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivItk-0008KA-TX; Sat, 25 Jan 2020 11:42:41 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 904891C1A72;
        Sat, 25 Jan 2020 11:42:39 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:39 -0000
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] powerpc: Remove comment about read_barrier_depends()
Cc:     Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994895940.396.635928895475003187.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c7e9c01f928a0e7e467ec3efe1b56bc566678bae
Gitweb:        https://git.kernel.org/tip/c7e9c01f928a0e7e467ec3efe1b56bc566678bae
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Fri, 08 Nov 2019 17:01:18 
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 24 Jan 2020 10:33:52 -08:00

powerpc: Remove comment about read_barrier_depends()

'read_barrier_depends()' doesn't exist anymore so stop talking about it.

Signed-off-by: Will Deacon <will@kernel.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/powerpc/include/asm/barrier.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index fbe8df4..123adce 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -18,8 +18,6 @@
  * mb() prevents loads and stores being reordered across this point.
  * rmb() prevents loads being reordered across this point.
  * wmb() prevents stores being reordered across this point.
- * read_barrier_depends() prevents data-dependent loads being reordered
- *	across this point (nop on PPC).
  *
  * *mb() variants without smp_ prefix must order all types of memory
  * operations with one another. sync is the only instruction sufficient
