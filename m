Return-Path: <linux-tip-commits+bounces-4813-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA67A830A4
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 21:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97344446126
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 19:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68A31F873E;
	Wed,  9 Apr 2025 19:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pwt49ETQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J91YZJ58"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3815C1E32D6;
	Wed,  9 Apr 2025 19:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744227605; cv=none; b=tXX3uUWE3hXiudubGMxz1AOVGvSbR5nKV8A5uodmahbTpY4YFTfGAC+3aRumudslgZbGm0dzCzqKyykvqLz1OCK5xN8LaezuBqqAZgvlS/EYxReSsGKPmJWOZp+FMTquzDjkIy4NbCbFx6/UgPmCA5OW1SD0+PsWydie+x8gUwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744227605; c=relaxed/simple;
	bh=wWyn7Un2q2ZXFZxYSx9qslch1cenjDqMHq3kHPEpqrk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=IH9H8unfIoDGtPmaLFFgyDDkr7pHuERmM22/NsLNVjIObAAtgvRmgjpmNt3CL8r6s9Orkl5ALaQpHZcYJfOS32649ogvS0COovfmNxytRgu5dF6A+tGKYiaB02oVTQhsNvDqgvb6XEEl7v/QGRIRdt7mQlX9V505fcEBSmjmGkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pwt49ETQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J91YZJ58; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 19:39:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744227602;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=QiNGNp24K2530Gr7je4syP1cBYRnEr/nj2jPBvFEJuM=;
	b=pwt49ETQBEVhMQL4L95MJZowGgqan3OK1EFW0vfOV66+N0R3al6W1IE5v+0ytCQcx3K8Dn
	bKgHNdThW85M9PgUU9UVxvUWhmUibSq20ZCZHU74GOSCk5PBY/JbiadRMgw4y63Er7Vo/D
	VF1UU5UhUa1bIm0QyKQxYfkmRmqvFS3MRTE42PSdSvCRHHXvhcHEVezXhTisKcRuaMnsZH
	HNcB+FQiZHEYNiYt0YE74VaUBxVKmu0mrlmwXOJAK2zMoYfgpRkqJBrOoTP97/w1C5ImGf
	X7UPpKIE7xULdRVZ2YN+50V47iQzSb1EtXlnDAwHbi0DaO2wun1w6uWnWVKmiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744227602;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=QiNGNp24K2530Gr7je4syP1cBYRnEr/nj2jPBvFEJuM=;
	b=J91YZJ58/aHX0GAxsxemfV8gHXrmn+Ff6oPyMOuetY+aC44G8b+vklwtBqMJuJi6cSG//E
	atpX4T/a/ArD9WDg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/ibt: Fix hibernate
Cc: Todd Brandt <todd.e.brandt@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Len Brown <len.brown@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174422759734.31282.1269344857115522289.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     1fac13956e9877483ece9d090a62239cdfe9deb7
Gitweb:        https://git.kernel.org/tip/1fac13956e9877483ece9d090a62239cdfe9deb7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 09 Apr 2025 21:16:01 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Apr 2025 21:29:11 +02:00

x86/ibt: Fix hibernate

Todd reported, and Len confirmed, that commit 582077c94052 ("x86/cfi:
Clean up linkage") broke S4 hiberate on a fair number of machines.

Turns out these machines trip #CP when trying to restore the image.

As it happens, the commit in question removes two ENDBR instructions
in the hibernate code, and clearly got it wrong.

Notably restore_image() does an indirect jump to
relocated_restore_code(), which is a relocated copy of
core_restore_code().

In turn, core_restore_code(), will at the end do an indirect jump to
restore_jump_address (r8), which is pointing at a relocated
restore_registers().

So both sites do indeed need to be ENDBR.

Fixes: 582077c94052 ("x86/cfi: Clean up linkage")
Reported-by: Todd Brandt <todd.e.brandt@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Todd Brandt <todd.e.brandt@intel.com>
Tested-by: Len Brown <len.brown@intel.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219998
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219998
---
 arch/x86/power/hibernate_asm_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index 8c534c3..66f066b 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -26,7 +26,7 @@
 	 /* code below belongs to the image kernel */
 	.align PAGE_SIZE
 SYM_FUNC_START(restore_registers)
-	ANNOTATE_NOENDBR
+	ENDBR
 	/* go back to the original page tables */
 	movq    %r9, %cr3
 
@@ -120,7 +120,7 @@ SYM_FUNC_END(restore_image)
 
 	/* code below has been relocated to a safe page */
 SYM_FUNC_START(core_restore_code)
-	ANNOTATE_NOENDBR
+	ENDBR
 	/* switch to temporary page tables */
 	movq	%rax, %cr3
 	/* flush TLB */

