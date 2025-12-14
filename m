Return-Path: <linux-tip-commits+bounces-7648-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 045C9CBB756
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7460E3007C65
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 07:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916DB21D3CD;
	Sun, 14 Dec 2025 07:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KUtcdjNC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4zGDyRZA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0E2219EB;
	Sun, 14 Dec 2025 07:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765698404; cv=none; b=EJjFD1aqhYlrHePdhLF2tRbKZ7VuOF2qpaLaqNJJI+6xO7GjuXNcxS4FDURc1i/vF/aYRyo0ZBuX0worhoO8vKdRFcQOeCysBiqwDi89jNThMiDd/2RSvVTx8VixXr2u/e+e/238QndfiQj+yhNzfQoYF5Yt5KqpQ7HbuZQ4Wbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765698404; c=relaxed/simple;
	bh=DxwYuvXjIviGx9cwpvTgyO80KaORZOlxzZ/169pYXMA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=kr857ZzbkzsP+Q30+VuIPWNpnYGqUgEzJhLDE7BB9CuueMAPiFQOC0qM99+XzbcAM0oENmB62gqVFHe94QLoa1u5bE+1Q4eAmPYnKbGUVyl0njkqzNmn+NS19F1xsSy7klPAXuVdvyoyRSCPzdd/8DIgitFfoJfACEClre3Lj0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KUtcdjNC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4zGDyRZA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 07:46:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765698395;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=tMOLA3GpF9XiZ82To1PLWD0/vs/6rpP76yqYEGAzhDk=;
	b=KUtcdjNCXmPiwm0GNVq8KM0C3AWI1Bec3smi0LAHRhurkZqLiFyiCSXt+9udbWJRqOyMhK
	gxaZ1j0dgfZeOc+zPlsQ9swn90SLzncIKNmNnwktIUu0g8cwKnNm5K1MiYeTNYuKV23S3F
	emKWp3TcUzeOnnq1uenBd6yfJQfpMHFPonCZpbaGT/JGj4eobVlyjwxEu/s0io8tCVeXF+
	CgkraOlf07drSjv4eVhqBEJiBlDonVk5uaTNGb5o8eimgPXvcSelu6avYTBvLCjnGAzcga
	CAp3OUyKmwrfAxtWQmw5BftCMk5HowupiOz3CWmuUBjvc0qfH3BFAEbjUIDuHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765698395;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=tMOLA3GpF9XiZ82To1PLWD0/vs/6rpP76yqYEGAzhDk=;
	b=4zGDyRZA8HcNr7jE+4RAgUMcmTPU54hEsG7CjDdzYG4xdyqZ+VVHCahjkJZNsdN0vxiqY2
	0ThdJ3JwEw9vZrAw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Introduce and use the vruntime_cmp()
 and vruntime_op() wrappers for wrapped-signed aritmetics
Cc:
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176569839418.498.8393430980235519812.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b715ed9df09f06933aed0483d98744a204e032fb
Gitweb:        https://git.kernel.org/tip/b715ed9df09f06933aed0483d98744a204e=
032fb
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 02 Dec 2025 16:10:32 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 08:25:03 +01:00

sched/fair: Introduce and use the vruntime_cmp() and vruntime_op() wrappers f=
or wrapped-signed aritmetics

We have to be careful with vruntime comparisons and subtraction,
due to the possibility of wrapping, so we have macros like:

   #define vruntime_gt(field, lse, rse) ({ (s64)((lse)->field - (rse)->field)=
 > 0; })

Which is used like this:

		if (vruntime_gt(min_vruntime, se, rse))
			se->min_vruntime =3D rse->min_vruntime;

Replace this with an easier to read pattern that uses the regular
arithmetics operators:

		if (vruntime_cmp(se->min_vruntime, ">", rse->min_vruntime))
			se->min_vruntime =3D rse->min_vruntime;

Also replace vruntime subtractions with vruntime_op():

	-       delta =3D (s64)(sea->vruntime - seb->vruntime) +
	-               (s64)(cfs_rqb->zero_vruntime_fi - cfs_rqa->zero_vruntime_fi);
	+       delta =3D vruntime_op(sea->vruntime, "-", seb->vruntime) +
	+               vruntime_op(cfs_rqb->zero_vruntime_fi, "-", cfs_rqa->zero_vr=
untime_fi);

In the vruntime_cmp() and vruntime_op() macros use Use __builtin_strcmp(),
because of __HAVE_ARCH_STRCMP might turn off the compiler optimizations
we rely on here to catch usage bugs.

No change in functionality.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 66 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 050ed08..b6043ec 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -524,10 +524,48 @@ void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 =
delta_exec);
  * Scheduling class tree data structure manipulation methods:
  */
