Return-Path: <linux-tip-commits+bounces-7261-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE5AC35A8B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 05 Nov 2025 13:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B0A1898EDC
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Nov 2025 12:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27142E9EA1;
	Wed,  5 Nov 2025 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OcOEff3u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h8w1hdwk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0BB2DE202;
	Wed,  5 Nov 2025 12:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762345900; cv=none; b=ZQvgPmzy00iWf0uKZ852uXkW7nCBpzz4ij2k54mSznMpugHSCjOBO3wPDERpwYb73Q/cY+SJ4eflsxU9YgsFjarm+OtG0RN6IT2y90R8rNRLzRr+m5NvkwwjYwSWYPGR+OzAeYgc/QiVftaHGNV0Ux/kQCEEO8x5CtE5Ql4V49A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762345900; c=relaxed/simple;
	bh=R0xIUk5xUk5kjTH1s/f7OZ2/U/P7P9oA6a70auF7DK0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=gtb4j1BzwBiBh6zJ0RyBwW24RAe0aJMsQmE+7qc3eaAM/EhLXWpEulTq4bSYgGLEtcqh6H7Dv+BVDTI4fQVsHP+quZiVwcIR3jDw4x//R4VR6s85rWCQidetSdhqAETzRMoQ1Th5DvwC7B/298aBtYpivDxIaiWQdH+XmdR1Tkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OcOEff3u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h8w1hdwk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Nov 2025 12:31:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762345890;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ZN5gtsvEQm25Odxnls5yakPee5U15HOSC/cewgMDyHE=;
	b=OcOEff3uWZVpW2HuvrOl3rKRrjjj46vONcfwl0uECOJYedB0dl9/yjolRP01dLwEFoPqUi
	rwStyEKTCgNu7oIJeruHdn0Z2rf/zM3A7XjM8kSTlicf1TUcsD1OypwUsv7WTaTQcjgu3f
	FT/UlsddL+nPGSg4/ChSkexu9jhOQpQiYG7ANilgk8F119cwW+mjQaqRBcaDtt5OsB/7ih
	4bWnRYtd/h/bXRodYXYPs/vIDsQJ7wdSBje95sSxqdqnTkAstzUbg6+crzv6rQ0cwB6SL+
	BVvAeLkz11FJc8AH4Lzj7bZNu2FG7JrMrtyjOHk/XWvi2KCKWiKK3mostztgbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762345890;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ZN5gtsvEQm25Odxnls5yakPee5U15HOSC/cewgMDyHE=;
	b=h8w1hdwkowUFpYbyq7f7uPjeESxh3iBuFp3LIBjqLXZV78czk8vF23B4yDo3n4daI40TsE
	9dwOHYuyOCD0NNAA==
From: "tip-bot2 for Marc Herbert" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/msr: Add CPU_OUT_OF_SPEC taint name to
 "unrecognized" pr_warn(msg)
Cc: Marc Herbert <marc.herbert@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176234588546.2601451.13367192916449580721.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     41f4767000667f402be2f1ccd70cd215bfc41ec3
Gitweb:        https://git.kernel.org/tip/41f4767000667f402be2f1ccd70cd215bfc=
41ec3
Author:        Marc Herbert <marc.herbert@linux.intel.com>
AuthorDate:    Mon, 03 Nov 2025 03:08:11=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 05 Nov 2025 13:14:42 +01:00

x86/msr: Add CPU_OUT_OF_SPEC taint name to "unrecognized" pr_warn(msg)

While restricting access,

  a7e1f67ed29f ("x86/msr: Filter MSR writes")

also added warning and started tainting the kernel.

But the warning message never mentioned tainting. Moreover, this uses the
"CPU_OUT_OF_SPEC" flag which is not clearly related to MSRs: that flag is
overloaded by several, fairly different situations, including some much
scarier ones.

So, without an expert around (thank you Dave Hansen), it would have been
practically impossible to root cause the tainting from just the log file at
hand. So it would be prudent to explicitly mention in the logs when the
tainting happens so that debugging crashes can be made easier.

Fix this by simply appending the CPU_OUT_OF_SPEC flag to the warning message.

This readability issue happened when staring at logs involving the Intel
Memory Latency Checker (among many other things going on in that log). The MLC
disables hardware prefetch.

  [ bp: Massage and extend commit message. ]

Signed-off-by: Marc Herbert <marc.herbert@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20251101-tainted-msr-v1-1-e00658ba04d4@linux.=
intel.com
---
 arch/x86/kernel/msr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index e17c16c..4469c78 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -98,7 +98,7 @@ static int filter_write(u32 reg)
 	if (!__ratelimit(&fw_rs))
 		return 0;
=20
-	pr_warn("Write to unrecognized MSR 0x%x by %s (pid: %d).\n",
+	pr_warn("Write to unrecognized MSR 0x%x by %s (pid: %d), tainting CPU_OUT_O=
F_SPEC.\n",
 	        reg, current->comm, current->pid);
 	pr_warn("See https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/ab=
out for details.\n");
=20

