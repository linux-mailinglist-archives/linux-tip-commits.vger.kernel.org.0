Return-Path: <linux-tip-commits+bounces-7807-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC6ECF48FF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 17:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23094301D9DD
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 16:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B26347FCF;
	Mon,  5 Jan 2026 15:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jzpfVOE3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q1KBi3cP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D9A346E78;
	Mon,  5 Jan 2026 15:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628478; cv=none; b=qRVWOBC8LP8bgkDL4EMo5lcz9MLl1e35ue0Agk9sj+xS2iaJswHxfv/d9/jKpIiu82mgIDFupXCxDTiU1bUBs5okNsZXGKbDWoZfllWCArxiNWxg22xwr+v/PVXCPopOeH4NpYm5szYPqji/h/xn+jehEAoFOt0XEfP2NKS3NXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628478; c=relaxed/simple;
	bh=LtdH5teDxjXmJrbPI1tRBoD/r6sLsiP8WlGBudup8j8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BZcbweYYXg+uQ7xqhpP8B/wJthW/2iTrgSAZ/I2j6ijrhuYMrLgO+AFq4JDwRdI5c2+t9NWbEoahzsyk35qD1t4sn/GyjGCnguLTEGlhkTPQYcu5pJiyLfkRwLxDIGwdH1WzMnX9OM3RzEK5Ff+xIV6fYo3blPqAMS4lkCztIiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jzpfVOE3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q1KBi3cP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:54:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628473;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X9x9/9s79uSquSKVTe+sCT/odZkv4M7Avt+7VqTVvUw=;
	b=jzpfVOE38jSeuJr0qdZIwWn1wVehCAUXuS13lveIibBuP3mezHGtP5KtZF8DCCdFcl3MBy
	ekew3oJZDzKns3yWIdO/ljs+Ef1ZAnGaLXISs3C70jxJx86Sh1+2RkutFu0cNnpszQy2W2
	lfhLnH2Cmp8/mUL/u6Fl64n5x/ZkVZ53hfEFwDcNoKY9PDAiwKpTffVPEMXacr7H3LYCZu
	sllOgVYz51kUkVjLivWs0CO1HWC2nV4Dt/o2NO8iaVwCWKg3FzA3VBRHuGx7jSi2rPhTxc
	/u7t+w0JEu50s4gc5DfCdumg0asVZh4093jtQLM2G+mJZ6XLTg9EgsnWGFIPGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628473;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X9x9/9s79uSquSKVTe+sCT/odZkv4M7Avt+7VqTVvUw=;
	b=q1KBi3cPqrifaoOU9YTZvxIFM2JO1L0XxMP2UL+tbNYTO9zn+pxkhitD+9FCxq5hbZqfww
	yCv8V/vEJcwxRbCg==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] srcu: Support Clang's context analysis
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-16-elver@google.com>
References: <20251219154418.3592607-16-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762847245.510.1208569364415271549.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f0b7ce22d71810c8c11abcd912fbd6f57c2e9677
Gitweb:        https://git.kernel.org/tip/f0b7ce22d71810c8c11abcd912fbd6f57c2=
e9677
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:40:04 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:30 +01:00

srcu: Support Clang's context analysis

Add support for Clang's context analysis for SRCU.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://patch.msgid.link/20251219154418.3592607-16-elver@google.com
---
 Documentation/dev-tools/context-analysis.rst |  2 +-
 include/linux/srcu.h                         | 73 +++++++++++++------
 include/linux/srcutiny.h                     |  6 ++-
 include/linux/srcutree.h                     | 10 ++-
 lib/test_context-analysis.c                  | 25 +++++++-
 5 files changed, 91 insertions(+), 25 deletions(-)

diff --git a/Documentation/dev-tools/context-analysis.rst b/Documentation/dev=
-tools/context-analysis.rst
index 3bc72f7..f7736f1 100644
--- a/Documentation/dev-tools/context-analysis.rst
+++ b/Documentation/dev-tools/context-analysis.rst
@@ -80,7 +80,7 @@ Supported Kernel Primitives
=20
 Currently the following synchronization primitives are supported:
 `raw_spinlock_t`, `spinlock_t`, `rwlock_t`, `mutex`, `seqlock_t`,
