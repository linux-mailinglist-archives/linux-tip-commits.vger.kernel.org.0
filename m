Return-Path: <linux-tip-commits+bounces-2112-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E50C95E3C7
	for <lists+linux-tip-commits@lfdr.de>; Sun, 25 Aug 2024 16:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0F61F211B9
	for <lists+linux-tip-commits@lfdr.de>; Sun, 25 Aug 2024 14:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1318E155308;
	Sun, 25 Aug 2024 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4OA3QTvu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A9rEOpsp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7669E42AAA;
	Sun, 25 Aug 2024 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724595129; cv=none; b=c22xxFUgUxFhw4NDwlgxprR7K/QoxY2ZZE6igY3WBUSvvDrBbCwx3Z2QcWAMneVSpOJkyDXnI5KV4er5BRUW6Qb10eXWVI4e3A2XtVzhmzygN8q4RmQAn8K+1cpTmsPElFmv/LIWI8ZY/gb7kZ3sxBw7I1IS9kVvvwTzkJ7FZnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724595129; c=relaxed/simple;
	bh=cvkNeCn7yvuMeh7za92cbvoJjBcqBVHuSYFAPsXvd+0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VdQfo/JpX34gJpczw7imGams3qY3eJdovUSt576ofnYVxFhExM/cjowZ02H0d/3CRDoOdF6NuXtXn+GbXqMmA4blVPcEi8eVp0+Kou1Rfi+0hwRTl3nq9U+8vKxGoQoGTUy5A4q+ouDBLiH3d4lqPrvql73Xgzr15cMXmTktWRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4OA3QTvu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A9rEOpsp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 25 Aug 2024 14:12:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724595123;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pRuMaLGGHk+OvAsODHPm7kXDkPi+BpsmBo7Ngbye4XQ=;
	b=4OA3QTvuTDjkatEJfclYKEpq7esU6AX4So+14khSHnGvSt4xOo1HZZdDTWFQ1FSF8XXjot
	lH1OgiYH7ujbGll6GMZ7QMACko4DWNC73TplQRm2gO3mjf16uPuwxcotLUMS3h8nuAUHI4
	a0DAtHx6+3JaNBC3BePTz2x4D4ok2ilLgE6Y5UaPtgRT1GKADp7rdnhPoLrJcLHvc983/I
	I+lO4/l0fVvWeqJB0zoqgd4uPETTnC9r7mEY5s5Yd9HQ85XHmGNtng5cFBS4SueOMOeKI3
	eiv1imhgDFBKou3ZaKp+DnQQGTZ4Hn4QkFHex9Z9tI1Ln1cVxMu6D7Z8dyuDHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724595123;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pRuMaLGGHk+OvAsODHPm7kXDkPi+BpsmBo7Ngbye4XQ=;
	b=A9rEOpspZVa3zPApfwbGqqvEqSYm50GlsRIH6NwGc2UUyqxpH04h9MpVJoWrtH3m/mtaNn
	XU+Ebtcg2acNIPAA==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/boot/64: Strip percpu address space when
 setting up GDT descriptors
Cc: Uros Bizjak <ubizjak@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240819083334.148536-1-ubizjak@gmail.com>
References: <20240819083334.148536-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172459512275.2215.9304580612288616565.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     b51207dc02ec3aeaa849e419f79055d7334845b6
Gitweb:        https://git.kernel.org/tip/b51207dc02ec3aeaa849e419f79055d7334845b6
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 19 Aug 2024 10:33:13 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 25 Aug 2024 16:07:51 +02:00

x86/boot/64: Strip percpu address space when setting up GDT descriptors

init_per_cpu_var() returns a pointer in the percpu address space while
rip_rel_ptr() expects a pointer in the generic address space.

When strict address space checks are enabled, GCC's named address space
checks fail:

  asm.h:124:63: error: passing argument 1 of 'rip_rel_ptr' from
                       pointer to non-enclosed address space

Add a explicit cast to remove address space of the returned pointer.

Fixes: 11e36b0f7c21 ("x86/boot/64: Load the final kernel GDT during early boot directly, remove startup_gdt[]")
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240819083334.148536-1-ubizjak@gmail.com

---
 arch/x86/kernel/head64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index a817ed0..4b9d455 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -559,10 +559,11 @@ void early_setup_idt(void)
  */
 void __head startup_64_setup_gdt_idt(void)
 {
+	struct desc_struct *gdt = (void *)(__force unsigned long)init_per_cpu_var(gdt_page.gdt);
 	void *handler = NULL;
 
 	struct desc_ptr startup_gdt_descr = {
-		.address = (unsigned long)&RIP_REL_REF(init_per_cpu_var(gdt_page.gdt)),
+		.address = (unsigned long)&RIP_REL_REF(*gdt),
 		.size    = GDT_SIZE - 1,
 	};
 

