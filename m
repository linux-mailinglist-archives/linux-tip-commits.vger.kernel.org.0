Return-Path: <linux-tip-commits+bounces-3189-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB69A071D1
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 10:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76469167B71
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 09:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4852216396;
	Thu,  9 Jan 2025 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R5DrLJFz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="olcYu7ge"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BD92153E7;
	Thu,  9 Jan 2025 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736415829; cv=none; b=eTB9C5k7Js4lQoAC3M+Au/NRBK3ZlrQt95nj784PGgG6BbgE/vR7LhGn5qdxPf2RyY/nN/zqCETzybj/Y2dTE0MV7gqnaBpMvP68fZe/vOCkPEM2xdnUvYjgW+9QvAPbGUOb2klAi4jFyFQ2/KVoftnKIgPn4agNQlHvUT00v7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736415829; c=relaxed/simple;
	bh=ppzESRzeW4eqiHle1hbObp9jVHWtBeiLa+ho+hHqgEk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KEsC2rR+2EDtBOD7ZZ0cnRuMSOW+CYp34r6A5oZqxZeTLBHcRqMrO1EUp7Ubni6RfxEugSHSST3y2ayDcAfwqnXhW2bb848zPt/f8uhMux456v8eC6SSp9eoy+VGrPAJkQr+WHU6H2CJ4U4Lr7KYOdhho/H3pCFQbHrRm61fyMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R5DrLJFz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=olcYu7ge; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 09 Jan 2025 09:43:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736415826;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vurFvvlHiL9f5zxRBFk6BivLqq/uFOtMeAYCAbWp/uc=;
	b=R5DrLJFzOsuALVybO82tPbOqLqOf1ud18rwDs7vDZghXic9dVbeMEQWI7otQGpXZAO9pL6
	VtSMePE3NvJOcmbTZYbY3960JJb2CAayoqskrcKruErGJdqDcNDHe/iX9wY2zpuZRLc1d5
	dg7NdhTPouKaQhlNlTHLx5C+vsobxjeFVN8VgxP0c63B+lUJhQQo7witDUJfmPCu/WXrz1
	GrLgUG3s+ygqE+cBhj6jxRBKqwRkP/xr+bOvSwenJDRh+XNXkVmraPqvPlI0161sSUVnRG
	bfWBgW2XON0Dl8TcHFo1yRlKxzQa0MkQxM1ly5MXHb9ICktZ2mW159NjRBnLgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736415826;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vurFvvlHiL9f5zxRBFk6BivLqq/uFOtMeAYCAbWp/uc=;
	b=olcYu7gezitTlmCfFXoborTr+Jh4PlUcxB0/e4ZLwNPiHUv/WvxWW+UU17mJhekzPMlwrn
	/3fDpjHtMROPgLAw==
From: "tip-bot2 for Nikunj A Dadhania" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Prevent RDTSC/RDTSCP interception for Secure
 TSC enabled guests
Cc: Nikunj A Dadhania <nikunj@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, Peter Gonda <pgonda@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250106124633.1418972-9-nikunj@amd.com>
References: <20250106124633.1418972-9-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173641582594.399.4506250825502984197.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     eef679a4b52e35be3b4a982a7f42bcc16054ec62
Gitweb:        https://git.kernel.org/tip/eef679a4b52e35be3b4a982a7f42bcc16054ec62
Author:        Nikunj A Dadhania <nikunj@amd.com>
AuthorDate:    Mon, 06 Jan 2025 18:16:28 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 07 Jan 2025 21:26:20 +01:00

x86/sev: Prevent RDTSC/RDTSCP interception for Secure TSC enabled guests

The hypervisor should not be intercepting RDTSC/RDTSCP when Secure TSC is
enabled. A #VC exception will be generated if the RDTSC/RDTSCP instructions
are being intercepted. If this should occur and Secure TSC is enabled,
guest execution should be terminated as the guest cannot rely on the TSC
value provided by the hypervisor.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Peter Gonda <pgonda@google.com>
Link: https://lore.kernel.org/r/20250106124633.1418972-9-nikunj@amd.com
---
 arch/x86/coco/sev/shared.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/coco/sev/shared.c b/arch/x86/coco/sev/shared.c
index 71de531..4386f37 100644
--- a/arch/x86/coco/sev/shared.c
+++ b/arch/x86/coco/sev/shared.c
@@ -1140,6 +1140,16 @@ static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
 	bool rdtscp = (exit_code == SVM_EXIT_RDTSCP);
 	enum es_result ret;
 
+	/*
+	 * The hypervisor should not be intercepting RDTSC/RDTSCP when Secure
+	 * TSC is enabled. A #VC exception will be generated if the RDTSC/RDTSCP
+	 * instructions are being intercepted. If this should occur and Secure
+	 * TSC is enabled, guest execution should be terminated as the guest
+	 * cannot rely on the TSC value provided by the hypervisor.
+	 */
+	if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
+		return ES_VMM_ERROR;
+
 	ret = sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, 0, 0);
 	if (ret != ES_OK)
 		return ret;

