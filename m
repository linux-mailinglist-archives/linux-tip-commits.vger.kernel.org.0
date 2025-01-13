Return-Path: <linux-tip-commits+bounces-3204-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EE7A0B625
	for <lists+linux-tip-commits@lfdr.de>; Mon, 13 Jan 2025 12:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009A03A5B79
	for <lists+linux-tip-commits@lfdr.de>; Mon, 13 Jan 2025 11:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C151B1CAA98;
	Mon, 13 Jan 2025 11:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N3cEjKTf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZuyEL8g4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BD622CF02;
	Mon, 13 Jan 2025 11:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736769350; cv=none; b=MF5PGiQTT4037VLMNH4E2DXWuUlx56x1akswpGVvEJ7cH+29ghRLAM3FFl313IPWVlD5edpz8MTu/fErRw5qy66cFSxA1lUpxIIEF685aQ5lJdaTfYdAmEua0tXPf2SNksEQLGWc9gdFxnOhprbuTSxeTViPbKbFsj96ytom4Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736769350; c=relaxed/simple;
	bh=re40VcQjjY40LabLyAiVNnDBwAAFG5DehzSFljr431U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XEiU08vWvvXI6OKMimzumn+kJcvoyp3IyRE6CUdTIWsRirKb09e6LWXfxbt4G3FxdyiLeSqPF48CYMiGspBXK98ouf9KpvLDlXjR9n3KkSy4wnNlW540UEDDfv2IdosX3Kj62JQFG2W+DsYoPfYw+AoypBB4GhR6ScX7e3gB5EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N3cEjKTf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZuyEL8g4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 13 Jan 2025 11:55:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736769347;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6uKr+K336708nrXf/Bfb168MfyBLI90Pvut/3ER7lcU=;
	b=N3cEjKTf5e9eKBXIQUgAYGHLgq0Lct4dFbLml38DIt6PHxnk4LpBkhMZVspqv7ngTc0aGO
	+IdoH+tl3X6X/WQAH8cpDcw7gKclRlzXfoT4aFzut1nZ2OwQiUbvzmY0vb6vwlnFvg4pge
	nNvBJ789rBCjd09fR/Y8HOZGuzpagy4XPSn7GobXLdYQ50NfCzZ64DF0QFrlgV4e5kkrj4
	WJRJDvTodgs0ooUPr5JsiP6C9ZHl9zJDEapPz70nUzqSzzgYEogcYTlxv9IbTB2x+4kpZa
	3/IGr+hneccpcdRJl+q6YRgydzY9wR47CRwTBsnNk4vfctA1acEzCGPWnvU1ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736769347;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6uKr+K336708nrXf/Bfb168MfyBLI90Pvut/3ER7lcU=;
	b=ZuyEL8g4PbrBGn3eZ232qPJaB8AF3xOshe1GVGZ7nIW46OtmtN3tBTnRZSwZdWjh9dli00
	XH0ooOVcxGFJfIBw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86: Disable EXECMEM_ROX support
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250113112934.GA8385@noisy.programming.kicks-ass.net>
References: <20250113112934.GA8385@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173676934371.399.12269265629128159619.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     a9bbe341333109465605e8733bab0b573cddcc8c
Gitweb:        https://git.kernel.org/tip/a9bbe341333109465605e8733bab0b573cddcc8c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 13 Jan 2025 12:29:34 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 13 Jan 2025 12:42:51 +01:00

x86: Disable EXECMEM_ROX support

The whole module_writable_address() nonsense made a giant mess of
alternative.c, not to mention it still contains bugs -- notable some of the
CFI variants crash and burn.

Mike has been working on patches to clean all this up again, but given the
current state of things, this stuff just isn't ready.

Disable for now, lets try again next cycle.

Fixes: 5185e7f9f3bd ("x86/module: enable ROX caches for module text on 64 bit")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250113112934.GA8385@noisy.programming.kicks-ass.net
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9d7bd0a..ef6cfea 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -83,7 +83,6 @@ config X86
 	select ARCH_HAS_DMA_OPS			if GART_IOMMU || XEN
 	select ARCH_HAS_EARLY_DEBUG		if KGDB
 	select ARCH_HAS_ELF_RANDOMIZE
-	select ARCH_HAS_EXECMEM_ROX		if X86_64
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL

