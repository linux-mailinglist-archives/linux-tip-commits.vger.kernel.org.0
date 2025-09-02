Return-Path: <linux-tip-commits+bounces-6405-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E434B3FCB1
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 12:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B9FC4E39EA
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 10:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671D32F5324;
	Tue,  2 Sep 2025 10:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bD28LhDD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m1au5rN9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4922F4A16;
	Tue,  2 Sep 2025 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809403; cv=none; b=Z1EPuxfl6D5YD2NywtDdTIOn0fZ+qFfHwVF2S1ey/OdVfkb7rPy8m0lwoMZi7dgx0BmoY+pw+MjZsouBvETLNaaMRYiyJxsiaKSV8rLEiAAd+k5N3RpS7C6jGoHuaRiziHor7fVsFDgqgjrqOFL3Bj7pUXnXZtWSgz3qBG2XKAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809403; c=relaxed/simple;
	bh=pIX++S+diRbY4Xi1K+u1u/VNP6SgEasoNiJRxhulgTY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mzwLJHZWAwbWVrW2MJh+T0LbPLkC3Ai817kmEaGaSQc4M/+AUBUopHuZ2MQlw2PuHauMXgAVCnTAqar9Sigmjr8F2Cu/sahc7bZSxNyKzJ3SPfZo20khEn8KEPlFcmDfXb/yzy7b3LK+ly5uV/SbUaDjma7/rnrdvdaptT/8ve4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bD28LhDD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m1au5rN9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Sep 2025 10:36:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756809398;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sChLSqrbwBMAiSuM27sNnf6st/YMEsTc3eZ3qM9hiuU=;
	b=bD28LhDD1Qex/OEjm9kQr4L9XhrttaLw/d+xh0qQv31FbWfQgVsVHC5gh66dSYSGabWnRf
	GsUrthzaspjw4nriiKg6ilSeD6AFtMEQ3TseCuinAzpNbMW0EsOmESfjq0vBWqMLASjRVt
	5GTm2F9LnpkbpHej8WQpdUFelsAiRcJ2gDHI0k81+k940uGAOZljh2Yw0z/k+PS9PVgZWn
	uf1vdbC0yK/zb11SfJK5qeqAAzse7EvcszHFbiInnzph/1bEnO4FmebTCfjMiQxtW68fs+
	8gNl7YTdlEUWiBcQwQdNKfTJVd8fjZpJ2Lxz9m85MgoZkKSpvVR3XQPfn4hABw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756809398;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sChLSqrbwBMAiSuM27sNnf6st/YMEsTc3eZ3qM9hiuU=;
	b=m1au5rN935d5WwxNeLCexAuig1jv88Gf4Eod9smvGYRciL6Oh+l4NnIAXHGRbOy9hoQXU2
	WPYdGSybTYDokjAg==
From: "tip-bot2 for Neeraj Upadhyay" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Read and write LVT* APIC registers from HV
 for SAVIC guests
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Tianyu Lan <tiala@microsoft.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250828111356.208972-1-Neeraj.Upadhyay@amd.com>
References: <20250828111356.208972-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175680939724.1920.2129893449886707431.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     8e3714305ad29866d27aa354f09fd03036f44375
Gitweb:        https://git.kernel.org/tip/8e3714305ad29866d27aa354f09fd03036f=
44375
Author:        Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
AuthorDate:    Thu, 28 Aug 2025 16:43:56 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 01 Sep 2025 13:02:11 +02:00

x86/apic: Read and write LVT* APIC registers from HV for SAVIC guests

The Hypervisor needs information about the current state of the LVT registers
for device emulation and NMIs. So, forward reads and write of these registers
to the hypervisor for Secure AVIC enabled guests.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Link: https://lore.kernel.org/20250828111356.208972-1-Neeraj.Upadhyay@amd.com
---
 arch/x86/kernel/apic/x2apic_savic.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_savic.c b/arch/x86/kernel/apic/x2api=
c_savic.c
index bbaedb4..b6d6e7a 100644
--- a/arch/x86/kernel/apic/x2apic_savic.c
+++ b/arch/x86/kernel/apic/x2apic_savic.c
@@ -67,6 +67,11 @@ static u32 savic_read(u32 reg)
 	case APIC_TMICT:
 	case APIC_TMCCT:
 	case APIC_TDCR:
+	case APIC_LVTTHMR:
+	case APIC_LVTPC:
+	case APIC_LVT0:
+	case APIC_LVT1:
+	case APIC_LVTERR:
 		return savic_ghcb_msr_read(reg);
 	case APIC_ID:
 	case APIC_LVR:
@@ -76,11 +81,6 @@ static u32 savic_read(u32 reg)
 	case APIC_LDR:
 	case APIC_SPIV:
 	case APIC_ESR:
-	case APIC_LVTTHMR:
-	case APIC_LVTPC:
-	case APIC_LVT0:
-	case APIC_LVT1:
-	case APIC_LVTERR:
 	case APIC_EFEAT:
 	case APIC_ECTRL:
 	case APIC_SEOI:
@@ -205,18 +205,18 @@ static void savic_write(u32 reg, u32 data)
 	case APIC_LVTT:
 	case APIC_TMICT:
 	case APIC_TDCR:
-		savic_ghcb_msr_write(reg, data);
-		break;
 	case APIC_LVT0:
 	case APIC_LVT1:
+	case APIC_LVTTHMR:
+	case APIC_LVTPC:
+	case APIC_LVTERR:
+		savic_ghcb_msr_write(reg, data);
+		break;
 	case APIC_TASKPRI:
 	case APIC_EOI:
 	case APIC_SPIV:
 	case SAVIC_NMI_REQ:
 	case APIC_ESR:
-	case APIC_LVTTHMR:
-	case APIC_LVTPC:
-	case APIC_LVTERR:
 	case APIC_ECTRL:
 	case APIC_SEOI:
 	case APIC_IER:

