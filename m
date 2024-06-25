Return-Path: <linux-tip-commits+bounces-1542-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4E1916D0D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Jun 2024 17:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5524B2587B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Jun 2024 15:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF23176230;
	Tue, 25 Jun 2024 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cGKd7t1g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OMrVABEr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BD9172BA4;
	Tue, 25 Jun 2024 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329233; cv=none; b=Lw0kxAExLS2FDHl4vS831BTO4HG51jHn4rDCGXKLYrlHkprEezns0UA+W8OxZAp8ZW0bRHDR+yDWIILmYVciMQc7QQi7oeo5lQJoztdBlHQJg5Fjx5miU4DNfdUReO1TArBeBno8JnKf4bijgkmD1TkxZAUXV4uh0gVUcQu9rWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329233; c=relaxed/simple;
	bh=heROmb6eVWM3GB8cXImbV9gYoNoKof5f0DLyJ9eJcew=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Rs6gSp0I/hct3IQ/g3WTEE5c5wuDr75Xb788Q9Pa+QCyqQEL6jKYvbQvN2Q9JrFiCm8qcuQHY/N314hgkAZ6vSjE2T3a9U7oklXOtt27JrVTy5jwpnhe1JINcRJ8+9KYTmKdKfFC9d1GZ3EQSjCARpdJDImt1rpGCVEFtbI8N0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cGKd7t1g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OMrVABEr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Jun 2024 15:27:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719329229;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=whVnrc43G9JNCt5jCDi1GET+WQTm0HJYWJ2BCjIljcM=;
	b=cGKd7t1g3pZfnSS6CTNJAzGngenemgWzbSZ9pR06k1aW1pHOIhsiQPPwZ/vS6ydHDYREJN
	lPCR0qHpOMo1z/eOBrBN33lJQ4PyaN1bXXOS70VMaUiH7r+tpVCmiOlU4UyxPf+Gr/hSfm
	xV85kq1v6jdnZWItzcXjA2jULGuO06lb5RAue1d+892r2YgjivXObD045k0cxAx5uW7uTN
	ruvchAv09NJQn/V4nHlgb73D8WTRiqtXU/HxsDyvvx+nHgUfh9JbmN4hdv1ZD3/u6AIVAz
	uh7igOeoaAT0IUDerqllkeMG8LKgPF525WSAs0e2U/z3K0kvvowvyX8AxQAMaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719329229;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=whVnrc43G9JNCt5jCDi1GET+WQTm0HJYWJ2BCjIljcM=;
	b=OMrVABErQwZCe6seRzflLn2//5T1UzHYj0gcyve9nEyXGI/r/0c26/9jBZeIl2A6QgwFmm
	qT7Iw88VBUdpUDDQ==
From: "tip-bot2 for Alexey Makhalov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vmware] ptp/vmware: Use VMware hypercall API
Cc: Alexey Makhalov <alexey.makhalov@broadcom.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240613191650.9913-3-alexey.makhalov@broadcom.com>
References: <20240613191650.9913-3-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171932922873.2215.4573183362712487048.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/vmware branch of tip:

Commit-ID:     54651bb4dcfea0949afe72775212511ec4193b85
Gitweb:        https://git.kernel.org/tip/54651bb4dcfea0949afe72775212511ec4193b85
Author:        Alexey Makhalov <alexey.makhalov@broadcom.com>
AuthorDate:    Thu, 13 Jun 2024 12:16:44 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 25 Jun 2024 17:15:47 +02:00

ptp/vmware: Use VMware hypercall API

Switch from VMWARE_HYPERCALL macro to vmware_hypercall API.
Eliminate arch specific code. No functional changes intended.

Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240613191650.9913-3-alexey.makhalov@broadcom.com
---
 drivers/ptp/ptp_vmw.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/ptp/ptp_vmw.c b/drivers/ptp/ptp_vmw.c
index 7ec9035..20ab05c 100644
--- a/drivers/ptp/ptp_vmw.c
+++ b/drivers/ptp/ptp_vmw.c
@@ -14,7 +14,6 @@
 #include <asm/hypervisor.h>
 #include <asm/vmware.h>
 
-#define VMWARE_MAGIC 0x564D5868
 #define VMWARE_CMD_PCLK(nr) ((nr << 16) | 97)
 #define VMWARE_CMD_PCLK_GETTIME VMWARE_CMD_PCLK(0)
 
@@ -24,15 +23,10 @@ static struct ptp_clock *ptp_vmw_clock;
 
 static int ptp_vmw_pclk_read(u64 *ns)
 {
-	u32 ret, nsec_hi, nsec_lo, unused1, unused2, unused3;
-
-	asm volatile (VMWARE_HYPERCALL :
-		"=a"(ret), "=b"(nsec_hi), "=c"(nsec_lo), "=d"(unused1),
-		"=S"(unused2), "=D"(unused3) :
-		"a"(VMWARE_MAGIC), "b"(0),
-		"c"(VMWARE_CMD_PCLK_GETTIME), "d"(0) :
-		"memory");
+	u32 ret, nsec_hi, nsec_lo;
 
+	ret = vmware_hypercall3(VMWARE_CMD_PCLK_GETTIME, 0,
+				&nsec_hi, &nsec_lo);
 	if (ret == 0)
 		*ns = ((u64)nsec_hi << 32) | nsec_lo;
 	return ret;

