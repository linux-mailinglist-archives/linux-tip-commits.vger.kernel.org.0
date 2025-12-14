Return-Path: <linux-tip-commits+bounces-7682-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC2DCBB85F
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 09:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 588893059694
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61412DAFA9;
	Sun, 14 Dec 2025 08:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XPz18DX2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ppw0+id5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB6D2D63E5;
	Sun, 14 Dec 2025 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765701463; cv=none; b=Kzb3wSQ3TUNHh+rDSz4hrklqOsbgCMFdQaGsf+7b3uzSaJVgUnZW/DpyYLj2tS2vImuMxIvFGqwFsVfuzE+JeUiPiQvf7QR70ZQIu8pJ3T9KbCNSDKbOW63uqIOGDPfmxKoDEwYZkS2FMv3Y8EiyPSGqEYHmvzUrvlbzb8X/1Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765701463; c=relaxed/simple;
	bh=V6rRVgmXtLggP9M0jbzuYAY3kOgcgrk2fu7Pa18pFog=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=n7omLMjszmWzpUmbNCh4fBgVe6XjwdjaCl6r/DOaxDjC8eHc5LMsdwdZJVTlwj/gV7+PHNGqcNb8NP2jTk0bqxDNfP4UwEij6D5jGv3tOBjQcqAS1FHSlasWUtnERGbkoaCvYTGIxQA631UpxKNxBZo6JdMkAb+lVNH10altgi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XPz18DX2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ppw0+id5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 08:37:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765701459;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3gbgLBJlgTZ6tWFGVmi+qMamWEwDobDNJzZP4eIiYM=;
	b=XPz18DX21151RXsajQ9wmrGMQzwTUjDy4zq5yclWRz+SUTdd7fR1uo20dHYAvQaKkY6Boe
	cN1Wet3Z6YQ6WnFphTlQGKZAOnscMeVUjDambzd76fRTysHiRuQ3D/9XzARBNbkVoAADeb
	n5jNodDPfFoxgxKd6HAmzV1TY6mAYT3XvDP/PLBTgTIbr2Ifn6qKO12gxnkxG4Lpv7eYlu
	uYdGrfmrflhRhpHki6Ma4JRmg45KW6tgB4sjwFaLeLAYZEO5tQreahl3E9hSw7EqnahPJe
	Rf6/0LgOV2yPQfmhkK1ldz7J6UVF2ZJ0kbxWlVsqZ53TCw7lDrIN3qJdoakPjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765701459;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3gbgLBJlgTZ6tWFGVmi+qMamWEwDobDNJzZP4eIiYM=;
	b=Ppw0+id5MlSW4VQyVsirmHoEyOijrDD+svlIfjyyZaL9vPnujZdCEj8Plfz/4XIoLK7qGv
	FuOvL6lDpc0I04DA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/boot/e820: Remove pointless early_panic() indirection
Cc: Ingo Molnar <mingo@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Juergen Gross <jgross@suse.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 David Woodhouse <dwmw@amazon.co.uk>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515120549.2820541-12-mingo@kernel.org>
References: <20250515120549.2820541-12-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176570145848.498.15705869721688207459.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     d214484f50f4c5dbab932b943b824a4c2920cb6e
Gitweb:        https://git.kernel.org/tip/d214484f50f4c5dbab932b943b824a4c292=
0cb6e
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 14:05:27 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:19:38 +01:00

x86/boot/e820: Remove pointless early_panic() indirection

early_panic() is a pointless wrapper around panic():

	static void __init early_panic(char *msg)
	{
		early_printk(msg);
		panic(msg);
	}

panic() will already do a printk() of 'msg', and an early_printk() if
earlyprintk is enabled. There's no need to print it separately.

Remove the function.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Link: https://patch.msgid.link/20250515120549.2820541-12-mingo@kernel.org
---
 arch/x86/kernel/e820.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 0378648..6bc0686 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -893,12 +893,6 @@ unsigned long __init e820__end_of_low_ram_pfn(void)
 	return e820__end_ram_pfn(1UL << (32 - PAGE_SHIFT));
 }
=20
-static void __init early_panic(char *msg)
-{
-	early_printk(msg);
-	panic(msg);
-}
-
 static int userdef __initdata;
=20
 /* The "mem=3Dnopentium" boot option disables 4MB page tables on 32-bit kern=
els: */
@@ -1018,7 +1012,7 @@ void __init e820__finish_early_params(void)
 {
 	if (userdef) {
 		if (e820__update_table(e820_table) < 0)
-			early_panic("Invalid user supplied memory map");
+			panic("Invalid user supplied memory map");
=20
 		pr_info("user-defined physical RAM map:\n");
 		e820__print_table("user");

