Return-Path: <linux-tip-commits+bounces-2174-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245D396DD29
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Sep 2024 17:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A1D1C23765
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Sep 2024 15:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF58D198E84;
	Thu,  5 Sep 2024 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zKcZ/PAP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ywUMC9xb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096B945025;
	Thu,  5 Sep 2024 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548607; cv=none; b=O+mRMpPL+P6BbeViWpFqFAOXo3Di6Scih77v6DbPlwMbuyxrBWrEHFMQDWytPwRBCPXhk+sroiJmIKQz0pa6WKCNvmcuLmtT6CwBRB9GlLC6ACyaJeKWeCXUUISLw66KdMG2SdJjSiL4niecsybdWDIO6HYhc5f5QXkr+mcd37s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548607; c=relaxed/simple;
	bh=K5/31oiAfX9HDI9NiTBAs+HlERD0LGNCJ9tQgWGCgLg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=G2QZKmNGWr5bjyqaGBSuUD6pFUoj4pBE+64wGIjRHhv666qWBp0djAnawMWCMWTOsNZCdtySL8N4nBc7A827jMEzHXmlfck88rrYfwlyPptjyjZJID1dxRwf2vjrBYw4kCDLqh6InmNU6SRpZMKRv82EPqWtpxlShV5nq4+y9hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zKcZ/PAP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ywUMC9xb; arc=none smtp.client-ip=193.142.43.55
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
	bh=zX5O/rEjVPLfDUlMS5inQdXQ/+GLE8jA9xIe9D+qVik=;
	b=zKcZ/PAPVrYt31ep2fPDN2YCm/Mv5agx+LCC81aDavS7i1AGkWKORTOnQ4UZboa4qfaPOs
	riwj6Vd1+uF2tbuNhKjDGbHHWJYmQZAgjmsVIEiRJIoq+OQ7/NxwJzHxChFCnYI7Ay2Q4Y
	7ZpOmjC3+OdrX9ixSqLqq085c2/Xx+fxgFMsBTY3ua46umzINYgPV1n540OP3XbltJx+eJ
	fx3suGYbxgpSatZuh8nsTimTVtVKZp6kfT34HsdZWk22rNK6leetsatuixV8lsnP1I+Li3
	n7o62zYPfXNzgiZ3qMyVPeFjxmiQLhROxAk366utrFqkgTusGZ+XSBUi+1mQKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725548604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zX5O/rEjVPLfDUlMS5inQdXQ/+GLE8jA9xIe9D+qVik=;
	b=ywUMC9xbnaIgiJs2TH10iAoPGBp+kTlJixdbzslfKSqlfh/wS9/ZV98ZmdrVTjNT3cn6Ic
	HMx3y5TaU9gBRSCw==
From: "tip-bot2 for Andrii Nakryiko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] uprobes: perform lockless SRCU-protected uprobes_tree lookup
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240903174603.3554182-8-andrii@kernel.org>
References: <20240903174603.3554182-8-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172554860388.2215.7049622728712709922.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     cd7bdd9d46a9540f3a20a0e14c99aa37b2d4a1dd
Gitweb:        https://git.kernel.org/tip/cd7bdd9d46a9540f3a20a0e14c99aa37b2d=
4a1dd
Author:        Andrii Nakryiko <andrii@kernel.org>
AuthorDate:    Tue, 03 Sep 2024 10:46:02 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 05 Sep 2024 16:56:15 +02:00

uprobes: perform lockless SRCU-protected uprobes_tree lookup

Another big bottleneck to scalablity is uprobe_treelock that's taken in
a very hot path in handle_swbp(). Now that uprobes are SRCU-protected,
take advantage of that and make uprobes_tree RB-tree look up lockless.

To make RB-tree RCU-protected lockless lookup correct, we need to take
into account that such RB-tree lookup can return false negatives if there
are parallel RB-tree modifications (rotations) going on. We use seqcount
lock to detect whether RB-tree changed, and if we find nothing while
RB-tree got modified inbetween, we just retry. If uprobe was found, then
it's guaranteed to be a correct lookup.

With all the lock-avoiding changes done, we get a pretty decent
improvement in performance and scalability of uprobes with number of
CPUs, even though we are still nowhere near linear scalability. This is
due to SRCU not really scaling very well with number of CPUs on
a particular hardware that was used for testing (80-core Intel Xeon Gold
6138 CPU @ 2.00GHz), but also due to the remaning mmap_lock, which is
currently taken to resolve interrupt address to inode+offset and then
uprobe instance. And, of course, uretprobes still need similar RCU to
avoid refcount in the hot path, which will be addressed in the follow up
patches.

Nevertheless, the improvement is good. We used BPF selftest-based
uprobe-nop and uretprobe-nop benchmarks to get the below numbers,
varying number of CPUs on which uprobes and uretprobes are triggered.

BASELINE
=3D=3D=3D=3D=3D=3D=3D=3D
uprobe-nop      ( 1 cpus):    3.032 =C2=B1 0.023M/s  (  3.032M/s/cpu)
uprobe-nop      ( 2 cpus):    3.452 =C2=B1 0.005M/s  (  1.726M/s/cpu)
uprobe-nop      ( 4 cpus):    3.663 =C2=B1 0.005M/s  (  0.916M/s/cpu)
uprobe-nop      ( 8 cpus):    3.718 =C2=B1 0.038M/s  (  0.465M/s/cpu)
uprobe-nop      (16 cpus):    3.344 =C2=B1 0.008M/s  (  0.209M/s/cpu)
uprobe-nop      (32 cpus):    2.288 =C2=B1 0.021M/s  (  0.071M/s/cpu)
uprobe-nop      (64 cpus):    3.205 =C2=B1 0.004M/s  (  0.050M/s/cpu)

uretprobe-nop   ( 1 cpus):    1.979 =C2=B1 0.005M/s  (  1.979M/s/cpu)
uretprobe-nop   ( 2 cpus):    2.361 =C2=B1 0.005M/s  (  1.180M/s/cpu)
uretprobe-nop   ( 4 cpus):    2.309 =C2=B1 0.002M/s  (  0.577M/s/cpu)
uretprobe-nop   ( 8 cpus):    2.253 =C2=B1 0.001M/s  (  0.282M/s/cpu)
uretprobe-nop   (16 cpus):    2.007 =C2=B1 0.000M/s  (  0.125M/s/cpu)
uretprobe-nop   (32 cpus):    1.624 =C2=B1 0.003M/s  (  0.051M/s/cpu)
uretprobe-nop   (64 cpus):    2.149 =C2=B1 0.001M/s  (  0.034M/s/cpu)

SRCU CHANGES
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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

Peak througput increased from 3.7 mln/s (uprobe triggerings) up to about
8 mln/s. For uretprobes it's a bit more modest with bump from 2.4 mln/s
to 5mln/s.

Suggested-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20240903174603.3554182-8-andrii@kernel.org
---
 kernel/events/uprobes.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 694f679..4b7e590 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -40,6 +40,7 @@ static struct rb_root uprobes_tree =3D RB_ROOT;
 #define no_uprobe_events()	RB_EMPTY_ROOT(&uprobes_tree)
=20
 static DEFINE_RWLOCK(uprobes_treelock);	/* serialize rbtree access */
+static seqcount_rwlock_t uprobes_seqcount =3D SEQCNT_RWLOCK_ZERO(uprobes_seq=
count, &uprobes_treelock);
=20
 DEFINE_STATIC_SRCU(uprobes_srcu);
=20
@@ -634,8 +635,11 @@ static void put_uprobe(struct uprobe *uprobe)
=20
 	write_lock(&uprobes_treelock);
=20
-	if (uprobe_is_active(uprobe))
+	if (uprobe_is_active(uprobe)) {
+		write_seqcount_begin(&uprobes_seqcount);
 		rb_erase(&uprobe->rb_node, &uprobes_tree);
+		write_seqcount_end(&uprobes_seqcount);
+	}
=20
 	write_unlock(&uprobes_treelock);
=20
@@ -701,14 +705,26 @@ static struct uprobe *find_uprobe_rcu(struct inode *ino=
de, loff_t offset)
 		.offset =3D offset,
 	};
 	struct rb_node *node;
+	unsigned int seq;
=20
 	lockdep_assert(srcu_read_lock_held(&uprobes_srcu));
=20
-	read_lock(&uprobes_treelock);
-	node =3D rb_find(&key, &uprobes_tree, __uprobe_cmp_key);
-	read_unlock(&uprobes_treelock);
+	do {
+		seq =3D read_seqcount_begin(&uprobes_seqcount);
+		node =3D rb_find_rcu(&key, &uprobes_tree, __uprobe_cmp_key);
+		/*
+		 * Lockless RB-tree lookups can result only in false negatives.
+		 * If the element is found, it is correct and can be returned
+		 * under RCU protection. If we find nothing, we need to
+		 * validate that seqcount didn't change. If it did, we have to
+		 * try again as we might have missed the element (false
+		 * negative). If seqcount is unchanged, search truly failed.
+		 */
+		if (node)
+			return __node_2_uprobe(node);
+	} while (read_seqcount_retry(&uprobes_seqcount, seq));
=20
-	return node ? __node_2_uprobe(node) : NULL;
+	return NULL;
 }
=20
 /*
@@ -730,7 +746,7 @@ static struct uprobe *__insert_uprobe(struct uprobe *upro=
be)
 {
 	struct rb_node *node;
 again:
-	node =3D rb_find_add(&uprobe->rb_node, &uprobes_tree, __uprobe_cmp);
+	node =3D rb_find_add_rcu(&uprobe->rb_node, &uprobes_tree, __uprobe_cmp);
 	if (node) {
 		struct uprobe *u =3D __node_2_uprobe(node);
=20
@@ -755,7 +771,9 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
 	struct uprobe *u;
=20
 	write_lock(&uprobes_treelock);
+	write_seqcount_begin(&uprobes_seqcount);
 	u =3D __insert_uprobe(uprobe);
+	write_seqcount_end(&uprobes_seqcount);
 	write_unlock(&uprobes_treelock);
=20
 	return u;

