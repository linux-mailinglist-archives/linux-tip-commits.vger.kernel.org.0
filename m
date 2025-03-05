Return-Path: <linux-tip-commits+bounces-4001-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A612DA4F980
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 10:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E94D63AC1DE
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 09:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534D61FDA61;
	Wed,  5 Mar 2025 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wrab8fv8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ceHpbqXJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF521FC7EE;
	Wed,  5 Mar 2025 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741165545; cv=none; b=MrNjizHIDTkrAiC7CWV64mEswJ2AoJDB0eBrVWcuWOoUzSf4l+SSy3K8xwCAHpwcRmuwfl1peIR/FmBqdI1K+GmFXuZYsSebRGV8DUQSdHM3e3I8xchYpiPWQ0DOH8WWAsP+kIM/qB2vYW4BlxOQMNn+XEJ5GywKoD2XXsyWNlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741165545; c=relaxed/simple;
	bh=eXrGlKvyBxB5Yi9UQBmkNPI0Y6dMFyz6zVG+qsJ5PdM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PA7AkotdPY0cfw+mxcPj+69vwZYgighg6yOuuiYk/D1eaR1jJ1SGts6WIRxIoM335/IToc0LY5c8/xkHV7PjVfhJKr7V+/vZpX6nTwKXnpqGdE3PfiLuXu+aV3pdiDYhX4kDm82YP2nUS+0ZbK6nOwrncaAkXQXxAPaNT/L2Uzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wrab8fv8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ceHpbqXJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Mar 2025 09:05:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741165541;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RrEB+oxxeOEbmk9wRgE7Nost4IAnxx1d16HIx+43vJc=;
	b=Wrab8fv8wft+6k62BPNshZl0odzU+pB7IGCdEMenpNZ1th0vXxz/7n+uexOFcULqEQkrdr
	WgWHdtFipw0rK7ZfvYnV54dYPxpzuziSyoOXCsdREyspEJdXL80Y4K5+yrcaCGpMev1CWn
	HMvQTp1Kbky5PN51SFZ1lgp8jsj1mcAUaNyHMepHeFi09t298aDB5LT9DGu5SET6N3zGUY
	J+nV9suNBJXAiibPbnnJo9DN/35MQkCWNxDnqFpGGwcTUlZL1h6ja6WKdNiZmf895TPpPa
	tVlVWR4nhsLzA16JlI7OK6iOfEIa11KSx6a2bfs7ftwX7yZz8IwaaAYqWx2fsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741165541;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RrEB+oxxeOEbmk9wRgE7Nost4IAnxx1d16HIx+43vJc=;
	b=ceHpbqXJiVuMsax4ztia6pPrRFxXtlSEQBCv+sGEfovHOx/vEIA69cy+P4hx3Urm0AKnqg
	IdC6+q6hXDzePiCQ==
From: "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sgx: Fix size overflows in sgx_encl_create()
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Jarkko Sakkinen <jarkko@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250305050006.43896-1-jarkko@kernel.org>
References: <20250305050006.43896-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174116554044.14745.885486771542250636.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     0d3e0dfd68fb9e6b0ec865be9f3377cc3ff55733
Gitweb:        https://git.kernel.org/tip/0d3e0dfd68fb9e6b0ec865be9f3377cc3ff55733
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Wed, 05 Mar 2025 07:00:05 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 05 Mar 2025 09:51:41 +01:00

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
Acked-by: Dave Hansen <dave.hansen@intel.com>
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

