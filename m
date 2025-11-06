Return-Path: <linux-tip-commits+bounces-7266-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A624C3AC2E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 06 Nov 2025 13:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91CD1AA4AF9
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Nov 2025 11:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F72931B117;
	Thu,  6 Nov 2025 11:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CPGycyDK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0FhLijPs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9856631AF1D;
	Thu,  6 Nov 2025 11:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430036; cv=none; b=satT8Fkb+PLUUdjCa6YQyY249jXqqZy0JXT33sEkPb/U/jUHX17zqqlYv+ObZSqxAJaJuCacj/TEPI5GUfDRXHxqiPft1RFIermUFzIkc9UyIX/+DmNt+5ZFcqcCJ034OoDTV0Ohs3YVoiLYKZKw0lwzZYgbjY1al/GnIOs98ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430036; c=relaxed/simple;
	bh=Gg4HG0sFgsdzzYyGP/M6dLgRi4v81jH91TRhK2KCHCI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=cH4tLFE+GO8Lguwd903zhJbMkEoqtW+M7SZTTYxmjbPWdYfQfr46du5HKWDZZ2wt/KhWuTKTrMpPeOSEQz7gmIhZzSxy9NgrzVFH004pE6uQNGOTkwoJ7IJtTL/lM3G7mF8TGVFlB6jWGSNiJ7xBZRx1HnFN2FdvJvaLAA1vUSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CPGycyDK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0FhLijPs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 06 Nov 2025 11:53:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762430032;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=URIO4IvByloy+pqC09EJwrQsiBuplWh0GnaV3YfBH30=;
	b=CPGycyDK5RkAlQJSMT8jWLIWTdBfMcqUiFfxxpiVb7dPBewrX7p1avL916lQmgDKMSZSF0
	Gh8xQrlNifgdY6Xp7KN49517JwYUbqymV+B14lz9PgwFfRq4mQECVGyio8MsRaQ+9/riqQ
	vaSK89XOzKPem5Gz9GI8gSyO1vCjRjbR4WPexsUOvcQUNN3nY4oMTbBOzCqgxYtpjOFSJT
	QEWmIHELM+IqTVqb7fl7bEN3PShZwg25XSKDClU+pKHSp+4q+Bi7/yxRvWpnyU8jtzaILD
	HCQOxh3gdBVWBcsU8yBCc4XnFd5E/fnEjicx41rwKqvcHtMSy2ucZ74FWOny3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762430032;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=URIO4IvByloy+pqC09EJwrQsiBuplWh0GnaV3YfBH30=;
	b=0FhLijPsrBfLvSzRyx9X/eD0bpLUs9Kb1+qZtB3j2T/2wRekQ+t8yDgeJD9dRkM0KiocUy
	27vxXxKBMN9L/UAw==
From: "tip-bot2 for Usama Arif" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/boot: Fix page table access in 5-level to 4-level
 paging transition
Cc: Michael van der Westhuizen <rmikey@meta.com>,
 Tobias Fleig <tfleig@meta.com>, Kiryl Shutsemau <kas@kernel.org>,
 Usama Arif <usamaarif642@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Ard Biesheuvel <ardb@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176242999882.2601451.16732035937829925380.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     eb2266312507d7b757859e2227aa5c4ba6280ebe
Gitweb:        https://git.kernel.org/tip/eb2266312507d7b757859e2227aa5c4ba62=
80ebe
Author:        Usama Arif <usamaarif642@gmail.com>
AuthorDate:    Mon, 03 Nov 2025 14:09:22=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 05 Nov 2025 17:19:11 +01:00

x86/boot: Fix page table access in 5-level to 4-level paging transition

When transitioning from 5-level to 4-level paging, the existing code
incorrectly accesses page table entries by directly dereferencing CR3 and
applying PAGE_MASK. This approach has several issues:

- __native_read_cr3() returns the raw CR3 register value, which on x86_64
  includes not just the physical address but also flags. Bits above the
  physical address width of the system i.e. above __PHYSICAL_MASK_SHIFT) are
  also not masked.

- The PGD entry is masked by PAGE_SIZE which doesn't take into account the
  higher bits such as _PAGE_BIT_NOPTISHADOW.

Replace this with proper accessor functions:

- native_read_cr3_pa(): Uses CR3_ADDR_MASK to additionally mask metadata out
  of CR3 (like SME or LAM bits). All remaining bits are real address bits or
  reserved and must be 0.

- mask pgd value with PTE_PFN_MASK instead of PAGE_MASK, accounting for flags
  above bit 51 (_PAGE_BIT_NOPTISHADOW in particular). Bits below 51, but above
  the max physical address are reserved and must be 0.

Fixes: e9d0e6330eb8 ("x86/boot/compressed/64: Prepare new top-level page tabl=
e for trampoline")
Reported-by: Michael van der Westhuizen <rmikey@meta.com>
Reported-by: Tobias Fleig <tfleig@meta.com>
Co-developed-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/a482fd68-ce54-472d-8df1-33d6ac9f6bb5@intel.com
---
 arch/x86/boot/compressed/pgtable_64.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed=
/pgtable_64.c
index bdd2605..0e89e19 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -3,6 +3,7 @@
 #include <asm/bootparam.h>
 #include <asm/bootparam_utils.h>
 #include <asm/e820/types.h>
+#include <asm/pgtable.h>
 #include <asm/processor.h>
 #include "../string.h"
 #include "efi.h"
@@ -168,9 +169,10 @@ asmlinkage void configure_5level_paging(struct boot_para=
ms *bp, void *pgtable)
 		 * For 4- to 5-level paging transition, set up current CR3 as
 		 * the first and the only entry in a new top-level page table.
 		 */
-		*trampoline_32bit =3D __native_read_cr3() | _PAGE_TABLE_NOENC;
+		*trampoline_32bit =3D native_read_cr3_pa() | _PAGE_TABLE_NOENC;
 	} else {
-		unsigned long src;
+		u64 *new_cr3;
+		pgd_t *pgdp;
=20
 		/*
 		 * For 5- to 4-level paging transition, copy page table pointed
@@ -180,8 +182,9 @@ asmlinkage void configure_5level_paging(struct boot_param=
s *bp, void *pgtable)
 		 * We cannot just point to the page table from trampoline as it
 		 * may be above 4G.
 		 */
-		src =3D *(unsigned long *)__native_read_cr3() & PAGE_MASK;
-		memcpy(trampoline_32bit, (void *)src, PAGE_SIZE);
+		pgdp =3D (pgd_t *)native_read_cr3_pa();
+		new_cr3 =3D (u64 *)(native_pgd_val(pgdp[0]) & PTE_PFN_MASK);
+		memcpy(trampoline_32bit, new_cr3, PAGE_SIZE);
 	}
=20
 	toggle_la57(trampoline_32bit);