-`bit_spinlock`, RCU.
+`bit_spinlock`, RCU, SRCU (`srcu_struct`).
=20
 For context locks with an initialization function (e.g., `spin_lock_init()`),
 calling this function before initializing any guarded members or globals
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 344ad51..bb44a0b 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -21,7 +21,7 @@
 #include <linux/workqueue.h>
 #include <linux/rcu_segcblist.h>
=20
-struct srcu_struct;
+context_lock_struct(srcu_struct, __reentrant_ctx_lock);
=20
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
=20
@@ -77,7 +77,7 @@ int init_srcu_struct_fast_updown(struct srcu_struct *ssp);
 #define SRCU_READ_FLAVOR_SLOWGP		(SRCU_READ_FLAVOR_FAST | SRCU_READ_FLAVOR_F=
AST_UPDOWN)
 						// Flavors requiring synchronize_rcu()
 						// instead of smp_mb().
-void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
+void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases_shared(=
ssp);
=20
 #ifdef CONFIG_TINY_SRCU
 #include <linux/srcutiny.h>
@@ -131,14 +131,16 @@ static inline bool same_state_synchronize_srcu(unsigned=
 long oldstate1, unsigned
 }
=20
 #ifdef CONFIG_NEED_SRCU_NMI_SAFE
-int __srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp);
-void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx) __releases=
(ssp);
+int __srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires_shared(ssp);
+void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx) __releases=
_shared(ssp);
 #else
 static inline int __srcu_read_lock_nmisafe(struct srcu_struct *ssp)
+	__acquires_shared(ssp)
 {
 	return __srcu_read_lock(ssp);
 }
 static inline void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int i=
dx)
+	__releases_shared(ssp)
 {
 	__srcu_read_unlock(ssp, idx);
 }
@@ -210,6 +212,14 @@ static inline int srcu_read_lock_held(const struct srcu_=
struct *ssp)
=20
 #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
=20
+/*
+ * No-op helper to denote that ssp must be held. Because SRCU-protected poin=
ters
+ * should still be marked with __rcu_guarded, and we do not want to mark them
+ * with __guarded_by(ssp) as it would complicate annotations for writers, we
+ * choose the following strategy: srcu_dereference_check() calls this helper
+ * that checks that the passed ssp is held, and then fake-acquires 'RCU'.
+ */
+static inline void __srcu_read_lock_must_hold(const struct srcu_struct *ssp)=
 __must_hold_shared(ssp) { }
=20
 /**
  * srcu_dereference_check - fetch SRCU-protected pointer for later dereferen=
cing
@@ -223,9 +233,15 @@ static inline int srcu_read_lock_held(const struct srcu_=
struct *ssp)
  * to 1.  The @c argument will normally be a logical expression containing
  * lockdep_is_held() calls.
  */
-#define srcu_dereference_check(p, ssp, c) \
-	__rcu_dereference_check((p), __UNIQUE_ID(rcu), \
-				(c) || srcu_read_lock_held(ssp), __rcu)
+#define srcu_dereference_check(p, ssp, c)					\
+({										\
+	__srcu_read_lock_must_hold(ssp);					\
+	__acquire_shared_ctx_lock(RCU);					\
+	__auto_type __v =3D __rcu_dereference_check((p), __UNIQUE_ID(rcu),	\
+				(c) || srcu_read_lock_held(ssp), __rcu);	\
+	__release_shared_ctx_lock(RCU);					\
+	__v;									\
+})
=20
 /**
  * srcu_dereference - fetch SRCU-protected pointer for later dereferencing
@@ -268,7 +284,8 @@ static inline int srcu_read_lock_held(const struct srcu_s=
truct *ssp)
  * invoke srcu_read_unlock() from one task and the matching srcu_read_lock()
  * from another.
  */
