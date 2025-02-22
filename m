Return-Path: <linux-tip-commits+bounces-3601-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C488FA40850
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Feb 2025 13:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A69F420E6E
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Feb 2025 12:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A5420A5F5;
	Sat, 22 Feb 2025 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fgjr+Ltp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fpIyUrPy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7E3208974;
	Sat, 22 Feb 2025 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740227181; cv=none; b=Kgkti7EKlPoharAEkIP9lhtJcjNALpi8NQyX28dLGgr7Q7X0V5ULQHkdi0cxRexMtty/nsTdneKXOBW7LrJaTRvNPYiM/PrTjXoEI+RGc/C6LvQygjk4cU4+lBfDj/Z9wxQRHfeWyAdE0mQxm/OxZ2Ezwuqyd9c7fTfofDal1tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740227181; c=relaxed/simple;
	bh=wr/cip9xzChbqPSHEYsbkaSNatL46OJxwbFfG4pzVdY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qtwBg8VpOlNxUzYSXSAUdeMgXWGUNfFHL91J+N/D+92fQbt4aUcGgygJYilyM+UbjKjk3b19uzuQaxqXiknKT8OUZKq/uPXSZYuaFlP2hPzQmBd18AHO6I89nmnZLU5ICQGxp9bQHslyiXOu8mqwSQ9aosXdG2V27dba29HT/oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fgjr+Ltp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fpIyUrPy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 22 Feb 2025 12:26:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740227177;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=65VNqZ7jm/pZTzxtkms7FT3QrXRGCdqWdQKEZR/Q/+o=;
	b=fgjr+Ltp2jjrPSmpDduAeNoDLcxGBTkerYYATCzr/412xaio68Hr+XvkL1sz127KO8C4Kp
	G4dEBSSgkS6OYQOpjbgPIyaAphWMGFKkUtyyKKxUBy1gaNJHdqQHD47xylF5ytxVZBHE3a
	m+yWw2MV0yiWCF28ap7bCqlFopu2vOk6HLPLnKcpGQW69RqO4j6MDURcCTa2ZRG8nOX8lk
	T4uXotpXy4Pi3SedjRA70f7Kz8YNgEY1NibmaA/tTGI6w5gO3wsDbAg/QGLEsB4wgCUoIA
	WYebhRzRliPZWirDwxiuF5PVOy3EwyizlJ1qf9Wdg1w/5xkNlRCDgdoVUH1dtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740227177;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=65VNqZ7jm/pZTzxtkms7FT3QrXRGCdqWdQKEZR/Q/+o=;
	b=fpIyUrPyCJUhiWjumOa58FhkuvCZY/4ejSLg6PDR+Ox7TrEKYNdozwwjiay04HWPoM4OQ+
	PraBzC16v0Vdn+Bw==
From: "tip-bot2 for Maciej Wieczor-Retman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] selftests/lam: Test get_user() LAM pointer handling
Cc: "Maciej Wieczor-Retman" <maciej.wieczor-retman@intel.com>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Alexander Potapenko <glider@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C1624d9d1b9502517053a056652d50dc5d26884ac=2E17379?=
 =?utf-8?q?90375=2Egit=2Emaciej=2Ewieczor-retman=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C1624d9d1b9502517053a056652d50dc5d26884ac=2E173799?=
 =?utf-8?q?0375=2Egit=2Emaciej=2Ewieczor-retman=40intel=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174022717448.10177.18420296797925083599.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     782b819827ee84532f3069e37aa091c1be00fa44
Gitweb:        https://git.kernel.org/tip/782b819827ee84532f3069e37aa091c1be00fa44
Author:        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
AuthorDate:    Mon, 27 Jan 2025 16:31:57 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 22 Feb 2025 13:17:07 +01:00

selftests/lam: Test get_user() LAM pointer handling

Recent change in how get_user() handles pointers:

  https://lore.kernel.org/all/20241024013214.129639-1-torvalds@linux-foundation.org/

has a specific case for LAM. It assigns a different bitmask that's
later used to check whether a pointer comes from userland in get_user().

Add test case to LAM that utilizes a ioctl (FIOASYNC) syscall which uses
get_user() in its implementation. Execute the syscall with differently
tagged pointers to verify that valid user pointers are passing through
and invalid kernel/non-canonical pointers are not.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lore.kernel.org/r/1624d9d1b9502517053a056652d50dc5d26884ac.1737990375.git.maciej.wieczor-retman@intel.com
---
 tools/testing/selftests/x86/lam.c | 108 +++++++++++++++++++++++++++++-
 1 file changed, 108 insertions(+)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index df91a41..b6166a5 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -4,6 +4,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/syscall.h>
+#include <sys/ioctl.h>
 #include <time.h>
 #include <signal.h>
 #include <setjmp.h>
