Return-Path: <linux-tip-commits+bounces-3765-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9BFA4BBF0
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 11:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C9C87A1FBB
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 10:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C38C1F0E51;
	Mon,  3 Mar 2025 10:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mm5vzNqn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qs8RDPGm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825681DB551;
	Mon,  3 Mar 2025 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997389; cv=none; b=EvDk8k4006U3m0vW58dCbNYWX/z+yAq2z8sZgqWDRkAMYLXoa774K0TsonK2aYDTm/rzfIsFX5rHuHUiexhq8J7BKIblFmcXeQWFJ9eD+WWoaoZNfT8IMKuQNz6qeJUN0cSFA8LZNYW1THICXvXOZr4oN3MtcvGKueaCShQA2PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997389; c=relaxed/simple;
	bh=rb6HiHdTrrfQcE6pGBqpshK1auuAjYTiGBZi4GUMEQg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=h9/wd3oebcTATXPM/dQP5hgHaEBCurP8RljcDohDHDgAr0M97CulDb1bTfq5UnTS5DLuLbYN8W1bHtfo9TlDdRScKURFQfCU9gFwLVP0M9KdNmb10Rsl5sAwZpmQQhbwHbk6w5mzxpbMim2oghgmxRzQX47UEIAekKb5kLApuF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mm5vzNqn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qs8RDPGm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 10:23:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740997383;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L93HLqzNF/w4Btg40ftW1mueR1K1M75TuT6aU5m3ApE=;
	b=mm5vzNqndV7TUbtbTyk1c8Kv6JE8sILgPk/I4OIpJA22D8lVrxr45ddRRW0eFdIGSj/Ch/
	vAoqOBebLzISUgfGJUF0NISL3LUrTxS0agqMm/jjJyJVVKIZPs+4GVsTTlsZx05KiqAe5u
	5gHBABH3NpQrvP7taOaSqt+camvDW4IZ7Rr/KNqk++0lbHxv1O8P2tFD82WncjBDQBF6jY
	/Mh3gY3ZUw75ChDoibCjYYUYcYshS8i2Es4K2Q7DJ2hmlno8UDXNPt5DfziGpqOVZhXO3v
	gk7qSioJMjZfNpLmZwuJVdD8/I+pxmXcepiDDCCdvFTHjdE5Q/vgKfzAOijhzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740997383;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L93HLqzNF/w4Btg40ftW1mueR1K1M75TuT6aU5m3ApE=;
	b=Qs8RDPGmeGYotipGuX6X/x7R6KoSQx1TZkYCDMWSTIYekdLPWXzrm4Pa0C3DoxxZGpO7Pr
	JBO2ziwVpHiG+hBg==
From: "tip-bot2 for Dr. David Alan Gilbert" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cleanups] x86/paravirt: Remove unused paravirt_disable_iospace()
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Juergen Gross <jgross@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250303004441.250451-1-linux@treblig.org>
References: <20250303004441.250451-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174099738198.10177.3185496763546260161.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     47f0008ed7774dd3b12bd5f596e8d106dfea305a
Gitweb:        https://git.kernel.org/tip/47f0008ed7774dd3b12bd5f596e8d106dfea305a
Author:        Dr. David Alan Gilbert <linux@treblig.org>
AuthorDate:    Mon, 03 Mar 2025 00:44:41 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 03 Mar 2025 10:59:16 +01:00

x86/paravirt: Remove unused paravirt_disable_iospace()

The last use of paravirt_disable_iospace() was removed in 2015 by
commit d1c29465b8a5 ("lguest: don't disable iospace.")

Remove it.

Note the comment above it about 'entry.S' is unrelated to this
but stayed when intervening code got deleted.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20250303004441.250451-1-linux@treblig.org
---
 arch/x86/include/asm/paravirt_types.h |  2 --
 arch/x86/kernel/paravirt.c            | 20 --------------------
 2 files changed, 22 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index fea56b0..3c54ac5 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -242,8 +242,6 @@ extern struct paravirt_patch_template pv_ops;
 
 #define paravirt_ptr(op)	[paravirt_opptr] "m" (pv_ops.op)
 
-int paravirt_disable_iospace(void);
-
 /* This generates an indirect call based on the operation type number. */
 #define PARAVIRT_CALL					\
 	ANNOTATE_RETPOLINE_SAFE				\
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 1ccaa33..debe928 100644
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

