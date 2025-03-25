Return-Path: <linux-tip-commits+bounces-4527-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A1BA6EDCB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 11:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38AEA3B1B35
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253FA256C7A;
	Tue, 25 Mar 2025 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xPz0hPnG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H+db9PsC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56592256C67;
	Tue, 25 Mar 2025 10:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898525; cv=none; b=H/1ZzpWBTMmr/DRzKuiygAJwgCbMtiQ1N9yMVzHsMtUfOwPiLz9AnZt1j+Xty8vJr72l/TQqHNSDDnukHYMl6RsWOKgxcbNtRnVUaoWBQwhVqsKhwWTkIe5syE8e1Rd3rxzx7JEU46W4fQRSHinMnLdJOHLdpJa+2rIlt7Zx+0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898525; c=relaxed/simple;
	bh=1oAZnWbMSlWwxqLWkfTXuFO9OrpnuuYTGvnFMiHwGhs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JaPacO//QIfrh25bS7oVzLrdGOgo7h2HOlRlTiJGS/kebI+4cD+b2GYIvph/aMt/WQhSH/3dtICxfpLJwkMXrs24LLcMBjw9L9nOfV0FUDMmkAMACmrVWiYNWxFAuSsoz1tBnfzs9agB+/dJYkgJuNgqHfm0q872H3ZrjveyT68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xPz0hPnG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H+db9PsC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 10:28:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742898521;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+70YDwchcNFsovZhzamRsBZiwxVQ/urJZVAc80a9z+Q=;
	b=xPz0hPnGfcrH4EUkemAH+o/4wyhBbqhpZlDAC2EBNo+0fEhCztsBIVvkZZLE9vWGyw/6qc
	bFGDlWFLkomFPbOyWNTpaXwh4jwgb2MWriJrAY4qbc1AHuosuIRzd+isYsla2NyKk/ojX2
	nqzL+XXjpxoDCehdTlrIfJ6TPzuQmWy5qPXwotkWeg5QKlohdiKMX98AGUH5DuY8lDCuU9
	Yc2Xi56YbXvEc7fKMcsdCZsZPEXbxSzC1pYPSEKZPYXrSHFm51b53CH6MztskYjJzvTfMK
	+RTgdesirYPiI9EWkMkqgptybhnd5LrLYMGyTgfJDrKAcq4o3zQMZtm5wGkjcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742898521;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+70YDwchcNFsovZhzamRsBZiwxVQ/urJZVAc80a9z+Q=;
	b=H+db9PsCTLn0NpJ9ZXgmePO9ARzVfgDMkTktt/MNDdigAUuCbJb34Z4zLnBu3LzLOA96oV
	YvBvXMVp37DT4KCQ==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/fpu] x86/fpu/xstate: Adjust xstate copying logic for user ABI
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250320234301.8342-5-chang.seok.bae@intel.com>
References: <20250320234301.8342-5-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289851964.14745.4055652915728849217.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     ed91ad084ef9fa49f6c6dfef2cb10c12ce3786a6
Gitweb:        https://git.kernel.org/tip/ed91ad084ef9fa49f6c6dfef2cb10c12ce3=
786a6
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Thu, 20 Mar 2025 16:42:55 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 11:21:20 +01:00

x86/fpu/xstate: Adjust xstate copying logic for user ABI

=3D=3D Background =3D=3D

As feature positions in the userspace XSAVE buffer do not always align
with their feature numbers, the XSAVE format conversion needs to be
reconsidered to align with the revised xstate size calculation logic.

* For signal handling, XSAVE and XRSTOR are used directly to save and
  restore extended registers.

* For ptrace, KVM, and signal returns (for 32-bit frame), the kernel
  copies data between its internal buffer and the userspace XSAVE buffer.
  If memcpy() were used for these cases, existing offset helpers =E2=80=94 su=
ch
  as __raw_xsave_addr() or xstate_offsets[] =E2=80=94 would be sufficient to
  handle the format conversion.

=3D=3D Problem =3D=3D

When copying data from the compacted in-kernel buffer to the
non-compacted userspace buffer, the function follows the
user_regset_get2_fn() prototype. This means it utilizes struct membuf
helpers for the destination buffer. As defined in regset.h, these helpers
update the memory pointer during the copy process, enforcing sequential
writes within the loop.

Since xstate components are processed sequentially, any component whose
buffer position does not align with its feature number has an issue.

=3D=3D Solution =3D=3D

Replace for_each_extended_xfeature() with the newly introduced
for_each_extended_xfeature_in_order(). This macro ensures xstate
components are handled in the correct order based on their actual
positions in the destination buffer, rather than their feature numbers.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20250320234301.8342-5-chang.seok.bae@intel.com
---
 arch/x86/kernel/fpu/xstate.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 93f9401..46c45e2 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1107,10 +1107,9 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struc=
t fpstate *fpstate,
 	const unsigned int off_mxcsr =3D offsetof(struct fxregs_state, mxcsr);
 	struct xregs_state *xinit =3D &init_fpstate.regs.xsave;
 	struct xregs_state *xsave =3D &fpstate->regs.xsave;
+	unsigned int zerofrom, i, xfeature;
 	struct xstate_header header;
-	unsigned int zerofrom;
 	u64 mask;
-	int i;
=20
 	memset(&header, 0, sizeof(header));
 	header.xfeatures =3D xsave->header.xfeatures;
@@ -1179,15 +1178,16 @@ void __copy_xstate_to_uabi_buf(struct membuf to, stru=
ct fpstate *fpstate,
 	 */
 	mask =3D header.xfeatures;
=20
-	for_each_extended_xfeature(i, mask) {
+	for_each_extended_xfeature_in_order(i, mask) {
+		xfeature =3D xfeature_uncompact_order[i];
 		/*
 		 * If there was a feature or alignment gap, zero the space
 		 * in the destination buffer.
 		 */
-		if (zerofrom < xstate_offsets[i])
-			membuf_zero(&to, xstate_offsets[i] - zerofrom);
+		if (zerofrom < xstate_offsets[xfeature])
+			membuf_zero(&to, xstate_offsets[xfeature] - zerofrom);
=20
-		if (i =3D=3D XFEATURE_PKRU) {
+		if (xfeature =3D=3D XFEATURE_PKRU) {
 			struct pkru_state pkru =3D {0};
 			/*
 			 * PKRU is not necessarily up to date in the
@@ -1197,14 +1197,14 @@ void __copy_xstate_to_uabi_buf(struct membuf to, stru=
ct fpstate *fpstate,
 			membuf_write(&to, &pkru, sizeof(pkru));
 		} else {
 			membuf_write(&to,
-				     __raw_xsave_addr(xsave, i),
-				     xstate_sizes[i]);
+				     __raw_xsave_addr(xsave, xfeature),
+				     xstate_sizes[xfeature]);
 		}
 		/*
 		 * Keep track of the last copied state in the non-compacted
 		 * target buffer for gap zeroing.
 		 */
-		zerofrom =3D xstate_offsets[i] + xstate_sizes[i];
+		zerofrom =3D xstate_offsets[xfeature] + xstate_sizes[xfeature];
 	}
=20
 out:

