Return-Path: <linux-tip-commits+bounces-3600-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12A3A4084F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Feb 2025 13:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9194207C5
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Feb 2025 12:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6482063E8;
	Sat, 22 Feb 2025 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="szNoidhx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NLu6RFz/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944B1208995;
	Sat, 22 Feb 2025 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740227181; cv=none; b=H6oDJVJVTmFGOLl6dp/KQ81nDP5dy5xiWSwsNXTAGucZtZWh45/ewQmp8Glow4KID7oua3VDTuLeiURjS5j7yVo670ZZa3/WYJdRTDgcHqpmYXnJKaddSuigRig4LvcOte2+/N2BHm+ffyVhrowqHLbmxpt8xraoKNjFNhAplDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740227181; c=relaxed/simple;
	bh=LO9/mRpHCVMrvxTJYlpL/eiXq+Ry7sMsOIA7JzYPwzE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LaJR3l9j0oebGBPH3hwp7JOwK3wmiqhnkRTcO+pUxo+X1f8/5+IuCHpjKBqFirhLSDz06t4X3dauN7E0w/I1q2O2nBbTr4Ap/VmqscCyDP6Yxy32jwLyXVxWQ7kWNu4HWcnzbDgQ5Jbxu4weWnl/YRBvrrmnGepDjTFxJtc900A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=szNoidhx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NLu6RFz/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 22 Feb 2025 12:26:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740227178;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZphHXWJDZqk97gWlBD+VsdveHKIz6ukiqEFpQ2mk+g=;
	b=szNoidhxINvtLJGvRReqYZaKIFKqfLJHIM0aHIeKNZLHjy5cUChL7NH6Jc1dWfKP+E1AnV
	2bRzd00WeL+8slm3S94XkymO3SoT9P/R48vQXkm6NPtkxl3FDaZ3PrWkzUEP0AjvuDIbZD
	98al38rHm2HXdgJjGcJP45ChLI6S0GLk07eCjrV6CRD7LSL0lq698vMCf1GOC6rR/yNkLh
	9MGXGc9J5BzLpjqRb9/Lpiuc6R+/dFiV9pFjAYEhONuF1d6fnlobfz9A69kj/AKUPMQp/g
	Hay05nQsO+ctQhhjotqO5o+QrMzr1OrBJ4pp9xUKxLFuHnr0TFcXoYWhGAn0LQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740227178;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZphHXWJDZqk97gWlBD+VsdveHKIz6ukiqEFpQ2mk+g=;
	b=NLu6RFz/+5fEeixDWF8+t2FyNpyNcBuLpxFd1uqNR9SwW7Xvxa/WJNfbqXupT33MxnOh5d
	xRKNfVpN7tHqh+BA==
From: "tip-bot2 for Maciej Wieczor-Retman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] selftests/lam: Skip test if LAM is disabled
Cc: "Maciej Wieczor-Retman" <maciej.wieczor-retman@intel.com>,
 Ingo Molnar <mingo@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Alexander Potapenko <glider@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C251d0f45f6a768030115e8d04bc85458910cb0dc=2E17379?=
 =?utf-8?q?90375=2Egit=2Emaciej=2Ewieczor-retman=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C251d0f45f6a768030115e8d04bc85458910cb0dc=2E173799?=
 =?utf-8?q?0375=2Egit=2Emaciej=2Ewieczor-retman=40intel=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174022717730.10177.4676833475098422793.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     51f909dcd178655b104d979a6870535268724498
Gitweb:        https://git.kernel.org/tip/51f909dcd178655b104d979a6870535268724498
Author:        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
AuthorDate:    Mon, 27 Jan 2025 16:31:56 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 22 Feb 2025 13:17:07 +01:00

selftests/lam: Skip test if LAM is disabled

Until LASS is merged into the kernel:

  https://lore.kernel.org/all/20241028160917.1380714-1-alexander.shishkin@linux.intel.com/

LAM is left disabled in the config file. Running the LAM selftest with
disabled LAM only results in unhelpful output.

Use one of LAM syscalls() to determine whether the kernel was compiled
with LAM support (CONFIG_ADDRESS_MASKING) or not. Skip running the tests
in the latter case.

Merge CPUID checking function with the one mentioned above to achieve a
single function that shows LAM's availability from both CPU and the
kernel.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lore.kernel.org/r/251d0f45f6a768030115e8d04bc85458910cb0dc.1737990375.git.maciej.wieczor-retman@intel.com
---
 tools/testing/selftests/x86/lam.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 60170a3..df91a41 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -115,13 +115,28 @@ static void segv_handler(int sig)
 	siglongjmp(segv_env, 1);
 }
 
-static inline int cpu_has_lam(void)
+static inline int lam_is_available(void)
 {
 	unsigned int cpuinfo[4];
+	unsigned long bits = 0;
+	int ret;
 
 	__cpuid_count(0x7, 1, cpuinfo[0], cpuinfo[1], cpuinfo[2], cpuinfo[3]);
 
-	return (cpuinfo[0] & (1 << 26));
+	/* Check if cpu supports LAM */
+	if (!(cpuinfo[0] & (1 << 26))) {
+		ksft_print_msg("LAM is not supported!\n");
+		return 0;
+	}
+
+	/* Return 0 if CONFIG_ADDRESS_MASKING is not set */
+	ret = syscall(SYS_arch_prctl, ARCH_GET_MAX_TAG_BITS, &bits);
+	if (ret) {
+		ksft_print_msg("LAM is disabled in the kernel!\n");
+		return 0;
+	}
+
+	return 1;
 }
 
 static inline int la57_enabled(void)
@@ -1185,10 +1200,8 @@ int main(int argc, char **argv)
 
 	tests_cnt = 0;
 
-	if (!cpu_has_lam()) {
-		ksft_print_msg("Unsupported LAM feature!\n");
+	if (!lam_is_available())
 		return KSFT_SKIP;
-	}
 
 	while ((c = getopt(argc, argv, "ht:")) != -1) {
 		switch (c) {

