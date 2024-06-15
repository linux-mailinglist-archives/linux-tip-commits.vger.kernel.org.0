Return-Path: <linux-tip-commits+bounces-1398-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 593369096ED
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Jun 2024 10:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2476B20D8B
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Jun 2024 08:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E8D2E401;
	Sat, 15 Jun 2024 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xJttK/j5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y6g1oIHP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEF420B20;
	Sat, 15 Jun 2024 08:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718439712; cv=none; b=Xzc4+aXB49gMWz+kOnQoRffPPbjPZVD2Tos2vb4PidEZSc8uypI3PVZJJUYqcSoxIbPWdDL+ynUCqHPMaBakE9Ka6LECiXRTHBXIlrINbaIzGKxoSYLq3cTVlTJmUzui/+pplgKlzWTEqtFkztbq9YjpeD0QiTeuhQ67L2vo60A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718439712; c=relaxed/simple;
	bh=MlfmUuUA3qEhl/4COBOZ/K0kpeYMhjS+bjmHfR7gR8A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kA5FuIZ1YPoJtiq4VQpwu4Pz5zmmyqrhtPl/uWg20eURUddEE5yePSrSiAxmy4XqUe/UrSPcb5hIa8pisIpv4GtEWeR6Luwqdj8zvK25PZUihetiouzDijDW2dwS50Ht4LfiQtq6njbLoZeicvBcuRNLqlXfADewIU4Fk9la4pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xJttK/j5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y6g1oIHP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 15 Jun 2024 08:21:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718439706;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=710G98VGfmxm2M2GCeEuqF1UgYQFo1CFwqu1cs+Kfw8=;
	b=xJttK/j5qxuJ6G7La8txQA5AvbBZnMEzyedreLLm+JvH5XRLlwFFwsTwWrqaDxAioUwRLt
	a1kOL1QY2gsRFCe3a6XBlr1uMebSuyfXuBpzS/722tthSyrglP6TrA60U0sfhJ7KXoOzGw
	Jk+z65i+Kpwbvp97RRNncCpOeuVvCqoWN9ZQocyfwYjmhxc4MxeEsr87aGjIv9xaq36zBp
	T9LRmXll5YNt155XPp2Y/aHyal0MHBApbno2zsZSrg7BS7kWZSEsuTf61X8aGJ8JEdJ84G
	5hJ1ZiNJCICYKmm6cNZh+YbnzNJdY95cxvE60UhLDiNF+zK0eUQMjdKS1xAPiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718439706;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=710G98VGfmxm2M2GCeEuqF1UgYQFo1CFwqu1cs+Kfw8=;
	b=Y6g1oIHPl+ckS3yLvfdrP9Tvb49y4t7n9GOcbZZ08tUWJzkd5jXmvBoQ/8bTvih//yONWj
	BPGqJMjL4c8tYCAA==
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
Message-ID: <171843970659.10875.334056753563660836.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/vmware branch of tip:

Commit-ID:     f8f9c6e7e54517213f48a7bb5cce8c5f41d5c4b8
Gitweb:        https://git.kernel.org/tip/f8f9c6e7e54517213f48a7bb5cce8c5f41d5c4b8
Author:        Alexey Makhalov <alexey.makhalov@broadcom.com>
AuthorDate:    Thu, 13 Jun 2024 12:16:44 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 14 Jun 2024 18:01:21 +02:00

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

