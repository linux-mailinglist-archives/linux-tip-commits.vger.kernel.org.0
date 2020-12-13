Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBAD2D8F9E
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390810AbgLMTCp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389883AbgLMTC3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2756C0611C5;
        Sun, 13 Dec 2020 11:01:06 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886065;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xc8c0J7TIMfKYXkIM1dKgjXLPKmxRqSqITG4PfD4hiE=;
        b=jrR4rKBmm+oXMUvLNoW4KYuOWLOUXAU4A164C5kTWy/o+5jvz3Ol9pl/ijHPF6y2x4E4Ub
        aKViQR1OWsU8S8VZk+wnBEIXPV3NdU7TDA7OXddBOhMOiwBf42Add4IXUQCZfZBuVlxKTm
        Ue01q6MAHLwTD41yypHCDTnJIEmTMwXJNtOBsnHGCOHN81B9p0VVDcyLMTPOILuVtbAnCc
        hLTsoJYp8qhAV6f5oWCcIcsqApL3jKAfoUGAv5prkxuzLSZwf4+p5miK30IZXTZrRyS7E6
        iZpMaFLxnZsol/+q74WWKVUTxyOmSYwwzJiFLR8rjJsat6x+mzJY5irosHT7PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886065;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xc8c0J7TIMfKYXkIM1dKgjXLPKmxRqSqITG4PfD4hiE=;
        b=zB4mkphYZazp1+8QOj1d85573Ajzmiv1p6bDhdonIkh1sm2XE6yoz0AU3LkRhfWSMPQw8w
        sr5slLa6/2E+b3Dg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] tools/memory-model: Add a glossary of LKMM terms
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606488.3364.12585060638080343395.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     0a27ce6b6968866fa8e3bd70371d67752db7718f
Gitweb:        https://git.kernel.org/tip/0a27ce6b6968866fa8e3bd70371d67752db7718f
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 22 Oct 2020 15:16:08 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:24:53 -08:00

tools/memory-model: Add a glossary of LKMM terms

