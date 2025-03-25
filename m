Return-Path: <linux-tip-commits+bounces-4541-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BF9A70C5F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 22:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3A216BB8D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 21:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1189B266B55;
	Tue, 25 Mar 2025 21:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vNWKcaF9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w3n2/ARM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F1E1A8F60;
	Tue, 25 Mar 2025 21:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742939334; cv=none; b=HUeclsyFmKrHMZjOzuwN5SjINM8j86NclY0nYWQboMZ0jnOurfOn0w2xbGjtULWuem7WaCYRZp0DBTYsFNjA7nnq8+Rbfz7bg+BTtOlqm3XRDYjBhGibQ9V2YVOW0zOzTsEgfiJexcIDxHHkvrjpGriQ50ZcSKXgLaEq9GjPsBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742939334; c=relaxed/simple;
	bh=FAJPQswga/rCguHs40Ezy1lKZ2ggl4FcpKvteTPRhOU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CEa5iUnSEmCEsk4s/oWhpPqENI0ZAEQ6dhANpEhicbih2S0cfFRJ93vHPXFkw9ldnqtLheGjgbyCFSDk6GAMyt27oKcvO4XOyxqrcf78nlzjwwovCtHWw3/lxqahW3jbrPCtGDK81/7QZjvM8ph1fo6vGehwqS8rx6iZtZRQeCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vNWKcaF9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w3n2/ARM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 21:48:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742939329;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Trc3lr1MI/DR/dpo7OS/gpOP28oHutpl0Zr17wM3BH4=;
	b=vNWKcaF96ufQgPKL3cE6fH3fPNEYHT8WVutuUgvRn7X9s+FTnRUgKUJUCFzkbYkd9ILhTy
	SJCK+l2SD8/GoCqG8qmJeRPWMU6uvmjQK5DeMixL5qeX4SL3u25OhVIT4ivHwnIeGBbywt
	5MmL5wmPlV8+SLnxgrKUqE90zKq+97bZC5e8Bm0Q/Rc3P+BKiXjkbqls1V5IYt3f2LJQlc
	XiWDzBwLCz/mXB2cGcYQT7lIivcq6jUCfO1fUYaqh/9qx8y1erqFYjN6D6ykFXVD3FyHRt
	soLz/2ODZvgZ5H6IUdD4WaaAyRegR/C+I/IeBecx79s31B/ipk4dqBy+hy67sA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742939329;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Trc3lr1MI/DR/dpo7OS/gpOP28oHutpl0Zr17wM3BH4=;
	b=w3n2/ARMO87LeEC/Ipv4PrezalVmcarHk/a5qqj4cmEzJSn9W3SXofxpaDFO1xl67z8WTI
	YUfxGgY2ChTLN5AA==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/bitops: Use TZCNT mnemonic in <asm/bitops.h>
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Juergen Gross <jgross@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250325175215.330659-1-ubizjak@gmail.com>
References: <20250325175215.330659-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174293932910.14745.11013941982683227927.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     0717b1392dc7e3f350e5a5d25ea794aa92210684
Gitweb:        https://git.kernel.org/tip/0717b1392dc7e3f350e5a5d25ea794aa92210684
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Tue, 25 Mar 2025 18:52:01 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 22:38:29 +01:00

x86/bitops: Use TZCNT mnemonic in <asm/bitops.h>

Current minimum required version of binutils is 2.25,
which supports TZCNT instruction mnemonic.

Replace "REP; BSF" in variable__{ffs,ffz}() function
with this proper mnemonic.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250325175215.330659-1-ubizjak@gmail.com
---
 arch/x86/include/asm/bitops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 100413a..bbaf75e 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -248,7 +248,7 @@ arch_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
 
 static __always_inline unsigned long variable__ffs(unsigned long word)
 {
-	asm("rep; bsf %1,%0"
+	asm("tzcnt %1,%0"
 		: "=r" (word)
 		: ASM_INPUT_RM (word));
 	return word;
@@ -267,7 +267,7 @@ static __always_inline unsigned long variable__ffs(unsigned long word)
 
 static __always_inline unsigned long variable_ffz(unsigned long word)
 {
-	asm("rep; bsf %1,%0"
+	asm("tzcnt %1,%0"
 		: "=r" (word)
 		: "r" (~word));
 	return word;

