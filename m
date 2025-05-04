Return-Path: <linux-tip-commits+bounces-5215-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7766AA84E2
	for <lists+linux-tip-commits@lfdr.de>; Sun,  4 May 2025 10:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582F63B8E8C
	for <lists+linux-tip-commits@lfdr.de>; Sun,  4 May 2025 08:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB779194A67;
	Sun,  4 May 2025 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q3lIxP/0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ncucfjKj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BF716F0FE;
	Sun,  4 May 2025 08:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746348867; cv=none; b=fd8KdDla/kACwBB7wIKrNirvVBizfLPXnDdvg0Rwvm2egcvur/ry7p+oyB0zUYVrrg0bsf3yIUGW+6xKRa+Tm+QcZR5gbCazM351H+JJhA4jyt+UNgRFCCorvcA11xAryRAWlZ792duK/aljd/45j0mdGKdUuleN1tuVCOUgVEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746348867; c=relaxed/simple;
	bh=/9pENk1ECXuhcIhvIrAtUfj0kujHwvTWxHAWKgw0zro=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JVRkHOZJWQeEf+mb42N9jzKagyjlQclPjcvE7+Xd6wKh3IX7EIzJATULpBRZfuFhDE6c0LQQ8+SBOrZnzGde3rjW9SRn9ULhGYdfL8iJIRKuC14NJJ0zNuJr0LQ17o4+JKceqiQuc1TiqEH7eiWMww7Rcib+EuHk46GshKOW1ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q3lIxP/0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ncucfjKj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 04 May 2025 08:54:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746348864;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HTXx5f72AEeRvNONFyc4kKrFzTkvUrTZG7Zb4mtu2Nk=;
	b=Q3lIxP/0IP2UemuNhBGgtxfh5rgZVfMvhIW5/f0Doqks3EflbrGsR5hgHDr7L5hqA64+YD
	eTfRJQQEr9fykK+uCGPFiu7WpngsTpFX14anbdrYeky2OG+quBrgPWfjDEbwwdEiCgASqk
	x9NSsiqzprFh7MnIETSd1DCV+FfuzlvjtyJh7k2qTRJwRo+Q18tcSA4qLsWytYrx3d+59A
	1o2u5IjLMgf0ubAsIdmahReBsGBgGXMgNmq+12702M7VSvlDYAJp4YBYv4alhuEYXJou8Z
	zma4B8tFtcUbUCuGH8ubm+eQ+8GBUkTC5DxzNbBkfGmGzK8HWzK4/4BKQobGzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746348864;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HTXx5f72AEeRvNONFyc4kKrFzTkvUrTZG7Zb4mtu2Nk=;
	b=ncucfjKjpaOvkbZBGjnGiqyruXTUgr2pJtXoPdWxOlXo8Yt9VWKltwLMMnw0Fy2L9ZdGwt
	F+8XuMZKg3nmFTCQ==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/fpu] x86/fpu: Always use memcpy_and_pad() in arch_dup_task_struct()
Cc: Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@amacapital.net>, Brian Gerst <brgerst@gmail.com>,
 "Chang S . Bae" <chang.seok.bae@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250503143850.GA8997@redhat.com>
References: <20250503143850.GA8997@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174634886368.22196.8705443193708873246.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     2d299e3d773d519ee93e5aaa3ffddd4a6276b005
Gitweb:        https://git.kernel.org/tip/2d299e3d773d519ee93e5aaa3ffddd4a6276b005
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Sat, 03 May 2025 16:38:50 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 04 May 2025 10:29:25 +02:00

x86/fpu: Always use memcpy_and_pad() in arch_dup_task_struct()

It makes no sense to copy the bytes after sizeof(struct task_struct),
FPU state will be initialized in fpu_clone().

A plain memcpy(dst, src, sizeof(struct task_struct)) should work too,
but "_and_pad" looks safer.

[ mingo: Simplify it a bit more. ]

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Chang S . Bae <chang.seok.bae@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250503143850.GA8997@redhat.com
---
 arch/x86/kernel/process.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 7a1bfb6..9e61807 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -93,11 +93,8 @@ EXPORT_PER_CPU_SYMBOL_GPL(__tss_limit_invalid);
  */
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 {
-	/* init_task is not dynamically sized (incomplete FPU state) */
-	if (unlikely(src == &init_task))
-		memcpy_and_pad(dst, arch_task_struct_size, src, sizeof(init_task), 0);
-	else
-		memcpy(dst, src, arch_task_struct_size);
+	/* fpu_clone() will initialize the "dst_fpu" memory */
+	memcpy_and_pad(dst, arch_task_struct_size, src, sizeof(*dst), 0);
 
 #ifdef CONFIG_VM86
 	dst->thread.vm86 = NULL;

