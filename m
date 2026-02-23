Return-Path: <linux-tip-commits+bounces-8221-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HIFEkcrnGmcAQQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8221-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:26:15 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0A4174D54
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB4AB302EFB0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 10:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24B335BDCA;
	Mon, 23 Feb 2026 10:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r9iSVYI6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QuzgiJDv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7DB3612F0;
	Mon, 23 Feb 2026 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771842321; cv=none; b=IE3EX+pq5RPG3QnjLhItvMak6kbAXJEU4FKhxlxQAUyZlxK2wNFTRc9iLhra2MnMdzQrb0JMODcXuMLgY1EwsnSvY4gHnJ6P5NUkvfotHpH3xCd63Z4TrkP64/L5gn0/BxH132ZZyFjMdlwqEmwxXfFjUXY0SQndH6lVzJNIHqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771842321; c=relaxed/simple;
	bh=dk5RHY8k7lhDdJXrZ2nxXqyjfiA5gFEA9GEl9yVhrCU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=beZ8DaZGFCeR5iuwaOCdDivutPBPNtQOY1blz8/gTyd6vizuSIe7yZBvtihROfhbmbBu3hOTVQ4c47mf4cXBavnZe40nauONTy5Hdu6nCof4areE8xDELEI20nVEypy4D3u0B9k5YHJkmJqDUvbVJkGUG4iHaXnHmsv/DvJ5YdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r9iSVYI6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QuzgiJDv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 23 Feb 2026 10:25:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771842318;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mTPv4EJd6G1oro91ggeaHUNdR5mNKSqrgaPfIxd/xTU=;
	b=r9iSVYI6sgSOebGtie5w+bvZZwoaCIkm0YOdPNSTMX1tfa1H9t2+ENTmOZgmi7pmo4GUjy
	uDbrnjUFxfiWifDEKgAvcVg7tsruWXapmTNfa31utqerkEIEPrhc4BUS9158bgPKkQobbN
	p+WnTB9qMLirNK6W9gb2u4UewnB5Nf320kjbOHYPeYn3NzTfzOqU2dY3/sSQVIiVCTOjdK
	YSt5Au3z/3CtFLJZNKVauMzbGQH4W6E3ZCU2nP3AM2PmTlNu2az5rt1pF1UoCS1oOFqZcW
	jNfyFsfhOdxz1HKmrwscmCMryQejy6mNtH4RMgkiJGh6W6Y5FOmQPVoc6t4APw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771842318;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mTPv4EJd6G1oro91ggeaHUNdR5mNKSqrgaPfIxd/xTU=;
	b=QuzgiJDvc0l1QT4HsOK/Gn0kdKIgeTeLrz1m71caZbMjF7FrYXzZAULQ92guviUKc+Et3k
	QTPWgUFydDmYHdAQ==
From: "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] rseq: slice ext: Ensure rseq feature size differs
 from original rseq size
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260220200642.1317826-3-mathieu.desnoyers@efficios.com>
References: <20260220200642.1317826-3-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177184231732.1647592.8530863668282649789.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8221-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,linutronix.de:dkim,vger.kernel.org:replyto,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: DF0A4174D54
X-Rspamd-Action: no action

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     3b68df978133ac3d46d570af065a73debbb68248
Gitweb:        https://git.kernel.org/tip/3b68df978133ac3d46d570af065a73debbb=
68248
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Fri, 20 Feb 2026 15:06:41 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 23 Feb 2026 11:19:19 +01:00

rseq: slice ext: Ensure rseq feature size differs from original rseq size

Before rseq became extensible, its original size was 32 bytes even
though the active rseq area was only 20 bytes. This had the following
impact in terms of userspace ecosystem evolution:

* The GNU libc between 2.35 and 2.39 expose a __rseq_size symbol set
  to 32, even though the size of the active rseq area is really 20.
* The GNU libc 2.40 changes this __rseq_size to 20, thus making it
  express the active rseq area.
* Starting from glibc 2.41, __rseq_size corresponds to the
  AT_RSEQ_FEATURE_SIZE from getauxval(3).

This means that users of __rseq_size can always expect it to
correspond to the active rseq area, except for the value 32, for
which the active rseq area is 20 bytes.

Exposing a 32 bytes feature size would make life needlessly painful
for userspace. Therefore, add a reserved field at the end of the
rseq area to bump the feature size to 33 bytes. This reserved field
is expected to be replaced with whatever field will come next,
expecting that this field will be larger than 1 byte.

The effect of this change is to increase the size from 32 to 64 bytes
before we actually have fields using that memory.

Clarify the allocation size and alignment requirements in the struct
rseq uapi comment.

Change the value returned by getauxval(AT_RSEQ_ALIGN) to return the
value of the active rseq area size rounded up to next power of 2, which
guarantees that the rseq structure will always be aligned on the nearest
power of two large enough to contain it, even as it grows. Change the
alignment check in the rseq registration accordingly.

