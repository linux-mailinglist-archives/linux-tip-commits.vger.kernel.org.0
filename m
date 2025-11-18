Return-Path: <linux-tip-commits+bounces-7396-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB9DC6B6F5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 20:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 566864E53B6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 19:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98582E764E;
	Tue, 18 Nov 2025 19:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UI7p+4r9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Qpabb2n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE822DF701;
	Tue, 18 Nov 2025 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763494122; cv=none; b=FTxUaJ6kCso/TUpHGs8rQnr9eXzR6vp/bRSlgYCAoJOYlCL0pd/3Qx6GD6xYwkjlFMzl/dhsBXAQkR7kKSPDo/XTg7pHniicKTdRjJCngV7o1fdmaG7Nc8L4qDFqFk90o/bye1xtZj0l3ZGuiHcoUBU0kBB4kkqPh9k89K1J2Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763494122; c=relaxed/simple;
	bh=XBwpEXWR7tB6uSLVPHmS8Gc0dbpk9f2RFUInAslvvdU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=WlZDpQnG+BuXYP0JZ9RMyBXgXPuoV6rvsW33T2O9wSStjWk/BWFFiL0WojiwmglPT1NpsnbR7zVFVZKpM5t2u49A7EkVEZGN2gpNG75YbeuaWyHCJwS3VzX00SXUCUshhH8pYSrn5DXc/sMETua1YP+ZEup1eULtg6q2CBoa/44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UI7p+4r9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Qpabb2n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Nov 2025 19:28:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763494118;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=jPzl+CEl5vO28GG38K4OgSLbtY8PZSphKWcr3srGy88=;
	b=UI7p+4r90Zh7UKglJxJqQZZw0fv/u0y9v3weUl/x83+hQ6iBob43vLg7AltXnNJAZfNs6r
	15m75ZU3zDMmgO8LoA3vOuPZOcayfDDADY51LSTr3MiqxV/1mOivnp0ue+aALo1pzIDYSL
	IAi/pdak9gVBkJdFHYiTNwj2OE53bSJV53lY0r3+OL3Fku6Uy/aS2r7ECYmdKkk4RzKoF8
	uFlAvdbIKZGSybdMVghGnQLcukxQKteW0eVZgmRjUgZgp/GcsBITzv52riHyQQGvaFpBKM
	xd1+ceXIUDT0bII9Ve3Z2K2v4sZudZb2vapSDdq23/k7O8Giek0eB+ZZMennoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763494118;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=jPzl+CEl5vO28GG38K4OgSLbtY8PZSphKWcr3srGy88=;
	b=1Qpabb2ncVYaWpZdmugpMJm5B7EZDgWzk37mLkDrCN9cw+XogX6mABVWPg9r/he0dzvdIc
	pUq0Rpkxm+nJVLBA==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] selftests/x86: Update the negative vsyscall tests to
 expect a #GP
Cc: Sohil Mehta <sohil.mehta@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176349411753.498.5373334341236306495.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     c9129cf0f0447cdf195df0c79b87940f266d3767
Gitweb:        https://git.kernel.org/tip/c9129cf0f0447cdf195df0c79b87940f266=
d3767
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Tue, 18 Nov 2025 10:29:09 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 18 Nov 2025 10:38:26 -08:00

selftests/x86: Update the negative vsyscall tests to expect a #GP

Some of the vsyscall selftests expect a #PF when vsyscalls are disabled.
However, with LASS enabled, an invalid access results in a SIGSEGV due
to a #GP instead of a #PF. One such negative test fails because it is
expecting X86_PF_INSTR to be set.

Update the failing test to expect either a #GP or a #PF. Also, update
the printed messages to show the trap number (denoting the type of
fault) instead of assuming a #PF.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://patch.msgid.link/20251118182911.2983253-8-sohil.mehta%40intel.c=
om
---
 tools/testing/selftests/x86/test_vsyscall.c | 21 +++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/self=
tests/x86/test_vsyscall.c
index 05e1e67..918eaec 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -308,12 +308,13 @@ static void test_getcpu(int cpu)
 #ifdef __x86_64__
=20
 static jmp_buf jmpbuf;
-static volatile unsigned long segv_err;
+static volatile unsigned long segv_err, segv_trapno;
=20
 static void sigsegv(int sig, siginfo_t *info, void *ctx_void)
 {
 	ucontext_t *ctx =3D (ucontext_t *)ctx_void;
=20
+	segv_trapno =3D ctx->uc_mcontext.gregs[REG_TRAPNO];
 	segv_err =3D  ctx->uc_mcontext.gregs[REG_ERR];
 	siglongjmp(jmpbuf, 1);
 }
@@ -336,7 +337,8 @@ static void test_vsys_r(void)
 	else if (can_read)
 		ksft_test_result_pass("We have read access\n");
 	else
-		ksft_test_result_pass("We do not have read access: #PF(0x%lx)\n", segv_err=
);
+		ksft_test_result_pass("We do not have read access (trap=3D%ld, error=3D0x%=
lx)\n",
+				      segv_trapno, segv_err);
 }
=20
 static void test_vsys_x(void)
@@ -347,7 +349,7 @@ static void test_vsys_x(void)
 		return;
 	}
=20
-	ksft_print_msg("Make sure that vsyscalls really page fault\n");
+	ksft_print_msg("Make sure that vsyscalls really cause a fault\n");
=20
 	bool can_exec;
 	if (sigsetjmp(jmpbuf, 1) =3D=3D 0) {
@@ -358,13 +360,14 @@ static void test_vsys_x(void)
 	}
=20
 	if (can_exec)
-		ksft_test_result_fail("Executing the vsyscall did not page fault\n");
-	else if (segv_err & (1 << 4)) /* INSTR */
-		ksft_test_result_pass("Executing the vsyscall page failed: #PF(0x%lx)\n",
-				      segv_err);
+		ksft_test_result_fail("Executing the vsyscall did not fault\n");
+	/* #GP or #PF (with X86_PF_INSTR) */
+	else if ((segv_trapno =3D=3D 13) || ((segv_trapno =3D=3D 14) && (segv_err &=
 (1 << 4))))
+		ksft_test_result_pass("Executing the vsyscall page failed (trap=3D%ld, err=
or=3D0x%lx)\n",
+				      segv_trapno, segv_err);
 	else
-		ksft_test_result_fail("Execution failed with the wrong error: #PF(0x%lx)\n=
",
-				      segv_err);
+		ksft_test_result_fail("Execution failed with the wrong error (trap=3D%ld, =
error=3D0x%lx)\n",
+				      segv_trapno, segv_err);
 }
=20
 /*

