Return-Path: <linux-tip-commits+bounces-7666-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A84CBB808
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 09:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40D5D300F885
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BA02C11C9;
	Sun, 14 Dec 2025 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y3AHKSCB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wmIUVHqN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACB5254B1F;
	Sun, 14 Dec 2025 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765701443; cv=none; b=gzCUXe6r632+eXL6vbpLb/t/CAj7Vl/GYWC/tToRqCH9BEWFqQA+5Ni6IRa2tyeTI+egfXlLjW2PSauCRKTOycms200rvIi00Qdbw7HtloXNMMPdzpzpraJKvdrSh0Ohn0MAWmjYQYrETc58ZAbHkoxG2U8nVbk3PUVSNt3vpD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765701443; c=relaxed/simple;
	bh=Q9bjMmrqr2MmVsJn33VhLC0uRAXEZ/MJhmEz5rnirCU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JC8cnAZ94QMkgZrcNwpmuMGqqTj8RY9zfZi/QnnNGQuvNOzHzYYbfkdlPqdpwspNO97U/T8/XOVmW95z4HE+/Q9F88GbAmCeOWHAusydBK1Ov2FkuLZGl1/bExxS82cQ7Tq0Zodd8UTftmqhCCAnB2nQh+Y6JJumIXVKYDEScnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y3AHKSCB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wmIUVHqN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 08:37:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765701440;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JvgEyqknhVY9gXiILi60MtRkuOftCesYw9uSla9o+sM=;
	b=y3AHKSCB68u90PLgUdHbkTtyuDEwM3tMjSgKXkYoK0NQEGafcUW6H5Vpf15YvFGd4tLFSu
	nRqEZSp60lHzcapsRONeZgd6oxcThSaLXBb+Bfmtx+PWY8mR+JToO+iEFnfHwjYZzDbX+d
	5RlvaCAsCzJbkc/FYfvCAOJVyjULrMNHEgWjVTWJw2eKFGJuEDOMiXGR6iWZ10HBTcfefC
	OcFPDNy/YP6e/+F2C1vvx6uErltkQfWPIkTAnIjD2tp39KxblChRvIgM9N4HSeMarQ6soj
	SuPqI47O/e7G41OTB2D7aM0KRkG4qo/iKNJjcL/wC4M7i/L2ehQoW5xTG5Q2Yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765701440;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JvgEyqknhVY9gXiILi60MtRkuOftCesYw9uSla9o+sM=;
	b=wmIUVHqNRikRnjuEXnl69N1iLLgl3m9l8TTzxvQ+oBRwK6Ka4w6+HAOo5UEeTuEqWoNKqF
	AsK0yE/FAnScglDA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/boot/e820: Make sure e820_search_gap() finds all gaps
Cc: Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Shevchenko <andy@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Juergen Gross <jgross@suse.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515120549.2820541-29-mingo@kernel.org>
References: <20250515120549.2820541-29-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176570143890.498.8541833963329762060.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     0d9daff41418cbc762e4b6ec683e0a5ec4cdb5f3
Gitweb:        https://git.kernel.org/tip/0d9daff41418cbc762e4b6ec683e0a5ec4c=
db5f3
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 14:05:44 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:19:42 +01:00

x86/boot/e820: Make sure e820_search_gap() finds all gaps

The current implementation of e820_search_gap() searches gaps
in a reverse search from MAX_GAP_END back to 0, contrary to
what its main comment claims:

    * Search for a gap in the E820 memory space from 0 to MAX_GAP_END (4GB).

But gaps can not only be beyond E820 RAM ranges, they can be below
them as well. For example this function will not find the proper
PCI gap for simplified memory map layouts that have a single RAM
range that crosses the 4GB boundary.

Rework the function to have a proper forward search of
E820 table entries.

This makes the code somewhat bigger:

   text       data        bss        dec        hex    filename
   7613      44072          0      51685       c9e5    e820.o.before
   7645      44072          0      51717       ca05    e820.o.after

but it now both implements what it claims to do, and is more
straightforward to read.

( This also allows 'idx' to be the regular u32 again, not an 'int'
  underflowing to -1. )

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
Link: https://patch.msgid.link/20250515120549.2820541-29-mingo@kernel.org
---
 arch/x86/kernel/e820.c | 59 ++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index c4b9a24..d1b1786 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -624,30 +624,52 @@ __init static void e820__update_table_kexec(void)
  */
 __init static int e820_search_gap(unsigned long *max_gap_start, unsigned lon=
g *max_gap_size)
 {
-	u64 last =3D MAX_GAP_END;
-	int idx =3D e820_table->nr_entries;
+	struct e820_entry *entry;
+	u64 range_end_prev =3D 0;
 	int found =3D 0;
+	u32 idx;
=20
-	while (--idx >=3D 0) {
-		u64 start =3D e820_table->entries[idx].addr;
-		u64 end =3D start + e820_table->entries[idx].size;
+	for (idx =3D 0; idx < e820_table->nr_entries; idx++) {
+		u64 range_start, range_end;
=20
-		/*
-		 * Since "last" is at most 4GB, we know we'll
-		 * fit in 32 bits if this condition is true:
-		 */
-		if (last > end) {
-			unsigned long gap =3D last - end;
+		entry =3D e820_table->entries + idx;
+		range_start =3D entry->addr;
+		range_end   =3D entry->addr + entry->size;
=20
-			if (gap > *max_gap_size) {
-				*max_gap_size =3D gap;
-				*max_gap_start =3D end;
-				found =3D 1;
+		/* Process any gap before this entry: */
+		if (range_start > range_end_prev) {
+			u64 gap_start =3D range_end_prev;
+			u64 gap_end =3D range_start;
+			u64 gap_size;
+
+			if (gap_start < MAX_GAP_END) {
+				/* Make sure the entirety of the gap is below MAX_GAP_END: */
+				gap_end =3D min(gap_end, MAX_GAP_END);
+				gap_size =3D gap_end-gap_start;
+
+				if (gap_size >=3D *max_gap_size) {
+					*max_gap_start =3D gap_start;
+					*max_gap_size =3D gap_size;
+					found =3D 1;
+				}
 			}
 		}
-		if (start < last)
-			last =3D start;
+
+		range_end_prev =3D range_end;
+	}
+
+	/* Is there a usable gap beyond the last entry: */
+	if (entry->addr + entry->size < MAX_GAP_END) {
+		u64 gap_start =3D entry->addr + entry->size;
+		u64 gap_size =3D MAX_GAP_END-gap_start;
+
+		if (gap_size >=3D *max_gap_size) {
+			*max_gap_start =3D gap_start;
+			*max_gap_size =3D gap_size;
+			found =3D 1;
+		}
 	}
+
 	return found;
 }
=20
@@ -664,6 +686,7 @@ __init void e820__setup_pci_gap(void)
 	unsigned long max_gap_start, max_gap_size;
 	int found;
=20
+	/* The minimum eligible gap size is 4MB: */
 	max_gap_size =3D SZ_4M;
 	found  =3D e820_search_gap(&max_gap_start, &max_gap_size);
=20
@@ -683,7 +706,7 @@ __init void e820__setup_pci_gap(void)
 	pci_mem_start =3D max_gap_start;
=20
 	pr_info("[gap %#010lx-%#010lx] available for PCI devices\n",
-		max_gap_start, max_gap_start + max_gap_size - 1);
+		max_gap_start, max_gap_start + max_gap_size-1);
 }
=20
 /*

