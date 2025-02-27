Return-Path: <linux-tip-commits+bounces-3721-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F6CA489B6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 21:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200BA3B3D1F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 20:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3801A841B;
	Thu, 27 Feb 2025 20:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GRd0QJLr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7qetVH1Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6282026F443;
	Thu, 27 Feb 2025 20:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687687; cv=none; b=HOMKmfI43vKT980F9/ukmRB7mJOJxHezrrXovqbTf7P/pJohB45sIYzKxmgzzXY7RGJhKB04mmL4JCXeNMJ593pO1kZhccJVMn+xYarpwVAyCgDGJL2STGgL5BHj4dtNVrtzgSo1otL1qXlLVTnHHAX8XRvPqnBwSE74dCdqSJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687687; c=relaxed/simple;
	bh=rATGIb8eOkGdpsr3UNt1z5AYAvAdTYeozpp0Xkop/ls=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=af9r35x0lejhIGHri8pppoNQFqOGEHKSFxAigaO/OrRsEEFosXxPVKcbNROX187xwbYPAXsVqsyDijMhlz+Qti3pgBYqu203+l5+x3YDqTFrxsdp6qI1xJwB5bJFUxUxlNfNYyKVFAc0LQ4KdHgElAoSzb/xZXqEcbtCtjk4WnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GRd0QJLr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7qetVH1Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 20:21:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740687683;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONSa22HSm7xGBZSnEu6JEbkICzapN8ExCxJSd8trR4A=;
	b=GRd0QJLrmdhz7MK42dppt/wJgCKIkIYA0Q9JlmD87I8rTSdEjWR7l4DyaZIKRUBTf/IeOA
	zyZ8Z6zTPtiL6V5/cP+im96W/TNGGAkVvcbVxRT755XWhpinAc/mSo7ZG81G5zWJK7XtRq
	7mxq/D/X0MtneUCFxdoNkzsLJ4PQ8SkGRKNmd3lAgmJHnelZ7WJtpmbxOsxNPr9FwrTVKd
	O/uTUfjFaUUyMnyOEEqeIOATefBXKAZ0wMrxaUJUQI2ccRuSGphAO6RWBEtgK4aSKx4qUZ
	VwIo9f5FKqq+IuZIg7VcHwXo/++6MiGsljVcYOsIieLXAL/VSWtxo1fB1R4QoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740687683;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONSa22HSm7xGBZSnEu6JEbkICzapN8ExCxJSd8trR4A=;
	b=7qetVH1Z48HD4Z8nn0pW8nuDC3bj5PiXyV7Y5ndi06qOBYg3mvV6GthkkALiHX6fo1sUYP
	p6jCgthWCXlMGTBA==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/bpf: Fix BPF percpu accesses
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Uros Bizjak <ubizjak@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250227195302.1667654-1-brgerst@gmail.com>
References: <20250227195302.1667654-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174068768313.10177.13465442167535423659.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     18cdd90aba794333f4c6dce39f5c3fe642af5575
Gitweb:        https://git.kernel.org/tip/18cdd90aba794333f4c6dce39f5c3fe642af5575
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Thu, 27 Feb 2025 14:53:02 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 21:10:03 +01:00

x86/bpf: Fix BPF percpu accesses

Due to this recent commit in the x86 tree:

  9d7de2aa8b41 ("Use relative percpu offsets")

percpu addresses went from positive offsets from the GSBASE to negative
kernel virtual addresses.  The BPF verifier has an optimization for
x86-64 that loads the address of cpu_number into a register, but was only
doing a 32-bit load which truncates negative addresses.

Change it to a 64-bit load so that the address is properly sign-extended.

Fixes: 9d7de2aa8b41 ("Use relative percpu offsets")
Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250227195302.1667654-1-brgerst@gmail.com
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9971c03..f74263b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21692,7 +21692,7 @@ patch_map_ops_generic:
 			 * way, it's fine to back out this inlining logic
 			 */
 #ifdef CONFIG_SMP
-			insn_buf[0] = BPF_MOV32_IMM(BPF_REG_0, (u32)(unsigned long)&pcpu_hot.cpu_number);
+			insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, (u32)(unsigned long)&pcpu_hot.cpu_number);
 			insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
 			insn_buf[2] = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0);
 			cnt = 3;

