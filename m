Return-Path: <linux-tip-commits+bounces-7672-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CC047CBB80B
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 09:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E3B293006E39
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894072D1F4E;
	Sun, 14 Dec 2025 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eBEjZ977";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3QyaLl6w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761962D2493;
	Sun, 14 Dec 2025 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765701452; cv=none; b=cQAfxfCYHWsBJRTYYGUT+xjSHuBsjgDsayHjeRDhHVGX7ioJCyNXI5OeWBEuYnxBbhK0tFup5cv6HSQwMNr6l16l7qJZBUvVSuWsRF57R7Of8/24ZvglrpXTjkpE2/NMXLmz2XDh+M+Q9boR4Cmf1+VIoI0otnlF0qkRVyC4qDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765701452; c=relaxed/simple;
	bh=kz06ONtnpqks5Y2PCCxW7ritLVIA3MvtK5EKFsOpxmY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=D2JU2jLMNWWaej2f+htSCnCzUGJ7hu/M0tW9Al0HPcQdftNncxsyaMkQHKBdsbILTW64rAa/c2qFdVjV2TffypJYXL5kJOIIMA6fsyUiYDknHYWAXqq947ldvQf7l4K/SJ7axTmPBH1Fv2h2bTOBZ3bLCrPG9NpQr+ztYi36CIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eBEjZ977; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3QyaLl6w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 08:37:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765701447;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v06FyEHy7qLMpvFMLpy0s9SKY/UZLmydFQZlc2Pu1cw=;
	b=eBEjZ977YOitz0mOAdC+vxnk+fTbVnWzXwgnlfnC0lsC2oqvZjPfWrebsbSJxe0LVZtLWc
	zXYkPOkk9aPbUbt/sVZVTbYC8dREGPHV8UqwDen1ehQORlhWrtf9QAWm3mRs3nq5AGhfR5
	UP6NC8LunuyK/FkQadgVNx6tiFAeN4/7rESaDqiRuptoKX6vShQanm34G6bN6XOPKZfG2T
	GxsKRcrSxgtWJ98KRZKkY1LZZTUubJ5M8C7nZti142JtYFST3Q6IwyAdigfBuIXElmHov7
	3FNEGJ5S+iihWB3h+9WwQX/NrQ4Dd85H1p8ItKZJsMj8UZqNAeBKLhFsLwol/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765701447;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v06FyEHy7qLMpvFMLpy0s9SKY/UZLmydFQZlc2Pu1cw=;
	b=3QyaLl6wz+5p4NOYW19zfhApsHj6GhX8a4jC+fvV1gJDgK4UDBFOH7GMVZBMu85DC/Ww1N
	ce1M9QWSN4dKoGBg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/e820: Rename gap_start/gap_size to
 max_gap_start/max_gap_start in e820_search_gap() et al
Cc: Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Shevchenko <andy@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Juergen Gross <jgross@suse.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515120549.2820541-23-mingo@kernel.org>
References: <20250515120549.2820541-23-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176570144607.498.6477109311574620020.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     95060e411ffd1be5db641d469b759912abad3332
Gitweb:        https://git.kernel.org/tip/95060e411ffd1be5db641d469b759912aba=
d3332
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 14:05:38 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:19:41 +01:00

x86/boot/e820: Rename gap_start/gap_size to max_gap_start/max_gap_start in e8=
20_search_gap() et al

The PCI gap searching functions pass around pointers to the
gap_start/gap_size variables, which refer to the maximum
size gap found so far.

Rename the variables to say so, and disambiguate their namespace
from 'current gap' variables.

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
Link: https://patch.msgid.link/20250515120549.2820541-23-mingo@kernel.org
---
 arch/x86/kernel/e820.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 3fba540..f582802 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -638,7 +638,7 @@ static void __init e820__update_table_kexec(void)
 /*
  * Search for a gap in the E820 memory space from 0 to MAX_GAP_END (4GB).
  */
-static int __init e820_search_gap(unsigned long *gap_start, unsigned long *g=
ap_size)
+static int __init e820_search_gap(unsigned long *max_gap_start, unsigned lon=
g *max_gap_size)
 {
 	u64 last =3D MAX_GAP_END;
 	int idx =3D e820_table->nr_entries;
@@ -655,9 +655,9 @@ static int __init e820_search_gap(unsigned long *gap_star=
t, unsigned long *gap_s
 		if (last > end) {
 			unsigned long gap =3D last - end;
=20
-			if (gap > *gap_size) {
-				*gap_size =3D gap;
-				*gap_start =3D end;
+			if (gap > *max_gap_size) {
+				*max_gap_size =3D gap;
+				*max_gap_start =3D end;
 				found =3D 1;
 			}
 		}
@@ -677,29 +677,29 @@ static int __init e820_search_gap(unsigned long *gap_st=
art, unsigned long *gap_s
  */
 __init void e820__setup_pci_gap(void)
 {
-	unsigned long gap_start, gap_size;
+	unsigned long max_gap_start, max_gap_size;
 	int found;
=20
-	gap_size =3D SZ_4M;
-	found  =3D e820_search_gap(&gap_start, &gap_size);
+	max_gap_size =3D SZ_4M;
+	found  =3D e820_search_gap(&max_gap_start, &max_gap_size);
=20
 	if (!found) {
 #ifdef CONFIG_X86_64
-		gap_start =3D (max_pfn << PAGE_SHIFT) + SZ_1M;
+		max_gap_start =3D (max_pfn << PAGE_SHIFT) + SZ_1M;
 		pr_err("Cannot find an available gap in the 32-bit address range\n");
 		pr_err("PCI devices with unassigned 32-bit BARs may not work!\n");
 #else
-		gap_start =3D 0x10000000;
+		max_gap_start =3D 0x10000000;
 #endif
 	}
=20
 	/*
 	 * e820__reserve_resources_late() protects stolen RAM already:
 	 */
-	pci_mem_start =3D gap_start;
+	pci_mem_start =3D max_gap_start;
=20
 	pr_info("[gap %#010lx-%#010lx] available for PCI devices\n",
-		gap_start, gap_start + gap_size - 1);
+		max_gap_start, max_gap_start + max_gap_size - 1);
 }
=20
 /*

