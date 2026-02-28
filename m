Return-Path: <linux-tip-commits+bounces-8290-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOyxKHoLo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8290-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:36:26 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 765421C3FD8
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DDBE830711E6
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB2947CC96;
	Sat, 28 Feb 2026 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H3S2kH8E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E+VnL/hB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DA147CC73;
	Sat, 28 Feb 2026 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292979; cv=none; b=lhrbjFmaOkLilSYMyB0VPs7kuvUACrLHRnXB0Yc0DA6I5J5onaQyZSc0dGXVhs0M53fsNSFiPXSyc0q1FOwsOZkRHTWUhAF4EYd464CqIe4bfSs1OIJ/UlGBQbDrE4AXoj8caVufMVJw41urqMS7eeSxOkovu8W4REcyX+A3yj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292979; c=relaxed/simple;
	bh=VNTmgVE0pljMFx7IL0p8CPanQbz3UB4rmmfZAVvhBSk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QRXoLD3L9SpMHWLhyMGOyfh+pr9D1C5wRsiJSCvgaERltWvK04dTkEk+KmXGr4QDtjjCjveyh4lVrhd6Vd2DdMY3xDU8+uaLeMKkuhyeduZEm2tXlf6/Z+P6IyRbs33evYBwWFQFg0B+q7EOQE7yMmLrng5Jj2DzLeJpTCG11CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H3S2kH8E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E+VnL/hB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772292976;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tWAGiOvgfzG8Htf1u6sJ3pC9CdsRmIEALpOSQccdxQs=;
	b=H3S2kH8EtYhNYkm1iHnMUUCV7d+7xjJ6lAtAferMh+6/453C1DSxqeZwjhQ7+yog+5Goiu
	5xrx8njqA0AT6zM1rKseH5PJmeN/z0DccvtCKo2wdGoYX9CpWp1fp1tSIX4N+3cYptya7S
	9HhuAsdkPPzfGsg3ahaBztkF6u1Dc1jWDV50WYFS/rCLgAqGDJn1XOl8xeHztbf8pLncSJ
	5iUMj3YoYvXx+Qw/DxYkc6MHLsv01CyI+XpkWnHkHxbwo08pv8ga5IIlBdD0IMvok1IXhL
	6w2Vhry4CptMDiKliVa2tQvH+IYKdOXtp9457qV/+4KwK2HXYxSrBisGfXudxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772292976;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tWAGiOvgfzG8Htf1u6sJ3pC9CdsRmIEALpOSQccdxQs=;
	b=E+VnL/hBSdCpP532U2qUt1QshozWj0dikwq5FAPFIO0qJCW8Y+OqlEXI9a/6NuT2gFWXSr
	4EAflnSB/tiTh2AA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] timerqueue: Provide linked timerqueue
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163431.734827095@kernel.org>
References: <20260224163431.734827095@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229297509.1647592.1106267273004908892.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8290-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,infradead.org:email];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 765421C3FD8
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     1339eeb73d6b99cf3aa9981f3f91d6ac4a49c72e
Gitweb:        https://git.kernel.org/tip/1339eeb73d6b99cf3aa9981f3f91d6ac4a4=
9c72e
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:38:52 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:16 +01:00

timerqueue: Provide linked timerqueue

The hrtimer subsystem wants to peak ahead to the next and previous timer to
evaluated whether a to be rearmed timer can stay at the same position in
the RB tree with the new expiry time.

The linked RB tree provides the infrastructure for this as it maintains
links to the previous and next nodes for each entry in the tree.

Provide timerqueue wrappers around that.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163431.734827095@kernel.org
---
 include/linux/timerqueue.h       | 56 ++++++++++++++++++++++++++-----
 include/linux/timerqueue_types.h | 15 ++++++--
 lib/timerqueue.c                 | 14 ++++++++-
 3 files changed, 74 insertions(+), 11 deletions(-)

diff --git a/include/linux/timerqueue.h b/include/linux/timerqueue.h
index d306d9d..7d0aaa7 100644
--- a/include/linux/timerqueue.h
+++ b/include/linux/timerqueue.h
@@ -5,12 +5,11 @@
 #include <linux/rbtree.h>
 #include <linux/timerqueue_types.h>
