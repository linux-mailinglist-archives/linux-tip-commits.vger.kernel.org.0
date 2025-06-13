Return-Path: <linux-tip-commits+bounces-5845-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C351AD9304
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 18:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08214173542
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 16:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581CB221555;
	Fri, 13 Jun 2025 16:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DKSytba1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kLY6bg3y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E81721882B;
	Fri, 13 Jun 2025 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749833077; cv=none; b=Ti7W7gus1MlGm625Y9xht1VFLgRXxEhxxSYHDru7d5/hDNTEbgH2enPlYv0+gpl/gG36VXeT8dGiiP0fvEfgFVbh4GQnUKVreuxiOzan8e5NitV2KnOPspIfLkcFfKsxO1y1dPWb+dHN4a1RVLpOTuO5f3nFMXiXMLGMicXsmmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749833077; c=relaxed/simple;
	bh=g71vHuvrgjFZ5e3mkhdBDSMn9fBAxU6x8kPR0nX5biE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JS3zRUJfSbCrLoo12E53dIuSK+ew11N5GLA72WX4V7DBhiSIBAHOA/e6Jj/J1c9eOg7O7dd9HZSVzovH/TkczTM66q8eRwqf+EjVIV7BFyWnANbG4aIOWH/dLzsfY+yaC+zI0qgr5wFaZ6VFzVHOTo/YFRKxAIAgnEMe04TgdCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DKSytba1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kLY6bg3y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 16:44:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749833073;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5djatIXuXUyy17+ZZGLMS1yoT89gSOoD3KAn1n1XEpw=;
	b=DKSytba1y0wh6WwEh/Rp1G2a4GxXVoTxRCwclPcnFOZMJzFsoYgzN/HRdomHgHRNAaZsBP
	tZYHtIGXD1Zut/nW4nNR+sIQnP3IrcP1iMg9DvSi0ExX00KZ5hEle2s5GAIpLSr16svDgc
	0aaDLQV26iK3uNQgdKecSscW6J3QMH9xMYoNYcQDct/kguDKnnwrg7jszb1ZFbSpAo5EfP
	nwtZ3WTL0kpzzyWgV2qnY/7ploUq3UXrAuCa/rWVTny6mQuvDArCGyPfbU1SRDPEmvKqSP
	MxB1b3h0oC6CQvszDqhmyMfp7+RjKiw5fyBsyIXKxrvfNPyjxfntkvu209iSRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749833073;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5djatIXuXUyy17+ZZGLMS1yoT89gSOoD3KAn1n1XEpw=;
	b=kLY6bg3ydK1U1r080IzkGl5xHwGaa4y91LTJwHubThjoKdQZsicA3cghKclx+bqYLIe/Qo
	R+Lwf4eJpE0EebDw==
From: "tip-bot2 for Dmitry Vyukov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/entry] selftests: Fix errno checking in syscall_user_dispatch test
Cc: Dmitry Vyukov <dvyukov@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <af6a04dbfef9af8570f5bab43e3ef1416b62699a.1747839857.git.dvyukov@google.com>
References:
 <af6a04dbfef9af8570f5bab43e3ef1416b62699a.1747839857.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174983307279.406.8576482002031316721.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     b89732c8c8357487185f260a723a060b3476144e
Gitweb:        https://git.kernel.org/tip/b89732c8c8357487185f260a723a060b3476144e
Author:        Dmitry Vyukov <dvyukov@google.com>
AuthorDate:    Wed, 21 May 2025 17:04:28 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 13 Jun 2025 18:36:39 +02:00

selftests: Fix errno checking in syscall_user_dispatch test

Successful syscalls don't change errno, so checking errno is wrong
to ensure that a syscall has failed. For example for the following
sequence:

	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0xff, 0);
	EXPECT_EQ(EINVAL, errno);
	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x0, &sel);
	EXPECT_EQ(EINVAL, errno);

only the first syscall may fail and set errno, but the second may succeed
and keep errno intact, and the check will falsely pass.
Or if errno happened to be EINVAL before, even the first check may falsely
pass.

