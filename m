Return-Path: <linux-tip-commits+bounces-1396-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930489096E8
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Jun 2024 10:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937271C20BB9
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Jun 2024 08:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FD01BC40;
	Sat, 15 Jun 2024 08:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D5dWJ6fC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sJyqGY0h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C0C18C38;
	Sat, 15 Jun 2024 08:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718439710; cv=none; b=JnjgwIrdvKV6kJ6y+8Wt4hobmOzq/xSmuTw2IBnzc1GBvainBN35kOaoJqRZ+2mSvrPhX9ZO7xT4bfXSw0wL+3iNdSjvAOYg08rT5B8EXpPMohbbkPEEvkMhjmoDu+JuXjKkDNkEEFA7BtqdKW2W/qC+Q0lxHI34wa0WT3Y8O/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718439710; c=relaxed/simple;
	bh=GeZiSYAxhp+7luu7ELIt5bApto+tep123M9FrEGb2c4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BBd0rqayAIRPNpDPQ2hOhJyI46vAry5EM3q77IfgwO5XPaRCgWA1WXtJGsO2iiA8SMGIaxoagDadLdA6mbC/UqGMm+YIY6qdINtg+MX2w+ugwMEtQsVW5oSHYvfdwXaE6PNRlTgFMjze6qUoJ+QKzM1mdzjclLhV8VC8t8Kz3YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D5dWJ6fC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sJyqGY0h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 15 Jun 2024 08:21:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718439706;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UThsgJEoUAKebclzK/Ewr9RjGBkf7J08M+TNRnBvsdI=;
	b=D5dWJ6fCrOzzj7PQr5oMtuq/J5u4PZWffJvgmQhTAWRPxf+N59lhP7+qOEAcfnFiz72kUC
	rQpyXFW5jzQdc33E8zpwGmtN+Ja46+PywRr+l1bQcxRpy5Vgze8Aam2VJHyeHtgFiZ+xkY
	DQ/NK/BmP9Hse8Fy5eyoUE4018ARHIXHUCuerNTemgq5Q+d55a6KBukkZylUmKoSshEYvd
	YaPrGdKY015C9dNkmLgsyeW15eqHzwZesthsf+CS1bKiaUFQJ2GAM6Gyg+svolJz0m043C
	h3CS4WJ6NRgYGs5xYYVWXg2bn5GNQfvmh+qEJM6iNSTTeKjm+2K0OrNggtZqGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718439706;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UThsgJEoUAKebclzK/Ewr9RjGBkf7J08M+TNRnBvsdI=;
	b=sJyqGY0h/x7cf2y73iMXHoGkR964E0OIupZzjnycXht7rW7NTIjvjqPWKOfP6jk2+qyjUA
	a8r5REjJelA4dECg==
From: "tip-bot2 for Alexey Makhalov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vmware] x86/vmware: Remove legacy VMWARE_HYPERCALL* macros
Cc: Alexey Makhalov <alexey.makhalov@broadcom.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240613191650.9913-8-alexey.makhalov@broadcom.com>
References: <20240613191650.9913-8-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171843970568.10875.8651021210359503206.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/vmware branch of tip:

Commit-ID:     ff42766138ff558224a35aef0ed3c4c9cfcec4de
Gitweb:        https://git.kernel.org/tip/ff42766138ff558224a35aef0ed3c4c9cfcec4de
Author:        Alexey Makhalov <alexey.makhalov@broadcom.com>
AuthorDate:    Thu, 13 Jun 2024 12:16:49 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 14 Jun 2024 18:01:21 +02:00

x86/vmware: Remove legacy VMWARE_HYPERCALL* macros

No more direct use of these macros should be allowed. The vmware_hypercallX API
still uses the new implementation of VMWARE_HYPERCALL macro internally, but it
is not exposed outside of the vmware.h.

Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240613191650.9913-8-alexey.makhalov@broadcom.com
---
 arch/x86/include/asm/vmware.h | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index 724c8b9..d83444f 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -279,30 +279,4 @@ unsigned long vmware_hypercall_hb_in(unsigned long cmd, unsigned long in2,
 #undef VMW_BP_CONSTRAINT
 #undef VMWARE_HYPERCALL
 
-/* The low bandwidth call. The low word of edx is presumed clear. */
-#define VMWARE_HYPERCALL						\
-	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT) ", %%dx; " \
-		      "inl (%%dx), %%eax",				\
-		      "vmcall", X86_FEATURE_VMCALL,			\
-		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
-
-/*
- * The high bandwidth out call. The low word of edx is presumed to have the
- * HB and OUT bits set.
- */
-#define VMWARE_HYPERCALL_HB_OUT						\
-	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT_HB) ", %%dx; " \
-		      "rep outsb",					\
-		      "vmcall", X86_FEATURE_VMCALL,			\
-		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
-
-/*
- * The high bandwidth in call. The low word of edx is presumed to have the
- * HB bit set.
- */
-#define VMWARE_HYPERCALL_HB_IN						\
-	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT_HB) ", %%dx; " \
-		      "rep insb",					\
-		      "vmcall", X86_FEATURE_VMCALL,			\
-		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
 #endif

