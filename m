Return-Path: <linux-tip-commits+bounces-4115-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC0EA5A411
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 20:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D359174A8E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 19:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1511DB131;
	Mon, 10 Mar 2025 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p+BNloam";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8QUz/za3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601F61D54EE;
	Mon, 10 Mar 2025 19:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636257; cv=none; b=UTkqCxDE/cMelGhOB/6XtA8u5oEhQsLSaaNx3vS5Y8VDZHI3SUZgsYUr+dbgepfzmdVW1Q69wx3gWnQ+/KvuE9TkamoC5xM8dI5SlNcqjjzHABOnz7MMOYD2mbKbT2zmv7Cyf65pzL1jlHYoPCJf3cuT42x4Td21kVYHvsL2vVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636257; c=relaxed/simple;
	bh=xHN0UbuA0tIcZDKvLAF8iGoi6ebfyK8WerbrYNdd1Ao=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nR+miIurCsIMnTJwjvRRc/19vcTNTRHfwht7VAr/r2f+SbOrOAoc7akqvgY/c8b9WHwWGu7DJyqS45UqYAEBpMdhRIoEmW0ra5nzRXlGF1j+sHYnWulctR4gx8u8J40PNGnh9DOnpG64RZ/+n3DO2MIc0071gFV+UAq3ccH4LFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p+BNloam; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8QUz/za3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Mar 2025 19:50:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741636254;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K0eb2fSg2ZeOBhyU7VgKL9DK54tLusDMmyQB+LWNDd8=;
	b=p+BNloamopM2EyZN8pXnKkcmDThhuio22jCwLU2ED46v+NOvgKVBC4r+hul7jlg7fwD7W+
	u93LwvPRn7k79pSLTKCI+53GoJHLArsEkWzrVfbkISDvTEdPLA3uyAPwradseJMHN71yce
	KaqA7m39breG7OVDfUCMcZClppTo8ECvzOfMn8Q9Rrb9lXaYEAsuR0RrGl3gMUfXcXqrkl
	O8ensICD1UsHQz8cCAYk3KnEJ+DfxURyNueOg4ITzZ2HutLkLRHz92qlWCEBTqQ9aiPgpG
	kYwyoWIWGb9Zb1lDSuI3mns/eJ5gbDfJFsSYyo/cSYxH6r+1kL72XKQb8H53Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741636254;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K0eb2fSg2ZeOBhyU7VgKL9DK54tLusDMmyQB+LWNDd8=;
	b=8QUz/za3locwmP6gmEBUV2LA7SfNkLWFhg7Vy8uHboq18WdnJcqTDkjaiUy27i94QXr6qW
	xLsamtkeEo6yEuAw==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/ident_map: Fix theoretical virtual address
 overflow to zero
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Kai Huang <kai.huang@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Andy Lutomirski <luto@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241016111458.846228-2-kirill.shutemov@linux.intel.com>
References: <20241016111458.846228-2-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174163625266.14745.15936824915490067574.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     4f10ec03fe1ed12479134be33ddf006382744651
Gitweb:        https://git.kernel.org/tip/4f10ec03fe1ed12479134be33ddf006382744651
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 16 Oct 2024 14:14:55 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 10 Mar 2025 20:31:30 +01:00

x86/mm/ident_map: Fix theoretical virtual address overflow to zero

The current calculation of the 'next' virtual address in the
page table initialization functions in arch/x86/mm/ident_map.c
doesn't protect against wrapping to zero.

This is a theoretical issue that cannot happen currently,
the problematic case is possible only if the user sets a
high enough x86_mapping_info::offset value - which no
current code in the upstream kernel does.

( The wrapping to zero only occurs if the top PGD entry is accessed.
  There are no such users upstream. Only hibernate_64.c uses
  x86_mapping_info::offset, and it operates on the direct mapping
  range, which is not the top PGD entry. )

Should such an overflow happen, it can result in page table
corruption and a hang.

To future-proof this code, replace the manual 'next' calculation
with p?d_addr_end() which handles wrapping correctly.

[ Backporter's note: there's no need to backport this patch. ]

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20241016111458.846228-2-kirill.shutemov@linux.intel.com
---
 arch/x86/mm/ident_map.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index 5ab7bd2..bd5d101 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -101,9 +101,7 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
 		pmd_t *pmd;
 		bool use_gbpage;
 
-		next = (addr & PUD_MASK) + PUD_SIZE;
-		if (next > end)
-			next = end;
+		next = pud_addr_end(addr, end);
 
 		/* if this is already a gbpage, this portion is already mapped */
 		if (pud_leaf(*pud))
@@ -154,10 +152,7 @@ static int ident_p4d_init(struct x86_mapping_info *info, p4d_t *p4d_page,
 		p4d_t *p4d = p4d_page + p4d_index(addr);
 		pud_t *pud;
 
-		next = (addr & P4D_MASK) + P4D_SIZE;
-		if (next > end)
-			next = end;
-
+		next = p4d_addr_end(addr, end);
 		if (p4d_present(*p4d)) {
 			pud = pud_offset(p4d, 0);
 			result = ident_pud_init(info, pud, addr, next);
@@ -199,10 +194,7 @@ int kernel_ident_mapping_init(struct x86_mapping_info *info, pgd_t *pgd_page,
 		pgd_t *pgd = pgd_page + pgd_index(addr);
 		p4d_t *p4d;
 
-		next = (addr & PGDIR_MASK) + PGDIR_SIZE;
-		if (next > end)
-			next = end;
-
+		next = pgd_addr_end(addr, end);
 		if (pgd_present(*pgd)) {
 			p4d = p4d_offset(pgd, 0);
 			result = ident_p4d_init(info, p4d, addr, next);

