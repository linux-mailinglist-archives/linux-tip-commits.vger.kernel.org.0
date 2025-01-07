Return-Path: <linux-tip-commits+bounces-3171-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3EAA03D5B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  7 Jan 2025 12:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9179F1880991
	for <lists+linux-tip-commits@lfdr.de>; Tue,  7 Jan 2025 11:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EF21E3DD1;
	Tue,  7 Jan 2025 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MtaqtwxS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6w0Mbrp3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E461E32D3;
	Tue,  7 Jan 2025 11:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736248363; cv=none; b=FR3DtWhPOzEO/d7nYZRGCbXdqLX4sIMsEMVkU2ubCdnk2gcaw/pf9UNRvreffn6a9OnIhVKEeiS1f8mwiOI1r8VVkDKRZ4HxieOyPtmf4O1Xk5QHC4p5LymawMMbMsg+teJyw8q4xI1ddJWlkkXh7CdYvd044VwvEErREQxiKM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736248363; c=relaxed/simple;
	bh=1LkDL1oyncs3cKtGbRYTQ4FKu72uLhmWcCWIsrK5wLM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eAjxGWrdWkbzvJ6e+CL/2adhhqX27UZohVIJUCj5fNoG/PatC3Petbzh9i2Yhlcvtskz9m4vYnFo3zRSZLx7vQxClAphsGNSy4pl9l1Y6zmSvrKcNkV4K+iqPzQO9LqXOR2TxDRg+/dXUol0UvDvOdCykCBoJAdTjS4hjoUiiUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MtaqtwxS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6w0Mbrp3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 07 Jan 2025 11:12:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736248357;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/UjrMM0DoChBoIc6aVSh7MU6lcbeGxBwexnWeNYUs0=;
	b=MtaqtwxS+aMDbez1/vapowVgXm/WSwPGzxha82i5r1DQ+JNx7sRXLRYTN4QpQ2HJqF55HS
	WRU6fPHXPRmfZc9Yqgpx+KnWr1F5vkfywcOQvK7HWnUzedIiVBo/z3MlLk7DWs/+odlIFG
	Pi/nfuE0vr4qX0D2QFhlS2J9qTCGmL9AmYtYMPHa4BeoyG+DVM67RTBL7DBdVz8Ym+3+rs
	ZZvbo7OwC+0gnwdYjrdM6sxr2Qv6qA2txis3Ncp+ZHD6hX0LjckrcKi1RkbNJZ4s8DQmiF
	Ss28ljaXZwHAS9rufUzHU/F7EuDDbRNx4dm0jKla6GeTQvnehsRBaaKJJuuy6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736248357;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/UjrMM0DoChBoIc6aVSh7MU6lcbeGxBwexnWeNYUs0=;
	b=6w0Mbrp38pYayJCFiL1RM4QP/FV37I44t+48EGrjLMoHhpDtsIOeB4kNe+qiKhcejQE/xU
	uVoWh+s4jOR562CA==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/sev: Don't hang but terminate on failure to remap SVSM CA
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Ard Biesheuvel <ardb@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <9ce88603-20ca-e644-2d8a-aeeaf79cde69@amd.com>
References: <9ce88603-20ca-e644-2d8a-aeeaf79cde69@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173624835316.399.255201405798021467.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     893930143440eb5e3ea8f69cb51ab2e61e15c4e1
Gitweb:        https://git.kernel.org/tip/893930143440eb5e3ea8f69cb51ab2e61e15c4e1
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Mon, 06 Jan 2025 16:57:46 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 07 Jan 2025 11:47:40 +01:00

x86/sev: Don't hang but terminate on failure to remap SVSM CA

Commit

  09d35045cd0f  ("x86/sev: Avoid WARN()s and panic()s in early boot code")

replaced a panic() that could potentially hit before the kernel is even
mapped with a deadloop, to ensure that execution does not proceed when the
condition in question hits.

As Tom suggests, it is better to terminate and return to the hypervisor
in this case, using a newly invented failure code to describe the
failure condition.

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/all/9ce88603-20ca-e644-2d8a-aeeaf79cde69@amd.com
---
 arch/x86/coco/sev/core.c          | 4 ++--
 arch/x86/include/asm/sev-common.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 499b419..8689854 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2356,8 +2356,8 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 	call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
 	call.rcx = pa;
 	ret = svsm_perform_call_protocol(&call);
-	while (ret)
-		cpu_relax(); /* too early to panic */
+	if (ret)
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CA_REMAP_FAIL);
 
 	RIP_REL_REF(boot_svsm_caa) = (struct svsm_ca *)pa;
 	RIP_REL_REF(boot_svsm_caa_pa) = pa;
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 50f5666..577b64d 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -206,6 +206,7 @@ struct snp_psc_desc {
 #define GHCB_TERM_NO_SVSM		7	/* SVSM is not advertised in the secrets page */
 #define GHCB_TERM_SVSM_VMPL0		8	/* SVSM is present but has set VMPL to 0 */
 #define GHCB_TERM_SVSM_CAA		9	/* SVSM is present but CAA is not page aligned */
+#define GHCB_TERM_SVSM_CA_REMAP_FAIL	10	/* SVSM is present but CA could not be remapped */
 
 #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
 

