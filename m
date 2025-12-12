Return-Path: <linux-tip-commits+bounces-7640-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A28DCB8788
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Dec 2025 10:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 284A03094E37
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Dec 2025 09:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98192313522;
	Fri, 12 Dec 2025 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Xfp6DvJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uRGcV0sV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76C33128D5;
	Fri, 12 Dec 2025 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765531756; cv=none; b=W3hxe1nsqibZzdVxRwjN7jeCRa2B9eQ6ZMWHjliwHONrD9PPcNMjLPTkkc/6Rh6j0AYKJfeArnYtE4vy2OydF1cBLpoa/NyQDQ0htA8yrat+uCgnHIurHVdTSDWzXDQDonxn0rgCT6TZwnp42cV3SKJROA7vXRuRnEDffdtKr2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765531756; c=relaxed/simple;
	bh=y8czPkgDKnL50TfCa4OzqJYDg1env9URVlrSdwoWlKo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gU5/os2eIotmnK1msRTp9CR7oaMC16SZoQlR1Fhu6WM6rft/spKmgMKqAFLxey5RQfSX30P0l8+HwGaEN8ZT3os1wlR6r2xnAfnwk5l+HI1tyOp50tmRxhsuDasWhrsouHPCwlSFmrMmPp1KlmcLQGclBLn0S4o3xlB6AIrC1bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Xfp6DvJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uRGcV0sV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Dec 2025 09:29:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765531750;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7lAXBAdp/4CMyV9DIl2p/LUTB0YPfKO6leNSKD9gpJw=;
	b=3Xfp6DvJJhSOt3K+6ff7IsVlD/0/wX2GFZ9EyHBpsE/QACtaqq3nY6IkXaIofcOHkzD7+x
	4DI151M8an4fDeb4mb/m6Q5dfu7TAhb5u3CLuDtuuc+Z1TogU/eMtjBQBRza0fZLQJvFx4
	5hpRvTDUMLVGRH85tyf9Kukysnlkl0OnFhsrV7CG3tYFm9bt+wwm8pTRtvtx+S6DV3+7L+
	718QYxlFK05XyvfE2sGgWLPaxXm8kfQ3U7rq6Re9JEIsEYtkAa9FZasI30rHvUk2FZFw1S
	+Mi/SjzKpfpUiu10Jg/UxEi18lZEdRg/NdG3rBLPf4maUiQFY072PAviJ0muFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765531750;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7lAXBAdp/4CMyV9DIl2p/LUTB0YPfKO6leNSKD9gpJw=;
	b=uRGcV0sVExoSkYBuObBCAAohxaNAkECXikky+JyWuherStKXW1zyTSmNrmvcCw/I9TKXSw
	M5+T8dc2wK27XdDA==
From: "tip-bot2 for Brendan Jackman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/urgent] bug: Hush suggest-attribute=format for __warn_printf()
Cc: Brendan Jackman <jackmanb@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251207-warn-printf-gcc-v1-1-b597d612b94b@google.com>
References: <20251207-warn-printf-gcc-v1-1-b597d612b94b@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176553174896.498.13361634715547530370.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     d36067d6ea00827e9b8fc087d8216710cb99b3cf
Gitweb:        https://git.kernel.org/tip/d36067d6ea00827e9b8fc087d8216710cb9=
9b3cf
Author:        Brendan Jackman <jackmanb@google.com>
AuthorDate:    Sun, 07 Dec 2025 03:53:18=20
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Dec 2025 10:26:26 +01:00

bug: Hush suggest-attribute=3Dformat for __warn_printf()

Recent additions to this function cause GCC 14.3.0 to get excited
(W=3D1) and suggest a missing attribute:

	lib/bug.c: In function '__warn_printf':
	lib/bug.c:187:25: error: function '__warn_printf' be a candidate for 'gnu_pr=
intf' format attribute [-Werror=3Dsuggest-attribute=3Dformat]
	  187 |                         vprintk(fmt, *args);
	      |                         ^~~~~~~

Disable the diagnostic locally, following the pattern used for stuff
like va_format().

Fixes: 5c47b7f3d1a9 ("bug: Add BUG_FORMAT_ARGS infrastructure")
Signed-off-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/20251207-warn-printf-gcc-v1-1-b597d612b94b@goo=
gle.com
---
 lib/bug.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bug.c b/lib/bug.c
index c6f691f..623c467 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -173,6 +173,9 @@ struct bug_entry *find_bug(unsigned long bugaddr)
 	return module_find_bug(bugaddr);
 }
=20
+__diag_push();
+__diag_ignore(GCC, all, "-Wsuggest-attribute=3Dformat",
+	      "Not a valid __printf() conversion candidate.");
 static void __warn_printf(const char *fmt, struct pt_regs *regs)
 {
 	if (!fmt)
@@ -192,6 +195,7 @@ static void __warn_printf(const char *fmt, struct pt_regs=
 *regs)
=20
 	printk("%s", fmt);
 }
+__diag_pop();
=20
 static enum bug_trap_type __report_bug(struct bug_entry *bug, unsigned long =
bugaddr, struct pt_regs *regs)
 {

