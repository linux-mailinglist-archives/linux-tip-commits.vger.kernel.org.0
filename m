Return-Path: <linux-tip-commits+bounces-6386-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8438EB37AB8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Aug 2025 08:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99930171C47
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Aug 2025 06:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4399B3176FA;
	Wed, 27 Aug 2025 06:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fvw3vL1s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mtlKV4bc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDEB3128C6;
	Wed, 27 Aug 2025 06:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277150; cv=none; b=ir6Puw6QR7ulJgxBFzix60wYXPICd5Ak+x+9UUF3vk6q91ZWOjXcdjDscJIuOvKZy99eesj7fYUW1UVfcmGuf7tQsLYeKzxXOh2D3M71GBEZhqqWVNe9W+PINufshgTAQZNlMHgm12yOBRCYAmMh2/7tqXXBCF/3wNZ6cNAKJyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277150; c=relaxed/simple;
	bh=6BQaJnfc+VeXx9pqUKikP9gRxfnxmQcrCE1IqHuNQI8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HVrd6E0rAuoMg2Tdn8hsuVCgYORVPzD28R8Xkcp9kggB3Fvcgxua1FvYnAp6O6uAo1pqqOgWXS3Uj4+q5cCQaX2pn4Xwg4zDlraPwSMaIcKOVrVLLSRme8xjekl6+PlR+aXbIefxp1X3q1AWt++zIen0ubEJYmkp+80dhx2/T1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fvw3vL1s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mtlKV4bc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 27 Aug 2025 06:45:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756277147;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xumVyvfDkUqJmbn6mIXLh63w5l6Dse9Gox7N3tdT+ew=;
	b=fvw3vL1spLXuT8yPsAJLb2V8Hv+srIeiYNXmjERtu34cB2lVmnGbMIisxxNEigggByaIlG
	bHe70OhmqHbwzZO543+GAgT5PidNRLJTtirmyD2B6D4wZJ5urAL1oc9nEro3vUHxWbbg1r
	gk38FC26Of7yMgacxaNngQM7upXhiR9nru1hqe5xFRTAPu5Z9u5OnD5oj0eIPXM8ahIMft
	IZu0ReB5C7POS9FqLJ2njmESycJd5TZe+qYbGFXZWiiTtv/Tk0RD6qdL/BJUIi96Y1Dr+9
	AaTHaUJv2/eFR6q/WWvVsQGrUXjHoRJH+H7HoqSOGM2htXsBJiNGY7EMJz0l+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756277147;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xumVyvfDkUqJmbn6mIXLh63w5l6Dse9Gox7N3tdT+ew=;
	b=mtlKV4bcMbYNibcFBHVr2jWS0OzkYZx1j2fTRkg7//xzv0v8aFttUQv3c5I1JhHUbfPdPz
	OD/GYeJE8sLu5NBw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cleanups] x86/sgx: Use ENCLS mnemonic in <kernel/cpu/sgx/encls.h>
Cc: Uros Bizjak <ubizjak@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250616085716.158942-1-ubizjak@gmail.com>
References: <20250616085716.158942-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175627714549.1920.13829887049245292535.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     13bdfb53aa04eeb8022af87288c5bc0a5d13a834
Gitweb:        https://git.kernel.org/tip/13bdfb53aa04eeb8022af87288c5bc0a5d1=
3a834
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 16 Jun 2025 10:56:30 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 25 Aug 2025 17:28:43 +02:00

x86/sgx: Use ENCLS mnemonic in <kernel/cpu/sgx/encls.h>

Current minimum required version of binutils is 2.30, which supports ENCLS
instruction mnemonic.

Replace the byte-wise specification of ENCLS with this proper mnemonic.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/20250616085716.158942-1-ubizjak@gmail.com
---
 arch/x86/kernel/cpu/sgx/encls.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encls.h b/arch/x86/kernel/cpu/sgx/encls.h
index 99004b0..42a088a 100644
--- a/arch/x86/kernel/cpu/sgx/encls.h
+++ b/arch/x86/kernel/cpu/sgx/encls.h
@@ -68,7 +68,7 @@ static inline bool encls_failed(int ret)
 	({							\
 	int ret;						\
 	asm volatile(						\
-	"1: .byte 0x0f, 0x01, 0xcf;\n\t"			\
+	"1: encls\n"						\
 	"2:\n"							\
 	_ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FAULT_SGX)		\
 	: "=3Da"(ret)						\
@@ -111,8 +111,8 @@ static inline bool encls_failed(int ret)
 	({							\
 	int ret;						\
 	asm volatile(						\
-	"1: .byte 0x0f, 0x01, 0xcf;\n\t"			\
-	"   xor %%eax,%%eax;\n"					\
+	"1: encls\n\t"						\
+	"xor %%eax,%%eax\n"					\
 	"2:\n"							\
 	_ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FAULT_SGX)		\
 	: "=3Da"(ret), "=3Db"(rbx_out)				\

