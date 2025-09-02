Return-Path: <linux-tip-commits+bounces-6409-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5DAB3FCBF
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 12:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC67C188F932
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 10:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5472F617E;
	Tue,  2 Sep 2025 10:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fbLMpuzf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ehju7mhE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802AD2F548B;
	Tue,  2 Sep 2025 10:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809406; cv=none; b=OA8KNFkz4nf2//4rUh42ZfO2udGC47mN3fyHk9UU5m7lgwAAaMCUC11hiG1t6yjB5O9LoIdaTZzpl81Pwxe0/1GJ4arso8mWllXpqg16eeoOm2bUZC9gUaKD8WodLW+yr2db+3p7HnwAVsMbdOyGY22YAScI5RP/+0zRzyJ7Dl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809406; c=relaxed/simple;
	bh=MFWVRRLVZBntdZwJbvXUs0gvW+M8asA5cOj6LcPB8GQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BbmynHMTwOvFqjO4Frfuiw2yaL8qAE1rnItIUuxnS6P0L4nl9k86bH9DOl8EbVE+3v0n1TY6lqAO7hMME0Zw0XyOYLQq7fMNrF0GnVkVToK2iPgf2ULeLQ63UC59nIrdNXMCu5fzrQo1FcXE2Y9lCSzlbwQOOHimL8s1+omshGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fbLMpuzf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ehju7mhE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Sep 2025 10:36:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756809403;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yZDk55I0UQIaXsQfsGmt57xIekF1ipjJLs4ydUwPyTw=;
	b=fbLMpuzf7PLCpOY/Cni8OGB+yw/s30iVrGpoIDjCcAn10d6k5JA0wCykHrdPomCF8mctQG
	eFvo525vsXBp8MniX65oP8xrNf7qLjvSFgnS6JceQ9+Eti5+YfBdLEnHbhIiqNbddxypDl
	MdeMcQh1WByRdVfNOGYNvYrXN7Wavgoy/Rn9tF7wNjGshcXROnAN6wg9YO8URTFuGXPiix
	tSmbfgw8hVhYfqvZlsSouHwnMESitRIcpi4pkTI7ADj70DpByK4nLH8ZDO5POZzKvTDqi+
	ilpuN01K6b0Iww/bvTKkl93EtIFhdI3WsfBztNrTU4WOq09WcCWY8FcpuIbbvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756809403;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yZDk55I0UQIaXsQfsGmt57xIekF1ipjJLs4ydUwPyTw=;
	b=Ehju7mhEoHjJujyfLE0VuGEA2zODqxtBCEyaRQSQ95jsd/27B1sYh6iBKxvNKSPtKScfv0
	7kJ3fDF7w8VutUAg==
From: "tip-bot2 for Kishon Vijay Abraham I" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] x86/sev: Initialize VGIF for secondary vCPUs for Secure AVIC
Cc: Kishon Vijay Abraham I <kvijayab@amd.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Tianyu Lan <tiala@microsoft.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250828111141.208920-1-Neeraj.Upadhyay@amd.com>
References: <20250828111141.208920-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175680940200.1920.8820779000967521417.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     c77683eccf53428a6934df76702e33c0faf46fe5
Gitweb:        https://git.kernel.org/tip/c77683eccf53428a6934df76702e33c0faf=
46fe5
Author:        Kishon Vijay Abraham I <kvijayab@amd.com>
AuthorDate:    Thu, 28 Aug 2025 16:41:41 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 01 Sep 2025 12:48:35 +02:00

x86/sev: Initialize VGIF for secondary vCPUs for Secure AVIC

Virtual GIF (VGIF) provides masking capability for when virtual interrupts
(virtual maskable interrupts, virtual NMIs) can be taken by the guest vCPU.

The Secure AVIC hardware reads VGIF state from the vCPU's VMSA. So, set VGIF =
for
secondary CPUs (the configuration for the boot CPU is done by the hypervisor),
to unmask delivery of virtual interrupts  to the vCPU.

Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Link: https://lore.kernel.org/20250828111141.208920-1-Neeraj.Upadhyay@amd.com
---
 arch/x86/coco/sev/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index da9fa9d..37b1d41 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -974,6 +974,9 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned l=
ong start_ip, unsigned=20
 	vmsa->x87_ftw		=3D AP_INIT_X87_FTW_DEFAULT;
 	vmsa->x87_fcw		=3D AP_INIT_X87_FCW_DEFAULT;
=20
+	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
+		vmsa->vintr_ctrl	|=3D V_GIF_MASK;
+
 	/* SVME must be set. */
 	vmsa->efer		=3D EFER_SVME;
=20

