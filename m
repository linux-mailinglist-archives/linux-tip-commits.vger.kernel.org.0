Return-Path: <linux-tip-commits+bounces-3619-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E88A44D5D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 21:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 720D5189EC89
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 20:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D946520FA9A;
	Tue, 25 Feb 2025 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LwJFf5X+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IqMdak5T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208D220E32B;
	Tue, 25 Feb 2025 20:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514779; cv=none; b=Ggw8rjR08RocTpMHKZCPNTvmvEhqRxCOVRJEVTIEBVu1TxCvCTfQQAwQUHc1irGeE7y02DGOCV0YavdWFD8F62yeqCFpfYoZe9d8DZm1xqrnGFodUCvzwhmb/+RS4aSXTgIuQJmebrEbHWz1+ZocwBfwet/H9dxv+5vaIlGtJcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514779; c=relaxed/simple;
	bh=pus0lWIgX9cf9W4hd3DtllbECUcdSaZd86mSGNH8MUI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZxwK5K8HmYhrPU0/8ad9Hv0eMCc/LOVOGQDK2YX5a6xoRRYYwJQdNPU7V1Y6Yq8s+NJPDHoXw6A2tTHl1YPexZSiREaz8fU80OIFt5p1KjzceUMboqUcodUoOcYCh21ituZXkUiYWfHoEXStceg4rnc2w9bOWGwTN8ABBaVlFqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LwJFf5X+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IqMdak5T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Feb 2025 20:19:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740514776;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qaKQRJvikQBLvdHwTac/iJwfeVJRDKdWu0sw1lzKP3Y=;
	b=LwJFf5X+VIC1YrAu3q1o4D9ngcER44+0G86XKr5bYkhSPhgMH9hbRFt2U5MYgCH/+b7R20
	9h6drXmvUSkpA5QPL2jvxB5mr1ucacf+ou5O+n98F8ov02IrnMBshnPubkBvKKa+Jfxr7J
	MYPNK36SOoo9CanMavzHiHjsOcCYipTROG4FIZA/G6vxNdOw5g00VnsvyC9Owo+b/6RhLq
	Vz4cpu3C6vRH8R+Y0gghYKZsq6RYFUFQc7rpnTrn9uiexc3CtZTgLkCqnNyFFfbL3SYMaf
	Oa9RrYsXPLTfYODjK1xK2BA1JJsviesnARrogdtGW/VPwsxPDs7LDJpIe5hzlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740514776;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qaKQRJvikQBLvdHwTac/iJwfeVJRDKdWu0sw1lzKP3Y=;
	b=IqMdak5TKZt3RpvcSovAHSwjAVwJ0GjoOpSuTpPlYECKgRuSx2tUUYGb/eQ3rsNz4aEbWe
	3TXS0Dcol09PujCg==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/asm] x86/percpu: Construct __percpu_seg_override from __percpu_seg
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250225200235.48007-1-ubizjak@gmail.com>
References: <20250225200235.48007-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174051477559.10177.12930277278126137493.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     79165720f31868d9a9f7e5a50a09d5fe510d1822
Gitweb:        https://git.kernel.org/tip/79165720f31868d9a9f7e5a50a09d5fe510d1822
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Tue, 25 Feb 2025 21:02:20 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Feb 2025 21:07:24 +01:00

x86/percpu: Construct __percpu_seg_override from __percpu_seg

Construct __percpu_seg_override macro from __percpu_seg by
concatenating the later with __seg_ prefix to reduce ifdeffery.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250225200235.48007-1-ubizjak@gmail.com
---
 arch/x86/include/asm/percpu.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index c2a9dfc..7cb4f64 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -22,6 +22,7 @@
 
 #else /* !__ASSEMBLY__: */
 
+#include <linux/args.h>
 #include <linux/build_bug.h>
 #include <linux/stringify.h>
 #include <asm/asm.h>
@@ -35,12 +36,7 @@
 # define __seg_fs		__attribute__((address_space(__seg_fs)))
 #endif
 
-#ifdef CONFIG_X86_64
-# define __percpu_seg_override	__seg_gs
-#else
-# define __percpu_seg_override	__seg_fs
-#endif
-
+#define __percpu_seg_override	CONCATENATE(__seg_, __percpu_seg)
 #define __percpu_prefix		""
 
 #else /* !CONFIG_CC_HAS_NAMED_AS: */

