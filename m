Return-Path: <linux-tip-commits+bounces-4358-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 381D0A68AD5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE9D1B607FE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D2A25BAA0;
	Wed, 19 Mar 2025 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SVinYCpT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gu4h/+Vo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF7425A343;
	Wed, 19 Mar 2025 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382231; cv=none; b=kdvfPId30vexDWpQcNtw3XyFnAZWjdLZA22WDNNcoo54bcEUo5os+gE/0lvyCR93x26WdXN6kToIoastHrNg+sRfS42FxoFxSbwFE1i/PMNNEpcNJMGUAj1pp3r/j/AzoSRR/DbJQNjqAgJcJKZ78166HjvAa5lS9wFqlt3ICos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382231; c=relaxed/simple;
	bh=cce1fp+uqH3NdxdX8FsGpwerkLG21kmKqNrzehffyFQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fzx64L4hARpyB8NoDZH9PvCjAdzlx2LRGGPAiXQbrPLmIs9UrbvOdkvANl4RJtPcklvECFlj/xGwvFLNfIVSPzizRuNSPgbbBTHHscPjvbYozkFfw48Yer7vgLPjHoB7diUEVtOM5GBGoKCz2HffMbapubtmwzSwsNZhbyJ6afo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SVinYCpT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gu4h/+Vo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382228;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9rT6xP3vYbu4E0Ap2i9DjzYagfu8YddALZpLLTZQNc=;
	b=SVinYCpTnPqFBrFwbiQM/24JUT/HRsMSWcmmNa8Z/4cfVYG4CyX7VVDiwr5HlKflJVsp/+
	eqLDA3JWcWV59lrxDEKlVoATLTKz+zuo3zZyUezle2alR5mc7ZPNpLXvv0Cv8eji1Abo78
	3W9tKHInuZJfCquvXA5BgerqAgDXrrf0rRzZuUx4nQAiLJVnGHtDaRu3U+3rUh+1d9tKV5
	by9Ka1a2S2K95c9Lf1T6A/9920/E0diYwQnJTD79tKJ0iZsT9rPQvjAnsDMYwoJh6rzbnw
	wgd1E2UMNMO2ZGHYWqqukIemM8kwqBJ0TQ6JhJAbxBA71dDS40Vb6CsUOcVP8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382228;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9rT6xP3vYbu4E0Ap2i9DjzYagfu8YddALZpLLTZQNc=;
	b=gu4h/+Vog3Sy3+B+BA1GRZbZYpaDDLwh7GfMkCNBDBuc3WrIb1OBm80E34mpwJ1hIMZ2ay
	cYK/+1CpmwkKEBAA==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/syscall/32: Add comment to conditional
Cc: Sohil Mehta <sohil.mehta@intel.com>, Brian Gerst <brgerst@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250314151220.862768-8-brgerst@gmail.com>
References: <20250314151220.862768-8-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238222755.14745.11123777162384005162.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     82070bc0425db949b406ede1c7f066346f5b3eb9
Gitweb:        https://git.kernel.org/tip/82070bc0425db949b406ede1c7f066346f5b3eb9
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 14 Mar 2025 11:12:20 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:19:20 +01:00

x86/syscall/32: Add comment to conditional

Add a CONFIG_X86_FRED comment, since this conditional is nested.

Suggested-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250314151220.862768-8-brgerst@gmail.com
---
 arch/x86/entry/syscall_32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 993d725..2b15ea1 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -238,7 +238,8 @@ DEFINE_FREDENTRY_RAW(int80_emulation)
 	instrumentation_end();
 	syscall_exit_to_user_mode(regs);
 }
-#endif
+#endif /* CONFIG_X86_FRED */
+
 #else /* CONFIG_IA32_EMULATION */
 
 /* Handles int $0x80 on a 32bit kernel */

