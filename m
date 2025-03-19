Return-Path: <linux-tip-commits+bounces-4344-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3AAA68AA8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0BDE8862D5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FD8257459;
	Wed, 19 Mar 2025 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XCrZC5K5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q1EqlF06"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB162561D1;
	Wed, 19 Mar 2025 11:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382223; cv=none; b=Klc05pro9mdt++NeRJo8SkVtliOBvYiCGiCvvt2GSqBTf4YUgiFQeCRe4y49NYusdjaCT8K6H9rdz9dwxMigUpuwjX9j0fvXCyzib71cS1u+VHY9Q1KXyr4VL2R7/z5WVvw3ODQH1jsZo+NOMxQngfVronHs2EJKTkXmqm8vtW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382223; c=relaxed/simple;
	bh=tZ6OeAiXOLDhTWbMFgdhj9yOjN9IrbdWrUAzZe/EvEM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JMljlUPPz+OqdaflfCpAOvjmhAcVZfat0EGswfg6Iw1XXNgxosBoYpoMP6vZa+m9tCL2M3XtAp9loIfC8gmjXMNoNKSTeu6E4yTX+WEvlrvVWtPESOWHj0WEUk1WuhNm62kNP36m8J1oe/tykgKUs4dMrLyMeS4L5XI0iqac4pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XCrZC5K5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q1EqlF06; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382218;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJafSyDzxv5mKvL5sU6LXtdpMsGN6JKbSsbPyNtYhYk=;
	b=XCrZC5K5c0EAaMtr3h762x6a0E63RHAJFi0Ht0iFCVWLci3NCosc8t1BNJ7s3Jx9xrR90Y
	RJ2MtbOUd8TM4C34kohcioai1vrbauUVATvnXTr1oAtN6GLDi2bugL41jQtPIOKYDayTWP
	rceA6hPwQCJJI39btlYnLs4w3EfJ08z4aC1XVzxVNw3ZkRfcoj2a1yXxPCA+OXsGzkBdcW
	rzO/S6JRPSkt259GPsgvZSmWsBpkKC3ICuyoMvxLbcP3h4bDnXV7c73r6FL+wLjYGF1qiq
	cFrvV0YCuX4hjqKEE+wzqcODNwjcWHJ9VpHjOmCBWBVbo/6Fxa08hz92j6bBOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382218;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJafSyDzxv5mKvL5sU6LXtdpMsGN6JKbSsbPyNtYhYk=;
	b=Q1EqlF06nTnNuib2qv6ajeWdwR1buxW7yzgIv9DhEP2hZzLVcfnks+I1Df8PRnzhQh0UXq
	izziJpUgRwWthTCg==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] x86/mm/pat: Replace Intel x86_model checks with VFM ones
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Rik van Riel <riel@surriel.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250219184133.816753-13-sohil.mehta@intel.com>
References: <20250219184133.816753-13-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238221777.14745.12144164016776827924.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     05d234d3c79e16ee5329dbbc611d1dde6c8c5ab3
Gitweb:        https://git.kernel.org/tip/05d234d3c79e16ee5329dbbc611d1dde6c8c5ab3
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Wed, 19 Feb 2025 18:41:30 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:19:53 +01:00

x86/mm/pat: Replace Intel x86_model checks with VFM ones

Introduce markers and names for some Family 6 and Family 15 models and
replace x86_model checks with VFM ones.

Since the VFM checks are closed ended and only applicable to Intel, get
rid of the explicit Intel vendor check as well.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20250219184133.816753-13-sohil.mehta@intel.com
---
 arch/x86/include/asm/intel-family.h | 1 +
 arch/x86/mm/pat/memtype.c           | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 51ea366..6cd08da 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -193,6 +193,7 @@
 /* Family 15 - NetBurst */
 #define INTEL_P4_WILLAMETTE		IFM(15, 0x01) /* Also Xeon Foster */
 #define INTEL_P4_PRESCOTT		IFM(15, 0x03)
+#define INTEL_P4_CEDARMILL		IFM(15, 0x06) /* Also Xeon Dempsey */
 
 /* Family 19 */
 #define INTEL_PANTHERCOVE_X		IFM(19, 0x01) /* Diamond Rapids */
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index feb8cc6..e40861c 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -43,6 +43,7 @@
 #include <linux/fs.h>
 #include <linux/rbtree.h>
 
+#include <asm/cpu_device_id.h>
 #include <asm/cacheflush.h>
 #include <asm/cacheinfo.h>
 #include <asm/processor.h>
@@ -290,9 +291,8 @@ void __init pat_bp_init(void)
 		return;
 	}
 
-	if ((c->x86_vendor == X86_VENDOR_INTEL) &&
-	    (((c->x86 == 0x6) && (c->x86_model <= 0xd)) ||
-	     ((c->x86 == 0xf) && (c->x86_model <= 0x6)))) {
+	if ((c->x86_vfm >= INTEL_PENTIUM_PRO   && c->x86_vfm <= INTEL_PENTIUM_M_DOTHAN) ||
+	    (c->x86_vfm >= INTEL_P4_WILLAMETTE && c->x86_vfm <= INTEL_P4_CEDARMILL)) {
 		/*
 		 * PAT support with the lower four entries. Intel Pentium 2,
 		 * 3, M, and 4 are affected by PAT errata, which makes the

