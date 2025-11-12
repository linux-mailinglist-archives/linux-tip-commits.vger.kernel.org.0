Return-Path: <linux-tip-commits+bounces-7317-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BF6C518AB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Nov 2025 11:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D4E18840B0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Nov 2025 10:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4262FD1D5;
	Wed, 12 Nov 2025 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d3u0sQfM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zwifnjyT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4A52F7AA2;
	Wed, 12 Nov 2025 10:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762941820; cv=none; b=XiveqINWjkwG+jsuAOglIBjzxgY9C4hz6rUv6yQlKbR2CnVatQ5aEsxnrklhGqzk08JyrrzkvFflC4ociJK41oiwrB8k+f6OMp3PAMsf3YH+Gbdjk6KJsOn5bj5AhNj7kEKb54E293ZUyyecUcITvtChsd5r10bwRwmpjl6Pc88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762941820; c=relaxed/simple;
	bh=XOUCdoQhrLVYizilV8Cp38Vv+Ls33Lt7GJ10D5/dyqg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dUyaTE1SxPdBoXQzn8Iu6JtkAEWr7c/szzKAShgYFiH5hIAhVDbTe9F8qDNV0KopDpa9Pw/ou8OaImL377FsLejSMrxRh6j0Tb6A4ab0/jVg/EmZK1/WZexJUupKaanApsijdorLtnOigfcfzlvQQcP/MdcvBAi9fogCNBbDx0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d3u0sQfM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zwifnjyT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Nov 2025 10:03:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762941815;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uCJbQ7bq/tuC4dKi9Pg6nAfTerhnjCkf15iPtRwdFA0=;
	b=d3u0sQfMzS+CSkhypOrZ+N5gG41GLjof5nrOXNEeR9dzJPX5xSHqnkY6wlPu+OitWm1Rvj
	fQTUMjTilG4iIQqSZwI9/+eNdupRD16eLp3QiXbC2q2wqT5338c9Jj7XNWddodWMCroghC
	Qh2bM7dij8SK8D9QyUO5VsOdZtlM1QzXUoe8Kg0PSLuD9r+gaR1nUz9PtPtjAX/BEgs6xC
	NqzHdgo58rxQ+uOLqaOOPshudgq/h/Z0L3mrgn8FfHksL1176zo0gK+HScd/TsYFzZIGiZ
	4JPmPeg8WjU5kPdYh8Wk3Wfox1guZm5c1BQfDmAqY5GJISyFu3XdkKQPWuT8Rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762941815;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uCJbQ7bq/tuC4dKi9Pg6nAfTerhnjCkf15iPtRwdFA0=;
	b=zwifnjyTRriZoqtgDpEpFjWNx/OTXJmJlA9hlt+2zbkDitNhkMLycfEIW+yjfuMnRXQJSZ
	Sr96VFVNngk7yADQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Fix and clean up
 intel_pmu_drain_arch_pebs() type use
Cc: Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251029102136.61364-10-dapeng1.mi@linux.intel.com>
References: <20251029102136.61364-10-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176294181180.498.2561117676728192325.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     60f9f1d437201f6c457fc8a56f9df6d8a6d0bea6
Gitweb:        https://git.kernel.org/tip/60f9f1d437201f6c457fc8a56f9df6d8a6d=
0bea6
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 12 Nov 2025 10:40:26 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 Nov 2025 10:49:35 +01:00

perf/x86/intel: Fix and clean up intel_pmu_drain_arch_pebs() type use

The following commit introduced a build failure on x86-32:

  2721e8da2de7 ("perf/x86/intel: Allocate arch-PEBS buffer and initialize PEB=
S_BASE MSR")

  ...

  arch/x86/events/intel/ds.c:2983:24: error: cast from pointer to integer of =
different size [-Werror=3Dpointer-to-int-cast]

The forced type conversion to 'u64' and 'void *' are not 32-bit clean,
but they are also entirely unnecessary: ->pebs_vaddr is 'void *' already,
and integer-compatible pointer arithmetics will work just fine on it.

Fix & simplify the code.

Fixes: 2721e8da2de7 ("perf/x86/intel: Allocate arch-PEBS buffer and initializ=
e PEBS_BASE MSR")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
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

