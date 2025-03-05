Return-Path: <linux-tip-commits+bounces-4000-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D82A4F93C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 09:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647511638A0
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 08:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291031FCFC6;
	Wed,  5 Mar 2025 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kmCe/jJR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LZEldiNR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877A3191F75;
	Wed,  5 Mar 2025 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741164931; cv=none; b=RwEl5AOFSDP/IgyXlLP/a7nIKdMN7l4mdfE0p9cMa8vlt4llpW+NJThH8Gj2vb8lG0OL0Gf07nXiftPx98VySu0FhXElEn/mU9bCRwUftF3FHJlmgXK1TGLxsVTbHrUtD4UUV3UcQ0LlfmcaImWQyqHNL2sdD1mzV7Z0+1MKkFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741164931; c=relaxed/simple;
	bh=OM8ChbKKXrcPJaC9Ogl1hi3hRqVPXbPVF1zrPZvCzKA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HX29Gsj+XkNkj9GaXDmvL5Lp5w/ZNa5wPlHt/+1NaIKRp7+n+JnwYD8xO5nVYdh9BjgJVf6BBya/c0D+g+iMXtt77KZ4PBi7nu3PXacybbQL/QNpgfsKMiSdzB3qTUC09R+Ze0HXj8URAklo4wgAIUvL0SidZjQeD5Pn92GeKIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kmCe/jJR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LZEldiNR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Mar 2025 08:55:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741164927;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SmIrqAGww47OaMggdhUBSr7EwqX9cMQ/T6aEaeVpL2o=;
	b=kmCe/jJRjH88oFA+hgmS2zGt0EfNrt+sNCk1IF0GvwKuNLxhvVaWfnRL+ZteZUu9ux1x9l
	AAlen8SLfxpW4MOekeqYmB2A9kJYUX3KU3m0yQ6NWjBwYdhuSaD6X+hIAof3FF105SzvN4
	6E/CT3729Owh00whQ4dQK/CNmgFtKTBMUGjHZvRLSBJQcEjxfmgc+W+1SDUFlAYYlRplp8
	F7w1VkBnBv4gvz/nEsD3+kUcbnBtCCTky1yCPLU5L+0O/iLR+1CkLcU75FAIAaZQJuCyJT
	UcLX8oL0Jw+uQht9iucx8BVvf+pkTviG+kezFt2q9agP+gya5mvIJXqo1GG1MQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741164927;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SmIrqAGww47OaMggdhUBSr7EwqX9cMQ/T6aEaeVpL2o=;
	b=LZEldiNRfAmuGIeEh/ZicX/0obLHYWDtuOjs4UREy3TqUkS85NNSXCCxT59zq2CchWKZi5
	x67G62NizArfqcDQ==
From: "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sgx: Fix size overflows in sgx_encl_create()
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Jarkko Sakkinen <jarkko@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250305050006.43896-1-jarkko@kernel.org>
References: <20250305050006.43896-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174116492272.14745.2721064032310702580.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     31d20f8f6c419b5e818aff2a2a0819a2a1d65003
Gitweb:        https://git.kernel.org/tip/31d20f8f6c419b5e818aff2a2a0819a2a1d65003
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Wed, 05 Mar 2025 07:00:05 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 05 Mar 2025 09:49:44 +01:00

x86/sgx: Fix size overflows in sgx_encl_create()

The total size calculated for EPC can overflow u64 given the added up page
for SECS.  Further, the total size calculated for shmem can overflow even
when the EPC size stays within limits of u64, given that it adds the extra
space for 128 byte PCMD structures (one for each page).

Address this by pre-evaluating the micro-architectural requirement of
SGX: the address space size must be power of two. This is eventually
checked up by ECREATE but the pre-check has the additional benefit of
making sure that there is some space for additional data.

Fixes: 888d24911787 ("x86/sgx: Add SGX_IOC_ENCLAVE_CREATE")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20250305050006.43896-1-jarkko@kernel.org

Closes: https://lore.kernel.org/linux-sgx/c87e01a0-e7dd-4749-a348-0980d3444f04@stanley.mountain/
---
 arch/x86/kernel/cpu/sgx/ioctl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index b65ab21..776a201 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -64,6 +64,13 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 	struct file *backing;
 	long ret;
 
+	/*
+	 * ECREATE would detect this too, but checking here also ensures
+	 * that the 'encl_size' calculations below can never overflow.
+	 */
+	if (!is_power_of_2(secs->size))
+		return -EINVAL;
+
 	va_page = sgx_encl_grow(encl, true);
 	if (IS_ERR(va_page))
 		return PTR_ERR(va_page);