This will minimize the amount of ABI corner-cases we need to document
and require userspace to play games with. The rule stays simple when
__rseq_size !=3D 32:

  #define rseq_field_available(field)	(__rseq_size >=3D offsetofend(struct rs=
eq_abi, field))

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260220200642.1317826-3-mathieu.desnoyers@eff=
icios.com
---
 fs/binfmt_elf.c           |  3 ++-
 include/linux/rseq.h      | 12 ++++++++++++
 include/uapi/linux/rseq.h | 26 ++++++++++++++++++++++----
 kernel/rseq.c             |  3 ++-
 4 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 8e89cc5..fb857fa 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -47,6 +47,7 @@
 #include <linux/dax.h>
 #include <linux/uaccess.h>
 #include <uapi/linux/rseq.h>
+#include <linux/rseq.h>
 #include <asm/param.h>
 #include <asm/page.h>
=20
@@ -286,7 +287,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct=
 elfhdr *exec,
 	}
 #ifdef CONFIG_RSEQ
 	NEW_AUX_ENT(AT_RSEQ_FEATURE_SIZE, offsetof(struct rseq, end));
-	NEW_AUX_ENT(AT_RSEQ_ALIGN, __alignof__(struct rseq));
+	NEW_AUX_ENT(AT_RSEQ_ALIGN, rseq_alloc_align());
 #endif
 #undef NEW_AUX_ENT
 	/* AT_NULL is zero; clear the rest too */
diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index 7a01a07..b9d62fc 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -146,6 +146,18 @@ static inline void rseq_fork(struct task_struct *t, u64 =
clone_flags)
 		t->rseq =3D current->rseq;
 }
=20
+/*
+ * Value returned by getauxval(AT_RSEQ_ALIGN) and expected by rseq
+ * registration. This is the active rseq area size rounded up to next
+ * power of 2, which guarantees that the rseq structure will always be
+ * aligned on the nearest power of two large enough to contain it, even
+ * as it grows.
+ */
+static inline unsigned int rseq_alloc_align(void)
+{
+	return 1U << get_count_order(offsetof(struct rseq, end));
+}
+
 #else /* CONFIG_RSEQ */
 static inline void rseq_handle_slowpath(struct pt_regs *regs) { }
 static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs =
*regs) { }
diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index 863c4a0..f69344f 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -87,10 +87,17 @@ struct rseq_slice_ctrl {
 };
=20
 /*
- * struct rseq is aligned on 4 * 8 bytes to ensure it is always
- * contained within a single cache-line.
+ * The original size and alignment of the allocation for struct rseq is
+ * 32 bytes.
  *
- * A single struct rseq per thread is allowed.
+ * The allocation size needs to be greater or equal to
+ * max(getauxval(AT_RSEQ_FEATURE_SIZE), 32), and the allocation needs to
+ * be aligned on max(getauxval(AT_RSEQ_ALIGN), 32).
+ *
+ * As an alternative, userspace is allowed to use both the original size
+ * and alignment of 32 bytes for backward compatibility.
+ *
+ * A single active struct rseq registration per thread is allowed.
  */
 struct rseq {
 	/*
@@ -181,9 +188,20 @@ struct rseq {
 	struct rseq_slice_ctrl slice_ctrl;
=20
 	/*
+	 * Before rseq became extensible, its original size was 32 bytes even
+	 * though the active rseq area was only 20 bytes.
+	 * Exposing a 32 bytes feature size would make life needlessly painful
+	 * for userspace. Therefore, add a reserved byte after byte 32
+	 * to bump the rseq feature size from 32 to 33.
+	 * The next field to be added to the rseq area will be larger
+	 * than one byte, and will replace this reserved byte.
+	 */
+	__u8 __reserved;
+
+	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
 	char end[];
-} __attribute__((aligned(4 * sizeof(__u64))));
+} __attribute__((aligned(32)));
=20
 #endif /* _UAPI_LINUX_RSEQ_H */
diff --git a/kernel/rseq.c b/kernel/rseq.c
index e349f86..38d3ef5 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -80,6 +80,7 @@
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
 #include <linux/types.h>
+#include <linux/rseq.h>
 #include <asm/ptrace.h>
=20
 #define CREATE_TRACE_POINTS
@@ -456,7 +457,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rs=
eq_len, int, flags, u32
 	 */
 	if (rseq_len < ORIG_RSEQ_SIZE ||
 	    (rseq_len =3D=3D ORIG_RSEQ_SIZE && !IS_ALIGNED((unsigned long)rseq, ORI=
G_RSEQ_SIZE)) ||
-	    (rseq_len !=3D ORIG_RSEQ_SIZE && (!IS_ALIGNED((unsigned long)rseq, __al=
ignof__(*rseq)) ||
+	    (rseq_len !=3D ORIG_RSEQ_SIZE && (!IS_ALIGNED((unsigned long)rseq, rseq=
_alloc_align()) ||
 					    rseq_len < offsetof(struct rseq, end))))
 		return -EINVAL;
 	if (!access_ok(rseq, rseq_len))