=20
+extern void __BUILD_BUG_vruntime_cmp(void);
+
+/* Use __builtin_strcmp() because of __HAVE_ARCH_STRCMP: */
+
+#define vruntime_cmp(A, CMP_STR, B) ({				\
+	int __res =3D 0;						\
+								\
+	if (!__builtin_strcmp(CMP_STR, "<")) {			\
+		__res =3D ((s64)((A)-(B)) < 0);			\
+	} else if (!__builtin_strcmp(CMP_STR, "<=3D")) {		\
+		__res =3D ((s64)((A)-(B)) <=3D 0);			\
+	} else if (!__builtin_strcmp(CMP_STR, ">")) {		\
+		__res =3D ((s64)((A)-(B)) > 0);			\
+	} else if (!__builtin_strcmp(CMP_STR, ">=3D")) {		\
+		__res =3D ((s64)((A)-(B)) >=3D 0);			\
+	} else {						\
+		/* Unknown operator throws linker error: */	\
+		__BUILD_BUG_vruntime_cmp();			\
+	}							\
+								\
+	__res;							\
+})
+
+extern void __BUILD_BUG_vruntime_op(void);
+
+#define vruntime_op(A, OP_STR, B) ({				\
+	s64 __res =3D 0;						\
+								\
+	if (!__builtin_strcmp(OP_STR, "-")) {			\
+		__res =3D (s64)((A)-(B));				\
+	} else {						\
+		/* Unknown operator throws linker error: */	\
+		__BUILD_BUG_vruntime_op();			\
+	}							\
+								\
+	__res;						\
+})
+
+
 static inline __maybe_unused u64 max_vruntime(u64 max_vruntime, u64 vruntime)
 {
-	s64 delta =3D (s64)(vruntime - max_vruntime);
-	if (delta > 0)
+	if (vruntime_cmp(vruntime, ">", max_vruntime))
 		max_vruntime =3D vruntime;
=20
 	return max_vruntime;
@@ -535,8 +573,7 @@ static inline __maybe_unused u64 max_vruntime(u64 max_vru=
ntime, u64 vruntime)
=20
 static inline __maybe_unused u64 min_vruntime(u64 min_vruntime, u64 vruntime)
 {
-	s64 delta =3D (s64)(vruntime - min_vruntime);
-	if (delta < 0)
+	if (vruntime_cmp(vruntime, "<", min_vruntime))
 		min_vruntime =3D vruntime;
=20
 	return min_vruntime;
@@ -549,12 +586,12 @@ static inline bool entity_before(const struct sched_ent=
ity *a,
 	 * Tiebreak on vruntime seems unnecessary since it can
 	 * hardly happen.
 	 */
-	return (s64)(a->deadline - b->deadline) < 0;
+	return vruntime_cmp(a->deadline, "<", b->deadline);
 }
=20
 static inline s64 entity_key(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	return (s64)(se->vruntime - cfs_rq->zero_vruntime);
+	return vruntime_op(se->vruntime, "-", cfs_rq->zero_vruntime);
 }
=20
 #define __node_2_se(node) \
@@ -732,7 +769,7 @@ static int vruntime_eligible(struct cfs_rq *cfs_rq, u64 v=
runtime)
 		load +=3D weight;
 	}
=20
-	return avg >=3D (s64)(vruntime - cfs_rq->zero_vruntime) * load;
+	return avg >=3D vruntime_op(vruntime, "-", cfs_rq->zero_vruntime) * load;
 }
=20
 int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
@@ -743,7 +780,7 @@ int entity_eligible(struct cfs_rq *cfs_rq, struct sched_e=
ntity *se)
 static void update_zero_vruntime(struct cfs_rq *cfs_rq)
 {
 	u64 vruntime =3D avg_vruntime(cfs_rq);
-	s64 delta =3D (s64)(vruntime - cfs_rq->zero_vruntime);
+	s64 delta =3D vruntime_op(vruntime, "-", cfs_rq->zero_vruntime);
=20
 	sum_w_vruntime_update(cfs_rq, delta);
=20
@@ -770,13 +807,12 @@ static inline bool __entity_less(struct rb_node *a, con=
st struct rb_node *b)
 	return entity_before(__node_2_se(a), __node_2_se(b));
 }
=20
-#define vruntime_gt(field, lse, rse) ({ (s64)((lse)->field - (rse)->field) >=
 0; })
-
 static inline void __min_vruntime_update(struct sched_entity *se, struct rb_=
node *node)
 {
 	if (node) {
 		struct sched_entity *rse =3D __node_2_se(node);
-		if (vruntime_gt(min_vruntime, se, rse))
+
+		if (vruntime_cmp(se->min_vruntime, ">", rse->min_vruntime))
 			se->min_vruntime =3D rse->min_vruntime;
 	}
 }
@@ -887,7 +923,7 @@ static inline void update_protect_slice(struct cfs_rq *cf=
s_rq, struct sched_enti
=20
 static inline bool protect_slice(struct sched_entity *se)
 {
-	return ((s64)(se->vprot - se->vruntime) > 0);
+	return vruntime_cmp(se->vruntime, "<", se->vprot);
 }
=20
 static inline void cancel_protect_slice(struct sched_entity *se)
@@ -1024,7 +1060,7 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct=
 sched_entity *se);
  */
 static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	if ((s64)(se->vruntime - se->deadline) < 0)
+	if (vruntime_cmp(se->vruntime, "<", se->deadline))
 		return false;
=20
 	/*
@@ -13299,8 +13335,8 @@ bool cfs_prio_less(const struct task_struct *a, const=
 struct task_struct *b,
 	 * zero_vruntime_fi, which would have been updated in prior calls
 	 * to se_fi_update().
 	 */
-	delta =3D (s64)(sea->vruntime - seb->vruntime) +
-		(s64)(cfs_rqb->zero_vruntime_fi - cfs_rqa->zero_vruntime_fi);
+	delta =3D vruntime_op(sea->vruntime, "-", seb->vruntime) +
+		vruntime_op(cfs_rqb->zero_vruntime_fi, "-", cfs_rqa->zero_vruntime_fi);
=20
 	return delta > 0;
 }

