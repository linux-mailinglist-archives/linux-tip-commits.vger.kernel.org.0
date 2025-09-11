Return-Path: <linux-tip-commits+bounces-6558-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E87F5B52E4F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 12:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F4AA81921
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 10:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F4531158A;
	Thu, 11 Sep 2025 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zo85m+Fg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aIPcyIUN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEE130FF3F;
	Thu, 11 Sep 2025 10:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586536; cv=none; b=nKeKNq7bOddntZtMfNa7g6lx5j/js3WvD3BPpeliFKwMo+mRUzhz2zQlJeEuEasCovd7ZbVq/SP+cN/MrLcP1EqzQ65y8XwHoYXHQ+f4AdUnn1bcZ6Kn1WsBa7v8z917RAcxFOJhYUyg0VLLA4dAWmXrMh+0fcy0ZORRkvmvKIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586536; c=relaxed/simple;
	bh=4VRi5e5Ne/O7gYV1ULCiHdvm0exP5ZbrWgTPgawOPFo=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=hMjmTvSLYO3maYS7oJcM694sN6OzzbyHtKtnN/S52HAe5KOZ14FFzV0aMkETuBzmCwp+9u2yo4T3Oo7Dxg+8Sl50d5uBRv1/O207hxQ+eoapRgvgDbaiug5hAoNsRKHFT0lt5qPuOoRO0x+wLa9d+I3+tbBp+EFXlRT9y4nZZ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zo85m+Fg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aIPcyIUN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Sep 2025 10:28:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757586533;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=RAHxvYqWzQvGkhOI9+yNrp7f5biDW7zVJNxxwrhcGR8=;
	b=zo85m+FgayvzoEPmu8vP/mUbrku0zY5B054rJ8qEoIrDAfqN1WV0w83DMCUZobzAmCLERQ
	gYVfRSq0XbHoqMaOXhwO4S/Xg7cb6DQQanLC4+QvDLbS1jEHxZ2Xpt6tflUypzwpD4qLIr
	9/5tKKvcLp5C5rJjVzkJNumpT/6VSAgfzYeikWvElnuT6sfPpeBFzZBVU+v9wQGFHg5XEZ
	FvnGAIuDCu+dtos+f7YIrTr1+XXeJySUC21gueDekP48IvvJmdSUhQ1EVPg5dgqo8pG7JY
	2k5BfYzVpOwKkoHoj/vp6yrPw/eGIBueI+rc9+hwxbaE5s+JuWbSRlNpqQ8vOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757586533;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=RAHxvYqWzQvGkhOI9+yNrp7f5biDW7zVJNxxwrhcGR8=;
	b=aIPcyIUN3l9R1YueEmlFLB35QYt0+uKQohXxc0mOiyC8NgLnZJHX4eUjHCcCbohfrUnQeT
	6DuKtrGPYvtU6QDg==
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
Message-ID: <175758653247.709179.17436625388312555748.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     922300abd79d9eac241a531579db3b5dfb2dd1a9
Gitweb:        https://git.kernel.org/tip/922300abd79d9eac241a531579db3b5dfb2=
dd1a9
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 08 Sep 2025 15:40:41=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 11 Sep 2025 12:23:48 +02:00

x86/mce/amd: Remove redundant reset_block()

Many of the checks in reset_block() are done again in the block restart
function. So drop former.

  [ bp: Fixup commit message. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.=
com
---
 arch/x86/kernel/cpu/mce/amd.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 3426894..9ca4079 100644
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

