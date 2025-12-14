Return-Path: <linux-tip-commits+bounces-7669-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F6DCBB81F
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 09:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B89BD3019B53
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2AF2C21FB;
	Sun, 14 Dec 2025 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fl9QX2N8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="djZGEvkR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB8F2C11CF;
	Sun, 14 Dec 2025 08:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765701447; cv=none; b=iXEECK2u5qIqnFo/ZPvtoCKinzi6Sg6OY0Qnwr+xyo5kmxfMFT7i6sM+TCjNQVezHlIitj2tnWR1s45VXZlo5ZyK+mlCEub7y0r/UTYhaiIs/f4B9pEyevm22yjjxLfr9XlhXY0gQ44LXv2CsHL+CVeSAuhFvnL3ItIPl7wi1L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765701447; c=relaxed/simple;
	bh=EubW2XrzquKcU/QK13NFSufDVT8RIkzOOQyjIPfFWTE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=q6Nm+75u7K2RxJNU5nVUcw7tqY1NP16ZNxWi9/EGlCBfna9PHypHasZ7Rva0RORUt4VdUAyot6pOlxPAvXx4pQ8ZlGlhthJeKFm0skEw6vfiAxTLph/tcNgIAst7oHDJP30m0TQU0275cwsKMb776HVPS00LnsufeEiY+M1WqoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fl9QX2N8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=djZGEvkR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 08:37:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765701443;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V/GtwuaYOQI4rTOgQ8HIAJd5q1NaRjmvqyDb540zZtU=;
	b=fl9QX2N8reUf53Vmfip9KB5K7ewlKypdqpN3eyluX3dN24RG2x2gKc9JIFPXyFTQP9wlHA
	oYkmy7iAndL33ki4NvIOi+m2i8Sx2V9GobPkRhHaDgcdc0G9YEBNRl/v3BBDDVeJSL1vYt
	VPNsMwUM2UQINxCxZc7Rwwb+++qsIvMxpvYEiAEQ989FrBYtTVf45nGnV7o2+BVF0dTTcL
	UYqIeenIL0cs8zsOtP8zR1ZEDAD5PxPgC/36qRhjPRhElSTEcukpb1S2yCTLibl/1Q5g67
	OEcLsfrAUl0bU2wTp0tCfGbYiF+/VBuWIsS2FXEp5m9u5XK5bdSWCE1Air5GRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765701443;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V/GtwuaYOQI4rTOgQ8HIAJd5q1NaRjmvqyDb540zZtU=;
	b=djZGEvkRbg1qQv5nTH2w9ubNHVFfrK9/He5A0bVDSjel4670/Hp3FE4iTIinLCnVEq1dyo
	+f5gF7gIht7WAdBw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/e820: Simplify append_e820_table() and
 remove restriction on single-entry tables
Cc: Ingo Molnar <mingo@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Arnd Bergmann <arnd@kernel.org>, David Woodhouse <dwmw@amazon.co.uk>,
 "H . Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515120549.2820541-26-mingo@kernel.org>
References: <20250515120549.2820541-26-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176570144257.498.13095011191968815152.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     157266edcc56715323de1bd60e49194b3b66a174
Gitweb:        https://git.kernel.org/tip/157266edcc56715323de1bd60e49194b3b6=
6a174
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 14:05:41 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:19:41 +01:00

x86/boot/e820: Simplify append_e820_table() and remove restriction on single-=
entry tables

So append_e820_table() begins with this weird condition that checks 'nr_entri=
es':

    static int __init append_e820_table(struct boot_e820_entry *entries, u32 =
nr_entries)
    {
            /* Only one memory region (or negative)? Ignore it */
            if (nr_entries < 2)
                    return -1;

Firstly, 'nr_entries' has been an u32 since 2017 and cannot be negative.

Secondly, there's nothing inherently wrong with single-entry E820 maps,
especially in virtualized environments.

So remove this restriction and remove the __append_e820_table()
indirection.

Also:

 - fix/update comments
 - remove obsolete comments

This shrinks the generated code a bit as well:

   text       data        bss        dec        hex    filename
   7549      44072          0      51621       c9a5    e820.o.before
   7533      44072          0      51605       c995    e820.o.after

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: H . Peter Anvin <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://patch.msgid.link/20250515120549.2820541-26-mingo@kernel.org
---
 arch/x86/kernel/e820.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 4696080..806fd92 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -441,17 +441,22 @@ __init int e820__update_table(struct e820_table *table)
 	return 0;
 }
=20
-__init static int __append_e820_table(struct boot_e820_entry *entries, u32 n=
r_entries)
+/*
+ * Copy the BIOS E820 map into the kernel's e820_table.
+ *
+ * Sanity-check it while we're at it..
+ */
+__init static int append_e820_table(struct boot_e820_entry *entries, u32 nr_=
entries)
 {
 	struct boot_e820_entry *entry =3D entries;
=20
 	while (nr_entries) {
 		u64 start =3D entry->addr;
-		u64 size =3D entry->size;
-		u64 end =3D start + size - 1;
-		u32 type =3D entry->type;
+		u64 size  =3D entry->size;
+		u64 end   =3D start + size-1;
+		u32 type  =3D entry->type;
=20
-		/* Ignore the entry on 64-bit overflow: */
+		/* Ignore the remaining entries on 64-bit overflow: */
 		if (start > end && likely(size))
 			return -1;
=20
@@ -463,24 +468,6 @@ __init static int __append_e820_table(struct boot_e820_e=
ntry *entries, u32 nr_en
 	return 0;
 }
=20
-/*
- * Copy the BIOS E820 map into a safe place.
- *
- * Sanity-check it while we're at it..
- *
- * If we're lucky and live on a modern system, the setup code
- * will have given us a memory map that we can use to properly
- * set up memory.  If we aren't, we'll fake a memory map.
- */
-__init static int append_e820_table(struct boot_e820_entry *entries, u32 nr_=
entries)
-{
-	/* Only one memory region (or negative)? Ignore it */
-	if (nr_entries < 2)
-		return -1;
-
-	return __append_e820_table(entries, nr_entries);
-}
-
 __init static u64
 __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e82=
0_type old_type, enum e820_type new_type)
 {
@@ -754,7 +741,7 @@ __init void e820__memory_setup_extended(u64 phys_addr, u3=
2 data_len)
 	entries =3D sdata->len / sizeof(*extmap);
 	extmap =3D (struct boot_e820_entry *)(sdata->data);
=20
-	__append_e820_table(extmap, entries);
+	append_e820_table(extmap, entries);
 	e820__update_table(e820_table);
=20
 	memcpy(e820_table_kexec, e820_table, sizeof(*e820_table_kexec));