@@ -43,7 +44,15 @@
 #define FUNC_INHERITE           0x20
 #define FUNC_PASID              0x40
 
+/* get_user() pointer test cases */
+#define GET_USER_USER           0
+#define GET_USER_KERNEL_TOP     1
+#define GET_USER_KERNEL_BOT     2
+#define GET_USER_KERNEL         3
+
 #define TEST_MASK               0x7f
+#define L5_SIGN_EXT_MASK        (0xFFUL << 56)
+#define L4_SIGN_EXT_MASK        (0x1FFFFUL << 47)
 
 #define LOW_ADDR                (0x1UL << 30)
 #define HIGH_ADDR               (0x3UL << 48)
@@ -389,6 +398,78 @@ static int handle_syscall(struct testcases *test)
 	return ret;
 }
 
+static int get_user_syscall(struct testcases *test)
+{
+	uint64_t ptr_address, bitmask;
+	int fd, ret = 0;
+	void *ptr;
+
+	if (la57_enabled()) {
+		bitmask = L5_SIGN_EXT_MASK;
+		ptr_address = HIGH_ADDR;
+	} else {
+		bitmask = L4_SIGN_EXT_MASK;
+		ptr_address = LOW_ADDR;
+	}
+
+	ptr = mmap((void *)ptr_address, PAGE_SIZE, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
+
+	if (ptr == MAP_FAILED) {
+		perror("failed to map byte to pass into get_user");
+		return 1;
+	}
+
+	if (set_lam(test->lam) != 0) {
+		ret = 2;
+		goto error;
+	}
+
+	fd = memfd_create("lam_ioctl", 0);
+	if (fd == -1) {
+		munmap(ptr, PAGE_SIZE);
+		exit(EXIT_FAILURE);
+	}
+
+	switch (test->later) {
+	case GET_USER_USER:
+		/* Control group - properly tagged user pointer */
+		ptr = (void *)set_metadata((uint64_t)ptr, test->lam);
+		break;
+	case GET_USER_KERNEL_TOP:
+		/* Kernel address with top bit cleared */
+		bitmask &= (bitmask >> 1);
+		ptr = (void *)((uint64_t)ptr | bitmask);
+		break;
+	case GET_USER_KERNEL_BOT:
+		/* Kernel address with bottom sign-extension bit cleared */
+		bitmask &= (bitmask << 1);
+		ptr = (void *)((uint64_t)ptr | bitmask);
+		break;
+	case GET_USER_KERNEL:
+		/* Try to pass a kernel address */
+		ptr = (void *)((uint64_t)ptr | bitmask);
+		break;
+	default:
+		printf("Invalid test case value passed!\n");
+		break;
+	}
+
+	/*
+	 * Use FIOASYNC ioctl because it utilizes get_user() internally and is
+	 * very non-invasive to the system. Pass differently tagged pointers to
+	 * get_user() in order to verify that valid user pointers are going
+	 * through and invalid kernel/non-canonical pointers are not.
+	 */
+	if (ioctl(fd, FIOASYNC, ptr) != 0)
+		ret = 1;
+
+	close(fd);
+error:
+	munmap(ptr, PAGE_SIZE);
+	return ret;
+}
+
 int sys_uring_setup(unsigned int entries, struct io_uring_params *p)
 {
 	return (int)syscall(__NR_io_uring_setup, entries, p);
@@ -902,6 +983,33 @@ static struct testcases syscall_cases[] = {
 		.test_func = handle_syscall,
 		.msg = "SYSCALL:[Negative] Disable LAM. Dereferencing pointer with metadata.\n",
 	},
+	{
+		.later = GET_USER_USER,
+		.lam = LAM_U57_BITS,
+		.test_func = get_user_syscall,
+		.msg = "GET_USER: get_user() and pass a properly tagged user pointer.\n",
+	},
+	{
+		.later = GET_USER_KERNEL_TOP,
+		.expected = 1,
+		.lam = LAM_U57_BITS,
+		.test_func = get_user_syscall,
+		.msg = "GET_USER:[Negative] get_user() with a kernel pointer and the top bit cleared.\n",
+	},
+	{
+		.later = GET_USER_KERNEL_BOT,
+		.expected = 1,
+		.lam = LAM_U57_BITS,
+		.test_func = get_user_syscall,
+		.msg = "GET_USER:[Negative] get_user() with a kernel pointer and the bottom sign-extension bit cleared.\n",
+	},
+	{
+		.later = GET_USER_KERNEL,
+		.expected = 1,
+		.lam = LAM_U57_BITS,
+		.test_func = get_user_syscall,
+		.msg = "GET_USER:[Negative] get_user() and pass a kernel pointer.\n",
+	},
 };
 
 static struct testcases mmap_cases[] = {

