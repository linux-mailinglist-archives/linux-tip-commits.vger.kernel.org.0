Return-Path: <linux-tip-commits+bounces-7787-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A69CF488A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 16:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF1F9303A391
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 15:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB15733A038;
	Mon,  5 Jan 2026 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Eyl8c0bI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cqmDWnYr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA693346B6;
	Mon,  5 Jan 2026 15:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628456; cv=none; b=uwqqkeSN/ZReNbG+q2WfsF+gGB09CvO7AL/tB9Gz9gnHPJ4NyLR8OJduMMziDhIFJpRcI+i+yGgA9N1ZLMvfcRzTvXlCTp8h+ORaXUsNnwFRsXirYthoOjrIZFiS1HxcQLkpkVl66pK4x7ZxsDz05t99wtmTW/2jTxKWagR7rq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628456; c=relaxed/simple;
	bh=ZX52eEhYRhABv1wV87xDfTDyl1qgTiKxei22A1y8mBU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=e0WWbw//dtv4FSn/8q3SzDFWb5ORNHQ2Te1kbDpTCI/mBYl2zXSnTZa4v0fIhvv1qrrrXQTCDayvN/0Vgc1G/N+uUh4SgCbyS6LMeZgEgpJnkpS6JP61Rq4lKcG5VVbR76FqlJ9YOaktJX6NTqimSR7yt4CbzuUgEIUlyLdi1oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Eyl8c0bI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cqmDWnYr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:54:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628452;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTXirJv0YLTmYlGb5vsRN+8tyoKOrp6FUv6Rg8uHSoc=;
	b=Eyl8c0bIaHGUsgwg/k7iKLwJUjGRowYg72ghwCBjXkDf1aTl7lIxd9y/jmTyF4tLQyCI6V
	FNINqxP5J4V6HrfrzEmqdKXu6bLIGhsrLf3vrkitRFXuURWOHTHwUwJaMa7vhXD6DUYKYM
	XC3FFmORDnuTHINnSttxBh6ufHHhQr156ScWjC4fjLjOzCm5ukbAqSCaqaR5sP9udf7RWM
	d5ddtCBd47QNkYQftYP6//SUKEXcAmb4KP+RLbfBiqk4E53bkk0zTJdO9eihJSIvNjMFgh
	TFtpCbmcqqPUYproqrdhdLSjJrW7sxhyk0jKsewS5eauFxyJntIByWUcRdphdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628452;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTXirJv0YLTmYlGb5vsRN+8tyoKOrp6FUv6Rg8uHSoc=;
	b=cqmDWnYra+Ko6I/ywGBNwFQ/bF84QD9BdojAWOwnU3fSf/rTaidTOI3bHyTkdQXHLjdD3W
	fESVn8KwLfrOaUCg==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] crypto: Enable context analysis
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-36-elver@google.com>
References: <20251219154418.3592607-36-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762845083.510.14318835233555993439.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     dc36d55d4e7259ff0f91a154744125ccc2228171
Gitweb:        https://git.kernel.org/tip/dc36d55d4e7259ff0f91a154744125ccc22=
28171
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:40:24 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:36 +01:00

crypto: Enable context analysis

Enable context analysis for crypto subsystem.

This demonstrates a larger conversion to use Clang's context
analysis. The benefit is additional static checking of locking rules,
along with better documentation.

Note the use of the __acquire_ret macro how to define an API where a
function returns a pointer to an object (struct scomp_scratch) with a
lock held. Additionally, the analysis only resolves aliases where the
analysis unambiguously sees that a variable was not reassigned after
initialization, requiring minor code changes.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251219154418.3592607-36-elver@google.com
---
 crypto/Makefile                     |  2 ++
 crypto/acompress.c                  |  6 +++---
 crypto/algapi.c                     |  2 ++
 crypto/api.c                        |  1 +
 crypto/crypto_engine.c              |  2 +-
 crypto/drbg.c                       |  5 +++++
 crypto/internal.h                   |  2 +-
 crypto/proc.c                       |  3 +++
 crypto/scompress.c                  | 24 ++++++++++++------------
 include/crypto/internal/acompress.h |  7 ++++---
 include/crypto/internal/engine.h    |  2 +-
 11 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/crypto/Makefile b/crypto/Makefile
index 16a3564..db264fe 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -3,6 +3,8 @@
 # Cryptographic API
 #
=20
+CONTEXT_ANALYSIS :=3D y
+
 obj-$(CONFIG_CRYPTO) +=3D crypto.o
 crypto-y :=3D api.o cipher.o
=20
diff --git a/crypto/acompress.c b/crypto/acompress.c
index be28cbf..25df368 100644
--- a/crypto/acompress.c
+++ b/crypto/acompress.c
@@ -449,8 +449,8 @@ int crypto_acomp_alloc_streams(struct crypto_acomp_stream=
s *s)
 }
 EXPORT_SYMBOL_GPL(crypto_acomp_alloc_streams);
=20
-struct crypto_acomp_stream *crypto_acomp_lock_stream_bh(
-	struct crypto_acomp_streams *s) __acquires(stream)
+struct crypto_acomp_stream *_crypto_acomp_lock_stream_bh(
+	struct crypto_acomp_streams *s)
 {
 	struct crypto_acomp_stream __percpu *streams =3D s->streams;
 	int cpu =3D raw_smp_processor_id();
@@ -469,7 +469,7 @@ struct crypto_acomp_stream *crypto_acomp_lock_stream_bh(
 	spin_lock(&ps->lock);
 	return ps;
 }
-EXPORT_SYMBOL_GPL(crypto_acomp_lock_stream_bh);
+EXPORT_SYMBOL_GPL(_crypto_acomp_lock_stream_bh);
=20
 void acomp_walk_done_src(struct acomp_walk *walk, int used)
 {
diff --git a/crypto/algapi.c b/crypto/algapi.c
index e604d0d..abc9333 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -244,6 +244,7 @@ EXPORT_SYMBOL_GPL(crypto_remove_spawns);
=20
 static void crypto_alg_finish_registration(struct crypto_alg *alg,
 					   struct list_head *algs_to_put)
+	__must_hold(&crypto_alg_sem)
 {
 	struct crypto_alg *q;
=20
@@ -299,6 +300,7 @@ static struct crypto_larval *crypto_alloc_test_larval(str=
uct crypto_alg *alg)
=20
 static struct crypto_larval *
 __crypto_register_alg(struct crypto_alg *alg, struct list_head *algs_to_put)
+	__must_hold(&crypto_alg_sem)
 {
 	struct crypto_alg *q;
 	struct crypto_larval *larval;
diff --git a/crypto/api.c b/crypto/api.c
index 5724d62..0562964 100644
--- a/crypto/api.c
+++ b/crypto/api.c
@@ -57,6 +57,7 @@ EXPORT_SYMBOL_GPL(crypto_mod_put);
=20
 static struct crypto_alg *__crypto_alg_lookup(const char *name, u32 type,
 					      u32 mask)
+	__must_hold_shared(&crypto_alg_sem)
 {
 	struct crypto_alg *q, *alg =3D NULL;
 	int best =3D -2;
diff --git a/crypto/crypto_engine.c b/crypto/crypto_engine.c
index 18e1689..1653a4b 100644
--- a/crypto/crypto_engine.c
+++ b/crypto/crypto_engine.c
@@ -453,8 +453,8 @@ struct crypto_engine *crypto_engine_alloc_init_and_set(st=
ruct device *dev,
 	snprintf(engine->name, sizeof(engine->name),
 		 "%s-engine", dev_name(dev));
=20
-	crypto_init_queue(&engine->queue, qlen);
 	spin_lock_init(&engine->queue_lock);
+	crypto_init_queue(&engine->queue, qlen);
=20
 	engine->kworker =3D kthread_run_worker(0, "%s", engine->name);
 	if (IS_ERR(engine->kworker)) {
diff --git a/crypto/drbg.c b/crypto/drbg.c
index 1d433da..0a6f6c0 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -232,6 +232,7 @@ static inline unsigned short drbg_sec_strength(drbg_flag_=
t flags)
  */
 static int drbg_fips_continuous_test(struct drbg_state *drbg,
 				     const unsigned char *entropy)
+	__must_hold(&drbg->drbg_mutex)
 {
 	unsigned short entropylen =3D drbg_sec_strength(drbg->core->flags);
 	int ret =3D 0;
@@ -848,6 +849,7 @@ static inline int __drbg_seed(struct drbg_state *drbg, st=
ruct list_head *seed,
 static inline int drbg_get_random_bytes(struct drbg_state *drbg,
 					unsigned char *entropy,
 					unsigned int entropylen)
+	__must_hold(&drbg->drbg_mutex)
 {
 	int ret;
=20
@@ -862,6 +864,7 @@ static inline int drbg_get_random_bytes(struct drbg_state=
 *drbg,
 }
=20
 static int drbg_seed_from_random(struct drbg_state *drbg)
+	__must_hold(&drbg->drbg_mutex)
 {
 	struct drbg_string data;
 	LIST_HEAD(seedlist);
@@ -919,6 +922,7 @@ static bool drbg_nopr_reseed_interval_elapsed(struct drbg=
_state *drbg)
  */
 static int drbg_seed(struct drbg_state *drbg, struct drbg_string *pers,
 		     bool reseed)
+	__must_hold(&drbg->drbg_mutex)
 {
 	int ret;
 	unsigned char entropy[((32 + 16) * 2)];
@@ -1153,6 +1157,7 @@ err:
 static int drbg_generate(struct drbg_state *drbg,
 			 unsigned char *buf, unsigned int buflen,
 			 struct drbg_string *addtl)
+	__must_hold(&drbg->drbg_mutex)
 {
 	int len =3D 0;
 	LIST_HEAD(addtllist);
diff --git a/crypto/internal.h b/crypto/internal.h
index b9afd68..8fbe022 100644
--- a/crypto/internal.h
+++ b/crypto/internal.h
@@ -61,8 +61,8 @@ enum {
 /* Maximum number of (rtattr) parameters for each template. */
 #define CRYPTO_MAX_ATTRS 32
=20
-extern struct list_head crypto_alg_list;
 extern struct rw_semaphore crypto_alg_sem;
+extern struct list_head crypto_alg_list __guarded_by(&crypto_alg_sem);
 extern struct blocking_notifier_head crypto_chain;
=20
 int alg_test(const char *driver, const char *alg, u32 type, u32 mask);
diff --git a/crypto/proc.c b/crypto/proc.c
index 82f15b9..5fb9fe8 100644
--- a/crypto/proc.c
+++ b/crypto/proc.c
@@ -19,17 +19,20 @@
 #include "internal.h"
=20
 static void *c_start(struct seq_file *m, loff_t *pos)
+	__acquires_shared(&crypto_alg_sem)
 {
 	down_read(&crypto_alg_sem);
 	return seq_list_start(&crypto_alg_list, *pos);
 }
=20
 static void *c_next(struct seq_file *m, void *p, loff_t *pos)
+	__must_hold_shared(&crypto_alg_sem)
 {
 	return seq_list_next(p, &crypto_alg_list, pos);
 }
=20
 static void c_stop(struct seq_file *m, void *p)
+	__releases_shared(&crypto_alg_sem)
 {
 	up_read(&crypto_alg_sem);
 }
diff --git a/crypto/scompress.c b/crypto/scompress.c
index 1a7ed8a..7aee1d5 100644
--- a/crypto/scompress.c
+++ b/crypto/scompress.c
@@ -28,8 +28,8 @@
 struct scomp_scratch {
 	spinlock_t	lock;
 	union {
-		void	*src;
-		unsigned long saddr;
+		void	*src __guarded_by(&lock);
+		unsigned long saddr __guarded_by(&lock);
 	};
 };
=20
@@ -38,8 +38,8 @@ static DEFINE_PER_CPU(struct scomp_scratch, scomp_scratch) =
=3D {
 };
=20
 static const struct crypto_type crypto_scomp_type;
-static int scomp_scratch_users;
 static DEFINE_MUTEX(scomp_lock);
+static int scomp_scratch_users __guarded_by(&scomp_lock);
=20
 static cpumask_t scomp_scratch_want;
 static void scomp_scratch_workfn(struct work_struct *work);
@@ -67,6 +67,7 @@ static void crypto_scomp_show(struct seq_file *m, struct cr=
ypto_alg *alg)
 }
=20
 static void crypto_scomp_free_scratches(void)
+	__context_unsafe(/* frees @scratch */)
 {
 	struct scomp_scratch *scratch;
 	int i;
@@ -101,7 +102,7 @@ static void scomp_scratch_workfn(struct work_struct *work)
 		struct scomp_scratch *scratch;
=20
 		scratch =3D per_cpu_ptr(&scomp_scratch, cpu);
-		if (scratch->src)
+		if (context_unsafe(scratch->src))
 			continue;
 		if (scomp_alloc_scratch(scratch, cpu))
 			break;
@@ -111,6 +112,7 @@ static void scomp_scratch_workfn(struct work_struct *work)
 }
=20
 static int crypto_scomp_alloc_scratches(void)
+	__context_unsafe(/* allocates @scratch */)
 {
 	unsigned int i =3D cpumask_first(cpu_possible_mask);
 	struct scomp_scratch *scratch;
@@ -139,7 +141,8 @@ unlock:
 	return ret;
 }
=20
-static struct scomp_scratch *scomp_lock_scratch(void) __acquires(scratch)
+#define scomp_lock_scratch(...) __acquire_ret(_scomp_lock_scratch(__VA_ARGS_=
_), &__ret->lock)
+static struct scomp_scratch *_scomp_lock_scratch(void) __acquires_ret
 {
 	int cpu =3D raw_smp_processor_id();
 	struct scomp_scratch *scratch;
@@ -159,7 +162,7 @@ static struct scomp_scratch *scomp_lock_scratch(void) __a=
cquires(scratch)
 }
=20
 static inline void scomp_unlock_scratch(struct scomp_scratch *scratch)
-	__releases(scratch)
+	__releases(&scratch->lock)
 {
 	spin_unlock(&scratch->lock);
 }
@@ -171,8 +174,6 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req,=
 int dir)
 	bool src_isvirt =3D acomp_request_src_isvirt(req);
 	bool dst_isvirt =3D acomp_request_dst_isvirt(req);
 	struct crypto_scomp *scomp =3D *tfm_ctx;
-	struct crypto_acomp_stream *stream;
-	struct scomp_scratch *scratch;
 	unsigned int slen =3D req->slen;
 	unsigned int dlen =3D req->dlen;
 	struct page *spage, *dpage;
@@ -232,13 +233,12 @@ static int scomp_acomp_comp_decomp(struct acomp_req *re=
q, int dir)
 		} while (0);
 	}
=20
-	stream =3D crypto_acomp_lock_stream_bh(&crypto_scomp_alg(scomp)->streams);
+	struct crypto_acomp_stream *stream =3D crypto_acomp_lock_stream_bh(&crypto_=
scomp_alg(scomp)->streams);
=20
 	if (!src_isvirt && !src) {
-		const u8 *src;
+		struct scomp_scratch *scratch =3D scomp_lock_scratch();
+		const u8 *src =3D scratch->src;
=20
-		scratch =3D scomp_lock_scratch();
-		src =3D scratch->src;
 		memcpy_from_sglist(scratch->src, req->src, 0, slen);
=20
 		if (dir)
diff --git a/include/crypto/internal/acompress.h b/include/crypto/internal/ac=
ompress.h
index 2d97440..9a3f28b 100644
--- a/include/crypto/internal/acompress.h
+++ b/include/crypto/internal/acompress.h
@@ -191,11 +191,12 @@ static inline bool crypto_acomp_req_virt(struct crypto_=
acomp *tfm)
 void crypto_acomp_free_streams(struct crypto_acomp_streams *s);
 int crypto_acomp_alloc_streams(struct crypto_acomp_streams *s);
=20
-struct crypto_acomp_stream *crypto_acomp_lock_stream_bh(
-	struct crypto_acomp_streams *s) __acquires(stream);
+#define crypto_acomp_lock_stream_bh(...) __acquire_ret(_crypto_acomp_lock_st=
ream_bh(__VA_ARGS__), &__ret->lock);
+struct crypto_acomp_stream *_crypto_acomp_lock_stream_bh(
+		struct crypto_acomp_streams *s) __acquires_ret;
=20
 static inline void crypto_acomp_unlock_stream_bh(
-	struct crypto_acomp_stream *stream) __releases(stream)
+	struct crypto_acomp_stream *stream) __releases(&stream->lock)
 {
 	spin_unlock_bh(&stream->lock);
 }
diff --git a/include/crypto/internal/engine.h b/include/crypto/internal/engin=
e.h
index f19ef37..6a1d278 100644
--- a/include/crypto/internal/engine.h
+++ b/include/crypto/internal/engine.h
@@ -45,7 +45,7 @@ struct crypto_engine {
=20
 	struct list_head	list;
 	spinlock_t		queue_lock;
-	struct crypto_queue	queue;
+	struct crypto_queue	queue __guarded_by(&queue_lock);
 	struct device		*dev;
=20
 	struct kthread_worker           *kworker;