-static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
+static inline int srcu_read_lock(struct srcu_struct *ssp)
+	__acquires_shared(ssp)
 {
 	int retval;
=20
@@ -304,7 +321,8 @@ static inline int srcu_read_lock(struct srcu_struct *ssp)=
 __acquires(ssp)
  * contexts where RCU is watching, that is, from contexts where it would
  * be legal to invoke rcu_read_lock().  Otherwise, lockdep will complain.
  */
-static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_stru=
ct *ssp) __acquires(ssp)
+static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_stru=
ct *ssp) __acquires_shared(ssp)
+	__acquires_shared(ssp)
 {
 	struct srcu_ctr __percpu *retval;
=20
@@ -344,7 +362,7 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fa=
st(struct srcu_struct *
  * complain.
  */
 static inline struct srcu_ctr __percpu *srcu_read_lock_fast_updown(struct sr=
cu_struct *ssp)
-__acquires(ssp)
+	__acquires_shared(ssp)
 {
 	struct srcu_ctr __percpu *retval;
=20
@@ -360,7 +378,7 @@ __acquires(ssp)
  * See srcu_read_lock_fast() for more information.
  */
 static inline struct srcu_ctr __percpu *srcu_read_lock_fast_notrace(struct s=
rcu_struct *ssp)
-	__acquires(ssp)
+	__acquires_shared(ssp)
 {
 	struct srcu_ctr __percpu *retval;
=20
@@ -381,7 +399,7 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fa=
st_notrace(struct srcu_
  * and srcu_read_lock_fast().  However, the same definition/initialization
  * requirements called out for srcu_read_lock_safe() apply.
  */
-static inline struct srcu_ctr __percpu *srcu_down_read_fast(struct srcu_stru=
ct *ssp) __acquires(ssp)
+static inline struct srcu_ctr __percpu *srcu_down_read_fast(struct srcu_stru=
ct *ssp) __acquires_shared(ssp)
 {
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_down_read_f=
ast().");
@@ -400,7 +418,8 @@ static inline struct srcu_ctr __percpu *srcu_down_read_fa=
st(struct srcu_struct *
  * then none of the other flavors may be used, whether before, during,
  * or after.
  */
-static inline int srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires=
(ssp)
+static inline int srcu_read_lock_nmisafe(struct srcu_struct *ssp)
+	__acquires_shared(ssp)
 {
 	int retval;
=20
@@ -412,7 +431,8 @@ static inline int srcu_read_lock_nmisafe(struct srcu_stru=
ct *ssp) __acquires(ssp
=20
 /* Used by tracing, cannot be traced and cannot invoke lockdep. */
 static inline notrace int
-srcu_read_lock_notrace(struct srcu_struct *ssp) __acquires(ssp)
+srcu_read_lock_notrace(struct srcu_struct *ssp)
+	__acquires_shared(ssp)
 {
 	int retval;
=20
@@ -443,7 +463,8 @@ srcu_read_lock_notrace(struct srcu_struct *ssp) __acquire=
s(ssp)
  * which calls to down_read() may be nested.  The same srcu_struct may be
  * used concurrently by srcu_down_read() and srcu_read_lock().
  */
-static inline int srcu_down_read(struct srcu_struct *ssp) __acquires(ssp)
+static inline int srcu_down_read(struct srcu_struct *ssp)
+	__acquires_shared(ssp)
 {
 	WARN_ON_ONCE(in_nmi());
 	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
@@ -458,7 +479,7 @@ static inline int srcu_down_read(struct srcu_struct *ssp)=
 __acquires(ssp)
  * Exit an SRCU read-side critical section.
  */
 static inline void srcu_read_unlock(struct srcu_struct *ssp, int idx)
-	__releases(ssp)
+	__releases_shared(ssp)
 {
 	WARN_ON_ONCE(idx & ~0x1);
 	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
@@ -474,7 +495,7 @@ static inline void srcu_read_unlock(struct srcu_struct *s=
sp, int idx)
  * Exit a light-weight SRCU read-side critical section.
  */
 static inline void srcu_read_unlock_fast(struct srcu_struct *ssp, struct src=
u_ctr __percpu *scp)
-	__releases(ssp)
+	__releases_shared(ssp)
 {
 	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
 	srcu_lock_release(&ssp->dep_map);
@@ -490,7 +511,7 @@ static inline void srcu_read_unlock_fast(struct srcu_stru=
ct *ssp, struct srcu_ct
  * Exit an SRCU-fast-updown read-side critical section.
  */
 static inline void
-srcu_read_unlock_fast_updown(struct srcu_struct *ssp, struct srcu_ctr __perc=
pu *scp) __releases(ssp)
+srcu_read_unlock_fast_updown(struct srcu_struct *ssp, struct srcu_ctr __perc=
pu *scp) __releases_shared(ssp)
 {
 	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST_UPDOWN);
 	srcu_lock_release(&ssp->dep_map);
@@ -504,7 +525,7 @@ srcu_read_unlock_fast_updown(struct srcu_struct *ssp, str=
uct srcu_ctr __percpu *
  * See srcu_read_unlock_fast() for more information.
  */
 static inline void srcu_read_unlock_fast_notrace(struct srcu_struct *ssp,
-						 struct srcu_ctr __percpu *scp) __releases(ssp)
+						 struct srcu_ctr __percpu *scp) __releases_shared(ssp)
 {
 	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
 	__srcu_read_unlock_fast(ssp, scp);
@@ -519,7 +540,7 @@ static inline void srcu_read_unlock_fast_notrace(struct s=
rcu_struct *ssp,
  * the same context as the maching srcu_down_read_fast().
  */
 static inline void srcu_up_read_fast(struct srcu_struct *ssp, struct srcu_ct=
r __percpu *scp)
-	__releases(ssp)
+	__releases_shared(ssp)
 {
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
 	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST_UPDOWN);
@@ -535,7 +556,7 @@ static inline void srcu_up_read_fast(struct srcu_struct *=
ssp, struct srcu_ctr __
  * Exit an SRCU read-side critical section, but in an NMI-safe manner.
  */
 static inline void srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
-	__releases(ssp)
+	__releases_shared(ssp)
 {
 	WARN_ON_ONCE(idx & ~0x1);
 	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NMI);
@@ -545,7 +566,7 @@ static inline void srcu_read_unlock_nmisafe(struct srcu_s=
truct *ssp, int idx)
=20
 /* Used by tracing, cannot be traced and cannot call lockdep. */
 static inline notrace void
-srcu_read_unlock_notrace(struct srcu_struct *ssp, int idx) __releases(ssp)
+srcu_read_unlock_notrace(struct srcu_struct *ssp, int idx) __releases_shared=
(ssp)
 {
 	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
 	__srcu_read_unlock(ssp, idx);
@@ -560,7 +581,7 @@ srcu_read_unlock_notrace(struct srcu_struct *ssp, int idx=
) __releases(ssp)
  * the same context as the maching srcu_down_read().
  */
 static inline void srcu_up_read(struct srcu_struct *ssp, int idx)
-	__releases(ssp)
+	__releases_shared(ssp)
 {
 	WARN_ON_ONCE(idx & ~0x1);
 	WARN_ON_ONCE(in_nmi());
@@ -600,15 +621,21 @@ DEFINE_LOCK_GUARD_1(srcu, struct srcu_struct,
 		    _T->idx =3D srcu_read_lock(_T->lock),
 		    srcu_read_unlock(_T->lock, _T->idx),
 		    int idx)
+DECLARE_LOCK_GUARD_1_ATTRS(srcu, __acquires_shared(_T), __releases_shared(*(=
struct srcu_struct **)_T))
+#define class_srcu_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(srcu, _T)
=20
 DEFINE_LOCK_GUARD_1(srcu_fast, struct srcu_struct,
 		    _T->scp =3D srcu_read_lock_fast(_T->lock),
 		    srcu_read_unlock_fast(_T->lock, _T->scp),
 		    struct srcu_ctr __percpu *scp)
+DECLARE_LOCK_GUARD_1_ATTRS(srcu_fast, __acquires_shared(_T), __releases_shar=
ed(*(struct srcu_struct **)_T))
+#define class_srcu_fast_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(srcu_fast, _=
T)
=20
 DEFINE_LOCK_GUARD_1(srcu_fast_notrace, struct srcu_struct,
 		    _T->scp =3D srcu_read_lock_fast_notrace(_T->lock),
 		    srcu_read_unlock_fast_notrace(_T->lock, _T->scp),
 		    struct srcu_ctr __percpu *scp)
+DECLARE_LOCK_GUARD_1_ATTRS(srcu_fast_notrace, __acquires_shared(_T), __relea=
ses_shared(*(struct srcu_struct **)_T))
+#define class_srcu_fast_notrace_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(srcu=
_fast_notrace, _T)
=20
 #endif
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index e069802..dec7cbe 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -73,6 +73,7 @@ void synchronize_srcu(struct srcu_struct *ssp);
  * index that must be passed to the matching srcu_read_unlock().
  */
 static inline int __srcu_read_lock(struct srcu_struct *ssp)
+	__acquires_shared(ssp)
 {
 	int idx;
=20
@@ -80,6 +81,7 @@ static inline int __srcu_read_lock(struct srcu_struct *ssp)
 	idx =3D ((READ_ONCE(ssp->srcu_idx) + 1) & 0x2) >> 1;
 	WRITE_ONCE(ssp->srcu_lock_nesting[idx], READ_ONCE(ssp->srcu_lock_nesting[id=
x]) + 1);
 	preempt_enable();
+	__acquire_shared(ssp);
 	return idx;
 }
=20
@@ -96,22 +98,26 @@ static inline struct srcu_ctr __percpu *__srcu_ctr_to_ptr=
(struct srcu_struct *ss
 }
=20
 static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct srcu_st=
ruct *ssp)
+	__acquires_shared(ssp)
 {
 	return __srcu_ctr_to_ptr(ssp, __srcu_read_lock(ssp));
 }
=20
 static inline void __srcu_read_unlock_fast(struct srcu_struct *ssp, struct s=
rcu_ctr __percpu *scp)
+	__releases_shared(ssp)
 {
 	__srcu_read_unlock(ssp, __srcu_ptr_to_ctr(ssp, scp));
 }
=20
 static inline struct srcu_ctr __percpu *__srcu_read_lock_fast_updown(struct =
srcu_struct *ssp)
+	__acquires_shared(ssp)
 {
 	return __srcu_ctr_to_ptr(ssp, __srcu_read_lock(ssp));
 }
=20
 static inline
 void __srcu_read_unlock_fast_updown(struct srcu_struct *ssp, struct srcu_ctr=
 __percpu *scp)
+	__releases_shared(ssp)
 {
 	__srcu_read_unlock(ssp, __srcu_ptr_to_ctr(ssp, scp));
 }
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index d6f978b..958cb7e 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -233,7 +233,7 @@ struct srcu_struct {
 #define DEFINE_STATIC_SRCU_FAST_UPDOWN(name) \
 					__DEFINE_SRCU(name, SRCU_READ_FLAVOR_FAST_UPDOWN, static)
=20
-int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
+int __srcu_read_lock(struct srcu_struct *ssp) __acquires_shared(ssp);
 void synchronize_srcu_expedited(struct srcu_struct *ssp);
 void srcu_barrier(struct srcu_struct *ssp);
 void srcu_expedite_current(struct srcu_struct *ssp);
@@ -286,6 +286,7 @@ static inline struct srcu_ctr __percpu *__srcu_ctr_to_ptr=
(struct srcu_struct *ss
  * implementations of this_cpu_inc().
  */
 static inline struct srcu_ctr __percpu notrace *__srcu_read_lock_fast(struct=
 srcu_struct *ssp)
+	__acquires_shared(ssp)
 {
 	struct srcu_ctr __percpu *scp =3D READ_ONCE(ssp->srcu_ctrp);
=20
@@ -294,6 +295,7 @@ static inline struct srcu_ctr __percpu notrace *__srcu_re=
ad_lock_fast(struct src
 	else
 		atomic_long_inc(raw_cpu_ptr(&scp->srcu_locks));  // Y, and implicit RCU re=
ader.
 	barrier(); /* Avoid leaking the critical section. */
+	__acquire_shared(ssp);
 	return scp;
 }
=20
@@ -308,7 +310,9 @@ static inline struct srcu_ctr __percpu notrace *__srcu_re=
ad_lock_fast(struct src
  */
 static inline void notrace
 __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *s=
cp)
+	__releases_shared(ssp)
 {
+	__release_shared(ssp);
 	barrier();  /* Avoid leaking the critical section. */
 	if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
 		this_cpu_inc(scp->srcu_unlocks.counter);  // Z, and implicit RCU reader.
@@ -326,6 +330,7 @@ __srcu_read_unlock_fast(struct srcu_struct *ssp, struct s=
rcu_ctr __percpu *scp)
  */
 static inline
 struct srcu_ctr __percpu notrace *__srcu_read_lock_fast_updown(struct srcu_s=
truct *ssp)
+	__acquires_shared(ssp)
 {
 	struct srcu_ctr __percpu *scp =3D READ_ONCE(ssp->srcu_ctrp);
=20
@@ -334,6 +339,7 @@ struct srcu_ctr __percpu notrace *__srcu_read_lock_fast_u=
pdown(struct srcu_struc
 	else
 		atomic_long_inc(raw_cpu_ptr(&scp->srcu_locks));  // Y, and implicit RCU re=
ader.
 	barrier(); /* Avoid leaking the critical section. */
+	__acquire_shared(ssp);
 	return scp;
 }
=20
@@ -348,7 +354,9 @@ struct srcu_ctr __percpu notrace *__srcu_read_lock_fast_u=
pdown(struct srcu_struc
  */
 static inline void notrace
 __srcu_read_unlock_fast_updown(struct srcu_struct *ssp, struct srcu_ctr __pe=
rcpu *scp)
+	__releases_shared(ssp)
 {
+	__release_shared(ssp);
 	barrier();  /* Avoid leaking the critical section. */
 	if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
 		this_cpu_inc(scp->srcu_unlocks.counter);  // Z, and implicit RCU reader.
diff --git a/lib/test_context-analysis.c b/lib/test_context-analysis.c
index 559df32..39e0379 100644
--- a/lib/test_context-analysis.c
+++ b/lib/test_context-analysis.c
@@ -10,6 +10,7 @@
 #include <linux/rcupdate.h>
 #include <linux/seqlock.h>
 #include <linux/spinlock.h>
+#include <linux/srcu.h>
=20
 /*
  * Test that helper macros work as expected.
@@ -369,3 +370,27 @@ static void __used test_rcu_assert_variants(void)
 	lockdep_assert_in_rcu_read_lock_sched();
 	wants_rcu_held_sched();
 }
+
+struct test_srcu_data {
+	struct srcu_struct srcu;
+	long __rcu_guarded *data;
+};
+
+static void __used test_srcu(struct test_srcu_data *d)
+{
+	init_srcu_struct(&d->srcu);
+
+	int idx =3D srcu_read_lock(&d->srcu);
+	long *data =3D srcu_dereference(d->data, &d->srcu);
+	(void)data;
+	srcu_read_unlock(&d->srcu, idx);
+
+	rcu_assign_pointer(d->data, NULL);
+}
+
+static void __used test_srcu_guard(struct test_srcu_data *d)
+{
+	{ guard(srcu)(&d->srcu); (void)srcu_dereference(d->data, &d->srcu); }
+	{ guard(srcu_fast)(&d->srcu); (void)srcu_dereference(d->data, &d->srcu); }
+	{ guard(srcu_fast_notrace)(&d->srcu); (void)srcu_dereference(d->data, &d->s=
rcu); }
+}