Also use EXPECT/ASSERT consistently. Currently there is an inconsistent mix
without obvious reasons for usage of one or another.

Fixes: 179ef035992e ("selftests: Add kselftest for syscall user dispatch")
Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/af6a04dbfef9af8570f5bab43e3ef1416b62699a.1747839857.git.dvyukov@google.com


---
 tools/testing/selftests/syscall_user_dispatch/sud_test.c | 50 +++----
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
index d975a67..48cf01a 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -79,6 +79,21 @@ TEST_SIGNAL(dispatch_trigger_sigsys, SIGSYS)
 	}
 }
 
+static void prctl_valid(struct __test_metadata *_metadata,
+			unsigned long op, unsigned long off,
+			unsigned long size, void *sel)
+{
+	EXPECT_EQ(0, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, off, size, sel));
+}
+
+static void prctl_invalid(struct __test_metadata *_metadata,
+			  unsigned long op, unsigned long off,
+			  unsigned long size, void *sel, int err)
+{
+	EXPECT_EQ(-1, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, off, size, sel));
+	EXPECT_EQ(err, errno);
+}
+
 TEST(bad_prctl_param)
 {
 	char sel = SYSCALL_DISPATCH_FILTER_ALLOW;
@@ -86,57 +101,42 @@ TEST(bad_prctl_param)
 
 	/* Invalid op */
 	op = -1;
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0, 0, &sel);
-	ASSERT_EQ(EINVAL, errno);
+	prctl_invalid(_metadata, op, 0, 0, &sel, EINVAL);
 
 	/* PR_SYS_DISPATCH_OFF */
 	op = PR_SYS_DISPATCH_OFF;
 
 	/* offset != 0 */
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x1, 0x0, 0);
-	EXPECT_EQ(EINVAL, errno);
+	prctl_invalid(_metadata, op, 0x1, 0x0, 0, EINVAL);
 
 	/* len != 0 */
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0xff, 0);
-	EXPECT_EQ(EINVAL, errno);
+	prctl_invalid(_metadata, op, 0x0, 0xff, 0, EINVAL);
 
 	/* sel != NULL */
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x0, &sel);
-	EXPECT_EQ(EINVAL, errno);
+	prctl_invalid(_metadata, op, 0x0, 0x0, &sel, EINVAL);
 
 	/* Valid parameter */
-	errno = 0;
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x0, 0x0);
-	EXPECT_EQ(0, errno);
+	prctl_valid(_metadata, op, 0x0, 0x0, 0x0);
 
 	/* PR_SYS_DISPATCH_ON */
 	op = PR_SYS_DISPATCH_ON;
 
 	/* Dispatcher region is bad (offset > 0 && len == 0) */
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x1, 0x0, &sel);
-	EXPECT_EQ(EINVAL, errno);
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, -1L, 0x0, &sel);
-	EXPECT_EQ(EINVAL, errno);
+	prctl_invalid(_metadata, op, 0x1, 0x0, &sel, EINVAL);
+	prctl_invalid(_metadata, op, -1L, 0x0, &sel, EINVAL);
 
 	/* Invalid selector */
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x1, (void *) -1);
-	ASSERT_EQ(EFAULT, errno);
+	prctl_invalid(_metadata, op, 0x0, 0x1, (void *) -1, EFAULT);
 
 	/*
 	 * Dispatcher range overflows unsigned long
 	 */
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 1, -1L, &sel);
-	ASSERT_EQ(EINVAL, errno) {
-		TH_LOG("Should reject bad syscall range");
-	}
+	prctl_invalid(_metadata, PR_SYS_DISPATCH_ON, 1, -1L, &sel, EINVAL);
 
 	/*
 	 * Allowed range overflows usigned long
 	 */
-	prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, -1L, 0x1, &sel);
-	ASSERT_EQ(EINVAL, errno) {
-		TH_LOG("Should reject bad syscall range");
-	}
+	prctl_invalid(_metadata, PR_SYS_DISPATCH_ON, -1L, 0x1, &sel, EINVAL);
 }
 
 /*

