Return-Path: <linux-tip-commits+bounces-3684-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A087A46346
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 15:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334831678F5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 14:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741F021D3C7;
	Wed, 26 Feb 2025 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2BcEhDu2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CVhnw3LD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E1B221711;
	Wed, 26 Feb 2025 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580954; cv=none; b=B5fooeSAp+JnB/vx6yDuY1nCK2LAvsSjyCyT1Y6eOpHg/Kwbl4y/w8Ns3KuL12aVXo3UXBVfVOP0nF/vLA9BI9Q06Ay0MIaeF6CxWwRlahbQGSaN3DVz0IS8Q8r5dAubrlT/XAkWaS+NthWwinukZYmzlDLKKOphilOaSoNGtwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580954; c=relaxed/simple;
	bh=9o4ynd5OU7q/sdk9GOnxCe8bihN6fpobRfCz8WqH8+0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=L9I25WjzYT7dnajBcN4GzzhH6KQteR+Cisn0y36Ffgv1EfgsvAG9mMRP5KJCYXdWMA4d3hX4dlUNnj1vM25sHI7cxzCVETKz0xVwggtBPPekxpmp5zf14sTstXkNFbM13gGHWEYOgp5MmO6vjxnZZkggoXTe55bN8xxihrTSslI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2BcEhDu2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CVhnw3LD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 14:42:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740580950;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIcwSUstoeqhAjCOmQ/dZW90SDtcJdVVqcLA8en+5Lg=;
	b=2BcEhDu2XkRwjj3Oeky84fKvygjUH8C9PYrv+dD6ofEh1ga5jRc17GKdzKi2vRhD4zqfru
	BOHVMSrnkDMj79IlW1hhxhiYnx845SMZ0Phs6F6IMx5G+iAzH1jr738432eyB4mbO1D5gr
	1vSvEIe+234oTliWK9ON8/wD9pJ8Rkh2TY+Xs/sV+l6yr0A6v8KaXSJeONmGuW0dxUdl8Y
	/whUNAFtHs7fD7SphxjD9VOaEgGk5cnzhEfJIAf3wLO7AfaY+OkYcgESH0o3XCgmYhe4ZB
	h9ERjAZ16vc/GbC+B0+y4z1AuwkE3blrQILLNACMcVwS+3P/mkRTK6uLfcbbKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740580950;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIcwSUstoeqhAjCOmQ/dZW90SDtcJdVVqcLA8en+5Lg=;
	b=CVhnw3LDBfSWeh7Wur5LLVHdaJAvmKJq3tFqgFUDpFmyTFTVkJaI93gkXg8dX5I8Bcda2A
	Rg9If0VTJDyiKvDA==
From: "tip-bot2 for Benjamin Berg" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Avoid copying dynamic FP state from init_task
 in arch_dup_task_struct()
Cc: Benjamin Berg <benjamin.berg@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250226133136.816901-1-benjamin@sipsolutions.net>
References: <20250226133136.816901-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174058095002.10177.7516126754738337823.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     5d3b81d4d8520efe888536b6906dc10fd1a228a8
Gitweb:        https://git.kernel.org/tip/5d3b81d4d8520efe888536b6906dc10fd1a228a8
Author:        Benjamin Berg <benjamin.berg@intel.com>
AuthorDate:    Wed, 26 Feb 2025 14:31:36 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Feb 2025 15:32:34 +01:00

x86/fpu: Avoid copying dynamic FP state from init_task in arch_dup_task_struct()

The init_task instance of struct task_struct is statically allocated and
may not contain the full FP state for userspace. As such, limit the copy
to the valid area of both init_task and 'dst' and ensure all memory is
initialized.

Note that the FP state is only needed for userspace, and as such it is
entirely reasonable for init_task to not contain parts of it.

Fixes: 5aaeb5c01c5b ("x86/fpu, sched: Introduce CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT and use it on x86")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20250226133136.816901-1-benjamin@sipsolutions.net
----

v2:
- Fix code if arch_task_struct_size < sizeof(init_task) by using
  memcpy_and_pad.
---
 arch/x86/kernel/process.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 6da6769..7cb52f8 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -93,7 +93,12 @@ EXPORT_PER_CPU_SYMBOL_GPL(__tss_limit_invalid);
  */
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 {
-	memcpy(dst, src, arch_task_struct_size);
+	/* init_task is not dynamically sized (incomplete FPU state) */
+	if (unlikely(src == &init_task))
+		memcpy_and_pad(dst, arch_task_struct_size, src, sizeof(init_task), 0);
+	else
+		memcpy(dst, src, arch_task_struct_size);
+
 #ifdef CONFIG_VM86
 	dst->thread.vm86 = NULL;
 #endif

