Return-Path: <linux-tip-commits+bounces-5870-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C877AE02D7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Jun 2025 12:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38DF3189F773
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Jun 2025 10:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9508225404;
	Thu, 19 Jun 2025 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XI/CsN5P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="awF9pJvS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64BE2248AC;
	Thu, 19 Jun 2025 10:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750329608; cv=none; b=JMyk11tTh5n/qt3C8UC8fW3Zc8keVyyQ+3lW5xJyh3dFRRvzKR/T7o3TejiRSQH0/grRrzqwIsLMolDHeis50UqC4R979aF/Sh5EAdBDiob8GNeRXFbybeUUh5Ieh4ASRPAAQbBH0PywZOpiwZpkpkJNanXHAKuhfnytB/6xpkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750329608; c=relaxed/simple;
	bh=SBT05F8AW+mX7qsPUQQu5oxy1sYowovpCnh314sOMC8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V7cq8aSlkTXlmC1hk23RWOFMbQX3eXt7dnhwi3Hyfn1Uy4v4pPareYjC5paVs5KLQ2mXNBsJuxnoDRFIajyfr5O1b2K/ByG4WYsFiMXYISrFneL91OrJgkRKoX8xckZjXVPsLf/TF5HWfM4ObnmIQg2kXrVwuRy+akKcquPoCcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XI/CsN5P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=awF9pJvS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 19 Jun 2025 10:39:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750329599;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMoJNe/fVARzYbO/WlqxF0sikGxbOzRj3GdLul7qBDk=;
	b=XI/CsN5PvnITYj7qR23HWZP9a984SmQrKgacbdOwoXtZRFSw3VYr5kT9Q8yCjmYbuaI9CC
	ZPfG/M2q5C4VgCIR3WBz1KQ1wD83MAqc3y0IyohgMUFdZB9rvDo8nrD4U2fyr0eua2KH9+
	zCQNdHn1SOVvXf9qGifXkwGDf9pt7RlzyAaojhtnazDmiUoi01ZuzZYYp09Q994lmqeCKw
	UtkH3g+gO5oV7gU14l4cATL/42++z4elagq5e3EXxg3j1VDyURsmTsRZze/i1oU2qIRKaI
	cJ3z8w+wxCYyh3QD8YwlI7iqOljCPLiJMRunlHVIhAz3Y0CzfA2+rchQlLtlkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750329599;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMoJNe/fVARzYbO/WlqxF0sikGxbOzRj3GdLul7qBDk=;
	b=awF9pJvSP22HmYFgRFSlntke739yh/XVUvxWrK2h+gf9OvhJyp8gr/Zhu7VexJs6ddf1Qu
	WXEFHxuCZf9LZiAg==
From: "tip-bot2 for Alexey Kardashevskiy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Document requirement for linear mapping of
 guest request buffers
Cc: Alexey Kardashevskiy <aik@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250611040842.2667262-4-aik@amd.com>
References: <20250611040842.2667262-4-aik@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175032959815.406.8513353373185987596.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     7ffeb2fc26707f613685ce7711c26a9de5890ab1
Gitweb:        https://git.kernel.org/tip/7ffeb2fc26707f613685ce7711c26a9de5890ab1
Author:        Alexey Kardashevskiy <aik@amd.com>
AuthorDate:    Wed, 11 Jun 2025 14:08:41 +10:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 18 Jun 2025 22:55:53 +02:00

x86/sev: Document requirement for linear mapping of guest request buffers

The Guest Request supports 3 types of messages now, the largest is the
extended variant of MSG_REPORT_REQ: sizeof(snp_ext_report_req)==112.  These
used to be allocated on stack and then moved to the SNP guest platform device
(snp_guest_dev) for the reason explained in

  db10cb9b5746 ("virt: sevguest: Fix passing a stack buffer as a scatterlist target"):

aesgcm_encrypt() and aesgcm_decrypt() are used for guest messages and might
potentially use a crypto accelerator which requires DMA buffers to be in the
linear mapping.

Add a comment, warn and return an error when the buffers are not in linear
mapping.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Dionna Glaze <dionnaglaze@google.com>
Link: https://lore.kernel.org/20250611040842.2667262-4-aik@amd.com
---
 arch/x86/coco/sev/core.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 0686538..b0d423a 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2008,6 +2008,15 @@ int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req
 	u64 seqno;
 	int rc;
 
+	/*
+	 * enc_payload() calls aesgcm_encrypt(), which can potentially offload to HW.
+	 * The offload's DMA SG list of data to encrypt has to be in linear mapping.
+	 */
+	if (!virt_addr_valid(req->req_buf) || !virt_addr_valid(req->resp_buf)) {
+		pr_warn("AES-GSM buffers must be in linear mapping");
+		return -EINVAL;
+	}
+
 	guard(mutex)(&snp_cmd_mutex);
 
 	/* Check if the VMPCK is not empty */

