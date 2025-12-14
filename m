Return-Path: <linux-tip-commits+bounces-7671-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD790CBB805
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 09:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F599300D649
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A032D2488;
	Sun, 14 Dec 2025 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ua2SK9WH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CG/p/o+p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00932C0F60;
	Sun, 14 Dec 2025 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765701449; cv=none; b=P0GfOErLBoTCHUjdoNwyS1B5knWbnlVjUKE1puIetiqZ+6MLTbjw5WDF2hk5u+socD0ZThsxgAD36I8r9XbI6PcSZ7X0cPqnSpvOgHeykz/O3BLaHTlkh0sBpm/eHMFR8rRdCnGEez+OdwniYkO7sHfm2miClRiUrvVSE4Tsuk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765701449; c=relaxed/simple;
	bh=PJHP6yQyzpos5aJfpfH0TDBXF5KelewXVfyOF66NYkw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J/oL/iRMjHxelxnosCMbU4fUpSMCcg1DIY47BjUjaR1tW5HX15iE0HJXhBq8sXHqz35MNS8smXdOJPO0xnqcS18cNDayejhUFXK56TOAruC/UAJBT3LL1dingvph5xcgGESdqjkhIpwhx47spx81UXhBuh5rByYIJb5+PmpEchw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ua2SK9WH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CG/p/o+p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 08:37:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765701446;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5wI7kLtccHNDcf225Gez7clktXI5+nbYvBTsZL1JVVQ=;
	b=ua2SK9WH6f3mO5gKQ8E1n3WBVnNKgIlXV3KoHSWRgtJpdUK5t4EAlv+ZyWoZ8fnH/sUgwe
	YZdnG0KaDARB+SIBbrWx2ZJIzWoGaXtxzEfhldjTScpyxbb0h47zwnusDIUIbQWbWSZOjj
	dkxR/G2clZ9gDmBohKSIQJfQ+T8uE0pCz9vr9NyhIMMa3qQTuOp6aDAwuggpIggLAwGLhr
	uZrXsttQkovCn7j//FsDR5bzTjBjmlPJVI2MAQ2S5JhlfMA+0gt96HHScLDoY71zhn69t9
	Ixe05bQfauXQ8qGIqCNiYZi+16H/CAgfYAnJ937ehxhkA7gta6QEJ7XIk+hwxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765701446;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5wI7kLtccHNDcf225Gez7clktXI5+nbYvBTsZL1JVVQ=;
	b=CG/p/o+pJhKTxnIH29GkpxxhWQZAYdgsYoCdiQV+3sg4QbKE9JvBlbzWNmg6I3BILHhS6m
	8B3Gxrw4xRtyO/Ag==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/boot/e820: Simplify & clarify __e820__range_add() a bit
Cc: Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Shevchenko <andy@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Juergen Gross <jgross@suse.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515120549.2820541-24-mingo@kernel.org>
References: <20250515120549.2820541-24-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176570144497.498.7293501390230041149.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     7df2f811b275e6067f7e15a966a2b6ff22a4edfc
Gitweb:        https://git.kernel.org/tip/7df2f811b275e6067f7e15a966a2b6ff22a=
4edfc
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 14:05:39 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:19:41 +01:00

x86/boot/e820: Simplify & clarify __e820__range_add() a bit

Use 'entry_new' to make clear we are allocating a new entry.

Change the table-full message to say that the table is full.

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
Link: https://patch.msgid.link/20250515120549.2820541-24-mingo@kernel.org
---
 arch/x86/kernel/e820.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index f582802..4758099 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -165,16 +165,19 @@ int e820__get_entry_type(u64 start, u64 end)
 static void __init __e820__range_add(struct e820_table *table, u64 start, u6=
4 size, enum e820_type type)
 {
 	u32 idx =3D table->nr_entries;
+	struct e820_entry *entry_new;
=20
 	if (idx >=3D ARRAY_SIZE(table->entries)) {
-		pr_err("too many E820 table entries; ignoring [mem %#010llx-%#010llx]\n",
+		pr_err("E820 table full; ignoring [mem %#010llx-%#010llx]\n",
 		       start, start + size-1);
 		return;
 	}
=20
-	table->entries[idx].addr =3D start;
-	table->entries[idx].size =3D size;
-	table->entries[idx].type =3D type;
+	entry_new =3D table->entries + idx;
+
+	entry_new->addr =3D start;
+	entry_new->size =3D size;
+	entry_new->type =3D type;
=20
 	table->nr_entries++;
 }

