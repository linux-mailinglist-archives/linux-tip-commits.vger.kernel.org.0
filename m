Return-Path: <linux-tip-commits+bounces-6247-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69444B25679
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Aug 2025 00:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760381C82EFB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Aug 2025 22:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF6D2FCBEB;
	Wed, 13 Aug 2025 22:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f7rPsOib";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7SMwQFQ6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ED42FCBE7;
	Wed, 13 Aug 2025 22:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755123311; cv=none; b=A1dqvZLhjqMMh5EBSoWybf/pVl3C0x69V6cjrnaJiBx8uKGxlAPwvRBGW+mFNyFIRi6Wv5/QBGnU/oizgbEPaipNNvWQkMiJ+02y49QQbclvfOxIAWeFRqZOyasShN3CsTd/gIb5T+3lJZqmFgrMv7y5EIphAj1WZRamUjSlx6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755123311; c=relaxed/simple;
	bh=G+mmBFJESpPz0yH5bKgn2HavzjDfjgjvfOyxf574VvY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RJE2UY9sC3bl17jGjLlKW2jnj9bOW6rNoCM1Rl2OVKRy2yyGy4h/ZPzuBZuKEmi3FhiN6aG/Co6a6amu0JIVpDppMpu7IZ1UurVjfQdeUJRxsqRd/Nt4+qxbyyJK/8uaqQA2wXkA5VYBJm9EgZ5EUOlJFBIJGr6GHzSRA8nUCIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f7rPsOib; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7SMwQFQ6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Aug 2025 22:15:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755123307;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z2xFOl9pKB9fowXhN5zH36UGHK1nQkMtc1Iy7X3OFXo=;
	b=f7rPsOibTLo8uSOe1aTA30SWQ7fEty/jvDeCAUSCK5abkIMPXc6yh5dpMJRfKPhCL4aDyv
	OVTm+8JcmygjiZvwnUAZeZUnJF5Xf01tqwEDoreMRQP7oBdw8M0Fx9fSEM6SA8SzMy9miS
	mdXKxa9lR5cZQb3KYa7ro1P2xFoQx4M0KRhVlmiE85C/nzefaMp8nqQBt/3IOnXoMfY5JD
	1DCwf5YnAXxbmowoPLVrzVmFXZrZLefXHWwvAl8pD/x9lh3CsZWDczps/oWZAlDsLCmSjn
	Dgty5hbnP+k3ZmfxhiFQRqAn3yHNFnuG4U3i2ARk0IURO/31j/vwpSI2hvveBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755123307;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z2xFOl9pKB9fowXhN5zH36UGHK1nQkMtc1Iy7X3OFXo=;
	b=7SMwQFQ6OBmpFReKBMHxPAVwbpVhFdrzyXr49ybNpd4SAWtZbjDHxbxahJGCpazZOndAsg
	2FR7EZE3aLjmtfDg==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/vsyscall: Do not require X86_PF_INSTR to emulate
 vsyscall
Cc: Dave Hansen <dave.hansen@intel.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <bd81a98b-f8d4-4304-ac55-d4151a1a77ab@intel.com>
References: <bd81a98b-f8d4-4304-ac55-d4151a1a77ab@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175512330621.1420.4357100927779312673.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     8ba38a7a9a699905b84fa97578a8291010dec273
Gitweb:        https://git.kernel.org/tip/8ba38a7a9a699905b84fa97578a8291010d=
ec273
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Tue, 24 Jun 2025 17:59:18 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 13 Aug 2025 15:02:12 -07:00

x86/vsyscall: Do not require X86_PF_INSTR to emulate vsyscall

emulate_vsyscall() expects to see X86_PF_INSTR in PFEC on a vsyscall
page fault, but the CPU does not report X86_PF_INSTR if neither
X86_FEATURE_NX nor X86_FEATURE_SMEP are enabled.

X86_FEATURE_NX should be enabled on nearly all 64-bit CPUs, except for
early P4 processors that did not support this feature.

Instead of explicitly checking for X86_PF_INSTR, compare the fault
address to RIP.

On machines with X86_FEATURE_NX enabled, issue a warning if RIP is equal
to fault address but X86_PF_INSTR is absent.

[ dhansen: flesh out code comments ]

Originally-by: Dave Hansen <dave.hansen@intel.com>
Reported-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
Link: https://lore.kernel.org/all/bd81a98b-f8d4-4304-ac55-d4151a1a77ab@intel.=
com
Link: https://lore.kernel.org/all/20250624145918.2720487-1-kirill.shutemov%40=
linux.intel.com
---
 arch/x86/entry/vsyscall/vsyscall_64.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/=
vsyscall_64.c
index c9103a6..6e6c0a7 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -124,7 +124,12 @@ bool emulate_vsyscall(unsigned long error_code,
 	if ((error_code & (X86_PF_WRITE | X86_PF_USER)) !=3D X86_PF_USER)
 		return false;
=20
-	if (!(error_code & X86_PF_INSTR)) {
+	/*
+	 * Assume that faults at regs->ip are because of an
+	 * instruction fetch. Return early and avoid
+	 * emulation for faults during data accesses:
+	 */
+	if (address !=3D regs->ip) {
 		/* Failed vsyscall read */
 		if (vsyscall_mode =3D=3D EMULATE)
 			return false;
@@ -137,12 +142,18 @@ bool emulate_vsyscall(unsigned long error_code,
 	}
=20
 	/*
+	 * X86_PF_INSTR is only set when NX is supported.  When
+	 * available, use it to double-check that the emulation code
+	 * is only being used for instruction fetches:
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_NX))
+		WARN_ON_ONCE(!(error_code & X86_PF_INSTR));
+
+	/*
 	 * No point in checking CS -- the only way to get here is a user mode
 	 * trap to a high address, which means that we're in 64-bit user code.
 	 */
=20
-	WARN_ON_ONCE(address !=3D regs->ip);
-
 	if (vsyscall_mode =3D=3D NONE) {
 		warn_bad_vsyscall(KERN_INFO, regs,
 				  "vsyscall attempted with vsyscall=3Dnone");

