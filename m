Return-Path: <linux-tip-commits+bounces-2175-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 448B696DD2A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Sep 2024 17:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6EBE1F2238F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Sep 2024 15:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C1619AD6C;
	Thu,  5 Sep 2024 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RE03jZml";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VVSe0CW6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0967F433A7;
	Thu,  5 Sep 2024 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548607; cv=none; b=XAjH5PPTXmvHCh8TfTAHq87BcGDnROvgV3BjXJaMyhLsE1i/+wQkjDD74UpvOZR9JQAMqgSm3Lw3ullAyEAxRpxhG+mUVO8XFlckHZV29opymjc0AnldiI4mi6UAS/FicPOFINShcYiOLiuTn/sL7dFCmkNNipKHgYn8IzfqFOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548607; c=relaxed/simple;
	bh=bsdGZvFxrG08u06o6wZPpS3CQ4lv/zjUUSA3VnRt8o8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rQnLSAlBVEFNCv0nqW22CGn0yTXO2gzH1Mm99ufqsLoCOz7PBaCvUDB3FgIqdxrVVtFCKb4WPKlbfZPdoPmTVUU6nAsqi+Y7vjzS1R6Ad5aQV41MTWJR8FOg2C8mqk9CbdnkbypckDhz7rsK45gjZ1CAvQvrzM2CDf3WcfEgmx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RE03jZml; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VVSe0CW6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Sep 2024 15:03:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725548604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1FR/P2FagHiCUhQIMUFAFbXP87//rocmbDHYi9srWds=;
	b=RE03jZmliyOE4wTXalPM2N953OfdZg/lmv8aKjw5P0ZKGwfmR17qog/TapfdIRYZvAN1fk
	k7G/rw9rODN6PG2t+auSCF0l32ZhISAMy1ss5H+QJl57L7blU9Gngdl/I75vZ7w/SKupv9
	lMkho27yi0zHdpp5gNsT514z1rIcQVzZVLl+F2OhZuIfG23irr8YGgdSr+eRIhhGeET3Ce
	2acgMHCO9k9jlL4skbqp9Zpe+wYXlL3XNlcVolvZbRbEY7JeZO2eeIUkvQ8xgapboBX2iB
	svNIBL4yIaUpfDrFXBx/6YStIw6ahgZsI5aiB6WZeA5NfaWxgWYa5nqKiLpkcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725548604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1FR/P2FagHiCUhQIMUFAFbXP87//rocmbDHYi9srWds=;
	b=VVSe0CW6xQf+Jej3CAC/tq9iC3Dtww2+kAsPY1rGYAet8XlL9v60x8CpWJBUBRGRWWkcHP
	K/2YM1gU7kdOTCDA==
From: "tip-bot2 for Andrii Nakryiko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: switch to RCU Tasks Trace flavor for better
 performance
Cc: Andrii Nakryiko <andrii@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240903174603.3554182-9-andrii@kernel.org>
References: <20240903174603.3554182-9-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172554860322.2215.10385397228202759078.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c4d4569c41f9cda745cfd1d8089ea3d3526bafe5
Gitweb:        https://git.kernel.org/tip/c4d4569c41f9cda745cfd1d8089ea3d3526=
bafe5
Author:        Andrii Nakryiko <andrii@kernel.org>
AuthorDate:    Tue, 03 Sep 2024 10:46:03 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 05 Sep 2024 16:56:15 +02:00

uprobes: switch to RCU Tasks Trace flavor for better performance

This patch switches uprobes SRCU usage to RCU Tasks Trace flavor, which
is optimized for more lightweight and quick readers (at the expense of
slower writers, which for uprobes is a fine tradeof) and has better
performance and scalability with number of CPUs.

Similarly to baseline vs SRCU, we've benchmarked SRCU-based
implementation vs RCU Tasks Trace implementation.

SRCU
=3D=3D=3D=3D
uprobe-nop      ( 1 cpus):    3.276 =C2=B1 0.005M/s  (  3.276M/s/cpu)
uprobe-nop      ( 2 cpus):    4.125 =C2=B1 0.002M/s  (  2.063M/s/cpu)
uprobe-nop      ( 4 cpus):    7.713 =C2=B1 0.002M/s  (  1.928M/s/cpu)
uprobe-nop      ( 8 cpus):    8.097 =C2=B1 0.006M/s  (  1.012M/s/cpu)
uprobe-nop      (16 cpus):    6.501 =C2=B1 0.056M/s  (  0.406M/s/cpu)
uprobe-nop      (32 cpus):    4.398 =C2=B1 0.084M/s  (  0.137M/s/cpu)
uprobe-nop      (64 cpus):    6.452 =C2=B1 0.000M/s  (  0.101M/s/cpu)

uretprobe-nop   ( 1 cpus):    2.055 =C2=B1 0.001M/s  (  2.055M/s/cpu)
uretprobe-nop   ( 2 cpus):    2.677 =C2=B1 0.000M/s  (  1.339M/s/cpu)
uretprobe-nop   ( 4 cpus):    4.561 =C2=B1 0.003M/s  (  1.140M/s/cpu)
uretprobe-nop   ( 8 cpus):    5.291 =C2=B1 0.002M/s  (  0.661M/s/cpu)
uretprobe-nop   (16 cpus):    5.065 =C2=B1 0.019M/s  (  0.317M/s/cpu)
uretprobe-nop   (32 cpus):    3.622 =C2=B1 0.003M/s  (  0.113M/s/cpu)
uretprobe-nop   (64 cpus):    3.723 =C2=B1 0.002M/s  (  0.058M/s/cpu)

RCU Tasks Trace
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
uprobe-nop      ( 1 cpus):    3.396 =C2=B1 0.002M/s  (  3.396M/s/cpu)
uprobe-nop      ( 2 cpus):    4.271 =C2=B1 0.006M/s  (  2.135M/s/cpu)
uprobe-nop      ( 4 cpus):    8.499 =C2=B1 0.015M/s  (  2.125M/s/cpu)
uprobe-nop      ( 8 cpus):   10.355 =C2=B1 0.028M/s  (  1.294M/s/cpu)
uprobe-nop      (16 cpus):    7.615 =C2=B1 0.099M/s  (  0.476M/s/cpu)
uprobe-nop      (32 cpus):    4.430 =C2=B1 0.007M/s  (  0.138M/s/cpu)
uprobe-nop      (64 cpus):    6.887 =C2=B1 0.020M/s  (  0.108M/s/cpu)

uretprobe-nop   ( 1 cpus):    2.174 =C2=B1 0.001M/s  (  2.174M/s/cpu)
uretprobe-nop   ( 2 cpus):    2.853 =C2=B1 0.001M/s  (  1.426M/s/cpu)
uretprobe-nop   ( 4 cpus):    4.913 =C2=B1 0.002M/s  (  1.228M/s/cpu)
uretprobe-nop   ( 8 cpus):    5.883 =C2=B1 0.002M/s  (  0.735M/s/cpu)
uretprobe-nop   (16 cpus):    5.147 =C2=B1 0.001M/s  (  0.322M/s/cpu)
uretprobe-nop   (32 cpus):    3.738 =C2=B1 0.008M/s  (  0.117M/s/cpu)
uretprobe-nop   (64 cpus):    4.397 =C2=B1 0.002M/s  (  0.069M/s/cpu)

Peak throughput for uprobes increases from 8 mln/s to 10.3 mln/s
(+28%!), and for uretprobes from 5.3 mln/s to 5.8 mln/s (+11%), as we
have more work to do on uretprobes side.

Even single-thread (no contention) performance is slightly better: 3.276
mln/s to 3.396 mln/s (+3.5%) for uprobes, and 2.055 mln/s to 2.174 mln/s
(+5.8%) for uretprobes.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20240903174603.3554182-9-andrii@kernel.org
---
 kernel/events/uprobes.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4b7e590..a2e6a57 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -26,6 +26,7 @@
 #include <linux/task_work.h>
 #include <linux/shmem_fs.h>
 #include <linux/khugepaged.h>
+#include <linux/rcupdate_trace.h>
=20
 #include <linux/uprobes.h>
=20
@@ -42,8 +43,6 @@ static struct rb_root uprobes_tree =3D RB_ROOT;
 static DEFINE_RWLOCK(uprobes_treelock);	/* serialize rbtree access */
 static seqcount_rwlock_t uprobes_seqcount =3D SEQCNT_RWLOCK_ZERO(uprobes_seq=
count, &uprobes_treelock);
=20
-DEFINE_STATIC_SRCU(uprobes_srcu);
-
 #define UPROBES_HASH_SZ	13
 /* serialize uprobe->pending_list */
 static struct mutex uprobes_mmap_mutex[UPROBES_HASH_SZ];
@@ -652,7 +651,7 @@ static void put_uprobe(struct uprobe *uprobe)
 	delayed_uprobe_remove(uprobe, NULL);
 	mutex_unlock(&delayed_uprobe_lock);
=20
-	call_srcu(&uprobes_srcu, &uprobe->rcu, uprobe_free_rcu);
+	call_rcu_tasks_trace(&uprobe->rcu, uprobe_free_rcu);
 }
=20
 static __always_inline
@@ -707,7 +706,7 @@ static struct uprobe *find_uprobe_rcu(struct inode *inode=
, loff_t offset)
 	struct rb_node *node;
 	unsigned int seq;
=20
-	lockdep_assert(srcu_read_lock_held(&uprobes_srcu));
+	lockdep_assert(rcu_read_lock_trace_held());
=20
 	do {
 		seq =3D read_seqcount_begin(&uprobes_seqcount);
@@ -935,8 +934,7 @@ static bool filter_chain(struct uprobe *uprobe, struct mm=
_struct *mm)
 	bool ret =3D false;
=20
 	down_read(&uprobe->consumer_rwsem);
-	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
-				 srcu_read_lock_held(&uprobes_srcu)) {
+	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_tr=
ace_held()) {
 		ret =3D consumer_filter(uc, mm);
 		if (ret)
 			break;
@@ -1157,7 +1155,7 @@ void uprobe_unregister_sync(void)
 	 * unlucky enough caller can free consumer's memory and cause
 	 * handler_chain() or handle_uretprobe_chain() to do an use-after-free.
 	 */
-	synchronize_srcu(&uprobes_srcu);
+	synchronize_rcu_tasks_trace();
 }
 EXPORT_SYMBOL_GPL(uprobe_unregister_sync);
=20
@@ -1241,19 +1239,18 @@ EXPORT_SYMBOL_GPL(uprobe_register);
 int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool add)
 {
 	struct uprobe_consumer *con;
-	int ret =3D -ENOENT, srcu_idx;
+	int ret =3D -ENOENT;
=20
 	down_write(&uprobe->register_rwsem);
=20
-	srcu_idx =3D srcu_read_lock(&uprobes_srcu);
-	list_for_each_entry_srcu(con, &uprobe->consumers, cons_node,
-				 srcu_read_lock_held(&uprobes_srcu)) {
+	rcu_read_lock_trace();
+	list_for_each_entry_rcu(con, &uprobe->consumers, cons_node, rcu_read_lock_t=
race_held()) {
 		if (con =3D=3D uc) {
 			ret =3D register_for_each_vma(uprobe, add ? uc : NULL);
 			break;
 		}
 	}
-	srcu_read_unlock(&uprobes_srcu, srcu_idx);
+	rcu_read_unlock_trace();
=20
 	up_write(&uprobe->register_rwsem);
=20
@@ -2123,8 +2120,7 @@ static void handler_chain(struct uprobe *uprobe, struct=
 pt_regs *regs)
=20
 	current->utask->auprobe =3D &uprobe->arch;
=20
-	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
-				 srcu_read_lock_held(&uprobes_srcu)) {
+	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_tr=
ace_held()) {
 		int rc =3D 0;
=20
 		if (uc->handler) {
@@ -2162,15 +2158,13 @@ handle_uretprobe_chain(struct return_instance *ri, st=
ruct pt_regs *regs)
 {
 	struct uprobe *uprobe =3D ri->uprobe;
 	struct uprobe_consumer *uc;
-	int srcu_idx;
=20
-	srcu_idx =3D srcu_read_lock(&uprobes_srcu);
-	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
-				 srcu_read_lock_held(&uprobes_srcu)) {
+	rcu_read_lock_trace();
+	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_tr=
ace_held()) {
 		if (uc->ret_handler)
 			uc->ret_handler(uc, ri->func, regs);
 	}
-	srcu_read_unlock(&uprobes_srcu, srcu_idx);
+	rcu_read_unlock_trace();
 }
=20
 static struct return_instance *find_next_ret_chain(struct return_instance *r=
i)
@@ -2255,13 +2249,13 @@ static void handle_swbp(struct pt_regs *regs)
 {
 	struct uprobe *uprobe;
 	unsigned long bp_vaddr;
-	int is_swbp, srcu_idx;
+	int is_swbp;
=20
 	bp_vaddr =3D uprobe_get_swbp_addr(regs);
 	if (bp_vaddr =3D=3D uprobe_get_trampoline_vaddr())
 		return uprobe_handle_trampoline(regs);
=20
-	srcu_idx =3D srcu_read_lock(&uprobes_srcu);
+	rcu_read_lock_trace();
=20
 	uprobe =3D find_active_uprobe_rcu(bp_vaddr, &is_swbp);
 	if (!uprobe) {
@@ -2319,7 +2313,7 @@ static void handle_swbp(struct pt_regs *regs)
=20
 out:
 	/* arch_uprobe_skip_sstep() succeeded, or restart if can't singlestep */
-	srcu_read_unlock(&uprobes_srcu, srcu_idx);
+	rcu_read_unlock_trace();
 }
=20
 /*

