Return-Path: <linux-tip-commits+bounces-6396-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40341B3E71B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Sep 2025 16:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E039917F72D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Sep 2025 14:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FCF34165B;
	Mon,  1 Sep 2025 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Og0nWXto";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pTh+Ulvl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC3C322550;
	Mon,  1 Sep 2025 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736895; cv=none; b=WH98K2hQx9XKTF5+U0xwBmQl1T/nqjNiEh/GO1/qkYGj85+jcZzAQwSsd9ltCuwnKQmX9HKYozh6YHQ1ER6DFPYrM7/ARmqYMU79z8SW8HPp4EgQYXkp89Jhyv1EFky2xD/qYXGjk8haF0Y6DKpCyv0Jn7KzgTjZmH2umVu8ydA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736895; c=relaxed/simple;
	bh=oWQjKNR6r0+m8U/2uexKkjZ+3e4nrf8hnYLehGlTy0U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JRUbpnbnc16KQuhUO0pIE3l91Z3tpRY5Aule447ZgJGSnLz/VmdwPtxVq/84rgwbjiXND2rcmWDxm+2Aw84or4Y65F4460O9cu11Eqq/UNRsReX9wrWIModdOtPR25V/Mhsa/xTJFRwRKd5Dmy3d7dtbCrS2tO22+Z5yyGi8hbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Og0nWXto; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pTh+Ulvl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 01 Sep 2025 14:28:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756736892;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mTVRHUZX0GX1oZiUTCi6d4Z4GjSt13GEcU82R5kzf4E=;
	b=Og0nWXto1opN7XfXxfuq6Y6NQHVxs2fNeY5PGkdqOvITDnhbUmTuuNHjfBE98FUN/kJFv7
	z+789+ZkFS2KncScHyAeirezgfl/gg2togsFU4yBcvDrzz6F0wM1wgp8VbGWCsIj7OdpL2
	Y9FP2mOCO6TSd58Eb5ZXeIXPuwXpwt7FiGYYwk/SNqXHeeYgNDO8oBYUTBpFCoN9wVrage
	8K6gXbl3vE1ILqaN7DnM1dz5092X0Cm2TyTZ3qTzwVnuBDFFW/4ZPvXdbiC/yADdEYZazO
	8WSNhfFrdvOEmlm4P0FamDEfOSLZE9/DsifrazgdZ4ojjc9QE+SqZUhG5QBQuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756736892;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mTVRHUZX0GX1oZiUTCi6d4Z4GjSt13GEcU82R5kzf4E=;
	b=pTh+Ulvl60KGOXrN6yu0ltd0STIRytbP/hd+oDT+bT2PUEV61aLTgt/pGw8DowSHduCHD6
	ozftE9Ks6s2CBwAw==
From: "tip-bot2 for Gopi Krishna Menon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftests/futex: Fix typos and grammar in
 futex_priv_hash
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, andrealmeid@igalia.com,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250827130011.677600-5-bigeasy@linutronix.de>
References: <20250827130011.677600-5-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175673689128.1920.13217952138220412057.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     5fdb877b4916a1eb2b2c85018c2311855893405b
Gitweb:        https://git.kernel.org/tip/5fdb877b4916a1eb2b2c85018c231185589=
3405b
Author:        Gopi Krishna Menon <krishnagopi487@gmail.com>
AuthorDate:    Wed, 27 Aug 2025 15:00:10 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 01 Sep 2025 16:21:02 +02:00

selftests/futex: Fix typos and grammar in futex_priv_hash

Fix multiple typos and small grammar issues in help text, comments and test
messages in the futex_priv_hash test.

Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Link: https://lore.kernel.org/20250827130011.677600-5-bigeasy@linutronix.de
---
 tools/testing/selftests/futex/functional/futex_priv_hash.c | 8 +++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/too=
ls/testing/selftests/futex/functional/futex_priv_hash.c
index ffd60d0..95f0160 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -188,7 +188,7 @@ int main(int argc, char *argv[])
 	if (ret !=3D 0)
 		ksft_exit_fail_msg("pthread_join() failed: %d, %m\n", ret);
=20
-	/* First thread, has to initialiaze private hash */
+	/* First thread, has to initialize private hash */
 	futex_slots1 =3D futex_hash_slots_get();
 	if (futex_slots1 <=3D 0) {
 		ksft_print_msg("Current hash buckets: %d\n", futex_slots1);
@@ -256,17 +256,17 @@ retry_getslots:
=20
 	futex_hash_slots_set_verify(2);
 	join_max_threads();
-	ksft_test_result(counter =3D=3D MAX_THREADS, "Created of waited for %d of %=
d threads\n",
+	ksft_test_result(counter =3D=3D MAX_THREADS, "Created and waited for %d of =
%d threads\n",
 			 counter, MAX_THREADS);
 	counter =3D 0;
-	/* Once the user set something, auto reisze must be disabled */
+	/* Once the user set something, auto resize must be disabled */
 	ret =3D pthread_barrier_init(&barrier_main, NULL, MAX_THREADS);
=20
 	create_max_threads(thread_lock_fn);
 	join_max_threads();
=20
 	ret =3D futex_hash_slots_get();
-	ksft_test_result(ret =3D=3D 2, "No more auto-resize after manaul setting, g=
ot %d\n",
+	ksft_test_result(ret =3D=3D 2, "No more auto-resize after manual setting, g=
ot %d\n",
 			 ret);
=20
 	futex_hash_slots_set_must_fail(1 << 29);

