Return-Path: <linux-tip-commits+bounces-8007-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23200D241B1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 12:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1D5A30C38F4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 11:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937E9374178;
	Thu, 15 Jan 2026 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZZJAdmn2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r1UfABBC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77C2361DB4;
	Thu, 15 Jan 2026 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475496; cv=none; b=B+SiYgy4IBuRL3PzXsVn5yjwFw5JA+KOKWrUC4mQYAIEh7IuWaC/qYsL3X/06cAq7WLh2aiZQUQkkSj+LagrqdlGqIWYBD5eRQsZvwIa9g0ZLjuvyzNNHxy2k64TKGIAiQTvBy5wgG0NYqF975YkCEJIU4KWokVsGqnCgpD99RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475496; c=relaxed/simple;
	bh=JwmXdFlhYCPTALEGCSqEQDlP/2CPQxNNTVwoD1Sfnt8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QCQ1DH7P8hoOFtMmKX5QomW3XQsJjTjoJ0bkZQ52tbPBp1sexsj5pJV5vq2SNtEloGGIiy52BAlis71RMXZAQKQo2biT4Sm4PuoavITv7AeF7Q8eUE9iwFxzYBy8KImoCcIBHUAozr4bfESewnvtEFS0UezptRYoAdC+e02yGVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZZJAdmn2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r1UfABBC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Jan 2026 11:11:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768475491;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TIDnbVtNQ7kPoXUcA05lhmIxd+Zy3LE5lS9D6xeEc0k=;
	b=ZZJAdmn2lykxTniSM4aFpMEOSmIQp1wOMC1eB68Q4Al8U4xzB3FGD6+fz212o3PSHIpdYK
	UL9HHe9SmSV/gy9ShNyxmZabJTI5pZw23eZ8LggxfF0MFrOb7eKdzJfyNdzcuxfwSSKRKQ
	IgQfHgBa5C+6Pf/REIUUqje86u4BG97QVyXqejpaMEMp0jc1e/DtHlCoLfkE4A5DHaVOEe
	azqmYy/hYaFAXzaeI91ArIiT/EjDigHbRyohQzv2xCdgprXudyXT48w0REif4gOotaeSpg
	Omjp6LhlUGvc9Pjb+A24GlLjDgHyFR2mWBdc/I8Z3caJs1KIpOC1mZlUVucrmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768475491;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TIDnbVtNQ7kPoXUcA05lhmIxd+Zy3LE5lS9D6xeEc0k=;
	b=r1UfABBCnTsvdJzT/rJ+vDDAF/L22sA/DkCmLRG8xXF8FM1yPjibIlRljObf2eVm5pX5W1
	QXMANZf6FJQj6ACA==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] x86/paravirt: Use XOR r32,r32 to clear register
 in pv_vcpu_is_preempted()
Cc: Uros Bizjak <ubizjak@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Juergen Gross <jgross@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260114211948.74774-2-ubizjak@gmail.com>
References: <20260114211948.74774-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176847548563.510.8833320214622078587.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     31911d3c394d6556a67ff63cf0093049ef6dcdd7
Gitweb:        https://git.kernel.org/tip/31911d3c394d6556a67ff63cf0093049ef6=
dcdd7
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 14 Jan 2026 22:18:15 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 15 Jan 2026 11:44:29 +01:00

x86/paravirt: Use XOR r32,r32 to clear register in pv_vcpu_is_preempted()

x86_64 zero extends 32bit operations, so for 64bit operands, XOR r32,r32 is
functionally equal to XOR r64,r64, but avoids a REX prefix byte when legacy
registers are used.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Acked-by: H. Peter Anvin <hpa@zytor.com>
Acked-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Link: https://patch.msgid.link/20260114211948.74774-2-ubizjak@gmail.com
---
 arch/x86/include/asm/paravirt-spinlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/paravirt-spinlock.h b/arch/x86/include/asm/=
paravirt-spinlock.h
index 458b888..7beffcb 100644
--- a/arch/x86/include/asm/paravirt-spinlock.h
+++ b/arch/x86/include/asm/paravirt-spinlock.h
@@ -45,7 +45,7 @@ static __always_inline void pv_queued_spin_unlock(struct qs=
pinlock *lock)
 static __always_inline bool pv_vcpu_is_preempted(long cpu)
 {
 	return PVOP_ALT_CALLEE1(bool, pv_ops_lock, vcpu_is_preempted, cpu,
-				"xor %%" _ASM_AX ", %%" _ASM_AX,
+				"xor %%eax, %%eax",
 				ALT_NOT(X86_FEATURE_VCPUPREEMPT));
 }
=20

