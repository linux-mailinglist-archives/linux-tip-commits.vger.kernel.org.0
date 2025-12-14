Return-Path: <linux-tip-commits+bounces-7686-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 694D9CBB874
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 09:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A04B6305EC1B
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0832C2D7394;
	Sun, 14 Dec 2025 08:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IytIwmJx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qf3MBGul"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BF22E03E3;
	Sun, 14 Dec 2025 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765701466; cv=none; b=COP/mZAIKNnaFyN4CVkHSKMuAHMqiEDMZ0yt/hCoXRVVrvjcstUZi5e0tmo3XNn8kscAhLru9hr1ZFgF9AM6mNSrg08sklnSxAWLi4z+vD1/2wblwdMx2ZiD9KrCPpxxO05Xsv79RkmT82hubZ6o6k12NuXn30gO1mlc3JCtBqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765701466; c=relaxed/simple;
	bh=NmZWkX0TBXAN7IFdDSO2YKGaejCQophC20763+VI1iQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OJDmXuLauFe87zLKPWbDWlugcndq38YoEoxEiM7qXr8erwwKKk9YGQHRHnoW2GpWqYESOSBjQvyAja6X7S364ZYdugJ17JQRdH+fag860/VaqohIGAkZNZQxaQiuoYXKAFUU077IbfVmCNkWHDnNRR+65rUA1F9ibrecvXhUH78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IytIwmJx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qf3MBGul; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 08:37:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765701463;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ejfOUPwHREUQ01TIFvBNGYU2sENeqfoaIhcnvQYdi5c=;
	b=IytIwmJxLklcuxvK/Tz2X5A2c+ekbrqQC9i99gsPvepgpJNvilOr8wl+cvi5A9GxXlquwR
	kMmWnsJ4FFLyCvY2ZchAEJZySpLClvN569EGOKiAWge71qE2aOrmDM0MnWgN0+cDkueYsm
	7mxWz0DS2EnEnkqpQ+mf/q/wDru+a7vExbHnXbbMPYuxDIzqWYPxbg/Og6cyLL4Sj2Q2xD
	lJl6CEG1m7wr7GvgS9SoIRI71NiXIl25ZRwYwo+FEzEXj0R6aacFTBgk3XT+n+mGVEL1QA
	LUhJZ3m/rOnEhkeJdRPDz9J0ppIrM3tLYvy1ambPi9AZh/OIEb6WcCFwlx4Htw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765701463;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ejfOUPwHREUQ01TIFvBNGYU2sENeqfoaIhcnvQYdi5c=;
	b=qf3MBGul6E38VMtbmVMxE6dXCZ8v/ZIWUS5jcOMViVWU9IvV5p3YoPiEJujY5bseXeoFIW
	iGBJUqJL8UOwGXAw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/boot/e820: Print E820_TYPE_RAM entries as ... RAM entries
Cc: Ingo Molnar <mingo@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Juergen Gross <jgross@suse.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 David Woodhouse <dwmw@amazon.co.uk>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515120549.2820541-9-mingo@kernel.org>
References: <20250515120549.2820541-9-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176570146193.498.5586028711805916840.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     fa06d58805c88f76f4454284c1e9e8334b559e30
Gitweb:        https://git.kernel.org/tip/fa06d58805c88f76f4454284c1e9e8334b5=
59e30
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 14:05:24 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:19:38 +01:00

x86/boot/e820: Print E820_TYPE_RAM entries as ... RAM entries

So it is a bit weird that the actual RAM entries of the E820 table
are not actually called RAM, but 'usable':

	BIOS-e820: [mem 0x0000000000100000-0x000000007ffdbfff]    1.9 GB usable

'usable' is pretty passive-aggressive in that context and ambiguous,
most E820 entries denote 'usable' address ranges - reserved ranges
may be used by devices, or the platform.

Clarify and disambiguate this by making the boot log entry
explicitly say 'System RAM', like in /proc/iomem:

	BIOS-e820: [mem 0x0000000000100000-0x000000007ffdbfff]    1.9 GB System RAM

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
Link: https://patch.msgid.link/20250515120549.2820541-9-mingo@kernel.org
---
 arch/x86/kernel/e820.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 5800153..b0efa4b 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -188,7 +188,7 @@ void __init e820__range_add(u64 start, u64 size, enum e82=
0_type type)
 static void __init e820_print_type(enum e820_type type)
 {
 	switch (type) {
-	case E820_TYPE_RAM:		pr_cont(" usable");			break;
+	case E820_TYPE_RAM:		pr_cont(" System RAM");			break;
 	case E820_TYPE_RESERVED:	pr_cont(" reserved");			break;
 	case E820_TYPE_SOFT_RESERVED:	pr_cont(" soft reserved");		break;
 	case E820_TYPE_ACPI:		pr_cont(" ACPI data");			break;

