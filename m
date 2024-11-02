Return-Path: <linux-tip-commits+bounces-2718-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7219B9B9EBB
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 446BAB2271B
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 10:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97D01AB6DA;
	Sat,  2 Nov 2024 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FJQfAoh5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9Zaky7wZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF5119885B;
	Sat,  2 Nov 2024 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542223; cv=none; b=ZrRbqpJIeJCw5Fl5hibdV1qim2I62K6TTSB4iapyqezrXOse8AI2paDZsglyCnJC/G3zL5hE7xFVqnQhGi1n4trWRW+xiAoLSVIIpH++zoTFhgHpm3c66CRWSMwtoLGP3Oh1qax32r5ESSWCVQ+y488uCX0ZUv0SWtRhCa9F3Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542223; c=relaxed/simple;
	bh=twAUd4w1I+uAvt+U7K/hsEf2sQg+ditshOoAiHraOc0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IOM9l550K8p6SA1arj5uRNh32uIKvJ6a/QRLSEjIf8HYiiSfEouXV94F2alc9HoAvS0XtidlhofJ5i0KVaIBTi0f5aHuDUVaZqsg8uwT1Cz12cpfh681AeUEEqXhe/0QIWJP8PbX/btib3bHtHaBXvo1Tk7lmlEG8qbZZAZ+fQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FJQfAoh5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9Zaky7wZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 10:10:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730542219;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W78VuEYfqiyM7aTmeHKinvtcBOmDgUlI3ToWJl1SF8g=;
	b=FJQfAoh5RdeakuoPWYxH7EiedEnl4ZikqxdAPPXD/eOaDdaOrbyOhONOkOYWywl34Co0v4
	FYhDDCj6IVsbitGbPWUkBAzEVWb7oob1IqyXoC3Vq0zrhh9/BDGBf/J/QkQuiIZeCQOypB
	jxht/9shxBxd+4w6bqBCfgVJ4r+pVFKzIJ2d2MUMjWJ2v1W3kJieOby/W7QrxbQL4kqlEZ
	/KRFRtb/gt2nZnz2EaLA8YtZd0jBSLl+12bi26c/jvVAU2WWDeiZGP+05Rt/tG8ADLN9Lg
	XUNCWLTKT7VaOM8r1MhzeTGtDDd6hjeTgfGH7AEkdvq4wfz0SIeWFdCaWk3KIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730542219;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W78VuEYfqiyM7aTmeHKinvtcBOmDgUlI3ToWJl1SF8g=;
	b=9Zaky7wZVSUco7/8ttflawH0piJ5vMeW7IyZqI29TWqGJMZFvBdF7HzfbySmJlAgtLd9XY
	Yh4xRN8FL8YPxkBw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] arm64: vdso: Drop LBASE_VDSO
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-4-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-4-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054221859.3137.16196724407535675632.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     7f98f677f54cd0578da4a5dd2b7dc268c7b5f423
Gitweb:        https://git.kernel.org/tip/7f98f677f54cd0578da4a5dd2b7dc268c7b=
5f423
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 11:05:13 +01:00

arm64: vdso: Drop LBASE_VDSO

This constant is always "0", providing no value and making the logic
harder to understand.
Also prepare for a consolidation of the vdso linkerscript logic by
aligning it with other architectures.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-4-b64f0842d51=
2@linutronix.de

---
 arch/arm64/include/asm/vdso.h       |  9 +--------
 arch/arm64/kernel/vdso/vdso.lds.S   |  2 +-
 arch/arm64/kernel/vdso32/vdso.lds.S |  2 +-
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
index 4305995..3e3c3fd 100644
--- a/arch/arm64/include/asm/vdso.h
+++ b/arch/arm64/include/asm/vdso.h
@@ -5,13 +5,6 @@
 #ifndef __ASM_VDSO_H
 #define __ASM_VDSO_H
=20
-/*
- * Default link address for the vDSO.
- * Since we randomise the VDSO mapping, there's little point in trying
- * to prelink this.
- */
-#define VDSO_LBASE	0x0
-
 #define __VVAR_PAGES    2
=20
 #ifndef __ASSEMBLY__
@@ -20,7 +13,7 @@
=20
 #define VDSO_SYMBOL(base, name)						   \
 ({									   \
-	(void *)(vdso_offset_##name - VDSO_LBASE + (unsigned long)(base)); \
+	(void *)(vdso_offset_##name + (unsigned long)(base)); \
 })
=20
 extern char vdso_start[], vdso_end[];
diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.=
lds.S
index f204a9d..4ec32e8 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -25,7 +25,7 @@ SECTIONS
 #ifdef CONFIG_TIME_NS
 	PROVIDE(_timens_data =3D _vdso_data + PAGE_SIZE);
 #endif
-	. =3D VDSO_LBASE + SIZEOF_HEADERS;
+	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text
 	.gnu.hash	: { *(.gnu.hash) }
diff --git a/arch/arm64/kernel/vdso32/vdso.lds.S b/arch/arm64/kernel/vdso32/v=
dso.lds.S
index 8d95d7d..732702a 100644
--- a/arch/arm64/kernel/vdso32/vdso.lds.S
+++ b/arch/arm64/kernel/vdso32/vdso.lds.S
@@ -22,7 +22,7 @@ SECTIONS
 #ifdef CONFIG_TIME_NS
 	PROVIDE_HIDDEN(_timens_data =3D _vdso_data + PAGE_SIZE);
 #endif
-	. =3D VDSO_LBASE + SIZEOF_HEADERS;
+	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text
 	.gnu.hash	: { *(.gnu.hash) }

