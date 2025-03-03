Return-Path: <linux-tip-commits+bounces-3769-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D443BA4BC5E
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 11:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1096E1894A7A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 10:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC83A94A;
	Mon,  3 Mar 2025 10:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lOA09czB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/tSePfZL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBE51F3BB9;
	Mon,  3 Mar 2025 10:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997991; cv=none; b=qYlrZ3eLT6v7wRMt4p2IiyF1GeOsn0QruWI9v1HLnWzjoOH2vGI4uBuXjy/Co3rmpXvVfdqpexVFAENPiq0qqf7vpsQ8TDow/HkY83ZPq80niiIGrMHqHg+pd3KwVICRZUnk35dE8vrCxwp/Hg+l3dL5D30kM2lIM4xdfOfcqW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997991; c=relaxed/simple;
	bh=RM4QAvGV1NBAb4Ues2i8QoBe5HEpy5pp0Y4Niq4mWkw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KkAYTw9CZfjE4un4grEd0+mjtMlpPb5pOwP7NgDOrkUN8HAk2iCBFqOP3GdRjwJZH/QKpg/LmxqneNsTeV9z+3GuhwLAQiGpc3Du8QeKfjQugXw1Yt6MDk1IG3L8q8z4O12JUC+W8bqIZnknx3ttGr7IB24C38C6vjgC73R7t3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lOA09czB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/tSePfZL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 10:33:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740997987;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDgAjsjFd8np8bHQW4EImxszyneFYWIZpyVBQYvGnYI=;
	b=lOA09czBpGh6D+oRmmBaYq6Ev3pcy3reNl9vazti4ahUoa+5yrHWjlKoW8cDy8cds9WHKN
	giapMrCnaz/KyCgWH3a2l+ZG5ntYBoxYkQ1AfR3k83oFulZqvZn+VfddXw/TDKeZ9tVrxP
	3oDyr6WO2PmLbIOuluknG8KpMVPcRPrIKb+7tlDVtbwjWkuHFwjjx7DXUH4GRi4kGYoPOA
	6A7Cm0V1BAAj1Z/Dq3aY2h9Sy6RXxfAjw41a4CH78WMqr0iwLh/MIjteIRZkOYxf9Hr7pV
	YcmtnE/s1hsCT3QAJDNjQVhWevahpFrDkXgGc0gqA6b+KczYD15ePpk37Qn+uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740997987;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDgAjsjFd8np8bHQW4EImxszyneFYWIZpyVBQYvGnYI=;
	b=/tSePfZLJF5OyMQ1mdwxwOxH2EJBJVU+WF6rjBTH0q3083IfheEWffT/wRXtT3Bx1kCQVD
	OHqahdMucTMfNBCw==
From: "tip-bot2 for Dr. David Alan Gilbert" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] x86/paravirt: Remove unused paravirt_disable_iospace()
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 Juergen Gross <jgross@suse.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250303004441.250451-1-linux@treblig.org>
References: <20250303004441.250451-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174099798705.10177.12196648903648840450.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     3101900218d7b6acbdee8af3e7bcf04acf5bf9ef
Gitweb:        https://git.kernel.org/tip/3101900218d7b6acbdee8af3e7bcf04acf5bf9ef
Author:        Dr. David Alan Gilbert <linux@treblig.org>
AuthorDate:    Mon, 03 Mar 2025 00:44:41 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Mar 2025 11:19:52 +01:00

x86/paravirt: Remove unused paravirt_disable_iospace()

The last use of paravirt_disable_iospace() was removed in 2015 by
commit d1c29465b8a5 ("lguest: don't disable iospace.")

Remove it.

Note the comment above it about 'entry.S' is unrelated to this
but stayed when intervening code got deleted.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20250303004441.250451-1-linux@treblig.org
---
 arch/x86/include/asm/paravirt_types.h |  2 --
 arch/x86/kernel/paravirt.c            | 20 --------------------
 2 files changed, 22 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 8b36a95..8e21a1a 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -242,8 +242,6 @@ extern struct paravirt_patch_template pv_ops;
 
 #define paravirt_ptr(op)	[paravirt_opptr] "m" (pv_ops.op)
 
-int paravirt_disable_iospace(void);
-
 /*
  * This generates an indirect call based on the operation type number.
  *
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 1dc114c..d0b789d 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -90,26 +90,6 @@ void paravirt_set_sched_clock(u64 (*func)(void))
 	static_call_update(pv_sched_clock, func);
 }
 
-/* These are in entry.S */
-static struct resource reserve_ioports = {
-	.start = 0,
-	.end = IO_SPACE_LIMIT,
-	.name = "paravirt-ioport",
-	.flags = IORESOURCE_IO | IORESOURCE_BUSY,
-};
-
-/*
- * Reserve the whole legacy IO space to prevent any legacy drivers
- * from wasting time probing for their hardware.  This is a fairly
- * brute-force approach to disabling all non-virtual drivers.
- *
- * Note that this must be called very early to have any effect.
- */
-int paravirt_disable_iospace(void)
-{
-	return request_resource(&ioport_resource, &reserve_ioports);
-}
-
 #ifdef CONFIG_PARAVIRT_XXL
 static noinstr void pv_native_write_cr2(unsigned long val)
 {

