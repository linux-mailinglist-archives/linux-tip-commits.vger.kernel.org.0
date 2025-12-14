Return-Path: <linux-tip-commits+bounces-7667-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55028CBB817
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 09:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 248CC30141CC
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C65D2C0F97;
	Sun, 14 Dec 2025 08:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UeaVV2Cd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1FpC/fpc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D6A2C0F7D;
	Sun, 14 Dec 2025 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765701445; cv=none; b=Qyo/QJ+/Z9ZqoWV9CMkPCRes21qTkcH0DuxHk1tCo3jelZZkkCg64/whRm6+gl0QMn6mlkxuo0IH5f0iYU5cSc6auDBJ0yXHAa5RcVF8CYa4f6/MwE/aB+FI/sRqz2ASKi/vZMhVYsdV1W5PifbDNL4WSz0UAtnYroVgH7RYwBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765701445; c=relaxed/simple;
	bh=tEx8vTOYLz3cUv/Zy7MXMIrCxLXIPhyLxWIUzXVA2uE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j2b7kcyS3c+NUJ4s80w4bMK7wHqUpJHI4J8HXLkc8PZUcGoCujLk1X+DiP3qAzA6jpDD5eeN5Ju0wz6T+Y49XnSy3YEPvTQNU/KyGrB9DcdihM+3eMfjnLnmjUvTh6lrySRlTnmkO4qvOXXtcepQHAny413aNYGAcor2y/UgIHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UeaVV2Cd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1FpC/fpc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 08:37:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765701441;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ThTsPNZTeIvQ7zUyMOBTzegxlhBi2iwCmnRLcwpilyk=;
	b=UeaVV2CdxAs8ZkhoK82p/c3V1eAcRsNl7URT1Qa46IcBykKtlFHxfBFl4jeiZSi0doI7m9
	SeDjUQaj5Q715HVuMQECTSUX4kWlUWjT9cPfyzaVcKYRtEyR4lHOFS7XX19ezSF53yWq7Y
	G5Vx7qruFPht89UiQjDH5aDSdwdQ7JX7oubtsOfSFuycrF6VEMffg+I+6HF77y2yb4tkx7
	kND4wSf3Yu3c0ety+TyKvFsRV44+65qGbUqXkgP1Cmv0KWAjSvcky2wkExh6Bw2CNHgwoS
	1kVvFgwvJvMFTMkAj/52zcCImudbXPi3LUiVdfzj4u/c2uL1qepK15C1QJ0uvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765701441;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ThTsPNZTeIvQ7zUyMOBTzegxlhBi2iwCmnRLcwpilyk=;
	b=1FpC/fpcmIOvNPmbrLbNJvey+pmcOPniZLKBAacS/EH2RA6aW2EyLnqTXHg2ld1ZsZTNwG
	Jrx25hW1jm1bokAg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/e820: Simplify the e820__range_remove() API
Cc: Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Shevchenko <andy@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Juergen Gross <jgross@suse.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515120549.2820541-28-mingo@kernel.org>
References: <20250515120549.2820541-28-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176570144019.498.5950308599102281160.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     4ad03f133c9e509099907df56717a01468aedfbc
Gitweb:        https://git.kernel.org/tip/4ad03f133c9e509099907df56717a01468a=
edfbc
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 14:05:43 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:19:42 +01:00

x86/boot/e820: Simplify the e820__range_remove() API

Right now e820__range_remove() has two parameters to control the
E820 type of the range removed:

	extern void e820__range_remove(u64 start, u64 size, enum e820_type old_type,=
 bool check_type);

Since E820 types start at 1, zero has a natural meaning of 'no type.

Consolidate the (old_type,check_type) parameters into a single (filter_type)
parameter:

	extern void e820__range_remove(u64 start, u64 size, enum e820_type filter_ty=
pe);

Note that both e820__mapped_raw_any() and e820__mapped_any()
already have such semantics for their 'type' parameter, although
it's currently not used with '0' by in-kernel code.

Also, the __e820__mapped_all() internal helper already has such
semantics implemented as well, and the e820__get_entry_type() API
uses the '0' type to such effect.

This simplifies not just e820__range_remove(), and synchronizes its
use of type filters with other E820 API functions, but simplifies
usage sites as well, such as parse_memmap_one(), beyond the reduction
of the number of parameters:

  -               else if (from)
  -                       e820__range_remove(start_at, mem_size, from, 1);
                  else
  -                       e820__range_remove(start_at, mem_size, 0, 0);
  +                       e820__range_remove(start_at, mem_size, from);

The generated code gets smaller as well:

	add/remove: 0/0 grow/shrink: 0/5 up/down: 0/-66 (-66)

	Function                                     old     new   delta
	parse_memopt                                 112     107      -5
	efi_init                                    1048    1039      -9
	setup_arch                                  2719    2709     -10
	e820__range_remove                           283     273     -10
	parse_memmap_opt                             559     527     -32

	Total: Before=3D22,675,600, After=3D22,675,534, chg -0.00%

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
Link: https://patch.msgid.link/20250515120549.2820541-28-mingo@kernel.org
---
 arch/x86/include/asm/e820/api.h |  2 +-
 arch/x86/kernel/e820.c          | 16 +++++++---------
 arch/x86/kernel/setup.c         |  4 ++--
 arch/x86/platform/efi/efi.c     |  3 +--
 4 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index 9cf416f..bbe0c8d 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -16,7 +16,7 @@ extern bool e820__mapped_all(u64 start, u64 end, enum e820_=
type type);
=20
 extern void e820__range_add   (u64 start, u64 size, enum e820_type type);
 extern u64  e820__range_update(u64 start, u64 size, enum e820_type old_type,=
 enum e820_type new_type);
