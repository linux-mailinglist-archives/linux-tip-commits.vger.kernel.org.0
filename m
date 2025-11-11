Return-Path: <linux-tip-commits+bounces-7292-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 061CBC4D709
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 12:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8748F3AFDBC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 11:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D14F3590C6;
	Tue, 11 Nov 2025 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FC8U2LzB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="auBnhqGD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8045358D2E;
	Tue, 11 Nov 2025 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861033; cv=none; b=d+ilDEt/ZoA60RyggSge/kDuybmyBXaqyIyEc5IZSOzKm1PlseqdlXYUMCc8S8PlhQ1WMq+jnZp309PdnwoRKaodPrhGkFUB8/fwuM+oysCs+KgT9TVdUOFWWqX01z2/yHsxNClejEyNU9wmdopQZgQ6VLGzzmpktJq/imuolDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861033; c=relaxed/simple;
	bh=ef45muh/lAAfFdiqsERUeLS6hM8/cXFMmGytNQpktdM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TkPXH0slYUGjf3hP9BLqMBJOQIZ47pS8HOeOx0UtTigYGFhlkUGl+zcHQXmYue9+3y4Zwczr6jF+o2ucD1TL7tvvNdWQDBrvWrrg2fVLKyYq3M06JCA9Y4TpdgDzuVeI+Jdrg+9XYMJj8ny0WcFbtYTbI70KgdEA47QVeCO2fac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FC8U2LzB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=auBnhqGD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 11:37:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762861029;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7mb/O4LvTFCbICGvSnxaNjoyvxfEzzoy+4ygc+yS+Fc=;
	b=FC8U2LzB/OfPv+IyMJcc08k2aA8qrPNN1W2TSnDdrwScX7l5CRvysvbCo7Qjy/gfS6zlUY
	r1ECcYLPAxwbI25YS4kOyxUWHP2TOxUagfwz2uQFMIfd0PbcODVmv+gTwiWmn/63JPJrso
	ZcCqtQoEUAeulIW1iZ3eSj4/S4s87dT9RAJw15CqCwDaioQqsqSR4J6qRahyo8GKffQDPo
	C8Ou82pkOf9kb05YqI6BnYlnfGHxDtArrFX4/xGw2HIDtlRyO+EVpTUTy7gEMaPYkRbgiB
	pg325nyOhLNgxvU9ZnYQID/TaO7/OD9KhcZerdgY5xBbGuvTUJfG7qLwtFCllA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762861029;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7mb/O4LvTFCbICGvSnxaNjoyvxfEzzoy+4ygc+yS+Fc=;
	b=auBnhqGDpTLBde30jS1oinyvmzPDkge1+nZlQ/jYP2fSOJVxcU/IGsrv7GkKFdlGNXHcUg
	FXLBBaG4R5dz8mBQ==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Correct large PEBS flag check
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251029102136.61364-5-dapeng1.mi@linux.intel.com>
References: <20251029102136.61364-5-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176286102787.498.3160255014727435221.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     5e4e355ae7cdeb0fef5dbe908866e1f895abfacc
Gitweb:        https://git.kernel.org/tip/5e4e355ae7cdeb0fef5dbe908866e1f895a=
bfacc
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Wed, 29 Oct 2025 18:21:28 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 07 Nov 2025 15:08:20 +01:00

perf/x86/intel: Correct large PEBS flag check

current large PEBS flag check only checks if sample_regs_user contains
unsupported GPRs but doesn't check if sample_regs_intr contains
unsupported GPRs.

Of course, currently PEBS HW supports to sample all perf supported GPRs,
the missed check doesn't cause real issue. But it won't be true any more
after the subsequent patches support to sample SSP register. SSP
sampling is not supported by adaptive PEBS HW and it would be supported
until arch-PEBS HW. So correct this issue.

Fixes: a47ba4d77e12 ("perf/x86: Enable free running PEBS for REGS_USER/INTR")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251029102136.61364-5-dapeng1.mi@linux.intel.=
com
---
 arch/x86/events/intel/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 46a000e..c88bcd5 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4029,7 +4029,9 @@ static unsigned long intel_pmu_large_pebs_flags(struct =
perf_event *event)
 	if (!event->attr.exclude_kernel)
 		flags &=3D ~PERF_SAMPLE_REGS_USER;
 	if (event->attr.sample_regs_user & ~PEBS_GP_REGS)
-		flags &=3D ~(PERF_SAMPLE_REGS_USER | PERF_SAMPLE_REGS_INTR);
+		flags &=3D ~PERF_SAMPLE_REGS_USER;
+	if (event->attr.sample_regs_intr & ~PEBS_GP_REGS)
+		flags &=3D ~PERF_SAMPLE_REGS_INTR;
 	return flags;
 }
=20

