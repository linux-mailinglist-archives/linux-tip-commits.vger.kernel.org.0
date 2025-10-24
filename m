Return-Path: <linux-tip-commits+bounces-6996-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF1FC0806B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Oct 2025 22:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB93A3A5A86
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Oct 2025 20:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77C22BEC2D;
	Fri, 24 Oct 2025 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TVOldf2f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ICctYwHv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478F52EFDA1;
	Fri, 24 Oct 2025 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761337278; cv=none; b=HBPSS6sIZW0E/ghPd42eawWtrJogaenZ278OOf95yWniEjh/YyvuyYjJKqyDwvl14n0sbaLs/EDC0UIVrJcBjl+96RejaKLIgBvCOQJBdI3wTPAlm5AtsAdhv8L243TdG6TWjb2eXoQQ/+2Q2+pvgzVe/ylGHZLdUatorpvKezo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761337278; c=relaxed/simple;
	bh=j9xuF4yDIzTQkKBt41wuiNUEnpNdgm4QY0Tm8voRNCY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=RE9qV99VU347wd36Zxv76sSAOUS7LA/Mq12KRBpM+ghYIMdTQwlwoKuO1V81oBv4JmEQZGrxgbRs+foREfAE1m+brQubZ0Boex54joEzrTX2TOLs/6+2GF1YNpaTcX7gFOJYKP7UL/s3ixj557yakUKQ0mawXR1+GdczMGiBW4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TVOldf2f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ICctYwHv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 24 Oct 2025 20:21:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761337275;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=qeDyLCIDRehGTOupCtBVUgO2L1YPm0r8puOg0MjCDwc=;
	b=TVOldf2fOVOcUqljdISd+5ern6JQuqhtPaAq+Iqb9D1CXfqACJebIGAXbX+/RonDyj5oAa
	QcL9RCfjzxPKW2/vRT3e42XONcESqtfE/pjdy3VYPIM4SaNOyexPhVMBZUPXThgE5ujF/x
	aH95svddAXy6e87xqv1+W91ZhFuRh2paHpUdc+WE7cUIyfCNSqCAXNFH+A9/AgXHcQa721
	VNBZcVnHHNxZTXqRQk2n2UpX708CXdkj4MBgUUt9c8BNvfcn/cYa2vx3GdcHppjwI0VgOr
	fi5BGzlhHeQ45ZoMT542x9l9ZxFCdaWFvETDM452w/TuSticiehJ6RkIs/T+ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761337275;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=qeDyLCIDRehGTOupCtBVUgO2L1YPm0r8puOg0MjCDwc=;
	b=ICctYwHvSCqpBCkFUE6YeEoSLK5D2K8vyAG1GjEgAtl/2FplCyD8yb5rDRofBvcaAJ2WT+
	XYKEjIiF8th+MVDg==
From: "tip-bot2 for Brendan Jackman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Unify __phys_addr_symbol()
Cc: Brendan Jackman <jackmanb@google.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176133727384.2601451.12595959116263501228.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     5385dec724ab4582df5b1fb2184c8b42ea547b3d
Gitweb:        https://git.kernel.org/tip/5385dec724ab4582df5b1fb2184c8b42ea5=
47b3d
Author:        Brendan Jackman <jackmanb@google.com>
AuthorDate:    Wed, 13 Aug 2025 15:08:22=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 24 Oct 2025 22:13:00 +02:00

x86/mm: Unify __phys_addr_symbol()

There are two implementations on 64-bit, depending on CONFIG_DEBUG_VIRTUAL,
but they differ only regarding the presence of VIRTUAL_BUG_ON, which is
already ifdef'd on CONFIG_DEBUG_VIRTUAL.

To avoid adding a function call on non-LTO non-DEBUG_VIRTUAL builds, move the
function into the header. (Note the function is already only used on 64-bit).

Signed-off-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://patch.msgid.link/all/20250813-phys-addr-cleanup-v1-1-19e334b1c4=
66@google.com/
---
 arch/x86/include/asm/page_64.h | 14 +++++++++++---
 arch/x86/mm/physaddr.c         | 11 -----------
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 015d23f..364c8d6 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -9,6 +9,7 @@
 #include <asm/alternative.h>
=20
 #include <linux/kmsan-checks.h>
+#include <linux/mmdebug.h>
=20
 /* duplicated to the one in bootmem.h */
 extern unsigned long max_pfn;
@@ -31,13 +32,20 @@ static __always_inline unsigned long __phys_addr_nodebug(=
unsigned long x)
=20
 #ifdef CONFIG_DEBUG_VIRTUAL
 extern unsigned long __phys_addr(unsigned long);
-extern unsigned long __phys_addr_symbol(unsigned long);
 #else
 #define __phys_addr(x)		__phys_addr_nodebug(x)
-#define __phys_addr_symbol(x) \
-	((unsigned long)(x) - __START_KERNEL_map + phys_base)
 #endif
=20
+static inline unsigned long __phys_addr_symbol(unsigned long x)
+{
+	unsigned long y =3D x - __START_KERNEL_map;
+
+	/* only check upper bounds since lower bounds will trigger carry */
+	VIRTUAL_BUG_ON(y >=3D KERNEL_IMAGE_SIZE);
+
+	return y + phys_base;
+}
+
 #define __phys_reloc_hide(x)	(x)
=20
 void clear_page_orig(void *page);
diff --git a/arch/x86/mm/physaddr.c b/arch/x86/mm/physaddr.c
index fc3f3d3..8d31c6b 100644
--- a/arch/x86/mm/physaddr.c
+++ b/arch/x86/mm/physaddr.c
@@ -31,17 +31,6 @@ unsigned long __phys_addr(unsigned long x)
 	return x;
 }
 EXPORT_SYMBOL(__phys_addr);
-
-unsigned long __phys_addr_symbol(unsigned long x)
-{
-	unsigned long y =3D x - __START_KERNEL_map;
-
-	/* only check upper bounds since lower bounds will trigger carry */
-	VIRTUAL_BUG_ON(y >=3D KERNEL_IMAGE_SIZE);
-
-	return y + phys_base;
-}
-EXPORT_SYMBOL(__phys_addr_symbol);
 #endif
=20
 bool __virt_addr_valid(unsigned long x)

