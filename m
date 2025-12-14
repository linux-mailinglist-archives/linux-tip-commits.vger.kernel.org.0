Return-Path: <linux-tip-commits+bounces-7675-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C5553CBB7FF
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 09:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C414530057B5
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176652C11C2;
	Sun, 14 Dec 2025 08:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R8oSr+ZO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KU224Lcy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4491B2D0C97;
	Sun, 14 Dec 2025 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765701454; cv=none; b=POzpx+6eTWxa+c1mNEQvMayEdR4rmy/VWh/rCZntscrXoaE3vATwMtM9sfJ4ATnJEAmztNJvnTeHNydxnkkaCzT3577KklBFccaPLNBCn6qzdT+CyyF6e8SlTAM51nxexMgFct8yHnwAObouF2RS8xVHi7rJKvyOjHQlm3ezoDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765701454; c=relaxed/simple;
	bh=WRzT0GeDJBdPJPfWRaS9ETzzAb7xWr5CcigkH1TTCec=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=K8nULyzqPCvQcUwpp4/L6ZdoqVmKHt5G1uKKjo5yQ1n5zTdnXh4nMwmF4fAJmoPamNndpLByLMPRzECbe2pP6Xha8mX+wHNfeOnboyeJQSKPfxWj0nAWzafNDCxY6kG9wpOYLz0svu3f6L1YB9lWbp1tMiH7Hn0HfHW2goRAVPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R8oSr+ZO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KU224Lcy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 08:37:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765701450;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yKI8CDpuUppOZla+QqERF1OaZvN7AlnBIGAW1NVQZTA=;
	b=R8oSr+ZObVctOAzaOlZ9W5G7k4/m+aRieXUglh+DBraSVyFe1AxuenrjM1bb0r5dGovDAb
	BFZ4GbBH3RxL0NCEOs5O20Pfx6KBsZCQji2S7ipcnBkc3FqRQ30FuHgJF1hhoLvnWWwlO1
	OyzzjhTjzkjMU5ljxCNpfJeuF5kGhJtessueZGHkLNMD0HDz0eAwUlPr8PmxDRM/Q0CFxW
	5tirJXsjAjENbDHbXQ5UKejN6kLELlnXFJENEDFKr26w4eiWbJRilFKMHDm+MQAN+XNrf2
	lptUljJwujmhznwIyrx8mIvpA8FVJLiZNcFaMyXmoVYXDWQYH5gTOP1zF6KRsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765701450;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yKI8CDpuUppOZla+QqERF1OaZvN7AlnBIGAW1NVQZTA=;
	b=KU224LcyHGnde0NzYF5bWh3F0N/qGUrsGyazgLOse0dGP5oYPdjy/uBHrgCqEVqoE6BTkP
	WQKWYVbUNw6oEtDQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/e820: Change struct e820_table::nr_entries
 type from __u32 to u32
Cc: Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Shevchenko <andy@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Juergen Gross <jgross@suse.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515120549.2820541-20-mingo@kernel.org>
References: <20250515120549.2820541-20-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176570144944.498.14747472293036505303.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     46f3e7d394b23e93d274590d7bede5d62d80440b
Gitweb:        https://git.kernel.org/tip/46f3e7d394b23e93d274590d7bede5d62d8=
0440b
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 14:05:35 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:19:40 +01:00

x86/boot/e820: Change struct e820_table::nr_entries type from __u32 to u32

__u32 is for UAPI headers, and this definition is the only place
in the kernel-internal E820 code that uses __u32. Change it to u32.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H . Peter Anvin <hpa@zytor.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://patch.msgid.link/20250515120549.2820541-20-mingo@kernel.org
---
 arch/x86/include/asm/e820/types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/e820/types.h b/arch/x86/include/asm/e820/ty=
pes.h
index 80c4a72..df12f7e 100644
--- a/arch/x86/include/asm/e820/types.h
+++ b/arch/x86/include/asm/e820/types.h
@@ -83,7 +83,7 @@ struct e820_entry {
  * The whole array of E820 entries:
  */
 struct e820_table {
-	__u32 nr_entries;
+	u32 nr_entries;
 	struct e820_entry entries[E820_MAX_ENTRIES];
 };
=20

