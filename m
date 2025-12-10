Return-Path: <linux-tip-commits+bounces-7622-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13690CB194C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Dec 2025 02:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A9413021908
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Dec 2025 01:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF62321ABC9;
	Wed, 10 Dec 2025 01:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XAgt0anC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="inZwBGC2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8EA21A92F;
	Wed, 10 Dec 2025 01:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765329142; cv=none; b=ggC/FJu88Gybs5BgdBdV0nbND/r/NzCzVsf0eItUaS6njIjAy6mjy50I1KnHFOdbUfqj+Vis867taTUcKCCJ49XeGdsk+UsDpzKhNQuaSzpoqIuRFyvzE6bBqfAJQ09m5mcAl21TuhVaa28sh0aReZYWaSFELBZoXouVyH63Kiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765329142; c=relaxed/simple;
	bh=2Z8wzATEHKuYL2uw3CgVWtMRf07YbvmaNIEcNeRnsPU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MoZB8fgqo5bRrsPI9YHpHTJ4C/wO0MVNtFzqvvRHF195aHp3W07lgtHCk9vZzaN7t3roNypFyUYmiIP5ee78QCqopVVzih0iCsj/FxFE/RmaLPY5+qwRoT+fbsKvJiIzWW1xv5RptWeM5XDWTtS5zmBrDx3gj86YbkGpg0xBbIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XAgt0anC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=inZwBGC2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Dec 2025 01:12:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765329138;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3JRN5YBKwjImNXWaMPt9WbRtUHyK53ANjuBWR0dyQn8=;
	b=XAgt0anCBH53qxFTk0QSRdAckm6o+6+8vMIrR5X/mncU2edHE/MHo2b6lb5jA/055pENRu
	MIUYoTHxIHl5koOp/BVwlRDfdsRoZvxHMaOIVcNklCIBaQZwblm2uxK+Ych1+Mhvvx3f64
	9nNzTf3LVJhtxe4nabIqzZOYJLN6LsIPte+I5zsapl3E9P1W+h35ad/FdF41gSDJYAW3xS
	wcHaKUJlHhFsy9EVQS+MJTngtrDtrmuu7yHYCWQaOdBZk2/h7s4yDBI0seLio3MZp+ErSm
	FYamdIU1FGchRufr0YViUuHe0cuY0RB1wPSYFTsY/NVqgTDT6OrUU/VGoO6hqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765329138;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3JRN5YBKwjImNXWaMPt9WbRtUHyK53ANjuBWR0dyQn8=;
	b=inZwBGC2WANLRIxnkmJ/2QwUjfz8+UGfxsiigdIWMUAjXbyv8X0GZvNO/BJgT/gyv5mBKk
	zO/9cle6hnrsAYDg==
From: "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] rseq: Always inline rseq_debug_syscall_return()
Cc: Eric Dumazet <edumazet@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251205100753.4073221-1-edumazet@google.com>
References: <20251205100753.4073221-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176532913615.498.13429276115753090996.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     ad9c647ad7627d1ced814fca6d75d046b5a04d6b
Gitweb:        https://git.kernel.org/tip/ad9c647ad7627d1ced814fca6d75d046b5a=
04d6b
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Fri, 05 Dec 2025 10:07:53=20
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Dec 2025 10:10:05 +09:00

rseq: Always inline rseq_debug_syscall_return()

To get the full benefit of commit eaa9088d568c ("rseq: Use static branch
for syscall exit debug when GENERIC_IRQ_ENTRY=3Dy"), clang needs
__always_inline instead of a plain inline qualifier.

for i in {1..10}; do taskset -c 4 perf5 bench syscall basic -l 100000000 | gr=
ep "ops/sec"; done

      	 Before	     After
ops/sec  15424491    15872221   +2.9%

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251205100753.4073221-1-edumazet@google.com
---
 include/linux/rseq_entry.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index c92167f..a36b472 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -596,7 +596,7 @@ static __always_inline void rseq_exit_to_user_mode_legacy=
(void)
=20
 void __rseq_debug_syscall_return(struct pt_regs *regs);
=20
-static inline void rseq_debug_syscall_return(struct pt_regs *regs)
+static __always_inline void rseq_debug_syscall_return(struct pt_regs *regs)
 {
 	if (static_branch_unlikely(&rseq_debug_enabled))
 		__rseq_debug_syscall_return(regs);

