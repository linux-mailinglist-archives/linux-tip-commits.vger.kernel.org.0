Return-Path: <linux-tip-commits+bounces-3667-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21301A45E64
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 13:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34A63AE214
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA36B24E013;
	Wed, 26 Feb 2025 12:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qeHTmDwU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3McyQm8J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E491923535E;
	Wed, 26 Feb 2025 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571493; cv=none; b=jKEO1GqMU1bk08S2VYN0SJGTsy4FqUtaJioZmKB0oVWVydJHL3kFE1PDb3LUIYmjRVe23t7uZLmWxWOLhfaMeayJua43IUuoikPJc3AEPftfkCf4IK1D71Ah6BDtIBexNqyIvKZvKXAHohzr0BZGTJoNQvjHRuVR1TkADMC3FzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571493; c=relaxed/simple;
	bh=pV/EDa0GwWE+xqgD5ZLb9sWNTm5HFpQmsr387LP7yyQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gZz3GibOJbZHcyHS6+UIgiVTL/IkHLgi6rLEbVz+R9gxE0Q90qp/uF1w2WyXYY64iRrLa89RRJiWSttzIFc+x1uHzU1A1ndwfb/nqWku6M9g/ICcwSqP0W1hz384cGYIoxiWUjjXFJ5cf+V4HylLlHK9MuV1cnMOPEOsiUw+te8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qeHTmDwU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3McyQm8J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 12:04:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740571489;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4XtzsmMdytaXozXTf/rNAyS7G68QM4szoCPKqrtrabE=;
	b=qeHTmDwU59k+llkVNO5xSDBIQcMJ7Lf/9hakxW8mCvqgeaemEEGAXLEqmlRMlsh92Dn2PW
	4D+pkOJgmS/mTwk5mimkk7uVdwFm9qNlVRMcWC+uAsvIE3UXoZWb0wT4IfKn8XqyN6f5yg
	hMbzAaQttFVX47vPi4q+XOCivQ6o+seGv4kOV2134gT/BARRg+vCfwx/ClGxXuhliIrxYi
	dzrnRWZovMjWUlEeXcS2jM9x+wc7nR6eWP1M+DwUB4NjS2isHVtjHKLAm0MaqkOa9Eu2QR
	QuxNuF3r7CifjgS6a/lIhfiF+xBKOQ80X8orfbj83v4rlX11Gx8I1Xq0nTrlbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740571489;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4XtzsmMdytaXozXTf/rNAyS7G68QM4szoCPKqrtrabE=;
	b=3McyQm8JObyF10MdDIQQYhBqSQ6opVjcaKsvUrSyH0LA2o35YOXKIdwjNMhJpoi6CM+Lhu
	xTyBEHGxYWrevFAw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt: Add exact_endbr() helper
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250224124200.059556588@infradead.org>
References: <20250224124200.059556588@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174057148918.10177.18138134979109290177.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     500a41acb05a973cb6826ee56df082a97e210a95
Gitweb:        https://git.kernel.org/tip/500a41acb05a973cb6826ee56df082a97e210a95
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 24 Feb 2025 13:37:05 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Feb 2025 12:11:18 +01:00

x86/ibt: Add exact_endbr() helper

For when we want to exactly match ENDBR, and not everything that we
can scribble it with.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kees Cook <kees@kernel.org>
Link: https://lore.kernel.org/r/20250224124200.059556588@infradead.org
---
 arch/x86/kernel/alternative.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 1142ebd..83316ea 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -863,6 +863,21 @@ Efault:
 	return false;
 }
 
+#ifdef CONFIG_FINEIBT
+
+static __noendbr bool exact_endbr(u32 *val)
+{
+	u32 endbr;
+
+	__get_kernel_nofault(&endbr, val, u32, Efault);
+	return endbr == gen_endbr();
+
+Efault:
+	return false;
+}
+
+#endif
+
 static void poison_cfi(void *addr);
 
 static void __init_or_module poison_endbr(void *addr)
@@ -1426,10 +1441,9 @@ static void poison_cfi(void *addr)
 bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type)
 {
 	unsigned long addr = regs->ip - fineibt_preamble_ud2;
-	u32 endbr, hash;
+	u32 hash;
 
-	__get_kernel_nofault(&endbr, addr, u32, Efault);
-	if (endbr != gen_endbr())
+	if (!exact_endbr((void *)addr))
 		return false;
 
 	*target = addr + fineibt_preamble_size;

