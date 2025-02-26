Return-Path: <linux-tip-commits+bounces-3643-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B75A45C47
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 11:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C60175479
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 10:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80280271272;
	Wed, 26 Feb 2025 10:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1N1e2egg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oApiFxAz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF05F26FA70;
	Wed, 26 Feb 2025 10:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567267; cv=none; b=j3mQg87au2W8Nh8Knraq+ZbWP1WM4X4SyWXMzT6pw0Kq6ZEA8ZVPdInyTvfsRoLEB1Fq3lKASSz/YZQdcjDTRaNWKwncs+KqNA1P42gDbKseT3NpVgyAwH9OQRsUW+9ng+afbB7xk2qc46/HoHiKtr6HxCY23Y28vR5nRBKR9wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567267; c=relaxed/simple;
	bh=1Q2t2ckichc1zaHULoouzCbay22qXmd4zDkK7lVs2TM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dzZmX2deWbo5el3iWfoER7LPZ0ySgX6Z5Nt3UaWsjs7fcADckS8LHcVHcddghjbmuyR7fff7Na5I9m6joKpNKEiDkIuaM0yZTGVmfSiUVIfY1f4JZW8xH3NyGL3cy8r/LFocd470h/HtWgrmgv/ZiDJ4Q3eoQJPXgp3uRlBStNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1N1e2egg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oApiFxAz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 10:54:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740567263;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xvHaR9tznwMQP9OOIDgTPyPnOn0Hoj7Y6w3MVd4252c=;
	b=1N1e2eggB1FnzdotnGqnUMJFkhEonuxIUJY2sHggpG+jOtR0DgWwBdz9bfK+no6RNpXon0
	C1IjIJi3WwGvrHMje+S9lXly151AdbpnL8xXU4Ywhes3TQTIF8hQPtJu7u7L8j0vvVpVla
	hCp+Iejn9PmMXfcz4u7eM635k7uQe42+O7pQwwQdRVh4jBQyN+IQXJZLMPynI08/FGJwed
	BguPh00MwhQV1B4OKq7xe08bgDnW4wQ4BkDeP3OcKUCCk42+R7RrWBp7KcTwTEKSs4gH95
	2KIsS+Fg8Hfqe73X0BTyV/wknVjM0sPXuNVK76LiCnw3SL7cN4Vrsznvhe/+yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740567263;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xvHaR9tznwMQP9OOIDgTPyPnOn0Hoj7Y6w3MVd4252c=;
	b=oApiFxAzSPe8vEMSqvrVETIQar4q7WmZcSs8eApeUYaMtTN6wQpffOG3liUpGWlH5mCC97
	WrzerRXej5YjpQAQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt: Add exact_endbr() helper
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kees Cook <kees@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250224124200.059556588@infradead.org>
References: <20250224124200.059556588@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174056726271.10177.1691643759974399191.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     1d60b295042d20f312de17d74076a74a0d13a32d
Gitweb:        https://git.kernel.org/tip/1d60b295042d20f312de17d74076a74a0d13a32d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 24 Feb 2025 13:37:05 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Feb 2025 11:41:53 +01:00

x86/ibt: Add exact_endbr() helper

For when we want to exactly match ENDBR, and not everything that we
can scribble it with.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <kees@kernel.org>
Link: https://lore.kernel.org/r/20250224124200.059556588@infradead.org
---
 arch/x86/kernel/alternative.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 1142ebd..1cc0e4d 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -863,6 +863,17 @@ Efault:
 	return false;
 }
 
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
 static void poison_cfi(void *addr);
 
 static void __init_or_module poison_endbr(void *addr)
@@ -1426,10 +1437,9 @@ static void poison_cfi(void *addr)
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

