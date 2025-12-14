Return-Path: <linux-tip-commits+bounces-7680-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 377FECBB80E
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 09:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A507A3005032
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E1C18787A;
	Sun, 14 Dec 2025 08:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MhMQR0IM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e5uHlYjq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF8D2C11EB;
	Sun, 14 Dec 2025 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765701459; cv=none; b=rZkISD88wuRSzI7F6hMVKg1zC46jSyyZUCsLXBhSn+Zk0CRaeEV/mkW2THu10jeNQbA+U8vOOs/fC7XKp+tBNTEGgX/nMXkBfoOw7fXKzHb5eiLsEKQBY9SfRl+sQGQb+WOwhtD0mxEGHoRtD0nof5uJ6PszJUlFpc2ILFRItwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765701459; c=relaxed/simple;
	bh=IaR4iRcbbpaqkpAjHhTteDzeiClb4vItA5KSaN8WhCc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=drsMbNtn+ZilZLdl/QcsI384KRDJq3ISVLrmiccWhMcFWBNbwqzL7EjVAnXWks9nsQS4WwIRFx57ZhC2ZmjyzWdPVWon6AMsAQ7rZv6j5nMB1rRbK6IuD8fTWm3jOIsgMGUq/PHYD9AGHzKQhZir/1kovsaPSpBMaydbzklwOBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MhMQR0IM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e5uHlYjq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 08:37:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765701456;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uys477tbVbW38gDVBbtzr4ZCkyHUYFKYYwj4lGBg7CU=;
	b=MhMQR0IMf6H4pEChXV2dWkaGimMFKXekkZP2go/uBXCCcN5v1BoYJpUPonkl/b7gU1AAy8
	qFF2V4bWLa6QbBIKva2FLwptgwcQ+dbHMF4JaoAOnqAqy0qOavTBQihsq6d/I2qJXtAKEo
	3i1nO+8cACvP81W6A9wXESv7RTe2xw7nZTruERp11QUiI7dF+LlYSewpyTNyDN0P7j4svN
	9BBoDdR/XGSHliFB/oHL46rP7Hdt2GY7z8lLJEz+Y2tdZuKHNBVGY4d6FMfh7056UGzitl
	B6TFp1GoiDhRp+Sr4ximiJGopyaTbW//2LFPgHsW1rnWftCC65e7R7qfmgAGTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765701456;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uys477tbVbW38gDVBbtzr4ZCkyHUYFKYYwj4lGBg7CU=;
	b=e5uHlYjq6Uu/Yb/792TAvLT6TZBymLaIWs5O/jA7sasDb7Zlg7UvUWTMUtK+LaB3c9BsUw
	thfws2TdeNPLQOBg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/e820: Clean up __e820__range_add() a bit
Cc: Ingo Molnar <mingo@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Juergen Gross <jgross@suse.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 David Woodhouse <dwmw@amazon.co.uk>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515120549.2820541-15-mingo@kernel.org>
References: <20250515120549.2820541-15-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176570145525.498.17211876197299706287.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     a4803df3a2b145fd17bc3d4c23c4c12c74951299
Gitweb:        https://git.kernel.org/tip/a4803df3a2b145fd17bc3d4c23c4c12c749=
51299
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 14:05:30 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:19:39 +01:00

x86/boot/e820: Clean up __e820__range_add() a bit

 - Use 'idx' index variable instead of a weird 'x'
 - Make the error message E820-specific
 - Group the code a bit better

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
Link: https://patch.msgid.link/20250515120549.2820541-15-mingo@kernel.org
---
 arch/x86/kernel/e820.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 0c3f12f..4340751 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -166,17 +166,18 @@ int e820__get_entry_type(u64 start, u64 end)
  */
 static void __init __e820__range_add(struct e820_table *table, u64 start, u6=
4 size, enum e820_type type)
 {
-	int x =3D table->nr_entries;
+	int idx =3D table->nr_entries;
=20
-	if (x >=3D ARRAY_SIZE(table->entries)) {
-		pr_err("too many entries; ignoring [mem %#010llx-%#010llx]\n",
-		       start, start + size - 1);
+	if (idx >=3D ARRAY_SIZE(table->entries)) {
+		pr_err("too many E820 table entries; ignoring [mem %#010llx-%#010llx]\n",
+		       start, start + size-1);
 		return;
 	}
=20
-	table->entries[x].addr =3D start;
-	table->entries[x].size =3D size;
-	table->entries[x].type =3D type;
+	table->entries[idx].addr =3D start;
+	table->entries[idx].size =3D size;
+	table->entries[idx].type =3D type;
+
 	table->nr_entries++;
 }
=20