=20
-extern bool timerqueue_add(struct timerqueue_head *head,
-			   struct timerqueue_node *node);
-extern bool timerqueue_del(struct timerqueue_head *head,
-			   struct timerqueue_node *node);
-extern struct timerqueue_node *timerqueue_iterate_next(
-						struct timerqueue_node *node);
+bool timerqueue_add(struct timerqueue_head *head, struct timerqueue_node *no=
de);
+bool timerqueue_del(struct timerqueue_head *head, struct timerqueue_node *no=
de);
+struct timerqueue_node *timerqueue_iterate_next(struct timerqueue_node *node=
);
+
+bool timerqueue_linked_add(struct timerqueue_linked_head *head, struct timer=
queue_linked_node *node);
=20
 /**
  * timerqueue_getnext - Returns the timer with the earliest expiration time
@@ -19,8 +18,7 @@ extern struct timerqueue_node *timerqueue_iterate_next(
  *
  * Returns a pointer to the timer node that has the earliest expiration time.
  */
-static inline
-struct timerqueue_node *timerqueue_getnext(struct timerqueue_head *head)
+static inline struct timerqueue_node *timerqueue_getnext(struct timerqueue_h=
ead *head)
 {
 	struct rb_node *leftmost =3D rb_first_cached(&head->rb_root);
=20
@@ -41,4 +39,46 @@ static inline void timerqueue_init_head(struct timerqueue_=
head *head)
 {
 	head->rb_root =3D RB_ROOT_CACHED;
 }
+
+/* Timer queues with linked nodes */
+
+static __always_inline
+struct timerqueue_linked_node *timerqueue_linked_first(struct timerqueue_lin=
ked_head *head)
+{
+	return rb_entry_safe(head->rb_root.rb_leftmost, struct timerqueue_linked_no=
de, node);
+}
+
+static __always_inline
+struct timerqueue_linked_node *timerqueue_linked_next(struct timerqueue_link=
ed_node *node)
+{
+	return rb_entry_safe(node->node.next, struct timerqueue_linked_node, node);
+}
+
+static __always_inline
+struct timerqueue_linked_node *timerqueue_linked_prev(struct timerqueue_link=
ed_node *node)
+{
+	return rb_entry_safe(node->node.prev, struct timerqueue_linked_node, node);
+}
+
+static __always_inline
+bool timerqueue_linked_del(struct timerqueue_linked_head *head, struct timer=
queue_linked_node *node)
+{
+	return rb_erase_linked(&node->node, &head->rb_root);
+}
+
+static __always_inline void timerqueue_linked_init(struct timerqueue_linked_=
node *node)
+{
+	RB_CLEAR_LINKED_NODE(&node->node);
+}
+
+static __always_inline bool timerqueue_linked_node_queued(struct timerqueue_=
linked_node *node)
+{
+	return !RB_EMPTY_LINKED_NODE(&node->node);
+}
+
+static __always_inline void timerqueue_linked_init_head(struct timerqueue_li=
nked_head *head)
+{
+	head->rb_root =3D RB_ROOT_LINKED;
+}
+
 #endif /* _LINUX_TIMERQUEUE_H */
diff --git a/include/linux/timerqueue_types.h b/include/linux/timerqueue_type=
s.h
index dc298d0..be2218b 100644
--- a/include/linux/timerqueue_types.h
+++ b/include/linux/timerqueue_types.h
@@ -6,12 +6,21 @@
 #include <linux/types.h>
=20
 struct timerqueue_node {
-	struct rb_node node;
-	ktime_t expires;
+	struct rb_node		node;
+	ktime_t			expires;
 };
=20
 struct timerqueue_head {
-	struct rb_root_cached rb_root;
+	struct rb_root_cached	rb_root;
+};
+
+struct timerqueue_linked_node {
+	struct rb_node_linked		node;
+	ktime_t				expires;
+};
+
+struct timerqueue_linked_head {
+	struct rb_root_linked		rb_root;
 };
=20
 #endif /* _LINUX_TIMERQUEUE_TYPES_H */
diff --git a/lib/timerqueue.c b/lib/timerqueue.c
index cdb9c76..e2a1e08 100644
--- a/lib/timerqueue.c
+++ b/lib/timerqueue.c
@@ -82,3 +82,17 @@ struct timerqueue_node *timerqueue_iterate_next(struct tim=
erqueue_node *node)
 	return container_of(next, struct timerqueue_node, node);
 }
 EXPORT_SYMBOL_GPL(timerqueue_iterate_next);
+
+#define __node_2_tq_linked(_n) \
+	container_of(rb_entry((_n), struct rb_node_linked, node), struct timerqueue=
_linked_node, node)
+
+static __always_inline bool __tq_linked_less(struct rb_node *a, const struct=
 rb_node *b)
+{
+	return __node_2_tq_linked(a)->expires < __node_2_tq_linked(b)->expires;
+}
+
+bool timerqueue_linked_add(struct timerqueue_linked_head *head, struct timer=
queue_linked_node *node)
+{
+	return rb_add_linked(&node->node, &head->rb_root, __tq_linked_less);
+}
+EXPORT_SYMBOL_GPL(timerqueue_linked_add);

