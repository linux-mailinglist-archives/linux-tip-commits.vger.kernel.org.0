Return-Path: <linux-tip-commits+bounces-3278-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A36A1788E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Jan 2025 08:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67450161009
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Jan 2025 07:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1FD1A2C11;
	Tue, 21 Jan 2025 07:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MtMnSKEX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wjGPabNi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDA01D554;
	Tue, 21 Jan 2025 07:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737444249; cv=none; b=OTjaJKp+FWzmwGDIuydCqrzB+kBCaOR6Lt6Vh5FhNR2+mfFbrUPaEiaaMDz8932hpA1N/fzG4+O/zAtJ2i26JGCHjOFPCZ55NUBMUQIORVMZ2X3/s5tAp4zVa4xZKoUHZHaTF1Oj+4aXylzz02Z85c73u55LBYi68uevYIqWXRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737444249; c=relaxed/simple;
	bh=qnlgGB/NARt31BKOxFxyr2sBWjwF6vZy7uQ5okx7OCQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VSVYU9yLDsx3TorpcXgySTB2+Pp7nqleHvpT7vbHDx/ZsYQZ/VCPdMWlbJLTjqf436DfqCuhfoB52zPC3fyD0FTIHgdPWGoKYAgXxSvMBJ6wrPiaKrDpXhM0F3tcMF3sFt+xioWJP9fIKJ+/08X5nZzpPaw7wNTFKZ0JQOl5xfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MtMnSKEX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wjGPabNi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 21 Jan 2025 07:24:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737444244;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q8S2veoK+/z+znYpvZ2lv0IiD+VC4iCwmuKbIfA6A/4=;
	b=MtMnSKEXB1/pGNfio8QA8Kn359Zg57kIISHA3iLS3vITsrqxdFFCNURT6JPh1E5f+RhSsu
	uzn2yHIo0rfFgCpZJVTybz80/LcCw1yKsHukEBgHH547bDDjcVb0K+e5lalw66ajnI88LL
	yskiqsINpQfXEBXybssqBh1rbMo+lP8wI7eBFgjF5x87AO0gdrWq5cdCXYk+KBZDW2fbKR
	IarkrTmX0BlttJvWoarSO0oB4+AgdTMHTP+fHrnIzDDpBb96yiOkKI4l/STrHNWUMadWDb
	c/u/Q9JF92X/ls05f/ZIlJ4Ye6/V9p+1INH8rrjt64Bt/6zDgy5kqXTS1jNhqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737444244;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q8S2veoK+/z+znYpvZ2lv0IiD+VC4iCwmuKbIfA6A/4=;
	b=wjGPabNi/9Dj7XRwy2oOSfClJepTQX0TVMEwLpRY1/CJfva+6Qa8MzGt83clNlw551iVBX
	QLgGLmp8fm1Hn9BQ==
From: "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rseq: Fix rseq unregistration regression
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250116205956.836074-1-mathieu.desnoyers@efficios.com>
References: <20250116205956.836074-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173744424077.31546.6902932742981910502.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     40724ecafccb1fb62b66264854e8c3ad394c8f3d
Gitweb:        https://git.kernel.org/tip/40724ecafccb1fb62b66264854e8c3ad394c8f3d
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Thu, 16 Jan 2025 15:59:56 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 21 Jan 2025 08:10:51 +01:00

rseq: Fix rseq unregistration regression

A logic inversion in rseq_reset_rseq_cpu_node_id() causes the rseq
unregistration to fail when rseq_validate_ro_fields() succeeds rather
than the opposite.

This affects both CONFIG_DEBUG_RSEQ=y and CONFIG_DEBUG_RSEQ=n.

Fixes: 7d5265ffcd8b ("rseq: Validate read-only fields under DEBUG_RSEQ config")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250116205956.836074-1-mathieu.desnoyers@efficios.com
---
 kernel/rseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index e04bb30..442aba2 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -201,7 +201,7 @@ static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 	/*
 	 * Validate read-only rseq fields.
 	 */
-	if (!rseq_validate_ro_fields(t))
+	if (rseq_validate_ro_fields(t))
 		return -EFAULT;
 	/*
 	 * Reset cpu_id_start to its initial state (0).

