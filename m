Return-Path: <linux-tip-commits+bounces-7318-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEA1C51F43
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Nov 2025 12:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E22423227
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Nov 2025 11:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766F630E0E6;
	Wed, 12 Nov 2025 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cZIv75tI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OtagGiSx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52B130E858;
	Wed, 12 Nov 2025 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946292; cv=none; b=HbJx+7kR9Ns7zvTiraonrCTr9t9j66kb8TTgYHua/gycYgAugga06rsi+c6p8Z3TLc3tXymF+PWtYwtBCsJ1+tEkHZ091o4qA/Vp556TnMfGp569/dQahEBh1XXwC/hYicjAKbAPwDTWgjH/Eb0hJ3BgV726zmX+mFZ7ThR8Nxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946292; c=relaxed/simple;
	bh=N3twta/GvhdZd6R5RQ3izwdunJLlNncZUeYLWCvXXQ0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DSeQs/t4NzGX86C3kVxMl7oKI/qhlp8Oy6qsCyMVeDUGUn8C6Ah7tskkfHSoQt0JcvLbQsJUgSkLiqFrUzb+XrPRIVfipG70nG23UEqFo1aEsRGGFhNQaaWfstTCSPxYYOZAnI52FGl4F7RvG95mTVfG1GgTLz4k9CLxVB6Tfcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cZIv75tI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OtagGiSx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Nov 2025 11:18:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762946284;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1H2O0JXBs4PIySf3+27Q4mgB+a2lweoP5+TCny5JjQo=;
	b=cZIv75tIyRvLJd6AEYnT99ngYHiewvMAZd9uRyCXHgtRZ5vo1wsNXShnjCCOrGLu23j7kp
	6KQRSEd2dQwgrXtR7GZxMakVih25c/RJBEnKtBkPI1MIpKhP4/+4V786hzCThfgjOYPkI0
	imyFhcXR1KLMUBo70Cu6jaWpXkmncFOTzwJbZ8ZS/oXlqzvyJk78cy/1xWbFsjqw8wWNJb
	TUvSNG7wXogftN1T647w8OA0tOePk9Rl14Vb126KS0RcOfLk4GlM0klUk3uqVwZTXceKa1
	DRDviQc9uU32bp61mAmiX8W6I3v8bD3y5SiLOwQFOE8Fq4nttVqMKfGMZDbEgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762946284;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1H2O0JXBs4PIySf3+27Q4mgB+a2lweoP5+TCny5JjQo=;
	b=OtagGiSxaJK8xybZhnFk7vvjgP6tzNFOmZZLwfJfAHBmVqjeiknOmxQvcQQPzUmgiX6JMq
	WzoGbhhuZWzOC9CQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Fix and clean up
 intel_pmu_drain_arch_pebs() type use
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251029102136.61364-10-dapeng1.mi@linux.intel.com>
References: <20251029102136.61364-10-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176294628290.498.15919466706254364220.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9929dffce5ed7e2988e0274f4db98035508b16d9
Gitweb:        https://git.kernel.org/tip/9929dffce5ed7e2988e0274f4db98035508=
b16d9
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 12 Nov 2025 10:40:26 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 Nov 2025 12:12:28 +01:00

perf/x86/intel: Fix and clean up intel_pmu_drain_arch_pebs() type use

The following commit introduced a build failure on x86-32:

  21954c8a0ff ("perf/x86/intel: Process arch-PEBS records or record fragments=
")

  ...

  arch/x86/events/intel/ds.c:2983:24: error: cast from pointer to integer of =
different size [-Werror=3Dpointer-to-int-cast]

The forced type conversion to 'u64' and 'void *' are not 32-bit clean,
but they are also entirely unnecessary: ->pebs_vaddr is 'void *' already,
and integer-compatible pointer arithmetics will work just fine on it.

Fix & simplify the code.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: d21954c8a0ff ("perf/x86/intel: Process arch-PEBS records or record fra=
gments")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Link: https://patch.msgid.link/20251029102136.61364-10-dapeng1.mi@linux.intel=
.com
---
 arch/x86/events/intel/ds.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index c93bf97..2e170f2 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2979,8 +2979,7 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *i=
regs,
 	}
=20
 	base =3D cpuc->pebs_vaddr;
-	top =3D (void *)((u64)cpuc->pebs_vaddr +
-		       (index.wr << ARCH_PEBS_INDEX_WR_SHIFT));
+	top =3D cpuc->pebs_vaddr + (index.wr << ARCH_PEBS_INDEX_WR_SHIFT);
=20
 	index.wr =3D 0;
 	index.full =3D 0;

