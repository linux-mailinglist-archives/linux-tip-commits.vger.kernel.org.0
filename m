Return-Path: <linux-tip-commits+bounces-8267-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WI+jLv/Jomnz5QQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8267-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 11:57:03 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B221C25C7
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 11:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA480305BF73
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 10:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C635E42883A;
	Sat, 28 Feb 2026 10:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tGtAo8uo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hztq7g4H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D99842884C;
	Sat, 28 Feb 2026 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772276200; cv=none; b=Oz3/9lqTT0a0gpkbSMqwFwIa20w0aMdjy8oPW9CQMEB7a40ir4tfujhHoO/q51/wUE9NsUXWMbgC6oFvFOCeG0FDezXdQQhv695a7AfNE+h7x0Kr1xoq+v7vIxv9sCJcoztMN0GncEXFZ8lwPSOZLCOxCwRLUIGfYXgR90wZoW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772276200; c=relaxed/simple;
	bh=yjKlE3FU2FT8hp/n1JWYOJsQzyLeM3YWI4E4BYNZrRA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sdOFw1y3hXpQCP/clbZ5X8J3FSGT6NVQAVj+dhhsIm7JheBB0ShudEbEDJFnBYZ3QGqCmALQMOQZZ0Z0KBp2hduYnPvB4qR+TxGOpVit/wYkFF92fJZOdY154ZWVicUCuFMfnDg4fkO9Qs7KC8+hIw7IRKEHQBLb11shjoirvvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tGtAo8uo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hztq7g4H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 10:56:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772276190;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8fbgrKcaXJtVP8WgjrzAMRCEfaAdgpDLfu9VuG86Zn8=;
	b=tGtAo8uoRstUVUia3sCw18Dj507+ImkrzzQpYi0M1Nn1NerPuqD6Fjrjv8rk8/AK9fmVjr
	JFD0icVvEEvaCGschNzkqA5M5AY3qnD2X5AHxxBfQVTcjlgeqwi8eEYU0Ir/QQzbIS/sct
	+HIkELy96rec7F9RT00OEb8qpOCF9AGpnMsGgtS6zDd8pqWKA/pzLCeelsRznKQQDhHmbN
	BBDGpQXjLPMrE8oNiAzbuGh9hinCSGrBn4izCz3etxqzLYRyo+m2LkGQNoEnfv4EcgOtIp
	stP4WAvduzpILRrC9BWYvqMhnXOalTjZCZ9N2+GbORfyN+oaSZMcacwdt+U3OQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772276190;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8fbgrKcaXJtVP8WgjrzAMRCEfaAdgpDLfu9VuG86Zn8=;
	b=hztq7g4Hys9MBqRZ9M9rmGJpdBoZncZ0jyFXYycmddG9/yLXeQ6qomV2yKErr/Y79AKiht
	uBK8D9tc95v2YACg==
From: "tip-bot2 for Bart Van Assche" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] locking: Fix rwlock and spinlock lock context annotations
Cc: Bart Van Assche <bvanassche@acm.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Marco Elver <elver@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260225183244.4035378-2-bvanassche@acm.org>
References: <20260225183244.4035378-2-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177227618921.1647592.10577654819420686202.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8267-lists,linux-tip-commits=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 65B221C25C7
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     38e18d825f7281fdc16d3241df5115ce6eaeaf79
Gitweb:        https://git.kernel.org/tip/38e18d825f7281fdc16d3241df5115ce6ea=
eaf79
Author:        Bart Van Assche <bvanassche@acm.org>
AuthorDate:    Wed, 25 Feb 2026 10:32:41 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:19 +01:00

locking: Fix rwlock and spinlock lock context annotations

Fix two incorrect rwlock_t lock context annotations. Add the raw_spinlock_t
lock context annotations that are missing.

