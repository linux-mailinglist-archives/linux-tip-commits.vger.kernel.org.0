Return-Path: <linux-tip-commits+bounces-7975-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D28AFD1BD91
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 01:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 704373065E35
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 00:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B6A21FF4D;
	Wed, 14 Jan 2026 00:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="acAnfN3D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mQRl32/R"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D033221F0C;
	Wed, 14 Jan 2026 00:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768351505; cv=none; b=K29Ltuozg9bvnfiwltcIYZfGUuC9iHKUN/fJvNwp/pF6MAG4wA3xn025xNvHBz07GjZFQyDJpde9l9kqzGaXkrFg5m+GqeWbPW+JO7RLFHcPJFLDwxcWg0BwYvTPbwsxTw7lgqBJmCNtM7NNspCHP36ZXq+Nym+SWWJGmJxPR1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768351505; c=relaxed/simple;
	bh=rla7SnacnYVKw3LARN6Klc0Qa9b/YNDS2xYl8bEOPIc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qa0FR/MT5DI9S8JfeYKf1Bj2kwC/BL3eQQByVcOfTraLrEAYmTKYUs1vwHpSAJ4BNhzHTFO1TYbQvRzHQqbACpMv6yz97EJU3IX5Ecz4fiz9ilz8v8bst/4a/oMvmbHC438XWyifwemP9rVJCwPTjrY3FuClQ7T45UNBbryJSmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=acAnfN3D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mQRl32/R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 00:44:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768351497;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uZH6BwW+VB6QfbJ7yuz60fVXhIAhlqzPetPDJAR8jLQ=;
	b=acAnfN3DbE5crKwDI0aA9iMA+9oOqzog+t27gCcxcU6c/p1ffYgTs9o4ZTgQZNxQUTSKbe
	R5QfvOslZbGYtezlrGloTio0Exg7AwKkvRRBTFBNQ1zg5H97pZZPOIfFcwPUUnTOmiLIIz
	2LMGfbLkEp4NPVCy92+mOpcpUfe015NLxhfQuzMkh1sf4IZnPpqtqruLql7H+hHvX1o+vJ
	7VIcBqzlAJc75Kf7HVtSBajd1n2WEu5/Btmbb3p2x/1dV63uE1wQqXcOJyKWdOaNCg7lIe
	jjLOs+dUPK/czOjX/4odnhnkpc/MPKBDugKFHBWtaICzX2Lzy/LMhWkh+3YDRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768351497;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uZH6BwW+VB6QfbJ7yuz60fVXhIAhlqzPetPDJAR8jLQ=;
	b=mQRl32/RPn1CycBOEoNBdNSavGKdoFod9PDilNCptjSRVQeTlGVxt51wW4ab5kw4MpWx9p
	CzhwG3BCv70VI0Aw==
From: "tip-bot2 for H. Peter Anvin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/vdso32: Don't rely on int80_landing_pad
 for adjusting ip
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251216212606.1325678-5-hpa@zytor.com>
References: <20251216212606.1325678-5-hpa@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176835149579.510.18025799979884459481.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     6e150b71019f386a021004fafea9ef7189bc6aea
Gitweb:        https://git.kernel.org/tip/6e150b71019f386a021004fafea9ef7189b=
c6aea
Author:        H. Peter Anvin <hpa@zytor.com>
AuthorDate:    Tue, 16 Dec 2025 13:25:58 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 13 Jan 2026 16:37:58 -08:00

x86/entry/vdso32: Don't rely on int80_landing_pad for adjusting ip

There is no fundamental reason to use the int80_landing_pad symbol to
adjust ip when moving the vdso. If ip falls within the vdso, and the
vdso is moved, we should change the ip accordingly, regardless of mode
or location within the vdso. This *currently* can only happen on 32
bits, but there isn't any reason not to do so generically.

Note that if this is ever possible from a vdso-internal call, then the
user space stack will also needed to be adjusted (as well as the
shadow stack, if enabled.) Fortunately this is not currently the case.

At the moment, we don't even consider other threads when moving the
vdso. The assumption is that it is only used by process freeze/thaw
for migration, where this is not an issue.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://patch.msgid.link/20251216212606.1325678-5-hpa@zytor.com
---
 arch/x86/entry/vdso/vma.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 8f98c2d..e7fd751 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -65,16 +65,12 @@ static vm_fault_t vdso_fault(const struct vm_special_mapp=
ing *sm,
 static void vdso_fix_landing(const struct vdso_image *image,
 		struct vm_area_struct *new_vma)
 {
-	if (in_ia32_syscall() && image =3D=3D &vdso32_image) {
-		struct pt_regs *regs =3D current_pt_regs();
-		unsigned long vdso_land =3D image->sym_int80_landing_pad;
-		unsigned long old_land_addr =3D vdso_land +
-			(unsigned long)current->mm->context.vdso;
-
-		/* Fixing userspace landing - look at do_fast_syscall_32 */
-		if (regs->ip =3D=3D old_land_addr)
-			regs->ip =3D new_vma->vm_start + vdso_land;
-	}
+	struct pt_regs *regs =3D current_pt_regs();
+	unsigned long ipoffset =3D regs->ip -
+		(unsigned long)current->mm->context.vdso;
+
+	if (ipoffset < image->size)
+		regs->ip =3D new_vma->vm_start + ipoffset;
 }
=20
 static int vdso_mremap(const struct vm_special_mapping *sm,

