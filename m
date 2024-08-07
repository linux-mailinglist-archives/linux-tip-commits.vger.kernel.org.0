Return-Path: <linux-tip-commits+bounces-1982-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCF294AE0C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 18:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF881F23DB7
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 16:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9495F13E021;
	Wed,  7 Aug 2024 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XvQCGGrA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f4taxt/q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5AD13C8F3;
	Wed,  7 Aug 2024 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047933; cv=none; b=d5bQn0sGSXvfHZ2tQL9ODfRJtCuD6HzUQM4sX+UuNolsHNc8xB70bZ8BtIU5t0D8sAl1OAkmQL2ZxFnTxUnqIu57PtR8So2mV7KjR1TAYVEBRJpwuAwRmoII801ClbPN4odAG4f9nxUOPtGiW6sMEywcrcDi0N1ibGPGlJBQSUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047933; c=relaxed/simple;
	bh=mRs68dRA/guASrX6h5faX1PKz17n6ieEjb1GiePH7Hw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Tgl0PP5CFOsDgvV2+aRdJ2pBhvStR9Jc/aWhxpbzqUK9YgwK7BFEX3K+WZJAg/L3oiJPC+ZNSIQW7RZuNi86eqcPMCv3jMcS0BbNpr/iH2QlgHtYNYDiGpJCVsGyyG/TYvodit+GXV7kk2xX9CxLZve/uiUWYlIQRgvw3QxI4nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XvQCGGrA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f4taxt/q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 Aug 2024 16:25:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723047929;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5E1dsamfab7g06H5ynHG8FZDV90Fpjl6fJjc+v5w4Vg=;
	b=XvQCGGrAFz5IRV/VAd8vpxgpoiVWuYPok4dHTPO8/Iyc2DMV6OwiRKR8/BvklQIIbkImnU
	XOyxrIk4bEzqkXiHzb/y+uppZ1vss+2f/VrVD5uTb38rOmiGoT2kgiGUOox9JUlm0uwGCr
	QqE4fUPLitk6EycUG7fyQ9FY/30M4sef4aTE1qKuKQsx9yVz7wNw0E4DW7G4Z9rKby2DWJ
	V9rAkprrSJzt+kwl30XoXz9wGICMf61iePt6ifjZsaFEsTsgBv/zidudMuIFaHrS2ZzBsR
	lN7vTes/nlI5gF5Qxooe26BlsNO6RXME9RcDf8IpvLoW1IX/1J+Cy0S2wWaGyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723047929;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5E1dsamfab7g06H5ynHG8FZDV90Fpjl6fJjc+v5w4Vg=;
	b=f4taxt/qczpE5hz0+b7xudZNndXH0npS4x+o76mlKoSD3G59RWwzds9ZQtJlpIz17WX7x3
	8KHPyUyRStKkBdBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Provide apic_printk() helpers
Cc: Thomas Gleixner <tglx@linutronix.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Breno Leitao <leitao@debian.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802155440.527510045@linutronix.de>
References: <20240802155440.527510045@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172304792925.2215.4089404378024732356.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     d768e3f3e3fb43df2559d4c053b0f68c9649b2c7
Gitweb:        https://git.kernel.org/tip/d768e3f3e3fb43df2559d4c053b0f68c9649b2c7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 02 Aug 2024 18:15:39 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Aug 2024 18:13:28 +02:00

x86/apic: Provide apic_printk() helpers

apic_printk() requires the APIC verbosity level and printk level which is
tedious and horrible to read. Provide helpers to simplify all of that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/all/20240802155440.527510045@linutronix.de

---
 arch/x86/include/asm/apic.h | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 9327eb0..34eaebe 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -18,6 +18,11 @@
 
 #define ARCH_APICTIMER_STOPS_ON_C3	1
 
+/* Macros for apic_extnmi which controls external NMI masking */
+#define APIC_EXTNMI_BSP		0 /* Default */
+#define APIC_EXTNMI_ALL		1
+#define APIC_EXTNMI_NONE	2
+
 /*
  * Debugging macros
  */
@@ -25,22 +30,22 @@
 #define APIC_VERBOSE 1
 #define APIC_DEBUG   2
 
-/* Macros for apic_extnmi which controls external NMI masking */
-#define APIC_EXTNMI_BSP		0 /* Default */
-#define APIC_EXTNMI_ALL		1
-#define APIC_EXTNMI_NONE	2
-
 /*
- * Define the default level of output to be very little
- * This can be turned up by using apic=verbose for more
- * information and apic=debug for _lots_ of information.
- * apic_verbosity is defined in apic.c
+ * Define the default level of output to be very little This can be turned
+ * up by using apic=verbose for more information and apic=debug for _lots_
+ * of information.  apic_verbosity is defined in apic.c
  */
-#define apic_printk(v, s, a...) do {       \
-		if ((v) <= apic_verbosity) \
-			printk(s, ##a);    \
-	} while (0)
-
+#define apic_printk(v, s, a...)			\
+do {						\
+	if ((v) <= apic_verbosity)		\
+		printk(s, ##a);			\
+} while (0)
+
+#define apic_pr_verbose(s, a...)	apic_printk(APIC_VERBOSE, KERN_INFO s, ##a)
+#define apic_pr_debug(s, a...)		apic_printk(APIC_DEBUG, KERN_DEBUG s, ##a)
+#define apic_pr_debug_cont(s, a...)	apic_printk(APIC_DEBUG, KERN_CONT s, ##a)
+/* Unconditional debug prints for code which is guarded by apic_verbosity already */
+#define apic_dbg(s, a...)		printk(KERN_DEBUG s, ##a)
 
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86_32)
 extern void x86_32_probe_apic(void);

