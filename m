Return-Path: <linux-tip-commits+bounces-6401-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9035EB3FCA9
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 12:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FAC917BDEB
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 10:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D12D2F28F8;
	Tue,  2 Sep 2025 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GTZBTe/t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CD5eZGao"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35792EBBB2;
	Tue,  2 Sep 2025 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809397; cv=none; b=YMSd0JIK7nOxbJ8GPcHKGPT54uswTL+k0/jK/0qXiiPGp9aAABFQC1qPmjzHH2VrUDwY5RsDnZrGyWZiujCa1uNhqj+IujS/f8je+6grrnkb2Tv4KrNXbPupk6enzNxLv5XByKRQYUT74GY+iJempXKDftPWe1MIXP8b553gNVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809397; c=relaxed/simple;
	bh=sfydwQ63GUjxMxuqMKB59CHQk5MkQY/tIYM0nSEc5MI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=adWM9iipSpYA+kH71IqWWMIcVHusnxYmkhByRIWbyN+a5MIgZjGmdsg3L1W+f/GmJa21Xj60ray3hsH05mBFEfG3bfywcXvt5U1BFbPpjwRXsr/5BLYRSNGZrM1KTPCZA+R02835woAeItkARjWe9yEw9VsoTBxjPE7JeIX2HEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GTZBTe/t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CD5eZGao; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Sep 2025 10:36:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756809393;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LOh77lt64myekIzCCA1SVBnRueU3Yiwo5Y2AQPeTZuM=;
	b=GTZBTe/t16NXeRbgYH8PdlLiHuZNk3L/BG+EShnutBlz8PikP3o0a37OBg54I3C1EVsRwx
	pnIc1t2ZSamtZzjz8QLwNFMtrYXxWlNaKczSBJg+bgvEMtiY80pQJ3wui+23+HPdQOLvBa
	qYaqtqFGqnYzxtsW0uuaDmkgkj6TGmL+sd6yKiSHaMQnD69P2KAStq+cmy3A65G/1QCV7O
	oWhxMm06Sqb3OfDFxdNMbAdVVBjsqodF0iC631QZ5QaTsT7N8iRL5zVWmO+8b32l2V5bvH
	MIJlUfHl80NCqgh9/hbgUudhQOhAJq4BPooOU4pkfKkpg6Y7GugSPGs179aL2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756809393;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LOh77lt64myekIzCCA1SVBnRueU3Yiwo5Y2AQPeTZuM=;
	b=CD5eZGao672snUw3nGEnBmHFmjMHYdw9hA9rfBpqbF/GlppESajEx0wkUzs2bpjjQDiFzN
	t/IgbsXFD+v9zQAA==
From: "tip-bot2 for Neeraj Upadhyay" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/sev: Prevent SECURE_AVIC_CONTROL MSR interception
 for Secure AVIC guests
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Tianyu Lan <tiala@microsoft.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250828113119.209135-1-Neeraj.Upadhyay@amd.com>
References: <20250828113119.209135-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175680939230.1920.7738574260721249850.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     952aefeebb3339d8129f7ca7fdb8f4344b6543a7
Gitweb:        https://git.kernel.org/tip/952aefeebb3339d8129f7ca7fdb8f4344b6=
543a7
Author:        Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
AuthorDate:    Thu, 28 Aug 2025 17:01:19 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 01 Sep 2025 13:18:48 +02:00

x86/sev: Prevent SECURE_AVIC_CONTROL MSR interception for Secure AVIC guests

The SECURE_AVIC_CONTROL MSR holds the GPA of the guest APIC backing page and
bitfields to control enablement of Secure AVIC and whether the guest allows
NMIs to be injected by the hypervisor.

This MSR is populated by the guest and can be read by the guest to get the GPA
of the APIC backing page. The MSR can only be accessed in Secure AVIC mode.
Any attempt to access it when not in Secure AVIC mode results in #GP. So, the
hypervisor should not intercept it. A #VC exception will be generated
otherwise. If this occurs and Secure AVIC is enabled, terminate the guest
execution.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Link: https://lore.kernel.org/20250828113119.209135-1-Neeraj.Upadhyay@amd.com
---
 arch/x86/coco/sev/vc-handle.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/coco/sev/vc-handle.c b/arch/x86/coco/sev/vc-handle.c
index c1aa10c..0fd94b7 100644
--- a/arch/x86/coco/sev/vc-handle.c
+++ b/arch/x86/coco/sev/vc-handle.c
@@ -415,6 +415,15 @@ enum es_result sev_es_ghcb_handle_msr(struct ghcb *ghcb,=
 struct es_em_ctxt *ctxt
 		if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
 			return __vc_handle_secure_tsc_msrs(ctxt, write);
 		break;
+	case MSR_AMD64_SAVIC_CONTROL:
+		/*
+		 * AMD64_SAVIC_CONTROL should not be intercepted when
+		 * Secure AVIC is enabled. Terminate the Secure AVIC guest
+		 * if the interception is enabled.
+		 */
+		if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
+			return ES_VMM_ERROR;
+		break;
 	default:
 		break;
 	}

