Return-Path: <linux-tip-commits+bounces-6794-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48885BD83E0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 10:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B53504FC12D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 08:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576BC30FF1C;
	Tue, 14 Oct 2025 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ywiHOtKU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rQMgxQPO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7749330FF1E;
	Tue, 14 Oct 2025 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431359; cv=none; b=uzzHsAlKaFywilT5TkhJFMOugPhPYmenMAYi/0Uw5LZbpTL6PsXyASqFOyDmqIFAy1f96ulBT/bG35m0+qJANJtQJB6jn+/vTBm8HNIs7nC1M49kYJ5Xo2fw+fWoIasG8lQu5YToGkh73pYoqzFq2+l3/dUDy1Ftct+Jh1tpq5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431359; c=relaxed/simple;
	bh=ofetTIjST2/q5MFo4UTNlzlcM2AqB0N5fPsUCqIFq7k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GHDAkbwCVB2KwBvHY5Ax8YX2G7B0HKJ6G6Pfs/SWy189YxQ3664cfmKrKaOi8OTyPFdQSB7bsR+tu12vD32v0emHLwNDcKw/PHBO+RJQKb5LYWiZmyYKIBRHCo4XlLjgxkQd6ty5Ntsdak5IPKaimJjVrI/8VjgN6whHCTjvUOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ywiHOtKU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rQMgxQPO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 Oct 2025 08:42:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760431355;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vRPd44Y/gynMcsUwSZsbFrZufYssZc3UEU1c5oBj26c=;
	b=ywiHOtKUeb97oLPnqJ2J3OY0p+I+08Gk3ZizlTZFOYq30Aw2mVVx9Aw8GoIE0FJB5XkFAB
	MbbfYwZmR/8ThPnkGvbEI/newBq8Zv0JNCk4EImNINP95X0Ro8XiC8A2gyuDY5BmOWJQy5
	+v3zllKTLi9ET8fswfPS+J0YdOZr0FbsLyY7yiadZ1EQPVoxOAQBLpw+dxwJsaq/7oDTff
	uJe1S7YOfoNnoE9aS3orJinTQLz6aPulK3Mu6oO3zbv6NhWYGWtaodHZCspZCMmBvx33R1
	Yls1H4g/ZAsCnw4/wmrhY//Lxa0IHuPaSb29yC2dV6xO6NlhK1BTH592fvp4DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760431355;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vRPd44Y/gynMcsUwSZsbFrZufYssZc3UEU1c5oBj26c=;
	b=rQMgxQPO9pbYjQ1/x0UjE8bfdy1CXQhEJek66rlaOeJ3o939OET7doGEs8RvZJ/eJFklEP
	KHFM9zj4W8zpZ1DA==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/alternative: Patch a single alternative location
 only once
Cc: Juergen Gross <jgross@suse.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250929112947.27267-4-jgross@suse.com>
References: <20250929112947.27267-4-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176043135449.709179.18067035380831847643.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     a17e1039874831c49d3c15d699a65a8f8130dbb5
Gitweb:        https://git.kernel.org/tip/a17e1039874831c49d3c15d699a65a8f813=
0dbb5
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 29 Sep 2025 13:29:47 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 14 Oct 2025 10:38:11 +02:00

x86/alternative: Patch a single alternative location only once

Instead of patching a single location potentially multiple times in
case of nested ALTERNATIVE()s, do the patching only after having
evaluated all alt_instr instances for that location.

This has multiple advantages:

- In case of replacing an indirect with a direct call using the
  ALT_FLAG_DIRECT_CALL flag, there is no longer the need to have that
  instance before any other instances at the same location (the
  original instruction is needed for finding the target of the direct
  call).

- In case of nested ALTERNATIVE()s there is no intermediate replacement
  visible. This avoids any problems in case e.g. an interrupt is
  happening between the single instances and the patched location is
  used during handling the interrupt.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index d86a012..90c0d16 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -648,6 +648,8 @@ void __init_or_module noinline apply_alternatives(struct =
alt_instr *start,
 	u8 insn_buff[MAX_PATCH_LEN];
 	u8 *instr;
 	struct alt_instr *a, *b;
+	unsigned int instances =3D 0;
+	bool patched =3D false;
=20
 	DPRINTK(ALT, "alt table %px, -> %px", start, end);
=20
@@ -677,9 +679,13 @@ void __init_or_module noinline apply_alternatives(struct=
 alt_instr *start,
 		 * padding for all alt_instr entries for this site (nested
 		 * alternatives result in consecutive entries).
 		 */
-		for (b =3D a+1; b < end && instr_va(b) =3D=3D instr_va(a); b++) {
-			u8 len =3D max(a->instrlen, b->instrlen);
-			a->instrlen =3D b->instrlen =3D len;
+		if (!instances) {
+			for (b =3D a+1; b < end && instr_va(b) =3D=3D instr_va(a); b++) {
+				u8 len =3D max(a->instrlen, b->instrlen);
+				a->instrlen =3D b->instrlen =3D len;
+			}
+			instances =3D b - a;
+			patched =3D false;
 		}
=20
 		instr =3D instr_va(a);
@@ -692,14 +698,19 @@ void __init_or_module noinline apply_alternatives(struc=
t alt_instr *start,
 		 * - feature not present but ALT_FLAG_NOT is set to mean,
 		 *   patch if feature is *NOT* present.
 		 */
-		if (!boot_cpu_has(a->cpuid) =3D=3D !(a->flags & ALT_FLAG_NOT)) {
-			memcpy(insn_buff, instr, a->instrlen);
-			optimize_nops(instr, insn_buff, a->instrlen);
-		} else {
+		if (!boot_cpu_has(a->cpuid) !=3D !(a->flags & ALT_FLAG_NOT)) {
 			apply_one_alternative(instr, insn_buff, a);
+			patched =3D true;
 		}
=20
-		text_poke_early(instr, insn_buff, a->instrlen);
+		instances--;
+		if (!instances) {
+			if (!patched) {
+				memcpy(insn_buff, instr, a->instrlen);
+				optimize_nops(instr, insn_buff, a->instrlen);
+			}
+			text_poke_early(instr, insn_buff, a->instrlen);
+		}
 	}
=20
 	kasan_enable_current();

