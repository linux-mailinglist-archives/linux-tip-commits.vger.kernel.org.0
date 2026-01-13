Return-Path: <linux-tip-commits+bounces-7912-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDA2D1834F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3BF93055000
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0010038B7BF;
	Tue, 13 Jan 2026 10:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2U+loYdN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R0GeKGVD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7E838A9A3;
	Tue, 13 Jan 2026 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301384; cv=none; b=AhhyPWZidAl0o+5SR4r/e3evReaOwvPCzzKewAgJlfW5UgbR21j4BIAbFo41CyWwp18VEuRoUSyob2+gJx7/ef283MrMRoWM3GcU5TMCnGpx5POEAoqSLgBdVgr0INDwnbuUjxkawlg6+wB73yyV8Kg9UnaLRRQ8kJmuoiYrcdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301384; c=relaxed/simple;
	bh=7D2albGIDfRKRZoH3494t9qDB0vLrVDm+qZhoDG4sPQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dVTuNsXNtESVHsCYIZw3May9n1DFaGRlvvDLJL5EIlsqMSwj+eDl2zoG6Rw3r1vUr6wpnsFFssSxFMWsm9gq4FTFBzFuJLytrKRM2vzL1Fh19XUqrWin9gca7uvQEZFV0zJdHjCtk7ipFeAg+Gu0H0TRihM6jj1lfI50/nNpWHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2U+loYdN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R0GeKGVD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:49:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301381;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=akS9hz0IjwPcT5va9ohMVsqRnoy+SSJNOg4hax3d/VQ=;
	b=2U+loYdN2J7fq00pHKJHLO8MCaVmqbWHvnVcaN6aWEl6Z/pT8KkPgGtI8x+IdnfuCQmqRE
	qRi2lxs4cfGqDT3bE8snhVEW3+CSkYg0Azbhw8w//s0rQP3oheIRx6l1WopVhGSTBmEJvU
	HR0Ov6z7L/CigbUs2ZLnpkd922q5gNEIk9S5opSXNsMdTbrqLe8i5nsTe14UL21kUUB1ev
	j6XS7nnTN0/F+aZGp25ozd6E+UX+VmLCB6vZOzrml5mm5nqEqlV2kJjh9UgOpFAhhgdvpP
	JVu9SW7pmcYTbsQ1KPC8ImsrCbVyZ1lTX55E0iVN4MwlLH/miJdyhYxjrYqvdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301381;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=akS9hz0IjwPcT5va9ohMVsqRnoy+SSJNOg4hax3d/VQ=;
	b=R0GeKGVD+z1V7RtnRxh7+Iq43Ly0w1r7X5h2T8E1948ZnAP6FwktBlaQAtNIeUKubsRwuG
	jnhAhYSQ2BnXsFCw==
From: "tip-bot2 for Alice Ryhl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: Add __rust_helper to helpers
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Alice Ryhl <aliceryhl@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260105-define-rust-helper-v2-20-51da5f454a67@google.com>
References: <20260105-define-rust-helper-v2-20-51da5f454a67@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830138010.510.3270228923379334787.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d4ad4de929ba27ed241c6ef1098b1687001ced1f
Gitweb:        https://git.kernel.org/tip/d4ad4de929ba27ed241c6ef1098b1687001=
ced1f
Author:        Alice Ryhl <aliceryhl@google.com>
AuthorDate:    Mon, 05 Jan 2026 12:42:33=20
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:42 +08:00

rust: sync: Add __rust_helper to helpers

This is needed to inline these helpers into Rust code.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20260105-define-rust-helper-v2-20-51da5f454a67=
@google.com
---
 rust/helpers/mutex.c    | 13 +++++++------
 rust/helpers/spinlock.c | 13 +++++++------
 rust/helpers/sync.c     |  4 ++--
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/rust/helpers/mutex.c b/rust/helpers/mutex.c
index e487819..1b07d6e 100644
--- a/rust/helpers/mutex.c
+++ b/rust/helpers/mutex.c
@@ -2,28 +2,29 @@
=20
 #include <linux/mutex.h>
=20
-void rust_helper_mutex_lock(struct mutex *lock)
+__rust_helper void rust_helper_mutex_lock(struct mutex *lock)
 {
 	mutex_lock(lock);
 }
=20
-int rust_helper_mutex_trylock(struct mutex *lock)
+__rust_helper int rust_helper_mutex_trylock(struct mutex *lock)
 {
 	return mutex_trylock(lock);
 }
=20
-void rust_helper___mutex_init(struct mutex *mutex, const char *name,
-			      struct lock_class_key *key)
+__rust_helper void rust_helper___mutex_init(struct mutex *mutex,
+					    const char *name,
+					    struct lock_class_key *key)
 {
 	__mutex_init(mutex, name, key);
 }
=20
-void rust_helper_mutex_assert_is_held(struct mutex *mutex)
+__rust_helper void rust_helper_mutex_assert_is_held(struct mutex *mutex)
 {
 	lockdep_assert_held(mutex);
 }
=20
-void rust_helper_mutex_destroy(struct mutex *lock)
+__rust_helper void rust_helper_mutex_destroy(struct mutex *lock)
 {
 	mutex_destroy(lock);
 }
diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
index 42c4bf0..4d13062 100644
--- a/rust/helpers/spinlock.c
+++ b/rust/helpers/spinlock.c
@@ -2,8 +2,9 @@
=20
 #include <linux/spinlock.h>
=20
-void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
-				  struct lock_class_key *key)
+__rust_helper void rust_helper___spin_lock_init(spinlock_t *lock,
+						const char *name,
+						struct lock_class_key *key)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
 # if defined(CONFIG_PREEMPT_RT)
@@ -16,22 +17,22 @@ void rust_helper___spin_lock_init(spinlock_t *lock, const=
 char *name,
 #endif /* CONFIG_DEBUG_SPINLOCK */
 }
=20
-void rust_helper_spin_lock(spinlock_t *lock)
+__rust_helper void rust_helper_spin_lock(spinlock_t *lock)
 {
 	spin_lock(lock);
 }
=20
-void rust_helper_spin_unlock(spinlock_t *lock)
+__rust_helper void rust_helper_spin_unlock(spinlock_t *lock)
 {
 	spin_unlock(lock);
 }
=20
-int rust_helper_spin_trylock(spinlock_t *lock)
+__rust_helper int rust_helper_spin_trylock(spinlock_t *lock)
 {
 	return spin_trylock(lock);
 }
=20
-void rust_helper_spin_assert_is_held(spinlock_t *lock)
+__rust_helper void rust_helper_spin_assert_is_held(spinlock_t *lock)
 {
 	lockdep_assert_held(lock);
 }
diff --git a/rust/helpers/sync.c b/rust/helpers/sync.c
index ff7e68b..82d6aff 100644
--- a/rust/helpers/sync.c
+++ b/rust/helpers/sync.c
@@ -2,12 +2,12 @@
=20
 #include <linux/lockdep.h>
=20
-void rust_helper_lockdep_register_key(struct lock_class_key *k)
+__rust_helper void rust_helper_lockdep_register_key(struct lock_class_key *k)
 {
 	lockdep_register_key(k);
 }
=20
-void rust_helper_lockdep_unregister_key(struct lock_class_key *k)
+__rust_helper void rust_helper_lockdep_unregister_key(struct lock_class_key =
*k)
 {
 	lockdep_unregister_key(k);
 }

