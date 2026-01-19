Return-Path: <linux-tip-commits+bounces-8072-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAB1D3A695
	for <lists+linux-tip-commits@lfdr.de>; Mon, 19 Jan 2026 12:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FC78306C75F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 19 Jan 2026 11:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45F73596EB;
	Mon, 19 Jan 2026 11:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZPYjLmua";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CRQbcjWZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3943590DB;
	Mon, 19 Jan 2026 11:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768821278; cv=none; b=d0ID4HZg9GCvWmJq0WHOhJkwSwwRh+pcF+mPRmGFM6YZqaembgReD94mwCB+qW/ODSg8+HcrrHLB17c4xYbiypPP1iwnQM0Q1cb3zbWwCXk6/mo14u1dTsAcIJZNhmcYpZUHvSTBBffXtNQzyObHXTELuLcHTL1QOuc/yTBccck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768821278; c=relaxed/simple;
	bh=If4eIWPN8sMNIASdHHalUe09itSGGoV1SfHaR//ju3Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lLIqrzV1fyfPaBavXHQTcW1TmpXs5j/6r7Pw1AdXa1GMPF+5B0lcVuf5225ilXjpkS0E9wXQPsdHbJFvCwTUDAhBZtuVRiBoxHs0iRW1mtLyRnu2pqSYBZLw1QugjPjlYQQFlIRBkfSA5CIeuFLVdBS3QVTfPG1g/kUjdXVi9nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZPYjLmua; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CRQbcjWZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Jan 2026 11:14:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768821275;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cDuGuhhdTOsQzLF1CVjLMuPApbQifWnfRh2WyFdEBpM=;
	b=ZPYjLmuahpqUiTfRhOMmWslOr1sHUIYTjL6WJcRsOavLS3d2BNdCfCfBsXpSx1kX0V6H1c
	nrrBszjDtavCn3m3iLdH/VNT0AlGZIULxeZpvu7/8+gxtFpGTWxsMzpRo8bX+Oo4IcF5nB
	9/DGSmrQ6/DKrYfRFTE4eqUAnQdU9vkBDKz1bNiW50A3Zrn/R059Yx9eoZc2dRHEwWH/T9
	zaCt9IgawLLUY1dOt5HfpdgPmzgeCXZX4CSBc08GmiJu/vzZ929SOyWuG5eBeUEdezFA7h
	siVqd+5JRvDe0RcXRyXqC2P7NJ5ARg0paGgR+ytuFrVR8zHfhddaORfYXI38dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768821275;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cDuGuhhdTOsQzLF1CVjLMuPApbQifWnfRh2WyFdEBpM=;
	b=CRQbcjWZLiGWof0hiYE6Dlwd5uS7q94ioGnk1erxKE9SUHnlL26a627s+vGC+jCgmForsC
	/m8xzYz4bVuEveDg==
From: "tip-bot2 for UYeol Jo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] selftests/x86: Clean up sysret_rip coding style
Cc: UYeol Jo <jouyeol8739@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260111210126.74752-1-jouyeol8739@gmail.com>
References: <20260111210126.74752-1-jouyeol8739@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176882127041.510.5669683472021243106.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     59cac9d52b885cbeba45fa455417b03dfb03eaa7
Gitweb:        https://git.kernel.org/tip/59cac9d52b885cbeba45fa455417b03dfb0=
3eaa7
Author:        UYeol Jo <jouyeol8739@gmail.com>
AuthorDate:    Mon, 12 Jan 2026 06:01:26 +09:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 19 Jan 2026 12:06:11 +01:00

selftests/x86: Clean up sysret_rip coding style

Tidy up sysret_rip style (cast spacing, main(void), const placement).
No functional change intended.

Signed-off-by: UYeol Jo <jouyeol8739@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20260111210126.74752-1-jouyeol8739@gmail.com
---
 tools/testing/selftests/x86/sysret_rip.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/x86/sysret_rip.c b/tools/testing/selftes=
ts/x86/sysret_rip.c
index 5fb531e..2e423a3 100644
--- a/tools/testing/selftests/x86/sysret_rip.c
+++ b/tools/testing/selftests/x86/sysret_rip.c
@@ -31,7 +31,7 @@
 void test_syscall_ins(void);
 extern const char test_page[];
=20
-static void const *current_test_page_addr =3D test_page;
+static const void *current_test_page_addr =3D test_page;
=20
 /* State used by our signal handlers. */
 static gregset_t initial_regs;
@@ -40,7 +40,7 @@ static volatile unsigned long rip;
=20
 static void sigsegv_for_sigreturn_test(int sig, siginfo_t *info, void *ctx_v=
oid)
 {
-	ucontext_t *ctx =3D (ucontext_t*)ctx_void;
+	ucontext_t *ctx =3D (ucontext_t *)ctx_void;
=20
 	if (rip !=3D ctx->uc_mcontext.gregs[REG_RIP]) {
 		printf("[FAIL]\tRequested RIP=3D0x%lx but got RIP=3D0x%lx\n",
@@ -56,7 +56,7 @@ static void sigsegv_for_sigreturn_test(int sig, siginfo_t *=
info, void *ctx_void)
=20
 static void sigusr1(int sig, siginfo_t *info, void *ctx_void)
 {
-	ucontext_t *ctx =3D (ucontext_t*)ctx_void;
+	ucontext_t *ctx =3D (ucontext_t *)ctx_void;
=20
 	memcpy(&initial_regs, &ctx->uc_mcontext.gregs, sizeof(gregset_t));
=20
@@ -69,8 +69,6 @@ static void sigusr1(int sig, siginfo_t *info, void *ctx_voi=
d)
 	       ctx->uc_mcontext.gregs[REG_R11]);
=20
 	sethandler(SIGSEGV, sigsegv_for_sigreturn_test, SA_RESETHAND);
-
-	return;
 }
=20
 static void test_sigreturn_to(unsigned long ip)
@@ -84,7 +82,7 @@ static jmp_buf jmpbuf;
=20
 static void sigsegv_for_fallthrough(int sig, siginfo_t *info, void *ctx_void)
 {
-	ucontext_t *ctx =3D (ucontext_t*)ctx_void;
+	ucontext_t *ctx =3D (ucontext_t *)ctx_void;
=20
 	if (rip !=3D ctx->uc_mcontext.gregs[REG_RIP]) {
 		printf("[FAIL]\tExpected SIGSEGV at 0x%lx but got RIP=3D0x%lx\n",
@@ -130,7 +128,7 @@ static void test_syscall_fallthrough_to(unsigned long ip)
 	printf("[OK]\tWe survived\n");
 }
=20
-int main()
+int main(void)
 {
 	/*
 	 * When the kernel returns from a slow-path syscall, it will

