Return-Path: <linux-tip-commits+bounces-7677-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF04FCBB84D
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 09:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 399C1304D0FC
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F9C2D23A3;
	Sun, 14 Dec 2025 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kHEo/15G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VTQNUGyL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72D22C11DB;
	Sun, 14 Dec 2025 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765701458; cv=none; b=NFkfrEZdAFp51a5sMZGZ5k2PrCW/McoXRyVIZ+qapZX7F27Mu97Y0dWVyM3h8z/QvENKQF0UBE2hKiTKe/7m4eta2lyIeBAKEetleNKeW2wJ60/y/VffYOaKSwr127F+ZG+5HD1+KMbtMUK7E8t9eDAWPds6mgu6SgQaK3ZOTWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765701458; c=relaxed/simple;
	bh=Rfwc/ayn4UjJRNTbUqre5hT4IfJaTYKx5XBd215C4HA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=S6/+E1xW7566mz6ocyvlPJHOxm5WR7/ll3z0+OBQLcOG8GQ14DlrjGdRRcApfXawtD0QRSV694tSd3FvO2v6xNY64T+fv6GFSM+XOdh3EV72poTHCMe6VpwFKUYUvFLoHsATlVcECZCiqv6Ywt+nqPsH2mgwPi9GTQn0apV9zS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kHEo/15G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VTQNUGyL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 08:37:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765701455;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FOR89DdUDQuhjsV3k4Apvvln/JVFrMsKQo/mgk4XBe8=;
	b=kHEo/15GVmdY6A5M3/wjayvt8gXLOnl1MjIiiq7RK1l53NLcPq8CDWU831DEqGZmx59mQj
	JWck0lkiZlm0genqELlhUXdqZhWbMMSnllbIBaLu3QdnhAF1ZVlAiTemThIFz4eVmTJKiN
	ZbeSMa7YJoEqCWLP5lleADjZ1uNb9BZQ6ADhV4AJQyH2whRvrSMFQpEoOcGHsvldvFCqk4
	C07wUkXq4RRkjxMuxF/9xW0Vrsfvjqt3q3zymwbO9H2JZUFOO4wnsRBDcoAzUGum2rbbci
	ysdFBwltY+nqNrVP5iI9lIyYjSRDXomcBEulgRffqjzxXmHKT09Eyp5Zi2heOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765701455;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FOR89DdUDQuhjsV3k4Apvvln/JVFrMsKQo/mgk4XBe8=;
	b=VTQNUGyLc+Ci+AIWOmMqjHnCIBc/gFB+kENkAqTlWyGB04o+xj5t7QJiILZPHLrZQrHrv9
	AI8z1+Ar6c+v2EAg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/e820: Clean up __refdata use a bit
Cc: Ingo Molnar <mingo@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Juergen Gross <jgross@suse.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 David Woodhouse <dwmw@amazon.co.uk>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515120549.2820541-16-mingo@kernel.org>
References: <20250515120549.2820541-16-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176570145411.498.14602338476948820983.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     2774ae1046fb1504908f8387351485cd0fc71108
Gitweb:        https://git.kernel.org/tip/2774ae1046fb1504908f8387351485cd0fc=
71108
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 14:05:31 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:19:39 +01:00

x86/boot/e820: Clean up __refdata use a bit

So __refdata, like __init, is more of a storage class specifier,
so move the attribute in front of the type, not after the variable
name. This also aligns it vertically.

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
Link: https://patch.msgid.link/20250515120549.2820541-16-mingo@kernel.org
---
 arch/x86/kernel/e820.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 4340751..2ce8ca5 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -61,9 +61,9 @@ static struct e820_table e820_table_init		__initdata;
 static struct e820_table e820_table_kexec_init		__initdata;
 static struct e820_table e820_table_firmware_init	__initdata;
=20
-struct e820_table *e820_table __refdata			=3D &e820_table_init;
-struct e820_table *e820_table_kexec __refdata		=3D &e820_table_kexec_init;
-struct e820_table *e820_table_firmware __refdata	=3D &e820_table_firmware_in=
it;
+__refdata struct e820_table *e820_table			=3D &e820_table_init;
+__refdata struct e820_table *e820_table_kexec		=3D &e820_table_kexec_init;
+__refdata struct e820_table *e820_table_firmware	=3D &e820_table_firmware_in=
it;
=20
 /* For PCI or other memory-mapped resources */
 unsigned long pci_mem_start =3D 0xaeedbabe;

