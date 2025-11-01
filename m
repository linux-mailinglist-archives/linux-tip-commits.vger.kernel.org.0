Return-Path: <linux-tip-commits+bounces-7147-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A110C2872B
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5C61895A4D
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758D130BF74;
	Sat,  1 Nov 2025 19:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ldsULxg+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BhILaP5S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C2B30B529;
	Sat,  1 Nov 2025 19:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026477; cv=none; b=OBslBADROjdSXzzCjZrgADkhNUviVX3MAObKfl7rgpjgJTWwOpD5f5FDkpuRlA40z/JXuxZR5OLgYsOlOhuPLQnLXPiAfn92IybVsnL8ZWFhTGSmhu7sXBa45Hk5X5aVcGE1lhxCXSULVUM61YVbg/cimwhVVB8dVMUvyfmsX5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026477; c=relaxed/simple;
	bh=Tkb0MO6nRucwXK65hj1i/PE9aHAKmoENSYPrEZh4nzA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=l5GMPFyuwrYZ0YcYN97rar3ScDHXgqhKTINK938zD/FiHC1DPdhebei9UDJjBwcl50w2w3uRSAYsn/dZ4hl/tgYHGuumGEBtcItIXCuJR4m3TTp47HBSXJUUTgAZEY3HlcbER7PIv1pbjZJgTvqLfPd4uLmQocehxCons+zb0Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ldsULxg+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BhILaP5S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:47:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026474;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qJUbl8hatECP/QqxuTy4oVV/4WDSB+YaJfhqHc/nwkk=;
	b=ldsULxg+B1NB/HMuJZtEezscr7i+9k0kkskFeeqjS12qnOi5eQWmD47v8E1T3x9LQpIj7k
	zJ+zI7f6rSWg8vs8VhoPUqsivU9UvT5ZoPBGeCgLlxvbYjW+3r/O0SHPsQd0ucb8ZU7FzM
	TswyLaKianSbzPCgNNdkFIyN+n1iMVXfgITmUFlYi+wHUnfDAtptieaCTPXACqek/drsvO
	GfkBXHXmHbDuXrml6c5xeq2ZLQY5HDQeMjLRbD8NgHiQuNB2rdXPudDD8e8efiT8QVddIR
	R7hBRAxl31DnB8yIWloV8RwFqCxRUXKIU5Et3UaTG+8BO0nHgyjrZ1YKWqtmTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026474;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qJUbl8hatECP/QqxuTy4oVV/4WDSB+YaJfhqHc/nwkk=;
	b=BhILaP5SUaIsXCHqf/Uy+LtGdOdumRhSZ9K8Sxs14/Z1AlbHqWzwy0WlBnzLODjOTs4DFM
	dBz5Jb/yPov5BoBg==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] random: vDSO: Only access vDSO datapage after
 random_init()
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20251014-vdso-sparc64-generic-2-v4-19-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-19-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202647299.2601451.467843181214566256.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     e5ec11b3da6d37dc2150007b34afca871c6b8fb4
Gitweb:        https://git.kernel.org/tip/e5ec11b3da6d37dc2150007b34afca871c6=
b8fb4
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:49:05 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:05 +01:00

random: vDSO: Only access vDSO datapage after random_init()

Upcoming changes to the generic vDSO library will mean that the vDSO
datapage will not yet be usable during early boot.

Introduce a static key which prevents early accesses.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-19-e0607bf4=
9dea@linutronix.de
---
 drivers/char/random.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 73c53a4..f39524f 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -88,6 +88,7 @@ static DEFINE_STATIC_KEY_FALSE(crng_is_ready);
 static DECLARE_WAIT_QUEUE_HEAD(crng_init_wait);
 static struct fasync_struct *fasync;
 static ATOMIC_NOTIFIER_HEAD(random_ready_notifier);
+static DEFINE_STATIC_KEY_FALSE(random_vdso_is_ready);
=20
 /* Control how we warn userspace. */
 static struct ratelimit_state urandom_warning =3D
@@ -252,6 +253,9 @@ static void random_vdso_update_generation(unsigned long n=
ext_gen)
 	if (!IS_ENABLED(CONFIG_VDSO_GETRANDOM))
 		return;
=20
+	if (!static_branch_likely(&random_vdso_is_ready))
+		return;
+
 	/* base_crng.generation's invalid value is ULONG_MAX, while
 	 * vdso_k_rng_data->generation's invalid value is 0, so add one to the
 	 * former to arrive at the latter. Use smp_store_release so that this
@@ -274,6 +278,9 @@ static void random_vdso_set_ready(void)
 	if (!IS_ENABLED(CONFIG_VDSO_GETRANDOM))
 		return;
=20
+	if (!static_branch_likely(&random_vdso_is_ready))
+		return;
+
 	WRITE_ONCE(vdso_k_rng_data->is_ready, true);
 }
=20
@@ -925,6 +932,9 @@ void __init random_init(void)
 	_mix_pool_bytes(&entropy, sizeof(entropy));
 	add_latent_entropy();
=20
+	if (IS_ENABLED(CONFIG_VDSO_GETRANDOM))
+		static_branch_enable(&random_vdso_is_ready);
+
 	/*
 	 * If we were initialized by the cpu or bootloader before jump labels
 	 * or workqueues are initialized, then we should enable the static
@@ -934,8 +944,10 @@ void __init random_init(void)
 		crng_set_ready(NULL);
=20
 	/* Reseed if already seeded by earlier phases. */
-	if (crng_ready())
+	if (crng_ready()) {
 		crng_reseed(NULL);
+		random_vdso_set_ready();
+	}
=20
 	WARN_ON(register_pm_notifier(&pm_notifier));
=20

