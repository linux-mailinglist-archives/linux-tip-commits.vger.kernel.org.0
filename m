Return-Path: <linux-tip-commits+bounces-4818-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC1CA8336B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 23:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C1B3B1B2B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 21:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411D21DF25A;
	Wed,  9 Apr 2025 21:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MMND7Xei";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="buf/ekgu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FF71B0F19;
	Wed,  9 Apr 2025 21:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744234380; cv=none; b=dToF49eOSVf9ZkbBB5C1Alu3Ig00F+KDz3nBiFaxy9/qjk2k/uMRGvjU+PFdwRWvVVJXjwrz//u/ac5gAUuCE5GY0j20LIn0tfZZYBXrD2k2A9OVmXxAahxgIpSSggubW46+U+vQycZ8Tp2sAt2pzpRgrRTXkZmVWJGo1FS0Vdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744234380; c=relaxed/simple;
	bh=2QUQgELCxvFLDB9jcjQGNk2a3i8O9fr1VGG8RHkIPpA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ERDTCEsJLpMPnl1c00dxhIlL/fns9O4F2+QSGmYsYYfesTY0BNFG1a+OyEnoPbKgLr571q9vhL8dQH35jafmBcSAhcQaI2/ICKxRmYYoaaJfLkkbeMD4DChSLp7kBa6b3JpFssnQRoUec12CHHoiCVjS0ew7vsh8CGHE4cwxx+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MMND7Xei; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=buf/ekgu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 21:32:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744234375;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aVVmA8Jt40b7DNs/HNOqjtq68IFfAdGn3ROBAvyYHZI=;
	b=MMND7Xeit+cPXit/SNDoPaPWQl9BeMAW54HH9UIe5mPBZYrxN4+nn4hmejJT9IDX0YI4h2
	E1LOHp57O/i1y3cP0cwl+N6qcQkzkHo27iCRopnbVPsM57jcQUO/N1Ov9gDfv9qkeNoVZj
	ucwQIO3dOwYfBYixIdITttJtbDKz1YH4QWpd/EMOvFB2AddzMctJ0BRr1pshae1yQTsmio
	sIWRzo/HkRB8HUsYtemgX3CEc5eCuPfR6Y4bv5c5WlQh8NvOEHo3S2vn0YBCP+t7g/BTgX
	kmbakGrveoQApvb13ftR0CECBUFEPhtTZ1kYz5UJbLkrkGVKJDXXVoyQWz3NiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744234375;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aVVmA8Jt40b7DNs/HNOqjtq68IFfAdGn3ROBAvyYHZI=;
	b=buf/ekguZsbJ8z1aay64x4SaPN9tv4axJpMvA0mY6BkqBoMFrWIKCp72bavJ/ckCap4MLD
	wjrnAjXBO/NNpkDQ==
From: "tip-bot2 for Mateusz Guzik" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/asm] x86/uaccess: Predict valid_user_address() returning true
Cc: Mateusz Guzik <mjguzik@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250401203029.1132135-1-mjguzik@gmail.com>
References: <20250401203029.1132135-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174423437391.31282.15319381610413742292.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     6f9bd8ae0340326a7c711bc681321bf9a4e15fb2
Gitweb:        https://git.kernel.org/tip/6f9bd8ae0340326a7c711bc681321bf9a4e15fb2
Author:        Mateusz Guzik <mjguzik@gmail.com>
AuthorDate:    Tue, 01 Apr 2025 22:30:29 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Apr 2025 21:40:17 +02:00

x86/uaccess: Predict valid_user_address() returning true

This works around what seems to be an optimization bug in GCC (at least
13.3.0), where it predicts access_ok() to fail despite the hint to the
contrary.

_copy_to_user() contains:

	if (access_ok(to, n)) {
		instrument_copy_to_user(to, from, n);
		n = raw_copy_to_user(to, from, n);
	}

Where access_ok() is likely(__access_ok(addr, size)), yet the compiler
emits conditional jumps forward for the case where it succeeds:

<+0>:     endbr64
<+4>:     mov    %rdx,%rcx
<+7>:     mov    %rdx,%rax
<+10>:    xor    %edx,%edx
<+12>:    add    %rdi,%rcx
<+15>:    setb   %dl
<+18>:    movabs $0x123456789abcdef,%r8
<+28>:    test   %rdx,%rdx
<+31>:    jne    0xffffffff81b3b7c6 <_copy_to_user+38>
<+33>:    cmp    %rcx,%r8
<+36>:    jae    0xffffffff81b3b7cb <_copy_to_user+43>
<+38>:    jmp    0xffffffff822673e0 <__x86_return_thunk>
<+43>:    nop
<+44>:    nop
<+45>:    nop
<+46>:    mov    %rax,%rcx
<+49>:    rep movsb %ds:(%rsi),%es:(%rdi)
<+51>:    nop
<+52>:    nop
<+53>:    nop
<+54>:    mov    %rcx,%rax
<+57>:    nop
<+58>:    nop
<+59>:    nop
<+60>:    jmp    0xffffffff822673e0 <__x86_return_thunk>

Patching _copy_to_user() to likely() around the access_ok() use does
not change the asm.

However, spelling out the prediction *within* valid_user_address() does the
trick:

<+0>:     endbr64
<+4>:     xor    %eax,%eax
<+6>:     mov    %rdx,%rcx
<+9>:     add    %rdi,%rdx
<+12>:    setb   %al
<+15>:    movabs $0x123456789abcdef,%r8
<+25>:    test   %rax,%rax
<+28>:    jne    0xffffffff81b315e6 <_copy_to_user+54>
<+30>:    cmp    %rdx,%r8
<+33>:    jb     0xffffffff81b315e6 <_copy_to_user+54>
<+35>:    nop
<+36>:    nop
<+37>:    nop
<+38>:    rep movsb %ds:(%rsi),%es:(%rdi)
<+40>:    nop
<+41>:    nop
<+42>:    nop
<+43>:    nop
<+44>:    nop
<+45>:    nop
<+46>:    mov    %rcx,%rax
<+49>:    jmp    0xffffffff82255ba0 <__x86_return_thunk>
<+54>:    mov    %rcx,%rax
<+57>:    jmp    0xffffffff82255ba0 <__x86_return_thunk>

Since we kinda expect valid_user_address() to be likely anyway,
add the likely() annotation that also happens to work around
this compiler bug.

[ mingo: Moved the unlikely() branch into valid_user_address() & updated the changelog ]

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250401203029.1132135-1-mjguzik@gmail.com
---
 arch/x86/include/asm/uaccess_64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index c52f013..4c13883 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -54,7 +54,7 @@ static inline unsigned long __untagged_addr_remote(struct mm_struct *mm,
 #endif
 
 #define valid_user_address(x) \
-	((__force unsigned long)(x) <= runtime_const_ptr(USER_PTR_MAX))
+	likely((__force unsigned long)(x) <= runtime_const_ptr(USER_PTR_MAX))
 
 /*
  * Masking the user address is an alternative to a conditional

