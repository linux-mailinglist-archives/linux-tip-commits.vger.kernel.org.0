Return-Path: <linux-tip-commits+bounces-7265-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F70C3AC1F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 06 Nov 2025 13:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982B6464F94
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Nov 2025 11:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F399D3164CD;
	Thu,  6 Nov 2025 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="19CJOv+E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KnAMtNNv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CE23161BC;
	Thu,  6 Nov 2025 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430002; cv=none; b=oVH4P5z52MUUVzvZF5G74NNbrobC6UNzrk5PpqdqYlFkLLFD+50SFtsWizPaqY+92+BnXz3tF+FzsY+bfSTes6ybtFH/wI6lxr42tejR293pxBKkSbGAv5idn5vlZsaVIZL1yJY2bpWAEfWlDgZcpQ3VkMq6VNYVZsNQKPnTvhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430002; c=relaxed/simple;
	bh=w3bCvHQibcs8861l2YRSg+GAzTVBoVsHnfTB0w5yVTQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aS4LFt5oECNNayhJ7d6N+e2IPDCnlvsHBLqpfWSEww52rKmvHcK2tT6qbkUVMacNb5qyXUO8HFQiqy3v8tkofkI4pp6Fn+3+iq/z3eSqmkML3HW292Fx+Nqkw2MgrI5XrkkoZqz4HfydM7EGCAEKSeoznbYqiL1XUbtuEyfGJWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=19CJOv+E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KnAMtNNv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 06 Nov 2025 11:53:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762429999;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IxDik6C95xiWI+dEiXhIUFzGJQwv2WTsJ0jHCTcP4v0=;
	b=19CJOv+EuIFNwVR0C2AQRXbFpXR8FJqqC4PB/NRcHmsr++2/Kip/cmQKWDQj1pA7A3bYdF
	GBr9IffAtj/el+fjByLnaTwtME/ioPrXyum3vgDIKasihRzYvNaDtmrOYhL2bvL5USLlJ0
	qjQN4wrL+iJM/pM3Lw3sUfd1cPH6fyZBIdf0ckh7IqNHFliFyHyfvVeQC1u14QgMuGKUX+
	0O80kbXvA1rIj4NijFcQ9a7Q97GgPNzUBkhlCD8M/yk2gEI66aiIl8FM2+asCrsTF/f5lJ
	EARkgeUH0WNaPw8qWr+pH6/RSys6srjBu3eYQwGIFcsYir5jRasYrXM79LSzeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762429999;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IxDik6C95xiWI+dEiXhIUFzGJQwv2WTsJ0jHCTcP4v0=;
	b=KnAMtNNv2l5j2g5Uv5w323FSD39AupjCOvzp6/xAMmbxO84LZT8Vs0mK2WQ5SehH31kWMK
	P4+njrrsQhMPGXCQ==
From: "tip-bot2 for Usama Arif" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] efi/libstub: Fix page table access in 5-level to
 4-level paging transition
Cc: Michael van der Westhuizen <rmikey@meta.com>,
 Tobias Fleig <tfleig@meta.com>, Kiryl Shutsemau <kas@kernel.org>,
 Usama Arif <usamaarif642@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251103141002.2280812-3-usamaarif642@gmail.com>
References: <20251103141002.2280812-3-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176242999709.2601451.11963512296401713746.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     84361123413efc84b06f3441c6c827b95d902732
Gitweb:        https://git.kernel.org/tip/84361123413efc84b06f3441c6c827b95d9=
02732
Author:        Usama Arif <usamaarif642@gmail.com>
AuthorDate:    Mon, 03 Nov 2025 14:09:23=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 05 Nov 2025 17:31:32 +01:00

efi/libstub: Fix page table access in 5-level to 4-level paging transition

When transitioning from 5-level to 4-level paging, the existing code
incorrectly accesses page table entries by directly dereferencing CR3 and
applying PAGE_MASK. This approach has several issues:

- __native_read_cr3() returns the raw CR3 register value, which on x86_64
  includes not just the physical address but also flags Bits above the
  physical address width of the system (i.e. above __PHYSICAL_MASK_SHIFT) are
  also not masked.

- The pgd value is masked by PAGE_SIZE which doesn't take into account the
  higher bits such as _PAGE_BIT_NOPTISHADOW.

Replace this with proper accessor functions:

- native_read_cr3_pa(): Uses CR3_ADDR_MASK to additionally mask metadata out
  of CR3 (like SME or LAM bits). All remaining bits are real address bits or
  reserved and must be 0.

- mask pgd value with PTE_PFN_MASK instead of PAGE_MASK, accounting for flags
  above bit 51 (_PAGE_BIT_NOPTISHADOW in particular). Bits below 51, but above
  the max physical address are reserved and must be 0.

Fixes: cb1c9e02b0c1 ("x86/efistub: Perform 4/5 level paging switch from the s=
tub")
Reported-by: Michael van der Westhuizen <rmikey@meta.com>
Reported-by: Tobias Fleig <tfleig@meta.com>
Co-developed-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://patch.msgid.link/20251103141002.2280812-3-usamaarif642@gmail.com
---
 drivers/firmware/efi/libstub/x86-5lvl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-5lvl.c b/drivers/firmware/efi/l=
ibstub/x86-5lvl.c
index f1c5fb4..c00d0ae 100644
--- a/drivers/firmware/efi/libstub/x86-5lvl.c
+++ b/drivers/firmware/efi/libstub/x86-5lvl.c
@@ -66,7 +66,7 @@ void efi_5level_switch(void)
 	bool have_la57 =3D native_read_cr4() & X86_CR4_LA57;
 	bool need_toggle =3D want_la57 ^ have_la57;
 	u64 *pgt =3D (void *)la57_toggle + PAGE_SIZE;
-	u64 *cr3 =3D (u64 *)__native_read_cr3();
+	pgd_t *cr3 =3D (pgd_t *)native_read_cr3_pa();
 	u64 *new_cr3;
=20
 	if (!la57_toggle || !need_toggle)
@@ -82,7 +82,7 @@ void efi_5level_switch(void)
 		new_cr3[0] =3D (u64)cr3 | _PAGE_TABLE_NOENC;
 	} else {
 		/* take the new root table pointer from the current entry #0 */
-		new_cr3 =3D (u64 *)(cr3[0] & PAGE_MASK);
+		new_cr3 =3D (u64 *)(native_pgd_val(cr3[0]) & PTE_PFN_MASK);
=20
 		/* copy the new root table if it is not 32-bit addressable */
 		if ((u64)new_cr3 > U32_MAX)