-extern void e820__range_remove(u64 start, u64 size, enum e820_type old_type,=
 bool check_type);
+extern void e820__range_remove(u64 start, u64 size, enum e820_type filter_ty=
pe);
 extern u64  e820__range_update_table(struct e820_table *t, u64 start, u64 si=
ze, enum e820_type old_type, enum e820_type new_type);
=20
 extern int  e820__update_table(struct e820_table *table);
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index dfbc6e1..c4b9a24 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -548,7 +548,7 @@ __init u64 e820__range_update_table(struct e820_table *t,=
 u64 start, u64 size,
 }
=20
 /* Remove a range of memory from the E820 table: */
-__init void e820__range_remove(u64 start, u64 size, enum e820_type old_type,=
 bool check_type)
+__init void e820__range_remove(u64 start, u64 size, enum e820_type filter_ty=
pe)
 {
 	u32 idx;
 	u64 end;
@@ -558,8 +558,8 @@ __init void e820__range_remove(u64 start, u64 size, enum =
e820_type old_type, boo
=20
 	end =3D start + size;
 	printk(KERN_DEBUG "e820: remove [mem %#010Lx-%#010Lx]", start, end - 1);
-	if (check_type)
-		e820_print_type(old_type);
+	if (filter_type)
+		e820_print_type(filter_type);
 	pr_cont("\n");
=20
 	for (idx =3D 0; idx < e820_table->nr_entries; idx++) {
@@ -567,7 +567,7 @@ __init void e820__range_remove(u64 start, u64 size, enum =
e820_type old_type, boo
 		u64 final_start, final_end;
 		u64 entry_end;
=20
-		if (check_type && entry->type !=3D old_type)
+		if (filter_type && entry->type !=3D filter_type)
 			continue;
=20
 		entry_end =3D entry->addr + entry->size;
@@ -903,7 +903,7 @@ __init static int parse_memopt(char *p)
 	if (mem_size =3D=3D 0)
 		return -EINVAL;
=20
-	e820__range_remove(mem_size, ULLONG_MAX - mem_size, E820_TYPE_RAM, 1);
+	e820__range_remove(mem_size, ULLONG_MAX - mem_size, E820_TYPE_RAM);
=20
 #ifdef CONFIG_MEMORY_HOTPLUG
 	max_mem_size =3D mem_size;
@@ -959,12 +959,10 @@ __init static int parse_memmap_one(char *p)
 			e820__range_update(start_at, mem_size, from, to);
 		else if (to)
 			e820__range_add(start_at, mem_size, to);
-		else if (from)
-			e820__range_remove(start_at, mem_size, from, 1);
 		else
-			e820__range_remove(start_at, mem_size, 0, 0);
+			e820__range_remove(start_at, mem_size, from);
 	} else {
-		e820__range_remove(mem_size, ULLONG_MAX - mem_size, E820_TYPE_RAM, 1);
+		e820__range_remove(mem_size, ULLONG_MAX - mem_size, E820_TYPE_RAM);
 	}
=20
 	return *p =3D=3D '\0' ? 0 : -EINVAL;
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index a231b24..ffbd04e 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -763,7 +763,7 @@ static void __init trim_bios_range(void)
 	 * area (640Kb -> 1Mb) as RAM even though it is not.
 	 * take them out.
 	 */
-	e820__range_remove(BIOS_BEGIN, BIOS_END - BIOS_BEGIN, E820_TYPE_RAM, 1);
+	e820__range_remove(BIOS_BEGIN, BIOS_END - BIOS_BEGIN, E820_TYPE_RAM);
=20
 	e820__update_table(e820_table);
 }
@@ -785,7 +785,7 @@ static void __init e820_add_kernel_range(void)
 		return;
=20
 	pr_warn(".text .data .bss are not marked as E820_TYPE_RAM!\n");
-	e820__range_remove(start, size, E820_TYPE_RAM, 0);
+	e820__range_remove(start, size, 0);
 	e820__range_add(start, size, E820_TYPE_RAM);
 }
=20
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 463b784..d00c6de 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -333,8 +333,7 @@ static void __init efi_remove_e820_mmio(void)
 			if (size >=3D 256*1024) {
 				pr_info("Remove mem%02u: MMIO range=3D[0x%08llx-0x%08llx] (%lluMB) from =
e820 map\n",
 					i, start, end, size >> 20);
-				e820__range_remove(start, size,
-						   E820_TYPE_RESERVED, 1);
+				e820__range_remove(start, size, E820_TYPE_RESERVED);
 			} else {
 				pr_info("Not removing mem%02u: MMIO range=3D[0x%08llx-0x%08llx] (%lluKB)=
 from e820 map\n",
 					i, start, end, size >> 10);

