Return-Path: <linux-tip-commits+bounces-7260-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB95C3332C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 04 Nov 2025 23:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014B0464C72
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Nov 2025 22:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBDE346E66;
	Tue,  4 Nov 2025 22:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y8eZ8ANM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wiVmVgw3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF4D346E56;
	Tue,  4 Nov 2025 22:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762294735; cv=none; b=XqeoeG3dU+Fh9XelcXZ5rHvWx10Oku+o81Jn9FAJjCrPN8KOS6Z5i+vVrK6tPj7fIykGrob5UuPupWnquzfHEdmNi7NTFmoIBO0h3ewpyZByYq0MUepgORW1Ix4JaUUvJ6XEsYIDOYIZXLWjsi/B8SeQrJXQMzXOHkm+Xac6Xf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762294735; c=relaxed/simple;
	bh=6CwreT1eSkBW+I3M0vTY0Wb41BgXFFEQVGG7F3WYSXM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=m7ETqiOjFTa3Csc8Mx1dEtQj0JA2qLzakMk5SeSfx6yTrX7HGGXVJF6QdASEuREDJsVTyoRhEkSJy9HzXL+Vd2wUpErKP9jVXNVAYJpzqs3CjQHyab8vMHpyNO8/BC813q3eziQCwEVij5XOd59fqVkGD8DnHWtyQSjpv+lC9sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y8eZ8ANM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wiVmVgw3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Nov 2025 22:18:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762294731;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vaqxls2bXBrYwIpBpaR0v7OqmPIsH6Zf0Y5dBprU2UI=;
	b=Y8eZ8ANMho0QLoDpb0+YU4rR8EdTRxHsSVh7nG/rQxY0WdLbRqM3tXaMcCUcLrJ1v1HMn4
	TGtFm/YO/fIE9hKrUSOBwZhcapDQW9l7za3KffFnRa/bTUpdAhMmd/nF/UlJmqvoRNhM8N
	QuMkHobz1CWkho5VqjgzrwTDatHTxGsdIpAyLX8Gn67JBr0HRUxBN75SelQrM1n1Z8tAV5
	4HqTHwZH+kIS5y1S+5gLTHEnG1xwABWkM5BMJM1e3VQo/pTtQFbKnFPW55loLkRQ9ouxGi
	q4qerBT8Ze443Hx78aGmv29xgn6zT3NvL4cs79JuMw4/f3ltsuH3XIlsM/PSIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762294731;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vaqxls2bXBrYwIpBpaR0v7OqmPIsH6Zf0Y5dBprU2UI=;
	b=wiVmVgw3KIMZ0pFn0xxJDNwd8y2VXIngr8sIFgpncSpU/XPKnQFaqMY+uVUqM23nT2XB81
	naVL4Ew7JMphETCw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cleanups] x86/cpufeatures: Correct LKGS feature flag description
Cc: "Xin Li (Intel)" <xin@zytor.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176229472775.2601451.15031143628480729557.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     47955b58cf9b97fe4dc2b0d622b8ea3a2656bbf9
Gitweb:        https://git.kernel.org/tip/47955b58cf9b97fe4dc2b0d622b8ea3a265=
6bbf9
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 15 Oct 2025 12:35:48 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 04 Nov 2025 23:09:34 +01:00

x86/cpufeatures: Correct LKGS feature flag description

Quotation marks in cpufeatures.h comments are special and when the
comment begins with a quoted string, that string lands in /proc/cpuinfo,
turning it into a user-visible one.

The LKGS comment doesn't begin with a quoted string but just in case
drop the quoted "kernel" in there to avoid confusion. And while at it,
simply change the description into what the LKGS instruction does for
more clarity.

No functional changes.

Reviewed-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20251015103548.10194-1-bp@kernel.org
---
 arch/x86/include/asm/cpufeatures.h       | 2 +-
 tools/arch/x86/include/asm/cpufeatures.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufea=
tures.h
index 4091a77..245cf6b 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -320,7 +320,7 @@
 #define X86_FEATURE_FSRS		(12*32+11) /* Fast short REP STOSB */
 #define X86_FEATURE_FSRC		(12*32+12) /* Fast short REP {CMPSB,SCASB} */
 #define X86_FEATURE_FRED		(12*32+17) /* "fred" Flexible Return and Event Del=
ivery */
-#define X86_FEATURE_LKGS		(12*32+18) /* Load "kernel" (userspace) GS */
+#define X86_FEATURE_LKGS		(12*32+18) /* Like MOV_GS except MSR_KERNEL_GS_BAS=
E =3D GS.base */
 #define X86_FEATURE_WRMSRNS		(12*32+19) /* Non-serializing WRMSR */
 #define X86_FEATURE_AMX_FP16		(12*32+21) /* AMX fp16 Support */
 #define X86_FEATURE_AVX_IFMA            (12*32+23) /* Support for VPMADD52[H=
,L]UQ */
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/includ=
e/asm/cpufeatures.h
index 06fc047..f61802f 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -320,7 +320,7 @@
 #define X86_FEATURE_FSRS		(12*32+11) /* Fast short REP STOSB */
 #define X86_FEATURE_FSRC		(12*32+12) /* Fast short REP {CMPSB,SCASB} */
 #define X86_FEATURE_FRED		(12*32+17) /* "fred" Flexible Return and Event Del=
ivery */
-#define X86_FEATURE_LKGS		(12*32+18) /* Load "kernel" (userspace) GS */
+#define X86_FEATURE_LKGS		(12*32+18) /* Like MOV_GS except MSR_KERNEL_GS_BAS=
E =3D GS.base */
 #define X86_FEATURE_WRMSRNS		(12*32+19) /* Non-serializing WRMSR */
 #define X86_FEATURE_AMX_FP16		(12*32+21) /* AMX fp16 Support */
 #define X86_FEATURE_AVX_IFMA            (12*32+23) /* Support for VPMADD52[H=
,L]UQ */

