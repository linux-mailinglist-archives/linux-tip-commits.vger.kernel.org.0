Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563E931BBA5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhBOO5k (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhBOO5L (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:57:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321B1C06121E;
        Mon, 15 Feb 2021 06:55:50 -0800 (PST)
Date:   Mon, 15 Feb 2021 14:55:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400948;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dk1DCFB9Z5/A92LTapGqR0uyJfohFOf8U96dc9NNhfE=;
        b=HbPmb8hhmAnJ4G20yh+hsTOcgsrT5so2xibFnLWrU00zSQXGmrV80u3eRxDS+9+aGnPuAf
        kxtb73tqyQCBsGLOrnW7nOP9T+dNrrFp0zDEAcXbFFi/IswY7s7xklq4CPVtdpCUFjn6cl
        xi3rqHJ/LPUYbdStutQm3dM7HJpQ6oICMDjg5wiskfPDbNRfnajdF0Fjk+0H30bbjQBHqj
        Y2FH1QAO8mB+LEwGS01WjO1Wzp5h6sVtSVVEhXyf41rgLmaj98JSfb8OSPDdvij93cyN27
        cB6rLGUY2wBehP8LMGncGsy1+qHVvyUrgib9CWFGqR5JKtc+Gn1Vshv4p8Wg3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400948;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dk1DCFB9Z5/A92LTapGqR0uyJfohFOf8U96dc9NNhfE=;
        b=7imIZ9aNTEC5/BGiV8Q6bP/FxsYBYVhFDQPOYJnTBSsEimjuwKZlkCOo8dYsNY/pyupTIY
        0Vi57dza4+G2KxBg==
From:   "tip-bot2 for Paul Gortmaker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] docs: Fix typos and drop/fix dead links in RCU documentation
Cc:     Michael Opdenacker <michael.opdenacker@free-electrons.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340094789.20312.6683600289454267185.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     9d3a04853fe640e0eba2c0799c880b7dcf190219
Gitweb:        https://git.kernel.org/tip/9d3a04853fe640e0eba2c0799c880b7dcf1=
90219
Author:        Paul Gortmaker <paul.gortmaker@windriver.com>
AuthorDate:    Sat, 28 Nov 2020 15:32:59 -05:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 13:35:14 -08:00

docs: Fix typos and drop/fix dead links in RCU documentation

It appears the Compaq link moved to a machine at HP for a while
after the merger of the two, but that doesn't work either.  A search
of HP for "wiz_2637" (w and w/o html suffix) comes up empty.

Since the references aren't critical to the documents we remove them.

Also, the lkml.kernel.org/g links have been broken for ages, so replace
them with lore.kernel.org/r links - standardize on lore for all links too.

Note that we put off fixing these 4y ago - presumably thinking that a
treewide fixup was pending.  Probably safe to go fix the RCU ones now.

https://lore.kernel.org/r/20160915144926.GD10850@linux.vnet.ibm.com/

Cc: Michael Opdenacker <michael.opdenacker@free-electrons.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/Design/Requirements/Requirements.rst | 23 ++++-----
 Documentation/RCU/checklist.rst                        |  8 +--
 2 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documen=
tation/RCU/Design/Requirements/Requirements.rst
index 1e3df77..f32f8fa 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -321,11 +321,10 @@ do_something_gp_buggy() below:
       12 }
=20
 However, this temptation must be resisted because there are a
-surprisingly large number of ways that the compiler (to say nothing of
-`DEC Alpha CPUs <https://h71000.www7.hp.com/wizard/wiz_2637.html>`__)
-can trip this code up. For but one example, if the compiler were short
-of registers, it might choose to refetch from ``gp`` rather than keeping
-a separate copy in ``p`` as follows:
+surprisingly large number of ways that the compiler (or weak ordering
+CPUs like the DEC Alpha) can trip this code up. For but one example, if
+the compiler were short of registers, it might choose to refetch from
+``gp`` rather than keeping a separate copy in ``p`` as follows:
=20
    ::
=20
@@ -1183,7 +1182,7 @@ costs have plummeted. However, as I learned from Matt M=
ackall's
 `bloatwatch <http://elinux.org/Linux_Tiny-FAQ>`__ efforts, memory
 footprint is critically important on single-CPU systems with
 non-preemptible (``CONFIG_PREEMPT=3Dn``) kernels, and thus `tiny
-RCU <https://lkml.kernel.org/g/20090113221724.GA15307@linux.vnet.ibm.com>`__
+RCU <https://lore.kernel.org/r/20090113221724.GA15307@linux.vnet.ibm.com>`__
 was born. Josh Triplett has since taken over the small-memory banner
 with his `Linux kernel tinification <https://tiny.wiki.kernel.org/>`__
 project, which resulted in `SRCU <#Sleepable%20RCU>`__ becoming optional
@@ -1624,7 +1623,7 @@ against mishaps and misuse:
    init_rcu_head() and cleaned up with destroy_rcu_head().
    Mathieu Desnoyers made me aware of this requirement, and also
    supplied the needed
-   `patch <https://lkml.kernel.org/g/20100319013024.GA28456@Krystal>`__.
+   `patch <https://lore.kernel.org/r/20100319013024.GA28456@Krystal>`__.
 #. An infinite loop in an RCU read-side critical section will eventually
    trigger an RCU CPU stall warning splat, with the duration of
    =E2=80=9Ceventually=E2=80=9D being controlled by the ``RCU_CPU_STALL_TIME=
OUT``
@@ -1716,7 +1715,7 @@ requires almost all of them be hidden behind a ``CONFIG=
_RCU_EXPERT``
=20
 This all should be quite obvious, but the fact remains that Linus
 Torvalds recently had to
-`remind <https://lkml.kernel.org/g/CA+55aFy4wcCwaL4okTs8wXhGZ5h-ibecy_Meg9C4=
MNQrUnwMcg@mail.gmail.com>`__
+`remind <https://lore.kernel.org/r/CA+55aFy4wcCwaL4okTs8wXhGZ5h-ibecy_Meg9C4=
MNQrUnwMcg@mail.gmail.com>`__
 me of this requirement.
=20
 Firmware Interface
@@ -1837,9 +1836,9 @@ NMI handlers.
=20
 The name notwithstanding, some Linux-kernel architectures can have
 nested NMIs, which RCU must handle correctly. Andy Lutomirski `surprised
-me <https://lkml.kernel.org/r/CALCETrXLq1y7e_dKFPgou-FKHB6Pu-r8+t-6Ds+8=3Dva=
7anBWDA@mail.gmail.com>`__
+me <https://lore.kernel.org/r/CALCETrXLq1y7e_dKFPgou-FKHB6Pu-r8+t-6Ds+8=3Dva=
7anBWDA@mail.gmail.com>`__
 with this requirement; he also kindly surprised me with `an
-algorithm <https://lkml.kernel.org/r/CALCETrXSY9JpW3uE6H8WYk81sg56qasA2aqmjM=
Psq5dOtzso=3Dg@mail.gmail.com>`__
+algorithm <https://lore.kernel.org/r/CALCETrXSY9JpW3uE6H8WYk81sg56qasA2aqmjM=
Psq5dOtzso=3Dg@mail.gmail.com>`__
 that meets this requirement.
=20
 Furthermore, NMI handlers can be interrupted by what appear to RCU to be
@@ -2264,7 +2263,7 @@ more extreme measures. Returning to the ``page`` struct=
ure, the
 ``rcu_head`` field shares storage with a great many other structures
 that are used at various points in the corresponding page's lifetime. In
 order to correctly resolve certain `race
-conditions <https://lkml.kernel.org/g/1439976106-137226-1-git-send-email-kir=
ill.shutemov@linux.intel.com>`__,
+conditions <https://lore.kernel.org/r/1439976106-137226-1-git-send-email-kir=
ill.shutemov@linux.intel.com>`__,
 the Linux kernel's memory-management subsystem needs a particular bit to
 remain zero during all phases of grace-period processing, and that bit
 happens to map to the bottom bit of the ``rcu_head`` structure's
@@ -2328,7 +2327,7 @@ preempted. This requirement made its presence known aft=
er users made it
 clear that an earlier `real-time
 patch <https://lwn.net/Articles/107930/>`__ did not meet their needs, in
 conjunction with some `RCU
-issues <https://lkml.kernel.org/g/20050318002026.GA2693@us.ibm.com>`__
+issues <https://lore.kernel.org/r/20050318002026.GA2693@us.ibm.com>`__
 encountered by a very early version of the -rt patchset.
=20
 In addition, RCU must make do with a sub-100-microsecond real-time
diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index bb7128e..2d1dc1d 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -70,7 +70,7 @@ over a rather long period of time, but improvements are alw=
ays welcome!
 	is less readable and prevents lockdep from detecting locking issues.
=20
 	Letting RCU-protected pointers "leak" out of an RCU read-side
-	critical section is every bid as bad as letting them leak out
+	critical section is every bit as bad as letting them leak out
 	from under a lock.  Unless, of course, you have arranged some
 	other means of protection, such as a lock or a reference count
 	-before- letting them out of the RCU read-side critical section.
@@ -129,9 +129,7 @@ over a rather long period of time, but improvements are a=
lways welcome!
 		accesses.  The rcu_dereference() primitive ensures that
 		the CPU picks up the pointer before it picks up the data
 		that the pointer points to.  This really is necessary
-		on Alpha CPUs.	If you don't believe me, see:
-
-			http://www.openvms.compaq.com/wizard/wiz_2637.html
+		on Alpha CPUs.
=20
 		The rcu_dereference() primitive is also an excellent
 		documentation aid, letting the person reading the
@@ -216,7 +214,7 @@ over a rather long period of time, but improvements are a=
lways welcome!
 7.	As of v4.20, a given kernel implements only one RCU flavor,
 	which is RCU-sched for PREEMPT=3Dn and RCU-preempt for PREEMPT=3Dy.
 	If the updater uses call_rcu() or synchronize_rcu(),
-	then the corresponding readers my use rcu_read_lock() and
+	then the corresponding readers may use rcu_read_lock() and
 	rcu_read_unlock(), rcu_read_lock_bh() and rcu_read_unlock_bh(),
 	or any pair of primitives that disables and re-enables preemption,
 	for example, rcu_read_lock_sched() and rcu_read_unlock_sched().
