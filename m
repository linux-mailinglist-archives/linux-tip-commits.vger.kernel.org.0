Return-Path: <linux-tip-commits+bounces-7674-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 334BFCBB841
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 09:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 059BF3030DB1
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FF92D23A5;
	Sun, 14 Dec 2025 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S5PemMsP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jCUFIAas"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E58254B1F;
	Sun, 14 Dec 2025 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765701453; cv=none; b=Q3VY6zB4Iydv0N2lm/IkMHsfxnLuUZh7LSOPmKLxeTJywyU5Uu/ixFuCK3aAvfrSKzg8+Pwvfgeb1pp9UECjNujea4hoF3Y45p9fA/WU0eghS2ZyxqOPk5kDqpHgpHv+XpoOQ5pUrQ080FznR4nSjK6KEn2kgpP7WnOw01uSfvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765701453; c=relaxed/simple;
	bh=xPRobxvqqAigA12bIs97REbwLXlYBrh2PjqRlr1UMys=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Q8ODDs+wKPKyTsRIJ/+mtuDvqFcmCGuED02DVHQbIqXHsn0kDuHhe1A4r7YRj5ElrQ0ZF9FKVXkwTlCDcfIgmPg89WYX6ibNskPLtodFYsh2raYN0GANApeFpKffBMDDc3C9r1kavvLxL9Dn4hSOTms5DrE+n8y1AZd2TBi2duU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S5PemMsP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jCUFIAas; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 08:37:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765701449;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/BHKC8WXfM8bBhCe5rD4Y5CGwQCrvXRmVygEJOJfZk4=;
	b=S5PemMsPJwFqg3Iso0It3RumKVZ/n+/T4RaAt/vpi50tV6KND9SFA3M7WeU3D62uxjvLJS
	dQXo/bG7nAyYcOcTXzYrUNpGdgMxbDQsEzwqu3ikBwzkQhICq4k2MUsRJrhSHs183eAxy5
	RLbial/WPsgtC3mEjm4d4HA+qxa9o5NCSxWwbUexJUVBfjII1p73dWkGweXIsf5jChXZNZ
	ys94z8JoMK1rJlHMZiKjvAaZUpS2qO6Y7gcornrl2GXmQvRikC+aOwKgy/jtkoXW1eQypp
	MQKTkuXs7kSr3y8hqeXjc5ZXeQPxZ2p+LXmKZnEeagDBqvg76Bi2dQNBh4F9eA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765701449;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/BHKC8WXfM8bBhCe5rD4Y5CGwQCrvXRmVygEJOJfZk4=;
	b=jCUFIAas4nhZgJFVkwVo7KAg2mheRhYbcj/jIWMpxnzJ64d2IlljutyQ8vjgVq/CrhK8Nv
	HvmM2NmMLeqrIxBQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/e820: Clean up
 e820__setup_pci_gap()/e820_search_gap() a bit
Cc: Andy Shevchenko <andy@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Arnd Bergmann <arnd@kernel.org>, David Woodhouse <dwmw@amazon.co.uk>,
 "H . Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515120549.2820541-21-mingo@kernel.org>
References: <20250515120549.2820541-21-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176570144828.498.13570441612695424395.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     cff02bff04f237b361fdc7066f043d00f0e3c872
Gitweb:        https://git.kernel.org/tip/cff02bff04f237b361fdc7066f043d00f0e=
3c872
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 14:05:36 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:19:40 +01:00

x86/boot/e820: Clean up e820__setup_pci_gap()/e820_search_gap() a bit

Apply misc cleanups:

 - Use a bit more readable variable names, we haven't run out of
   underscore characters in the kernel yet.

 - s/0x400000/SZ_4M

 - s/1024*1024/SZ_1M

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: H . Peter Anvin <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://patch.msgid.link/20250515120549.2820541-21-mingo@kernel.org
---
 arch/x86/kernel/e820.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 39f29bf..b8edc5e 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -638,7 +638,7 @@ static void __init e820__update_table_kexec(void)
 /*
  * Search for a gap in the E820 memory space from 0 to MAX_GAP_END (4GB).
  */
-static int __init e820_search_gap(unsigned long *gapstart, unsigned long *ga=
psize)
+static int __init e820_search_gap(unsigned long *gap_start, unsigned long *g=
ap_size)
 {
 	u64 last =3D MAX_GAP_END;
 	int idx =3D e820_table->nr_entries;
@@ -655,9 +655,9 @@ static int __init e820_search_gap(unsigned long *gapstart=
, unsigned long *gapsiz
 		if (last > end) {
 			unsigned long gap =3D last - end;
=20
-			if (gap >=3D *gapsize) {
-				*gapsize =3D gap;
-				*gapstart =3D end;
+			if (gap >=3D *gap_size) {
+				*gap_size =3D gap;
+				*gap_start =3D end;
 				found =3D 1;
 			}
 		}
@@ -677,29 +677,29 @@ static int __init e820_search_gap(unsigned long *gapsta=
rt, unsigned long *gapsiz
  */
 __init void e820__setup_pci_gap(void)
 {
-	unsigned long gapstart, gapsize;
+	unsigned long gap_start, gap_size;
 	int found;
=20
-	gapsize =3D 0x400000;
-	found  =3D e820_search_gap(&gapstart, &gapsize);
+	gap_size =3D SZ_4M;
+	found  =3D e820_search_gap(&gap_start, &gap_size);
=20
 	if (!found) {
 #ifdef CONFIG_X86_64
-		gapstart =3D (max_pfn << PAGE_SHIFT) + 1024*1024;
+		gap_start =3D (max_pfn << PAGE_SHIFT) + SZ_1M;
 		pr_err("Cannot find an available gap in the 32-bit address range\n");
 		pr_err("PCI devices with unassigned 32-bit BARs may not work!\n");
 #else
-		gapstart =3D 0x10000000;
+		gap_start =3D 0x10000000;
 #endif
 	}
=20
 	/*
 	 * e820__reserve_resources_late() protects stolen RAM already:
 	 */
-	pci_mem_start =3D gapstart;
+	pci_mem_start =3D gap_start;
=20
 	pr_info("[gap %#010lx-%#010lx] available for PCI devices\n",
-		gapstart, gapstart + gapsize - 1);
+		gap_start, gap_start + gap_size - 1);
 }
=20
 /*

