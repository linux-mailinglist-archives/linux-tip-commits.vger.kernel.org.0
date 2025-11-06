Return-Path: <linux-tip-commits+bounces-7272-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C36FC3B15C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 06 Nov 2025 14:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B0285610F3
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Nov 2025 12:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F40132E751;
	Thu,  6 Nov 2025 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ecdxRgFh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r80T7Vod"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744B432D0D4;
	Thu,  6 Nov 2025 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433583; cv=none; b=CgD2Ao9uCqztziG573doCYLic/aJ7rSUT+utU8Dv0cweMGnAZWOAr8TY5ehh/5SzsbUjvVESjY2fKS8gJNO5CogA0HXHHMZP/d1sj02dmDZSJHYrSjFhHQNb4a/hU1BImsc7a2nfYLGe8aQ2ZtB+SweIv1pRx6SK5QLmKWk7+ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433583; c=relaxed/simple;
	bh=H9bCl4tBdch3n9x9d0TTZmIOEs7o0SDXQScPj27K1ig=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=GuxBVLOohtc/ZPDZASWbx6hysQgEBHPTul9Yx1cx8dWWcocZ+BgWl1AGx1HathG4N/aTr5fKOwsDnLxFZV12aV1hYyET0I9xm1N6jFITdhHTGIhj2WGt3RLCzZd+uCB8DgO63tN8fz2CLz1bTGqxn3vndffiFc3HujEp/ywHSps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ecdxRgFh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r80T7Vod; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 06 Nov 2025 12:52:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762433573;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=2XUb3Garv6WWcVuIEsX3m2/Fx1VDmgqMjUhG1bgb5gE=;
	b=ecdxRgFhh+H+AQkL+rC5i1RfsURe/1tSWGbz4BA3TkDkQmwXQSFUM0JBWPxXMZ2d2MGeH9
	foKq55j1Q62+cj1yy4K8V9R9/cAVONEgLWRW91E0PW/vRF2rdAoiGR/pcrb2BJ3yL1e1im
	I76Zcz31mqhXZOEp5hQ6o45pFC9nXRp/7klYXYnaWE7FwBVuCo0+GvnoT01KWKXfdAS3DI
	urQI7ErJGnr8OTm8Z0cGWie/Ix+ndL3JlMmDJgzQ3OCGO/vLoTGQEnJMjuhmBFnEjJndhp
	Se8lHbYzPGGWipT4yzXsOtCdKUNyHgaaygcskUeCqivrgkdACz5iCdNrym4TZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762433573;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=2XUb3Garv6WWcVuIEsX3m2/Fx1VDmgqMjUhG1bgb5gE=;
	b=r80T7VodxSDPZsqh12WfyoBxRkk5tW3lykDckbQfGbcdbWidt5II5VSKbMqASp7gDbf0fm
	YN/U2jV5hVD6VQBQ==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/amd: Remove redundant reset_block()
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176243357223.2601451.7359439918721059537.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     3206b41604f80bb84c19ae3ed7c01d9d671ece2a
Gitweb:        https://git.kernel.org/tip/3206b41604f80bb84c19ae3ed7c01d9d671=
ece2a
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Tue, 04 Nov 2025 14:55:42=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 05 Nov 2025 22:34:53 +01:00

x86/mce/amd: Remove redundant reset_block()

Many of the checks in reset_block() are done again in the block reset
function. So drop the redundant checks.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20251104-wip-mca-updates-v8-0-66c8eacf67b9@amd.=
com
---
 arch/x86/kernel/cpu/mce/amd.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 6d16b45..af2221b 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -812,29 +812,11 @@ static void amd_deferred_error_interrupt(void)
 	machine_check_poll(MCP_TIMESTAMP, &this_cpu_ptr(&mce_amd_data)->dfr_intr_ba=
nks);
 }
=20
-static void reset_block(struct threshold_block *block)
-{
-	struct thresh_restart tr;
-	u32 low =3D 0, high =3D 0;
-
-	if (!block)
-		return;
-
-	if (rdmsr_safe(block->address, &low, &high))
-		return;
-
-	if (!(high & MASK_OVERFLOW_HI))
-		return;
-
-	memset(&tr, 0, sizeof(tr));
-	tr.b =3D block;
-	threshold_restart_block(&tr);
-}
-
 static void amd_reset_thr_limit(unsigned int bank)
 {
 	struct threshold_bank **bp =3D this_cpu_read(threshold_banks);
 	struct threshold_block *block, *tmp;
+	struct thresh_restart tr;
=20
 	/*
 	 * Validate that the threshold bank has been initialized already. The
@@ -844,8 +826,12 @@ static void amd_reset_thr_limit(unsigned int bank)
 	if (!bp || !bp[bank])
 		return;
=20
-	list_for_each_entry_safe(block, tmp, &bp[bank]->miscj, miscj)
-		reset_block(block);
+	memset(&tr, 0, sizeof(tr));
+
+	list_for_each_entry_safe(block, tmp, &bp[bank]->miscj, miscj) {
+		tr.b =3D block;
+		threshold_restart_block(&tr);
+	}
 }
=20
 /*