[ paulmck: Apply Alan Stern feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/glossary.txt | 172 +++++++++++++++++-
 1 file changed, 172 insertions(+)
 create mode 100644 tools/memory-model/Documentation/glossary.txt

diff --git a/tools/memory-model/Documentation/glossary.txt b/tools/memory-model/Documentation/glossary.txt
new file mode 100644
index 0000000..79acb75
--- /dev/null
+++ b/tools/memory-model/Documentation/glossary.txt
@@ -0,0 +1,172 @@
+This document contains brief definitions of LKMM-related terms.  Like most
+glossaries, it is not intended to be read front to back (except perhaps
+as a way of confirming a diagnosis of OCD), but rather to be searched
+for specific terms.
+
+
+Address Dependency:  When the address of a later memory access is computed
+	based on the value returned by an earlier load, an "address
+	dependency" extends from that load extending to the later access.
+	Address dependencies are quite common in RCU read-side critical
+	sections:
+
+	 1 rcu_read_lock();
+	 2 p = rcu_dereference(gp);
+	 3 do_something(p->a);
+	 4 rcu_read_unlock();
+
+	 In this case, because the address of "p->a" on line 3 is computed
+	 from the value returned by the rcu_dereference() on line 2, the
+	 address dependency extends from that rcu_dereference() to that
+	 "p->a".  In rare cases, optimizing compilers can destroy address
+	 dependencies.	Please see Documentation/RCU/rcu_dereference.txt
+	 for more information.
+
+	 See also "Control Dependency" and "Data Dependency".
+
+Acquire:  With respect to a lock, acquiring that lock, for example,
+	using spin_lock().  With respect to a non-lock shared variable,
+	a special operation that includes a load and which orders that
+	load before later memory references running on that same CPU.
+	An example special acquire operation is smp_load_acquire(),
+	but atomic_read_acquire() and atomic_xchg_acquire() also include
+	acquire loads.
+
+	When an acquire load returns the value stored by a release store
+	to that same variable, then all operations preceding that store
+	happen before any operations following that load acquire.
+
+	See also "Relaxed" and "Release".
+
+Coherence (co):  When one CPU's store to a given variable overwrites
+	either the value from another CPU's store or some later value,
+	there is said to be a coherence link from the second CPU to
+	the first.
+
+	It is also possible to have a coherence link within a CPU, which
+	is a "coherence internal" (coi) link.  The term "coherence
+	external" (coe) link is used when it is necessary to exclude
+	the coi case.
+
+	See also "From-reads" and "Reads-from".
+
+Control Dependency:  When a later store's execution depends on a test
+	of a value computed from a value returned by an earlier load,
+	a "control dependency" extends from that load to that store.
+	For example:
+
+	 1 if (READ_ONCE(x))
+	 2   WRITE_ONCE(y, 1);
+
+	 Here, the control dependency extends from the READ_ONCE() on
+	 line 1 to the WRITE_ONCE() on line 2.	Control dependencies are
+	 fragile, and can be easily destroyed by optimizing compilers.
+	 Please see control-dependencies.txt for more information.
+
+	 See also "Address Dependency" and "Data Dependency".
+
+Cycle:	Memory-barrier pairing is restricted to a pair of CPUs, as the
+	name suggests.	And in a great many cases, a pair of CPUs is all
+	that is required.  In other cases, the notion of pairing must be
+	extended to additional CPUs, and the result is called a "cycle".
+	In a cycle, each CPU's ordering interacts with that of the next:
+
+	CPU 0                CPU 1                CPU 2
+	WRITE_ONCE(x, 1);    WRITE_ONCE(y, 1);    WRITE_ONCE(z, 1);
+	smp_mb();            smp_mb();            smp_mb();
+	r0 = READ_ONCE(y);   r1 = READ_ONCE(z);   r2 = READ_ONCE(x);
+
+	CPU 0's smp_mb() interacts with that of CPU 1, which interacts
+	with that of CPU 2, which in turn interacts with that of CPU 0
+	to complete the cycle.	Because of the smp_mb() calls between
+	each pair of memory accesses, the outcome where r0, r1, and r2
+	are all equal to zero is forbidden by LKMM.
+
+	See also "Pairing".
+
+Data Dependency:  When the data written by a later store is computed based
+	on the value returned by an earlier load, a "data dependency"
+	extends from that load to that later store.  For example:
+
+	 1 r1 = READ_ONCE(x);
+	 2 WRITE_ONCE(y, r1 + 1);
+
+	In this case, the data dependency extends from the READ_ONCE()
+	on line 1 to the WRITE_ONCE() on line 2.  Data dependencies are
+	fragile and can be easily destroyed by optimizing compilers.
+	Because optimizing compilers put a great deal of effort into
+	working out what values integer variables might have, this is
+	especially true in cases where the dependency is carried through
+	an integer.
+
+	See also "Address Dependency" and "Control Dependency".
+
+From-Reads (fr):  When one CPU's store to a given variable happened
+	too late to affect the value returned by another CPU's
+	load from that same variable, there is said to be a from-reads
+	link from the load to the store.
+
+	It is also possible to have a from-reads link within a CPU, which
+	is a "from-reads internal" (fri) link.  The term "from-reads
+	external" (fre) link is used when it is necessary to exclude
+	the fri case.
+
+	See also "Coherence" and "Reads-from".
+
+Fully Ordered:  An operation such as smp_mb() that orders all of
+	its CPU's prior accesses with all of that CPU's subsequent
+	accesses, or a marked access such as atomic_add_return()
+	that orders all of its CPU's prior accesses, itself, and
+	all of its CPU's subsequent accesses.
+
+Marked Access:  An access to a variable that uses an special function or
+	macro such as "r1 = READ_ONCE(x)" or "smp_store_release(&a, 1)".
+
+	See also "Unmarked Access".
+
+Pairing: "Memory-barrier pairing" reflects the fact that synchronizing
+	data between two CPUs requires that both CPUs their accesses.
+	Memory barriers thus tend to come in pairs, one executed by
+	one of the CPUs and the other by the other CPU.  Of course,
+	pairing also occurs with other types of operations, so that a
+	smp_store_release() pairs with an smp_load_acquire() that reads
+	the value stored.
+
+	See also "Cycle".
+
+Reads-From (rf):  When one CPU's load returns the value stored by some other
+	CPU, there is said to be a reads-from link from the second
+	CPU's store to the first CPU's load.  Reads-from links have the
+	nice property that time must advance from the store to the load,
+	which means that algorithms using reads-from links can use lighter
+	weight ordering and synchronization compared to algorithms using
+	coherence and from-reads links.
+
+	It is also possible to have a reads-from link within a CPU, which
+	is a "reads-from internal" (rfi) link.	The term "reads-from
+	external" (rfe) link is used when it is necessary to exclude
+	the rfi case.
+
+	See also Coherence" and "From-reads".
+
+Relaxed:  A marked access that does not imply ordering, for example, a
+	READ_ONCE(), WRITE_ONCE(), a non-value-returning read-modify-write
+	operation, or a value-returning read-modify-write operation whose
+	name ends in "_relaxed".
+
+	See also "Acquire" and "Release".
+
+Release:  With respect to a lock, releasing that lock, for example,
+	using spin_unlock().  With respect to a non-lock shared variable,
+	a special operation that includes a store and which orders that
+	store after earlier memory references that ran on that same CPU.
+	An example special release store is smp_store_release(), but
+	atomic_set_release() and atomic_cmpxchg_release() also include
+	release stores.
+
+	See also "Acquire" and "Relaxed".
+
+Unmarked Access:  An access to a variable that uses normal C-language
+	syntax, for example, "a = b[2]";
+
+	See also "Marked Access".
