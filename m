Return-Path: <linux-tip-commits+bounces-7681-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FAACBB86B
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 09:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A655301CE91
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D121A2D7384;
	Sun, 14 Dec 2025 08:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4iWjUG7e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RQUmBVLT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E70B2D249A;
	Sun, 14 Dec 2025 08:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765701463; cv=none; b=I0e7zfsuSdbI+VQe/yEEd2Dxb9mwQFjzxQIRKA6F9n39iRXBgm/xPWlCKYJ8L5f7pXkAOV72IPJcW5wO/12t8Mr/9S+8YkJkNkOiGkQI2jVcbe3RU0wNE1G8Xg9B8/XJEkux4ocAVBiaASyDbel7FB3/NdZaPAsbjaIcZb5o2j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765701463; c=relaxed/simple;
	bh=7Um0+HXpVgTzJVbyjP3cBpt3B7uqLPoopdW19EvkQZw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Cd+LWhC2p0dCD2fzfdqU840staiM6lSTy7ZLKTHmewxuKtusKP7q0QeGL+HI7zQu5nZBpc5ZwsrY2qvnvTCxXTyuKz3XXvaZR09gTa/NHuOiXcSbcIr9qptvFWNmi4xC6609Keb4kmXlX2JNLaDCUCsG1GF3ZBY+mzbi4NszXPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4iWjUG7e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RQUmBVLT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 08:37:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765701458;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dGxyiwrO+AOGdAdVN2fmy5wyIGyh+8h0K/V3LYOD+ZY=;
	b=4iWjUG7eOH4thKvxQ40Spr0I2DgrAPDEUeEFzG5VzUjiSRk66dVBF2uY2Y79C+5L2nPSzv
	q2o7itOmhfkvsSUmiutGHJ7F1njs7+Bswzw1M6RKgNwV55mwg7gxlJZfxXlfTY7EXUvh1I
	8qeaCyyiSnpx/bgLxkFcThiWfH+ubeBx3ss2CcdvreDaZQBdH3oONfE2o5lHakooPC1Tgn
	kUs47oNdC6EN+bEeoeGzvU1ckjKXGB4eDgc6wVspdd8jL/SJXjzpFabrhN2Ojdjj0YfuR/
	6SWKkDIMChGBjVefn7IzOSi2Lah21GHMJXdXTSizsZKjXr87oKdRw/VlHPdBYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765701458;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dGxyiwrO+AOGdAdVN2fmy5wyIGyh+8h0K/V3LYOD+ZY=;
	b=RQUmBVLT/l7qdvxmYJ1tbKNUauEb0qpQBzuEcu/X9vwPxihFN6U9YSdw0haZnEPcIhI1Lj
	snYvZg7JomDItBAw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/e820: Clean up confusing and
 self-contradictory verbiage around E820 related resource allocations
Cc: Ingo Molnar <mingo@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Juergen Gross <jgross@suse.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 David Woodhouse <dwmw@amazon.co.uk>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515120549.2820541-13-mingo@kernel.org>
References: <20250515120549.2820541-13-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176570145732.498.10803065058126907204.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     44f732f3ec8273b99252fcd47f873206d556a69f
Gitweb:        https://git.kernel.org/tip/44f732f3ec8273b99252fcd47f873206d55=
6a69f
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 14:05:28 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:19:38 +01:00

x86/boot/e820: Clean up confusing and self-contradictory verbiage around E820=
 related resource allocations

So the E820 code has a rather confusing area of code at around
e820__reserve_resources(), which is, by its plain reading,
rather self-contradictory. For example, the comment explaining
e820__reserve_resources() claims:

 - '* Mark E820 reserved areas as busy for the resource manager'

By 'E820 reserved areas' one can naively conclude that it's
talking about E820_TYPE_RESERVED areas - while those areas
are treated in exactly the opposite fashion by do_mark_busy():

        switch (type) {
        case E820_TYPE_RESERVED:
        case E820_TYPE_SOFT_RESERVED:
        case E820_TYPE_PRAM:
        case E820_TYPE_PMEM:
                return false;

Ie. E820_TYPE_RESERVED areas are *not* marked busy for the
resource manager, because E820_TYPE_RESERVED areas are
device regions that might eventually be claimed by a device driver.

This type of confusion permeates this whole area of code,
making it exceedingly difficult to read (for me at least).

So untangle it bit by bit:

 - Instead of talking about ambiguous 'reserved areas',
   talk about 'E820 device address regions' instead,
   and 'register'/'lock' them.

 - The do_mark_busy() function is a misnomer as well, because despite
   its name it 'does' nothing - it only determines what type
   of resource handling an E820 type should receive from the
   kernel. Rename it to e820_device_region() and negate its
   meaning, to avoid the 'busy/reserved' confusion. Because
   that's what this code is really about: filtering out
   device regions such as E820_TYPE_RESERVED, E820_TYPE_PRAM,
   E820_TYPE_PMEM, etc., and allowing them to be claimed
   by device drivers later on.

 - All other E820 regions (system regions) are registered and
   locked early on, before the PCI resource manager does its
   search for device BAR addresses, etc.

Also fix this somewhat misleading comment:

	/*
	 * Try to bump up RAM regions to reasonable boundaries, to
	 * avoid stolen RAM:
	 */

and explain that here we register artificial 'gap' resources
at the end of suspiciously sized RAM regions, as heuristics
to try to avoid buggy firmware with undeclared 'stolen RAM' regions:

	/*
	 * Create additional 'gaps' at the end of RAM regions,
	 * rounding them up to 64k/1MB/64MB boundaries, should
	 * they be weirdly sized, and register extra, locked
	 * resource regions for them, to make sure drivers
	 * won't claim those addresses.
	 *
	 * These are basically blind guesses and heuristics to
	 * avoid resource conflicts with broken firmware that
	 * doesn't properly list 'stolen RAM' as a system region
	 * in the E820 map.
	 */

Also improve the printout of this extra resource a bit: make the
message more unambiguous, and upgrade it from pr_debug() (where
very few people will see it), to pr_info() (where it will make
it into the syslog on default distro configs).

Also fix spelling and improve comment placement.

No change in functionality intended.

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
Link: https://patch.msgid.link/20250515120549.2820541-13-mingo@kernel.org
---
 arch/x86/kernel/e820.c | 55 +++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 6bc0686..0316a18 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1064,37 +1064,44 @@ static unsigned long __init e820_type_to_iores_desc(s=
truct e820_entry *entry)
 	}
 }
