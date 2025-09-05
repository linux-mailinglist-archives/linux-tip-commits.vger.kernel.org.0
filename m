Return-Path: <linux-tip-commits+bounces-6493-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6637B456B4
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 13:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A71A445BF
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 11:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB56834AB15;
	Fri,  5 Sep 2025 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VsQCrVSy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vwOGHpC7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0854934AAE8;
	Fri,  5 Sep 2025 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757072456; cv=none; b=mFFqEahjAgqUgEuupH52PQ2QWyC53a6xXvg7n2uTYOV4iLHOAYy5+C1zfU74n8lAV8a6DtU4W5s3J1GHW9ZDeLZsBVBNr0FoAULk3BAiZN1a+2Kdcm1nZmIXTSMMZ/3xACp2ut0xRAd4HBp6lgthsfGkmgzjIO+siEwZMCBgBgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757072456; c=relaxed/simple;
	bh=+0TXCogZdMAhRf8P8pc0EKBTW2Dg4du4tclPEKs0pVY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=E2FNscJG5mnWwtM16zcEC16IWx35G5D6eTLVI+Au9cyzZQM1vWuwC4/Q0+TtYRh/Vulat9b4RXbwNKOhFONWo5WAz3gs4AwULjeiqi90Nk8rJxHM0UXSS8MO/zTjSCHhMe7xspoYCDJ9qW4NHPdz7OlRMB03ekwjfFgKC6ZftDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VsQCrVSy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vwOGHpC7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Sep 2025 11:40:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757072452;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/rvM4HgoFIOkOYvAg7ZAkoJxxkN+uq6mkuQ+sxjUNY=;
	b=VsQCrVSy2We0DGkAKhCWEgCv7VpMuvZMF4cMhKq9i/Ft3UwTKR5Qbz8V+q1X2VZk9mLsZt
	kooyV7a82DgIOw8ld6jdGa1GH3d7LWJfOs0IBOzBByjh0i1scDAi5QVlH+8PJvSOvPeU98
	FcZ1dMDBt8D/S3vW3HcZjgd6GFtMAWAUsHtdq2iY1odPEG62nttozW9hZQMnwNoF1s6tCe
	bJNPB4YuijDuK+nO3yyQRtGUBJ8UM21yea5OGOBik73AZ48joiKRk2oFNOtxnTSsIo8CNJ
	+PyvLI06KlhQU47CBljCc1yGZy7MVPynKyggeIyvW91Yc+XT2F7hP1c2nb9PhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757072452;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/rvM4HgoFIOkOYvAg7ZAkoJxxkN+uq6mkuQ+sxjUNY=;
	b=vwOGHpC7q564onCpkDJOnvhLQLxeltSDfVCeq0ce1irhv4c9uG9IuiIe0cZSIRok6Gvebp
	+l94OpaKgzzl12Cg==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/amd: Rename threshold restart function
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250624-wip-mca-updates-v4-5-236dd74f645f@amd.com>
References: <20250624-wip-mca-updates-v4-5-236dd74f645f@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175707245095.1920.10393228070002861336.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     9af8b441cf6953f683b825fbf241a979ea7521e8
Gitweb:        https://git.kernel.org/tip/9af8b441cf6953f683b825fbf241a979ea7=
521e8
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Tue, 24 Jun 2025 14:16:00=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 05 Sep 2025 12:35:29 +02:00

x86/mce/amd: Rename threshold restart function

It operates per block rather than per bank. So rename it for clarity.

No functional changes.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250624-wip-mca-updates-v4-5-236dd74f645f@amd.=
com
---
 arch/x86/kernel/cpu/mce/amd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 5c4eb28..9b980ae 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -419,8 +419,8 @@ static bool lvt_off_valid(struct threshold_block *b, int =
apic, u32 lo, u32 hi)
 	return true;
 };
=20
-/* Reprogram MCx_MISC MSR behind this threshold bank. */
-static void threshold_restart_bank(void *_tr)
+/* Reprogram MCx_MISC MSR behind this threshold block. */
+static void threshold_restart_block(void *_tr)
 {
 	struct thresh_restart *tr =3D _tr;
 	u32 hi, lo;
@@ -478,7 +478,7 @@ static void mce_threshold_block_init(struct threshold_blo=
ck *b, int offset)
 	};
=20
 	b->threshold_limit		=3D THRESHOLD_MAX;
-	threshold_restart_bank(&tr);
+	threshold_restart_block(&tr);
 };
=20
 static int setup_APIC_mce_threshold(int reserved, int new)
@@ -921,7 +921,7 @@ static void log_and_reset_block(struct threshold_block *b=
lock)
 	/* Reset threshold block after logging error. */
 	memset(&tr, 0, sizeof(tr));
 	tr.b =3D block;
-	threshold_restart_bank(&tr);
+	threshold_restart_block(&tr);
 }
=20
 /*
@@ -995,7 +995,7 @@ store_interrupt_enable(struct threshold_block *b, const c=
har *buf, size_t size)
 	memset(&tr, 0, sizeof(tr));
 	tr.b		=3D b;
=20
-	if (smp_call_function_single(b->cpu, threshold_restart_bank, &tr, 1))
+	if (smp_call_function_single(b->cpu, threshold_restart_block, &tr, 1))
 		return -ENODEV;
=20
 	return size;
@@ -1020,7 +1020,7 @@ store_threshold_limit(struct threshold_block *b, const =
char *buf, size_t size)
 	b->threshold_limit =3D new;
 	tr.b =3D b;
=20
-	if (smp_call_function_single(b->cpu, threshold_restart_bank, &tr, 1))
+	if (smp_call_function_single(b->cpu, threshold_restart_block, &tr, 1))
 		return -ENODEV;
=20
 	return size;

