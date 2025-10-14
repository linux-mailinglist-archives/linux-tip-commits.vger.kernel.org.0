Return-Path: <linux-tip-commits+bounces-6799-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D4890BD9198
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 13:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7FC8C346C20
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 11:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BD731065B;
	Tue, 14 Oct 2025 11:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fXRh4J4l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qk0f7osF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36395310654;
	Tue, 14 Oct 2025 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760442480; cv=none; b=X1R69KRWtRmV4zkhh3tMQToNW5HMZnl+X1SM/MvluytzAhGAEOzKF8eRu9C00c9Goo+LysSfJX7BcqJ04fk7Rdax7QqcOAdxjEeoHvrdt4vjEutyytU8HoPcB5CSz0PqS5oQTImWjSne2Akds8qWr+3UtdlagRs1r/VsQEi1dPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760442480; c=relaxed/simple;
	bh=Bw1AobTvJCR434879lNXNUD8reAUP9dp8K6ahFAgchE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XIF0NzmekDgH13pJ6WVz2WF1Gexv2hXTeGGjDYGyr6iDqDNQMhVM+PTa2hFd20cAOASJJ5EPBsSkkuPZTiU8CwOFEg62yQzzGkXqbJuU2MFUTsXb1hyCac+R32NNhkQ9pnO3lkDpEP4JRkVG96anYilc3SW5X7u2tXIZ986JduM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fXRh4J4l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qk0f7osF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 Oct 2025 11:47:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760442477;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNYsaYHiBtNN32gFcc8EIZPzetr0z8geZh0L4yKQsZM=;
	b=fXRh4J4lq7Sr/VdiDpBYfF5C5MpJ96Tb0vxL9F/DVTyv/NTy6qmnFG32EYGH3visLXjv3C
	TRjpldKpe9QWjoxzPKPqa59ytfRrIx/bERkqxPmLehbKOug5MEgzIcBi69iDeEyqBd11+o
	+0EV6dWPeUlTRO/aUFv7Lj03iCMluWt7+0VODICfCH/VFzdqF8lbqJhGS6m/cD3JISa4l6
	zlAWReKn9pj84AJR+DpXgi+udbdGnUsHjOaNJ0B9vAj6uITvyzEK2bI8efx6ryCY9ao/DD
	NztiyiDXpmKFyvA+807uygnPVwPVJ+laVRqKlydD2qdhw4LNzJU/iMxK7yF6QQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760442477;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNYsaYHiBtNN32gFcc8EIZPzetr0z8geZh0L4yKQsZM=;
	b=Qk0f7osFnIm/4HTKOmGU5kEho00Au/lgxAaq+OocNDCOQjTjFA6NkNAZoHgJAY/Mw0QSWw
	VjS6xhKjGxR8rpDg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool/x86: Fix NOP decode
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250924134644.154610650@infradead.org>
References: <20250924134644.154610650@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176044247632.709179.2414903530940509412.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     044f721ccd33103349eebbb960825584bc6d8e23
Gitweb:        https://git.kernel.org/tip/044f721ccd33103349eebbb960825584bc6=
d8e23
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 24 Sep 2025 15:27:03 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 14 Oct 2025 13:43:11 +02:00

objtool/x86: Fix NOP decode

For x86_64 the kernel consistently uses 2 instructions for all NOPs:

  90       - NOP
  0f 1f /0 - NOPL

Notably:

 - REP NOP is PAUSE, not a NOP instruction.

 - 0f {0c...0f} is reserved space,
   except for 0f 0d /1, which is PREFETCHW, not a NOP.

 - 0f {19,1c...1f} is reserved space,
   except for 0f 1f /0, which is NOPL.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index ef6e96d..204e2ad 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -494,6 +494,12 @@ int arch_decode_instruction(struct objtool_file *file, c=
onst struct section *sec
 		break;
=20
 	case 0x90:
+		if (rex_b) /* XCHG %r8, %rax */
+			break;
+
+		if (prefix =3D=3D 0xf3) /* REP NOP :=3D PAUSE */
+			break;
+
 		insn->type =3D INSN_NOP;
 		break;
=20
@@ -547,13 +553,14 @@ int arch_decode_instruction(struct objtool_file *file, =
const struct section *sec
=20
 		} else if (op2 =3D=3D 0x0b || op2 =3D=3D 0xb9) {
=20
-			/* ud2 */
+			/* ud2, ud1 */
 			insn->type =3D INSN_BUG;
=20
-		} else if (op2 =3D=3D 0x0d || op2 =3D=3D 0x1f) {
+		} else if (op2 =3D=3D 0x1f) {
=20
-			/* nopl/nopw */
-			insn->type =3D INSN_NOP;
+			/* 0f 1f /0 :=3D NOPL */
+			if (modrm_reg =3D=3D 0)
+				insn->type =3D INSN_NOP;
=20
 		} else if (op2 =3D=3D 0x1e) {
=20