=20
-static bool __init do_mark_busy(enum e820_type type, struct resource *res)
+/*
+ * We assign one resource entry for each E820 map entry:
+ */
+static struct resource __initdata *e820_res;
+
+/*
+ * Is this a device address region that should not be marked busy?
+ * (Versus system address regions that we register & lock early.)
+ */
+static bool __init e820_device_region(enum e820_type type, struct resource *=
res)
 {
-	/* this is the legacy bios/dos rom-shadow + mmio region */
+	/* This is the legacy BIOS/DOS ROM-shadow + MMIO region: */
 	if (res->start < (1ULL<<20))
-		return true;
+		return false;
=20
 	/*
 	 * Treat persistent memory and other special memory ranges like
-	 * device memory, i.e. reserve it for exclusive use of a driver
+	 * device memory, i.e. keep it available for exclusive use of a
+	 * driver:
 	 */
 	switch (type) {
 	case E820_TYPE_RESERVED:
 	case E820_TYPE_SOFT_RESERVED:
 	case E820_TYPE_PRAM:
 	case E820_TYPE_PMEM:
-		return false;
+		return true;
 	case E820_TYPE_RAM:
 	case E820_TYPE_ACPI:
 	case E820_TYPE_NVS:
 	case E820_TYPE_UNUSABLE:
 	default:
-		return true;
+		return false;
 	}
 }
=20
 /*
- * Mark E820 reserved areas as busy for the resource manager:
+ * Mark E820 system regions as busy for the resource manager:
  */
-
-static struct resource __initdata *e820_res;
-
 void __init e820__reserve_resources(void)
 {
 	int i;
@@ -1120,18 +1127,18 @@ void __init e820__reserve_resources(void)
 		res->desc  =3D e820_type_to_iores_desc(entry);
=20
 		/*
-		 * Don't register the region that could be conflicted with
-		 * PCI device BAR resources and insert them later in
-		 * pcibios_resource_survey():
+		 * Skip and don't register device regions that could be conflicted
+		 * with PCI device BAR resources. They get inserted later in
+		 * pcibios_resource_survey() -> e820__reserve_resources_late():
 		 */
-		if (do_mark_busy(entry->type, res)) {
+		if (!e820_device_region(entry->type, res)) {
 			res->flags |=3D IORESOURCE_BUSY;
 			insert_resource(&iomem_resource, res);
 		}
 		res++;
 	}
=20
-	/* Expose the kexec e820 table to the sysfs. */
+	/* Expose the kexec e820 table to sysfs: */
 	for (i =3D 0; i < e820_table_kexec->nr_entries; i++) {
 		struct e820_entry *entry =3D e820_table_kexec->entries + i;
=20
@@ -1165,6 +1172,10 @@ void __init e820__reserve_resources_late(void)
 	int i;
 	struct resource *res;
=20
+	/*
+	 * Register device address regions listed in the E820 map,
+	 * these can be claimed by device drivers later on:
+	 */
 	res =3D e820_res;
 	for (i =3D 0; i < e820_table->nr_entries; i++) {
 		if (!res->parent && res->end)
@@ -1173,8 +1184,16 @@ void __init e820__reserve_resources_late(void)
 	}
=20
 	/*
-	 * Try to bump up RAM regions to reasonable boundaries, to
-	 * avoid stolen RAM:
+	 * Create additional 'gaps' at the end of RAM regions,
+	 * rounding them up to 64k/1MB/64MB boundaries, should
+	 * they be weirdly sized, and register extra, locked
+	 * resource regions for them, to make sure drivers
+	 * won't claim those addresses.
+	 *
+	 * These are basically blind guesses and heuristics to
+	 * avoid resource conflicts with broken firmware that
+	 * doesn't properly list 'stolen RAM' as a system region
+	 * in the E820 map.
 	 */
 	for (i =3D 0; i < e820_table->nr_entries; i++) {
 		struct e820_entry *entry =3D &e820_table->entries[i];
@@ -1190,7 +1209,7 @@ void __init e820__reserve_resources_late(void)
 		if (start >=3D end)
 			continue;
=20
-		printk(KERN_DEBUG "e820: reserve RAM buffer [mem %#010llx-%#010llx]\n", st=
art, end);
+		pr_info("e820: register RAM buffer resource [mem %#010llx-%#010llx]\n", st=
art, end);
 		reserve_region_with_split(&iomem_resource, start, end, "RAM buffer");
 	}
 }