Fixes: f16a802d402d ("locking/rwlock, spinlock: Support Clang's context analy=
sis")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Marco Elver <elver@google.com>
Link: https://patch.msgid.link/20260225183244.4035378-2-bvanassche@acm.org
---
 include/linux/rwlock.h         | 4 ++--
 include/linux/rwlock_api_smp.h | 6 ++++--
 include/linux/spinlock.h       | 3 ++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/rwlock.h b/include/linux/rwlock.h
index 3390d21..21ceefc 100644
--- a/include/linux/rwlock.h
+++ b/include/linux/rwlock.h
@@ -30,10 +30,10 @@ do {								\
=20
 #ifdef CONFIG_DEBUG_SPINLOCK
  extern void do_raw_read_lock(rwlock_t *lock) __acquires_shared(lock);
- extern int do_raw_read_trylock(rwlock_t *lock);
+ extern int do_raw_read_trylock(rwlock_t *lock) __cond_acquires_shared(true,=
 lock);
  extern void do_raw_read_unlock(rwlock_t *lock) __releases_shared(lock);
  extern void do_raw_write_lock(rwlock_t *lock) __acquires(lock);
- extern int do_raw_write_trylock(rwlock_t *lock);
+extern int do_raw_write_trylock(rwlock_t *lock) __cond_acquires(true, lock);
  extern void do_raw_write_unlock(rwlock_t *lock) __releases(lock);
 #else
 # define do_raw_read_lock(rwlock)	do {__acquire_shared(lock); arch_read_lock=
(&(rwlock)->raw_lock); } while (0)
diff --git a/include/linux/rwlock_api_smp.h b/include/linux/rwlock_api_smp.h
index 61a8526..9e02a5f 100644
--- a/include/linux/rwlock_api_smp.h
+++ b/include/linux/rwlock_api_smp.h
@@ -23,7 +23,7 @@ void __lockfunc _raw_write_lock_bh(rwlock_t *lock)	__acquir=
es(lock);
 void __lockfunc _raw_read_lock_irq(rwlock_t *lock)	__acquires_shared(lock);
 void __lockfunc _raw_write_lock_irq(rwlock_t *lock)	__acquires(lock);
 unsigned long __lockfunc _raw_read_lock_irqsave(rwlock_t *lock)
-							__acquires(lock);
+							__acquires_shared(lock);
 unsigned long __lockfunc _raw_write_lock_irqsave(rwlock_t *lock)
 							__acquires(lock);
 int __lockfunc _raw_read_trylock(rwlock_t *lock)	__cond_acquires_shared(true=
, lock);
@@ -36,7 +36,7 @@ void __lockfunc _raw_read_unlock_irq(rwlock_t *lock)	__rele=
ases_shared(lock);
 void __lockfunc _raw_write_unlock_irq(rwlock_t *lock)	__releases(lock);
 void __lockfunc
 _raw_read_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
-							__releases(lock);
+							__releases_shared(lock);
 void __lockfunc
 _raw_write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 							__releases(lock);
@@ -116,6 +116,7 @@ _raw_write_unlock_irqrestore(rwlock_t *lock, unsigned lon=
g flags)
 #endif
=20
 static inline int __raw_read_trylock(rwlock_t *lock)
+	__cond_acquires_shared(true, lock)
 {
 	preempt_disable();
 	if (do_raw_read_trylock(lock)) {
@@ -127,6 +128,7 @@ static inline int __raw_read_trylock(rwlock_t *lock)
 }
=20
 static inline int __raw_write_trylock(rwlock_t *lock)
+	__cond_acquires(true, lock)
 {
 	preempt_disable();
 	if (do_raw_write_trylock(lock)) {
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index e1e2f14..241277c 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -178,7 +178,7 @@ do {									\
=20
 #ifdef CONFIG_DEBUG_SPINLOCK
  extern void do_raw_spin_lock(raw_spinlock_t *lock) __acquires(lock);
- extern int do_raw_spin_trylock(raw_spinlock_t *lock);
+ extern int do_raw_spin_trylock(raw_spinlock_t *lock) __cond_acquires(true, =
lock);
  extern void do_raw_spin_unlock(raw_spinlock_t *lock) __releases(lock);
 #else
 static inline void do_raw_spin_lock(raw_spinlock_t *lock) __acquires(lock)
@@ -189,6 +189,7 @@ static inline void do_raw_spin_lock(raw_spinlock_t *lock)=
 __acquires(lock)
 }
=20
 static inline int do_raw_spin_trylock(raw_spinlock_t *lock)
+	__cond_acquires(true, lock)
 {
 	int ret =3D arch_spin_trylock(&(lock)->raw_lock);
=20

