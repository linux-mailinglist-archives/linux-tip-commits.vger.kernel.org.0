Return-Path: <linux-tip-commits+bounces-7738-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3E0CC7B06
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 13:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F8573063C2C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 12:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50833451BF;
	Wed, 17 Dec 2025 12:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XVW5GymM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bJfR0kiS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F963446B7;
	Wed, 17 Dec 2025 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975088; cv=none; b=KbriYA2jN4nhZJRoHpMw93vAZ6hbhlZbFkfNKqxtWVQML6vmYCD6zGX2K7OwoyPArcFjflg82x18dnyVlsiJVcSjENNTYGMRwkQGL1fpJB5vMGFwsKfjnWADN6eHTldxWVwcelq3Rw0dQyLSivAYQ6RGZcnz18Ef86GAQ8HDL64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975088; c=relaxed/simple;
	bh=KoApPD5u+b/YYzw6sjOhKvoRzhDNVhDJJ1VCjfw77SA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ag3KoHezJOzZSgp0kohBZqpte0guxAryMpNyVbOTINvl3X3iGtSm7lPOpfEGCGkL+Mh02c7VhckTCyhsia0w6Z249AKV4O5obTvA4guLR46ntPfTy75JPpI0MWd0rA3aNEM9FcWLcnrHIsjh87zO61Hlp/2KakauMrxMaRmVd+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XVW5GymM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bJfR0kiS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Dec 2025 12:38:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765975085;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xU384yOPGk6V46Y0ZDQUp6ra+LJa5XpSo8F7PgyrDE8=;
	b=XVW5GymMsEjh9uCn03KWEtlvUbUl4JFgK9tILADBUzEnP2oKTTyB1WnMv72sBNxf4HIE/n
	v6L9I22AVmWzGa/0cFalW99TchhuApbaKsAu2b31de+zM4HuUkqUJxdrTC3eeoJSya3UoQ
	vOImx6ZAVWvlsKHEsbdw2McF5jxqPjT5Q9XWxuyT73W+DhkGvkRY2S2MkSx/L7+vdf78n3
	VqPVtftO2mcMbl5upTFU9l3zDw9hfrkpMH95K0gMPHBTJCbi3lltxEjJ+fZaSg47vwhp93
	uD8+CUwS1yuskk/NpalyA2ogjmVMXCaKcnv2Qy9nEyCyiy2/dldDYXRgDFT0sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765975085;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xU384yOPGk6V46Y0ZDQUp6ra+LJa5XpSo8F7PgyrDE8=;
	b=bJfR0kiSWO/j+BME413odXV68tgpAvaFxAJ6PC/AAHppoEENSnEj7Qpt3TwOtqmWU/hwEG
	P8u/UR/OTEcxX7AA==
From: "tip-bot2 for Jens Remus" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] unwind_user/fp: Use dummies instead of ifdef
Cc: Jens Remus <jremus@linux.ibm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251208160352.1363040-3-jremus@linux.ibm.com>
References: <20251208160352.1363040-3-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176597508428.510.17923884239996413306.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2652f9a4b019e34fbbde8dcd1396f1f00ec4844f
Gitweb:        https://git.kernel.org/tip/2652f9a4b019e34fbbde8dcd1396f1f00ec=
4844f
Author:        Jens Remus <jremus@linux.ibm.com>
AuthorDate:    Mon, 08 Dec 2025 17:03:50 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Dec 2025 13:31:07 +01:00

unwind_user/fp: Use dummies instead of ifdef

This simplifies the code.   unwind_user_next_fp() does not need to
return -EINVAL if config option HAVE_UNWIND_USER_FP is disabled, as
unwind_user_start() will then not select this unwind method and
unwind_user_next() will therefore not call it.

Provide (1) a dummy definition of ARCH_INIT_USER_FP_FRAME, if the unwind
user method HAVE_UNWIND_USER_FP is not enabled, (2) a common fallback
definition of unwind_user_at_function_start() which returns false, and
(3) a common dummy definition of ARCH_INIT_USER_FP_ENTRY_FRAME.

Note that enabling the config option HAVE_UNWIND_USER_FP without
defining ARCH_INIT_USER_FP_FRAME triggers a compile error, which is
helpful when implementing support for this unwind user method in an
architecture.  Enabling the config option when providing an arch-
specific unwind_user_at_function_start() definition makes it necessary
to also provide an arch-specific ARCH_INIT_USER_FP_ENTRY_FRAME
definition.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251208160352.1363040-3-jremus@linux.ibm.com
---
 arch/x86/include/asm/unwind_user.h |  1 +
 include/linux/unwind_user.h        | 18 ++++++++++++++++--
 kernel/unwind/user.c               |  4 ----
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind=
_user.h
index 1206428..971ffe9 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -35,6 +35,7 @@ static inline bool unwind_user_at_function_start(struct pt_=
regs *regs)
 {
 	return is_uprobe_at_func_entry(regs);
 }
+#define unwind_user_at_function_start unwind_user_at_function_start
=20
 #endif /* CONFIG_HAVE_UNWIND_USER_FP */
=20
diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
index 7f72825..6461861 100644
--- a/include/linux/unwind_user.h
+++ b/include/linux/unwind_user.h
@@ -5,8 +5,22 @@
 #include <linux/unwind_user_types.h>
 #include <asm/unwind_user.h>
=20
-#ifndef ARCH_INIT_USER_FP_FRAME
- #define ARCH_INIT_USER_FP_FRAME
+#ifndef CONFIG_HAVE_UNWIND_USER_FP
+
+#define ARCH_INIT_USER_FP_FRAME(ws)
+
+#endif
+
+#ifndef ARCH_INIT_USER_FP_ENTRY_FRAME
+#define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)
+#endif
+
+#ifndef unwind_user_at_function_start
+static inline bool unwind_user_at_function_start(struct pt_regs *regs)
+{
+	return false;
+}
+#define unwind_user_at_function_start unwind_user_at_function_start
 #endif
=20
 int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries);
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 0ca434f..90ab3c1 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -67,7 +67,6 @@ static int unwind_user_next_common(struct unwind_user_state=
 *state,
=20
 static int unwind_user_next_fp(struct unwind_user_state *state)
 {
-#ifdef CONFIG_HAVE_UNWIND_USER_FP
 	struct pt_regs *regs =3D task_pt_regs(current);
=20
 	if (state->topmost && unwind_user_at_function_start(regs)) {
@@ -81,9 +80,6 @@ static int unwind_user_next_fp(struct unwind_user_state *st=
ate)
 		ARCH_INIT_USER_FP_FRAME(state->ws)
 	};
 	return unwind_user_next_common(state, &fp_frame);
-#else
-	return -EINVAL;
-#endif
 }
=20
 static int unwind_user_next(struct unwind_user_state *state)

