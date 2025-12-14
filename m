Return-Path: <linux-tip-commits+bounces-7689-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0621BCBB8BC
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 09:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3582C3043575
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF802EDD62;
	Sun, 14 Dec 2025 08:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pVDzVA+K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fDPqvoPX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031D02D190C;
	Sun, 14 Dec 2025 08:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765701470; cv=none; b=d8eRkyMgAJcxDy8lyLUPYqQe0RUkSqZFTYnrZkobL11TpzAqWHrlsQwlIBzh4V2twBO05/bZuE8/2M4VZdaxNYRGA7tm7IFfDLK26kirBHWC1E7iP837kzbfDyfzSJBDIyHLI5BEZK5vsUh4LnUlMeoNXBBoaN3CAek56O9V27s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765701470; c=relaxed/simple;
	bh=kZGY7V5ysuxWg3Abt1g/yzkysAHlKx6VIanv+UDB2/0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YDHyFlVLqI5tGzqZoqHJQHpZ5WRowxMvZD9M4tc7SwuRAPgWzhLny11twhjwH/xQzZm/lQL6u9A8L0GnJGQna8U2ALwAmUmxvmpSZmaEx8O41vbxH01jW5NA2uTI/FXreYxsbpyafylN26kHxQzk79B8BBvd+gb/eokop5XYd2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pVDzVA+K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fDPqvoPX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 08:37:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765701465;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ofvEawv9X4u7uKH5giIa8ZJWqzm7A8vdh3XNqmkc20E=;
	b=pVDzVA+K271NkLeH1gmdE6qqT6wpAoRUHe4+1HBQRg6h+KMpUZQiSjqqk0R8XbDpUHR2iK
	fJEIREK9UZ6cLYlhIMTIKbsHcHBBuiA4N0+4v/bQM9mQKbpsXmG+mbJFjAjcfysVYwsr54
	V+ueKefDqUj0MefW3dKawDlWTgRQxWrPwvgNYoiyAUybBV62HFlP/fQHII+SCFyzNUQFwy
	Sguj1w+IOID//dJ0FX2QKNqjBIXPwdButAFI05JuYYxL4DwjUgW/+6/tU/M/IneitQXG5o
	ph5yIRRsM1U90ip+2GbupkaDL0t05MER6xzFGstYLs0a1XLvD7xKOx2rgF0rDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765701465;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ofvEawv9X4u7uKH5giIa8ZJWqzm7A8vdh3XNqmkc20E=;
	b=fDPqvoPXhChqR0TUPXuHYBDeODrQ4U9S9WQ2GTQ8V2Umkl8QjRU9gNtOnvlz8W8K50g/Px
	RO/HU5wLr/3D2qDw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/e820: Print gaps in the E820 table
Cc: Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Shevchenko <andy@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Juergen Gross <jgross@suse.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515120549.2820541-6-mingo@kernel.org>
References: <20250515120549.2820541-6-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176570146427.498.1627436688656580787.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     4d8e5a682be4136758a8beadd5aecc7f76276504
Gitweb:        https://git.kernel.org/tip/4d8e5a682be4136758a8beadd5aecc7f762=
76504
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 14:05:21 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:19:37 +01:00

x86/boot/e820: Print gaps in the E820 table

Gaps in the E820 table are not obvious at a glance and can
easily be overlooked.

Print out gaps in the E820 table:

Before:

	BIOS-provided physical RAM map:
	BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
	BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
	BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
	BIOS-e820: [mem 0x0000000000100000-0x000000007ffdbfff] usable
	BIOS-e820: [mem 0x000000007ffdc000-0x000000007fffffff] reserved
	BIOS-e820: [mem 0x00000000b0000000-0x00000000bfffffff] reserved
	BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
	BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
	BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
	BIOS-e820: [mem 0x000000fd00000000-0x000000ffffffffff] reserved
After:

	BIOS-provided physical RAM map:
	BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
	BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
	BIOS-e820: [gap 0x00000000000a0000-0x00000000000effff]
	BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
	BIOS-e820: [mem 0x0000000000100000-0x000000007ffdbfff] usable
	BIOS-e820: [mem 0x000000007ffdc000-0x000000007fffffff] reserved
	BIOS-e820: [gap 0x0000000080000000-0x00000000afffffff]
	BIOS-e820: [mem 0x00000000b0000000-0x00000000bfffffff] reserved
	BIOS-e820: [gap 0x00000000c0000000-0x00000000fed1bfff]
	BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
	BIOS-e820: [gap 0x00000000fed20000-0x00000000feffbfff]
	BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
	BIOS-e820: [gap 0x00000000ff000000-0x00000000fffbffff]
	BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
	BIOS-e820: [gap 0x0000000100000000-0x000000fcffffffff]
	BIOS-e820: [mem 0x000000fd00000000-0x000000ffffffffff] reserved

Also warn about badly ordered E820 table entries:

	BUG: out of order E820 entry!

( this is printed before the entry is printed, so there's no need to
  print any additional data with the warning. )

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
Link: https://patch.msgid.link/20250515120549.2820541-6-mingo@kernel.org
---
 arch/x86/kernel/e820.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 09c712a..460645d 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -202,18 +202,32 @@ static void __init e820_print_type(enum e820_type type)
=20
 static void __init e820__print_table(const char *who)
 {
+	u64 range_end_prev =3D 0;
 	int i;
=20
 	for (i =3D 0; i < e820_table->nr_entries; i++) {
 		struct e820_entry *entry =3D e820_table->entries + i;
+		u64 range_start, range_end;
=20
-		pr_info("%s: [mem %#018Lx-%#018Lx] ",
-			who,
-			entry->addr,
-			entry->addr + entry->size-1);
+		range_start =3D entry->addr;
+		range_end   =3D entry->addr + entry->size;
=20
+		/* Out of order E820 maps should not happen: */
+		if (range_start < range_end_prev)
+			pr_info(FW_BUG "out of order E820 entry!\n");
+
+		if (range_start > range_end_prev) {
+			pr_info("%s: [gap %#018Lx-%#018Lx]\n",
+				who,
+				range_end_prev,
+				range_start-1);
+		}
+
+		pr_info("%s: [mem %#018Lx-%#018Lx] ", who, range_start, range_end-1);
 		e820_print_type(entry->type);
 		pr_cont("\n");
+
+		range_end_prev =3D range_end;
 	}
 }
=20

