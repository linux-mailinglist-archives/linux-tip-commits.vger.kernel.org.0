Return-Path: <linux-tip-commits+bounces-5869-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DDCAE02D2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Jun 2025 12:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 404AC176C17
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Jun 2025 10:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFDA224B0F;
	Thu, 19 Jun 2025 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ymG6D8qn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S9OoYbpA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E8B22422A;
	Thu, 19 Jun 2025 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750329607; cv=none; b=rEzhg581LtnzYUjqWpXmMyn26zv3r1rjukZtG5saK0/IFkJWXkOS6R+toMtKND8ccOptQD2F9wlNSSEuBa1H0gFc2OZrv4hWTOuc5OSxd/ORW54wHwVkxzUeWhy7kl+zMrJt+F3uYyHixEnYeUUL6wydgIfJWS/wKDyqI58zcyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750329607; c=relaxed/simple;
	bh=nAxcaVlQregigfOwpAy0vN43+YjW0z3YXYOsj09Gr1g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iCNjtIu9SOXDPApnBFCmJvqSky06FrHDOQ2uBXE2MaAKTqVwycew+b2jZDdMeq/IfU30DdBM2TbUD0k1t7Spx8+ebdiA6JJPkLGI2zgMAhwnBABi1KCTVPDYjW1rMLfovWUKjqUi2K23rtNaRAnPwYCHcLSp0vOl8kMzLt7/yxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ymG6D8qn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S9OoYbpA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 19 Jun 2025 10:39:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750329598;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U09fvUZdyhWwKLSannNM7ZG+7no2FLevxwRzlDal0h8=;
	b=ymG6D8qnqXMJhjirvbhXF/faWli7U7SKhvmNGBXOweP7bYvNhTvAHVS6aPtiZwKoPgcLhA
	Tzobvh7Qus0QPSwV1vklSJ8iElcQp2Bp0mNKCVTNu/DXSGU16dLmio7zktGyX96wZTOZU7
	TfieG2hFyOvkq5c/K7jWxUFbvD+xdHKCwM03TC6JjbGVCzdtQufJVLLtyX+F5FMiJFsM35
	vflMp+OJLd7fMwAUsxnJ/HSlbvel0b1MoEC+HmTjD5NVEgmzNSFk5uAXvxNmwXt69rpXnQ
	MCD+XVPPrIMfrCu8w1N4T0zOKvD/qAiWypyulLzekjNNBXx759jysBc7g/xt6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750329598;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U09fvUZdyhWwKLSannNM7ZG+7no2FLevxwRzlDal0h8=;
	b=S9OoYbpAg1miAek/FnmetkBFQAaAhC3IjBHRpuHFbyGBuP2j5uDpGdfAN0OXxS+2BJX2It
	uQijWDnrKe1LWvDw==
From: "tip-bot2 for Alexey Kardashevskiy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Drop unnecessary parameter in
 snp_issue_guest_request()
Cc: Alexey Kardashevskiy <aik@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250611040842.2667262-5-aik@amd.com>
References: <20250611040842.2667262-5-aik@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175032959721.406.7056066096713448732.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     040ed574ee823a2ce5da36a8d385d3133787c9c5
Gitweb:        https://git.kernel.org/tip/040ed574ee823a2ce5da36a8d385d3133787c9c5
Author:        Alexey Kardashevskiy <aik@amd.com>
AuthorDate:    Wed, 11 Jun 2025 14:08:42 +10:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 18 Jun 2025 22:55:58 +02:00

x86/sev: Drop unnecessary parameter in snp_issue_guest_request()

Commit

  3e385c0d6ce8 ("virt: sev-guest: Move SNP Guest Request data pages handling under snp_cmd_mutex")

moved @input from snp_msg_desc to snp_guest_req which is passed to
snp_issue_guest_request().

Drop the extra parameter.

No functional change intended.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Dionna Glaze <dionnaglaze@google.com>
Link: https://lore.kernel.org/20250611040842.2667262-5-aik@amd.com
---
 arch/x86/coco/sev/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index b0d423a..8375ca7 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1389,8 +1389,9 @@ int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *call,
 }
 EXPORT_SYMBOL_GPL(snp_issue_svsm_attest_req);
 
-static int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_data *input)
+static int snp_issue_guest_request(struct snp_guest_req *req)
 {
+	struct snp_req_data *input = &req->input;
 	struct ghcb_state state;
 	struct es_em_ctxt ctxt;
 	unsigned long flags;
@@ -1932,7 +1933,7 @@ retry_request:
 	 * sequence number must be incremented or the VMPCK must be deleted to
 	 * prevent reuse of the IV.
 	 */
-	rc = snp_issue_guest_request(req, &req->input);
+	rc = snp_issue_guest_request(req);
 	switch (rc) {
 	case -ENOSPC:
 		/*

