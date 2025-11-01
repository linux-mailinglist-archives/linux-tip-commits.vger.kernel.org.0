Return-Path: <linux-tip-commits+bounces-7148-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CCAC28713
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D3C84EBF55
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC6030C624;
	Sat,  1 Nov 2025 19:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d5o1FNf5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tZX7j06s"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A5830BF7D;
	Sat,  1 Nov 2025 19:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026478; cv=none; b=ub4WmuHtjuH1QGhWPJr2xs/TEOi8gWnGeJHPNHTckhOSpYp0UCsI4kGU5M75Ztbg+YReA+gu4gs3g6g4Rw+WB+SINdO6w52T5SRvvDlqI8g2Pw0YWi0G7Njn13nSSdsxEWeRcWG1wllXnY0xzB69TSDr+Vevm3/ZbhzmazrIl20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026478; c=relaxed/simple;
	bh=H4tN8HolrFldMpY2rUsO5B2tRLBdeKJO45/f/7rNoSg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XN3S+zIkUuTM0TCJxBxlTPHyHD/KcUONUVyA8NAG3SFVlV+MCgGCEMsjYI8NaC7tyg0ndG9YvG7vW2wZZ6muNtiN7ypx5iGW8Wy4Jsd2bbJhil3ZG3Jerws3JaTQquZEn0s7+oKba94hUMT4kfqaRmnWdFQgauceGN3oTcbuxZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d5o1FNf5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tZX7j06s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:47:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026475;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/FTp9qHtcvg0XC6goGQWkDBXkQfbrdiUuT+kh2BWf8=;
	b=d5o1FNf5H7WVEyBq7vR75lqlUWFvnrgRQOllJeq4kXtldLhjKHZbHJ8Z6J28la3leiXljL
	+z3uhn3le/2PZ0BO7FtuKcofsK8Lc/90bFZyZZ9xL7pVEDSf/YlVuUbV3tgoLSaCvJISfZ
	X/ZvoLrqfM4l1wZIKf66qX6bX0RbnTTKzqUdFId326lTXfo4KK0MzZv+xrXTOe1Z/V3Zy0
	WdbT/pIIze6yhOVmcH6pZAIBDiNqvQbxy2MVBDaeMDm/bUrtWzXEwGRuTKPThPw3ihrgEn
	Yy3ru7/uprTSNORLn2dG3w+Uu/I94LzIZAZr5vqDeUI1yIfsbDltJuNUlBxV3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026475;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/FTp9qHtcvg0XC6goGQWkDBXkQfbrdiUuT+kh2BWf8=;
	b=tZX7j06sS+gTvyVNMYClC8bSTW4+4me+I/7iUwMvlXLUIQ16Q9ovC/E/rL3Tg1L6C6assp
	ZlHG0hBNFPCWQPCQ==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] random: vDSO: Split out datapage update into
 helper functions
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20251014-vdso-sparc64-generic-2-v4-18-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-18-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202647422.2601451.4246149334422878805.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     f9e5f71bfb88878e203afe0efe4828e790442c8f
Gitweb:        https://git.kernel.org/tip/f9e5f71bfb88878e203afe0efe4828e7904=
42c8f
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:49:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:05 +01:00

random: vDSO: Split out datapage update into helper functions

Some upcoming changes will introduce additional callers of them.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-18-e0607bf4=
9dea@linutronix.de
---
 drivers/char/random.c | 51 +++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index b0b88c6..73c53a4 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -246,6 +246,37 @@ static unsigned int crng_reseed_interval(void)
 /* Used by crng_reseed() and crng_make_state() to extract a new seed from th=
e input pool. */
 static void extract_entropy(void *buf, size_t len);
=20
+/* This updates the generation in the vDSO data page */
+static void random_vdso_update_generation(unsigned long next_gen)
+{
+	if (!IS_ENABLED(CONFIG_VDSO_GETRANDOM))
+		return;
+
+	/* base_crng.generation's invalid value is ULONG_MAX, while
+	 * vdso_k_rng_data->generation's invalid value is 0, so add one to the
+	 * former to arrive at the latter. Use smp_store_release so that this
+	 * is ordered with the write above to base_crng.generation. Pairs with
+	 * the smp_rmb() before the syscall in the vDSO code.
+	 *
+	 * Cast to unsigned long for 32-bit architectures, since atomic 64-bit
+	 * operations are not supported on those architectures. This is safe
+	 * because base_crng.generation is a 32-bit value. On big-endian
+	 * architectures it will be stored in the upper 32 bits, but that's okay
+	 * because the vDSO side only checks whether the value changed, without
+	 * actually using or interpreting the value.
+	 */
+	smp_store_release((unsigned long *)&vdso_k_rng_data->generation, next_gen +=
 1);
+}
+
+/* This sets is_ready in the vDSO data page */
+static void random_vdso_set_ready(void)
+{
+	if (!IS_ENABLED(CONFIG_VDSO_GETRANDOM))
+		return;
+
+	WRITE_ONCE(vdso_k_rng_data->is_ready, true);
+}
+
 /* This extracts a new crng key from the input pool. */
 static void crng_reseed(struct work_struct *work)
 {
@@ -272,22 +303,7 @@ static void crng_reseed(struct work_struct *work)
 	if (next_gen =3D=3D ULONG_MAX)
 		++next_gen;
 	WRITE_ONCE(base_crng.generation, next_gen);
-
-	/* base_crng.generation's invalid value is ULONG_MAX, while
-	 * vdso_k_rng_data->generation's invalid value is 0, so add one to the
-	 * former to arrive at the latter. Use smp_store_release so that this
-	 * is ordered with the write above to base_crng.generation. Pairs with
-	 * the smp_rmb() before the syscall in the vDSO code.
-	 *
-	 * Cast to unsigned long for 32-bit architectures, since atomic 64-bit
-	 * operations are not supported on those architectures. This is safe
-	 * because base_crng.generation is a 32-bit value. On big-endian
-	 * architectures it will be stored in the upper 32 bits, but that's okay
-	 * because the vDSO side only checks whether the value changed, without
-	 * actually using or interpreting the value.
-	 */
-	if (IS_ENABLED(CONFIG_VDSO_GETRANDOM))
-		smp_store_release((unsigned long *)&vdso_k_rng_data->generation, next_gen =
+ 1);
+	random_vdso_update_generation(next_gen);
=20
 	if (!static_branch_likely(&crng_is_ready))
 		crng_init =3D CRNG_READY;
@@ -741,8 +757,7 @@ static void __cold _credit_init_bits(size_t bits)
 		if (static_key_initialized && system_unbound_wq)
 			queue_work(system_unbound_wq, &set_ready);
 		atomic_notifier_call_chain(&random_ready_notifier, 0, NULL);
-		if (IS_ENABLED(CONFIG_VDSO_GETRANDOM))
-			WRITE_ONCE(vdso_k_rng_data->is_ready, true);
+		random_vdso_set_ready();
 		wake_up_interruptible(&crng_init_wait);
 		kill_fasync(&fasync, SIGIO, POLL_IN);
 		pr_notice("crng init done\n");

